# LLLCategory<br>
<br>
(好多人用LLCategory命名...)<br>
<br>
##### 关键字：类别 数组越界 label文字为空 闪退 字符串下标连接 富文本make label拷贝<br>
<br>
#### pod 'LLLCategory', '~> 1.0.5'<br>
<br>
### //pch<br>
#### #import "LLCategory.h"<br>
<br>
### //使用<br>
<br>
#### #import "NSObject+LLErrorHandle.h"<br>
##### //1.数组越界不会崩<br>
array = @[@1];<br>
a = array[2];//返回nil<br>
<br>
##### //2.label文字为空不会崩<br>
label.text = nil;//.text = " ";<br>
<br>
<br>
<br>
#### #import "NSString+LLStringConnection.h"<br>
##### //3.字符串下标连接<br>
a = @"str1"[@"_and_"][@"str2"];//str1_and_str2 字符串连接<br>
b = @""[@1];//"1" NSNumber转NSString<br>
c = @""[@{@"key":@"value"}];//"{"key":"value"}" NSDictionary转NSString<br>
d = @""[@[@"1",@"2"]];//"["1","2"]" NSArray转NSString<br>
<br>
<br>
<br>
#### #import "NSAttributedString+LLMake.h"<br>
##### //4.富文本make http://note.youdao.com/noteshare?id=596573b938472ab05d46bb06ae419aef<br>
##### //关键代码 <br>
 label.attributedText = [NSAttributedString makeAttributedString:^(LLAttributedStringMaker *make) {<br>
        make.text(@"如您同意");<br>
        make.text(@"《隐私政策》").foregroundColor([UIColor redColor]).underline(NSUnderlineStyleSingle);<br>
        make.text(@"请点击“同意”开始使用我们的产品和服务，我们尽全力保护您的个人信息安全。");<br>
    }];<br>
##### //链接可点击情况<br>
textView.attributedText = [NSAttributedString makeAttributedString:^(LLAttributedStringMaker *make) {<br>
        make.text(@"如您同意");<br>
        make.text(@"《隐私政策1》").foregroundColor([UIColor redColor]).underline(NSUnderlineStyleSingle).link(@"link1");<br>
        make.text(@"《隐私政策2》").foregroundColor([UIColor redColor]).underline(NSUnderlineStyleSingle).link(@"link2");<br>
        make.text(@"《隐私政策3》").foregroundColor([UIColor redColor]).underline(NSUnderlineStyleSingle).link(@"link3");<br>
        make.text(@"请点击“同意”开始使用我们的产品和服务，我们尽全力保护您的个人信息安全。");<br>
    }];<br>
##### //必须禁止输入，否则点击将弹出输入键盘<br>
textView.delegate = self;<br>
textView.editable = NO;<br>        
textView.scrollEnabled = NO;<br>
<br>
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {<br>
    NSLog(@"%@",[URL absoluteString]);<br>
    return NO;<br>
}<br>
<br>
<br>
#### #import "UILabel+LLCopyLabel.h"<br>
##### //5.label拷贝<br>
##### //关键代码 <br>
label.canCope = YES;<br>
<br>
<br>
