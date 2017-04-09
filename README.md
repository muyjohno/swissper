# Swissper

Swissper lets you generate swiss pairings for tournaments of all kinds.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'swissper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install swissper

## Usage

Use `Swissper.pair(players, options)` where `players` is an array of objects, and `options` is an optional hash of options.

The `player` objects you pass can be any type of object you like, so long as there are no duplicates. There is a simple `Swissper::Player` class available for ease of use.

```ruby
player1 = Swissper::Player.new
player2 = Swissper::Player.new

Swissper.pair([player1, player2])
# [
#   [#<Swissper::Player:0x007ffc22e456d0 @delta=0, @exclude=[]>, #<Swissper::Player:0x007ffc22e3d318 @delta=0, @exclude=[]>]
# ]
```

`Swissper.pair` returns an array of tuples, each of which contains exactly two objects. These objects will be the objects you pass in.

### Making players more likely to play

If the player is an object that responds to `delta`, Swissper will weight pairings so that players with similar deltas are more likely to be paired. In a typical tournament, the `delta` value might be the player's ranking, or points they've scored.

```ruby
jack = Swissper::Player.new
jack.delta = 3
jill = Swissper::Player.new
jill.delta = 3
hansel = Swissper::Player.new
hansel.delta = 0
gretel = Swissper::Player.new
gretel.delta = 0

Swissper.pair([jack, jill, hansel, gretel])
# outputs:
[
  [#<Swissper::Player:0x007ffc209fd7a0 @delta=0, @exclude=[]>, #<Swissper::Player:0x007ffc22d34818 @delta=0, @exclude=[]>],
  [#<Swissper::Player:0x007ffc209f4df8 @delta=3, @exclude=[]>, #<Swissper::Player:0x007ffc21846ca8 @delta=3, @exclude=[]>]
]
```

You can customise the method called on the player objects with the `delta_key` option.

```ruby
Swissper.pair(players, delta_key: :tournament_points)
# The player objects should respond to `tournament_points`
```

### Avoiding specific pairings

You're likely to need to avoid repeat pairings, such as players who have already faced each other. You can pass an array of players to be avoided to the `exclude` method of each player.

```ruby
jack = Swissper::Player.new
jill = Swissper::Player.new
hansel = Swissper::Player.new
gretel = Swissper::Player.new

jack.exclude = [jill, hansel]

Swissper.pair([jack, jill, hansel, gretel])
# [
#   [#<Swissper::Player:0x007fe1b89a1f18 @delta=0, @exclude=[]>, #<Swissper::Player:0x007fe1b8bacb78 @delta=0, @exclude=[]>],
#   [#<Swissper::Player:0x007fe1b8bf4428 @delta=0, @exclude=[#<Swissper::Player:0x007fe1b8bacb78 @delta=0, @exclude=[]>, #<Swissper::Player:0x007fe1b89a1f18 @delta=0, @exclude=[]>]>, #<Swissper::Player:0x007fe1b8b15fc0 @delta=0, @exclude=[]>]
# ]
```

Players cannot be paired against players returned from the `exclude` method. In this example, Jack was paired with Gretel because that was the only valid remaining opponent for him.

You can customise this key with the `exclude_key` option.

```ruby
Swissper.pair(players, exclude_key: :previous_opponents)
# Player objects should respond to `previous_opponents`
```

## Byes

If your array of players contains an odd number, one player will be paired with the `Swissper::Bye` class.

You can prevent players from receiving byes (e.g. if they've already received one) by passing `Swissper::Bye` in the `exclude` parameter of any player.

```ruby
snap = Swissper::Player.new
crackle = Swissper::Player.new
pop = Swissper::Player.new

snap.exclude = [Swissper::Bye]
crackle.exclude = [Swissper::Bye]

Swissper.pair([snap, crackle, pop])
# [
#   [Swissper::Bye, #<Swissper::Player:0x007fb2f99cb838 @delta=0, @exclude=[]>],
#   [#<Swissper::Player:0x007fb2f9accac0 @delta=0, @exclude=[Swissper::Bye]>, #<Swissper::Player:0x007fb2f91a8f98 @delta=0, @exclude=[Swissper::Bye]>]
# ]
```

Please don't manually pass in `Swissper::Bye` in your array of players, passing in an odd-length array is the correct way to use byes.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/muyjohno/swissper.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
