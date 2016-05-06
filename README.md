# fluent-plugin-has-keys
This fluentd plugin is to filter records without the given keys.

## Usage

fluentd.conf

```
<filter **>
  @type has_keys
  keys  hoge, foo
</filter>
```

Input messages:

```
  2016-05-03T11:22:33 test {"hoge" => "fuga", "foo" => "bar"}
  2016-05-03T11:22:34 test {"hoge" => "fuga"}
  2016-05-03T11:22:35 test {"foo" => "bar"}
  2016-05-03T11:22:36 test {"spam" => "ham"}
  2016-05-03T11:22:37 test {"hoge" => "fuga", "foo" => "bar", "spam" => "ham"}
```

Output messages:

```
  2016-05-03T11:22:33 test {"hoge" => "fuga", "foo" => "bar"}
  2016-05-03T11:22:37 test {"hoge" => "fuga", "foo" => "bar", "spam" => "ham"}
```

## TODO
* Check whether this plugin works under a general operation.

## Copyright
Copyright (c) 2016 Trickey
Released under the MIT license
https://opensource.org/licenses/MIT
