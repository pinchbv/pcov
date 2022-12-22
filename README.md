[![codecov](https://codecov.io/gh/pinchbv/pcov/branch/develop/graph/badge.svg?token=Wuf1i3qiTc)](https://codecov.io/gh/pinchbv/pcov)

## About

Getting your test coverage through `flutter test --coverage` can be a bit misleading, since this 
will only take the files into account that you touched in your tests. With `pcov` you can get the
actual coverage of your project, including untested files, as well as exclude files based on name
or content. This can come in handy for things like generated files or widgets for example.

---

## Getting Started

Install the latest Pcov version as a global package via [Pub](https://pub.dev/).

```bash
dart pub global activate pcov

# Or specify a specific version if needed:
# pub global activate pcov 1.0.0
```

---

## Running tests

Running tests with Pcov can be done by suppyling your command to pcov using the --test-command option:

```bash
pcov --test-command="flutter test --coverage"
```

---

## Excluding files

Excluding files while running tests with pcov can be done by adding a `pcov.yml` file to the root of
your project. You can then exclude files by:

- File name
- File content

You can use `*` as wildcards just like you would normally do in your `.gitignore` file for example.

```yaml
exclude:
  file_name:
    - '*.g.dart'
    - '*.freezed.dart'
    
  content:
    - 'class * extends StatelessWidget *'
    - 'class * extends StatefulWidget *'
```

---