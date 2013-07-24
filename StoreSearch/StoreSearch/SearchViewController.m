//
//  ViewController.m
//  StoreSearch
//
//  Created by Nguyen Quoc Viet on 7/24/13.
//  Copyright (c) 2013 Nguyen Quoc Viet. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResult.h"
#import "SearchResultCell.h"
static NSString *SearchResultCellIdentifier = @"SearchResultCell";
static NSString *NothingFoundCellIdentifier = @"NothingFoundCell";

@interface SearchViewController ()
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation SearchViewController {
    NSMutableArray *searchResults;
}
@synthesize searchBar = _searchBar;
@synthesize tableView = _tableView;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UINib *cellNib = [UINib nibWithNibName:@"SearchResultCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:SearchResultCellIdentifier];
    
    UINib *notFoundNib = [UINib nibWithNibName:NothingFoundCellIdentifier bundle:nil];
    [self.tableView registerNib:notFoundNib forCellReuseIdentifier:NothingFoundCellIdentifier];
    
    self.tableView.rowHeight = 80;
    
    [self.searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(searchResults == nil) {
        return 0;
    } else {
        return [searchResults count] == 0 ? 1 : [searchResults count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if([searchResults count] == 0) {
        return [tableView dequeueReusableCellWithIdentifier:NothingFoundCellIdentifier];
    }
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:SearchResultCellIdentifier];
    
    SearchResult *searchResult = [searchResults objectAtIndex:indexPath.row];
    cell.nameLabel.text = searchResult.name;
    cell.artistNameLabel.text = searchResult.artistName;
        
    return cell;
}

#pragma mark UITableViewDelegate methods
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([searchResults count] == 0) {
        return nil;
    } else {
        return indexPath;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UISearchBarDelegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchText = searchBar.text;
    if([searchText length] > 0) {
        [searchBar resignFirstResponder];
        searchResults = [[NSMutableArray alloc] init];
        NSURL *url = [self searchRequestUrl:searchText];
        NSString *jsonString = [self performSearchRequest:url];
        if(jsonString == nil) {
            [self showNetworkError];
        } else {
            NSDictionary *dict = [self parseJSON:jsonString];
            if(dict == nil) {
                [self showNetworkError];
            } else {
                [self parseDictionnary:dict];
            }
        }
        [self.tableView reloadData];
    }
}

#pragma mark Helper methods

- (NSURL *)searchRequestUrl:(NSString *)searchText;
{
    NSString *escapedText = [searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *requestLink = [NSString stringWithFormat:@"http://itunes.apple.com/search?term=%@", escapedText];
    return  [NSURL URLWithString:requestLink];
}

- (NSString *)performSearchRequest:(NSURL *)url
{
    NSError *error;
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    if(jsonString == nil) {
        NSLog(@"%@", [error description]);
        return nil;
    }
    return jsonString;
}

- (NSDictionary *)parseJSON:(NSString*)jsonString
{
    NSError *error;
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id object = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if(object == nil) {
        NSLog(@"%@", [error description]);
        return nil;
    }
    if(![object isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return object;
}

- (void)parseDictionnary:(NSDictionary *)dict
{
    NSArray *array = [dict objectForKey:@"results"];
    if(array == nil) {
        NSLog(@"Expected 'results' array");
        return;
    }
    for(NSDictionary *dictTmp in array) {
        SearchResult *searchResult;
        
        NSString *wrapperType = [dictTmp objectForKey:@"wrapperType"];
        
        if ([wrapperType isEqualToString:@"track"]) {
            searchResult = [self parseTrack:dictTmp];
        }
        
        if (searchResult != nil) {
            [searchResults addObject:searchResult];
        }
    }
}
- (void)showNetworkError
{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Whoops..."
                              message:@"There was an error reading from the iTunes Store. Please try again."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    
    [alertView show];
}

- (SearchResult *)parseTrack:(NSDictionary *)dictionary
{
    SearchResult *searchResult = [[SearchResult alloc] init];
    searchResult.name = [dictionary objectForKey:@"trackName"];
    searchResult.artistName = [dictionary objectForKey:@"artistName"];
    searchResult.artworkURL60 = [dictionary objectForKey:@"artworkUrl60"];
    searchResult.artworkURL100 = [dictionary objectForKey:@"artworkUrl100"];
    searchResult.storeURL = [dictionary objectForKey:@"trackViewUrl"];
    searchResult.kind = [dictionary objectForKey:@"kind"];
    searchResult.price = [dictionary objectForKey:@"trackPrice"];
    searchResult.currency = [dictionary objectForKey:@"currency"];
    searchResult.genre = [dictionary objectForKey:@"primaryGenreName"];
    return searchResult;
}
@end
