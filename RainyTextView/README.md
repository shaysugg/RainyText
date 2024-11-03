# RainyTextView

This package contains the code for showing rainy text view.
You can use and customize it in your like:

```swift
let setting = Setting(rainColors: [.black, .green], letters: [.english, .chinese], backgroundColor: .black, rainHeight: 200, rainSpeed: .medium)

struct MyView: View {
    var body: some View {
            RainyTextView()
                .ignoresSafeArea()
                .environmentObject(setting)
            
    }
}
```
