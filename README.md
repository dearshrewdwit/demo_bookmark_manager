## Bookmark Manager

**For students:** I spent about 8hours meandering my way through the [bookmark manager](https://github.com/makersacademy/course/blob/master/bookmark_manager/00_challenge_map.md) challenge, recording every scintillating second. It can be at times quite dreary while I looked things up at times, so buckle up, get your popcorn, and maybe use [this hack](https://www.quora.com/Is-there-a-way-of-watching-YouTube-videos-at-higher-than-2x-speed) to occasionally speed up the video more than youtube thinks the average joe should.

**For coaches:** If you find some time, record yourself working through it: I found it useful to see how the flow works, how the step weighting varies, and where it all could be improved a lot.

**For everyone:** The intention is for this to be a resource to see how an experienced dev would approach the steps without using the walkthrough or hints, just docs and google as needed.

_The caveat:_ I was constrained at times by the contrived nature of the learning exercise. I prioritised basic implementations in favour of covering edge-cases. I allowed myself a few refactors to ease my way, but this is in no way a bug-free app. It was always primarily going to demonstrate TDD.

Oh. Also.

There is no styling. I forewarn you.

### Quick Start
```sh
# master branch
$ git clone git@github.com:dearshrewdwit/demo_bookmark_manager.git && cd demo_bookmark_manager
$ bundle install
$ createdb demo_bookmark_manager_development
$ bundle exec rake db:setup RACK_ENV=development
$ bundle exec rake db:migrate RACK_ENV=development
$ bundle exec rackup
```

### Tests

```sh
# master branch
$ createdb demo_bookmark_manager_test
$ bundle exec rake db:setup RACK_ENV=test
$ bundle exec rake db:migrate RACK_ENV=test
$ bundle exec rspec
```

### Diffs, Branches, and Recordings

Check out the [pull requests](https://github.com/dearshrewdwit/demo_bookmark_manager/pulls) that show the diff for each section I worked through.
- branch [version1](https://github.com/dearshrewdwit/demo_bookmark_manager/tree/version1): Steps 1-10 | [recording](https://youtu.be/LHX1SqQ5F-g)
- branch [version2](https://github.com/dearshrewdwit/demo_bookmark_manager/tree/version2): Steps 11-13 | [recording](https://youtu.be/lfcUauCejx4)
- branch [version3](https://github.com/dearshrewdwit/demo_bookmark_manager/tree/version3): Steps 14-15 | [recording](https://youtu.be/c7vVCXJzjX0)
- branch [version4](https://github.com/dearshrewdwit/demo_bookmark_manager/tree/version4): Steps 16 | [recording](https://youtu.be/-FiN_820MEc)
- branch [version5](https://github.com/dearshrewdwit/demo_bookmark_manager/tree/version5): Steps 17 | [recording](https://youtu.be/lUgXzqBaDT4), [recording2](https://youtu.be/weFlLixdrBw)
- branch [version6](https://github.com/dearshrewdwit/demo_bookmark_manager/tree/version6): Steps 18-19 | [recording](https://youtu.be/sV346p8zIkQ)
