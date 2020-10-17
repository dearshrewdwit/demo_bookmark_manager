## Bookmark Manager

I spent about 10hours meandering my way through this challenge, recording every scintillating second. It can be at times quite dreary, so buckle up, get your popcorn, and maybe use [this hack](https://www.quora.com/Is-there-a-way-of-watching-YouTube-videos-at-higher-than-2x-speed) to occasionally speed up the video more than youtube thinks the average joe should.

The intention is for this to be a resource (for staff and students) to see how an experienced dev would approach the steps.

The caveat: I was constrained at times by the contrived nature of the learning exercise. I prioritised basic implementations in favour of covering edge-cases. This is in no way a bug-free app, but it was always primarily going to demonstrate TDD.

### Quick Start
```sh
$ git clone git@github.com:dearshrewdwit/demo_bookmark_manager.git && cd demo_bookmark_manager
$ bundle install
$ createdb demo_bookmark_manager_development
$ bundle exec rake db:migrate RACK_ENV=development
$ bundle exec rackup
```

### Tests

```sh
$ createdb demo_bookmark_manager_test
$ bundle exec rake db:migrate RACK_ENV=test
$ bundle exec rspec
```

### Branch & Recordings

Check out the [pull requests](https://github.com/dearshrewdwit/demo_bookmark_manager/pulls) that show the diff for each section I worked through.
- [Steps 1-10](https://github.com/dearshrewdwit/demo_bookmark_manager/tree/version1) | [recording](https://youtu.be/LHX1SqQ5F-g)
- [Steps 11-13](https://github.com/dearshrewdwit/demo_bookmark_manager/tree/version2) |
- [Steps 14-15](https://github.com/dearshrewdwit/demo_bookmark_manager/tree/version3) |
- [Steps 16](https://github.com/dearshrewdwit/demo_bookmark_manager/tree/version4) |
- [Steps 17](https://github.com/dearshrewdwit/demo_bookmark_manager/tree/version5) |
- [Steps 18-19](https://github.com/dearshrewdwit/demo_bookmark_manager/tree/version6) |
