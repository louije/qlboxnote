#import <CoreFoundation/CoreFoundation.h>
#import <CoreServices/CoreServices.h>
#import <Foundation/Foundation.h>
#import <QuickLook/QuickLook.h>

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options);
void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview);

/* -----------------------------------------------------------------------------
   Generate a preview for file

   This function's job is to create preview for designated file
   ----------------------------------------------------------------------------- */

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options)
{
    @autoreleasepool {
        
        NSString *contents;
        NSData *file = [NSData dataWithContentsOfURL: [(__bridge NSURL * _Nonnull)(url) absoluteURL]];
        NSError *error = nil;
        id json = [NSJSONSerialization JSONObjectWithData: file options: kNilOptions error: &error];
        
        NSDictionary *atext = [json objectForKey: @"atext"];
        if (atext) {
            contents = [atext objectForKey: @"text"];
        }
        if (!contents) {
            return noErr;
        }
        
//        NSLog(json);
        
        NSString *textEncoding = [[NSUserDefaults standardUserDefaults]
                                  stringForKey:@"webkitTextEncoding"];
        if (!textEncoding || [textEncoding length] == 0)
            textEncoding = @"UTF-8";
        CFDictionaryRef properties = (__bridge CFDictionaryRef)[NSDictionary dictionaryWithObject:textEncoding
                                                     forKey:(NSString *)kQLPreviewPropertyTextEncodingNameKey];
        
        
//        NSString *outputString = @"<html><body><h1>Hello !</h1><p></body></html>";
        NSData *output = [contents dataUsingEncoding: NSUTF8StringEncoding];
        
        
        QLPreviewRequestSetDataRepresentation(preview, (__bridge CFDataRef)output,
                                              //kUTTypePlainText,
                                              kUTTypeHTML,
                                              properties);
    }
    
    return noErr;
}

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview)
{
    // Implement only if supported
}
