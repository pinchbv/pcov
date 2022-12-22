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