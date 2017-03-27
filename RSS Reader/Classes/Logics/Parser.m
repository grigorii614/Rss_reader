//
//  Manager.m
//  Travel
//
//  Created by Eugene Vegner on 08.05.15.
//  Copyright (c) 2015 Eugene Vegner. All rights reserved.
//

#import "Parser.h"

@interface Parser () <NSXMLParserDelegate>
{
    NSXMLParser *parser;
    NSMutableDictionary *item;
    
    NSString *element;
    
    NSMutableString *title;
    NSMutableString *link;
    NSMutableString *description_;
    
    Rss *rssMod;
}

@end

@implementation Parser

+ (instancetype)instance {
    static Parser *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [Parser new];
    });
    return _instance;
}

- (void)parseRss:(Rss *) rss delegate:(id) delegate
{
    self.delegate = delegate;
    
    rssMod = rss;
    
    NSURL *url = [NSURL URLWithString:rssMod.link];
    
    if (url)
    {
        [Item removeAllItemsByRss_Id:rssMod.rss_id];
        
        parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        
        [parser setDelegate:self];
        [parser setShouldResolveExternalEntities:NO];
        [parser parse];
    }
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;

    if ([element isEqualToString:@"item"]) {
        
        item    = [[NSMutableDictionary alloc] init];
        
        link         = [[NSMutableString alloc] init];
        title        = [[NSMutableString alloc] init];
        description_ = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([element isEqualToString:@"title"])
        [title appendString:string];
    else if ([element isEqualToString:@"link"])
        [link appendString:string];
    else if ([element isEqualToString:@"description"])
    {
        NSString *resultString = [[string componentsSeparatedByCharactersInSet:[[NSCharacterSet letterCharacterSet] invertedSet]] componentsJoinedByString:@" "];
        
        NSString *result = [resultString stringByReplacingOccurrencesOfString:@"\\s+"
                                                                   withString:@" "
                                                                      options:NSRegularExpressionSearch
                                                                        range:NSMakeRange(0, resultString.length)];
        
        [description_ appendString:result];
    }
    else if ([element isEqualToString:@"pubDate"]) {}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"item"])
    {
        [item setObject:link forKey:@"link"];
        [item setObject:title forKey:@"title"];
        [item setObject:description_ forKey:@"description"];
        
        [Item saveItemFromDictionary:item rss:rssMod];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(parserDidFinish)])
        [self.delegate parserDidFinish];
}

@end
