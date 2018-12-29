# SPMultipleSwitch

![image](https://github.com/SPStore/SPMultipleSwitch/blob/master/未命名.gif)

## CocoaPods
```
pod "SPMultipleSwitch", "~> 1.0"
```

## Use 
```
    SPMultipleSwitch *multipleSwitch = [[SPMultipleSwitch alloc] initWithItems:@[@"Feed",@"Leaderboard"]];
    multipleSwitch.frame = CGRectMake(30, 100, ScreenW-60, 40);
    multipleSwitch.backgroundColor = [UIColor orangeColor];
    multipleSwitch.selectedTitleColor = [UIColor orangeColor];
    multipleSwitch.titleColor = [UIColor whiteColor];
    multipleSwitch.trackerColor = [UIColor whiteColor];
    multipleSwitch.contentInset = 5;
    multipleSwitch.spacing = 10;
    multipleSwitch.titleFont = [UIFont boldSystemFontOfSize:17];
    multipleSwitch.trackerColor = [UIColor whiteColor];
    [multipleSwitch addTarget:self action:@selector(multipleSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:multipleSwitch];
```
