LLLCategory

(好多人用LLCategory命名...)

关键字：类别 数组越界 label文字为空 闪退 字符串下标连接 富文本make

pod 'LLLCategory', '~> 1.0.3'

//pch
#import "LLCategory.h"

//使用

#import "NSObject+LLErrorHandle.h"
//1.数组越界不会崩
array = @[@1];
a = array[2];//返回nil

//2.label文字为空不会崩
label.text = nil;//.text = " ";



#import "NSString+LLStringConnection.h"
//3.字符串下标连接
a = @"str1"[@"_and_"][@"str2"];//str1_and_str2 字符串连接
b = @""[@1];//"1" NSNumber转NSString
c = @""[@{@"key":@"value"}];//"{"key":"value"}" NSDictionary转NSString
d = @""[@[@"1",@"2"]];//"["1","2"]" NSArray转NSString



#import "NSAttributedString+LLMake.h"
//4.富文本make http://note.youdao.com/noteshare?id=596573b938472ab05d46bb06ae419aef
//关键代码 
 label.attributedText = [NSAttributedString makeAttributedString:^(LLAttributedStringMaker *make) {
        make.text(@"如您同意");
        make.text(@"《隐私政策》").foregroundColor([UIColor redColor]).underline(NSUnderlineStyleSingle);
        make.text(@"请点击“同意”开始使用我们的产品和服务，我们尽全力保护您的个人信息安全。");
    }];
//链接可点击情况
textView.attributedText = [NSAttributedString makeAttributedString:^(LLAttributedStringMaker *make) {
        make.text(@"如您同意");
        make.text(@"《隐私政策1》").foregroundColor([UIColor redColor]).underline(NSUnderlineStyleSingle).link(@"link1");
        make.text(@"《隐私政策2》").foregroundColor([UIColor redColor]).underline(NSUnderlineStyleSingle).link(@"link2");
        make.text(@"《隐私政策3》").foregroundColor([UIColor redColor]).underline(NSUnderlineStyleSingle).link(@"link3");
        make.text(@"请点击“同意”开始使用我们的产品和服务，我们尽全力保护您的个人信息安全。");
    }];
//必须禁止输入，否则点击将弹出输入键盘
textView.delegate = self;
textView.editable = NO;        
textView.scrollEnabled = NO;

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    NSLog(@"%@",[URL absoluteString]);
    return NO;
}
