# Changelog

## [Unreleased](https://github.com/gusbrs/postnotes/compare/v0.4.2...HEAD)

### Changed
- The support for running headers in `\printpostnotes`, which previously
  generated its data by means of an internal cross-reference structure, has
  migrated to use the generalized mark mechanism provided by the `ltmarks`
  kernel module instead.  This was a long due change, since `ltmarks` is *the*
  right tool for the task, but unfortunately was not available when
  `postnotes` was originally developed and released.  In practice, we get
  improved functionality replacing what was a complicated cross-reference
  setup with a straightforward application of `ltmarks`.  Very neat, if I may
  say so.  Hat tip to `ltmarks` devs.

### Deprecated
- The header support variables `\pnhdpagefirst`, `\pnhdpagelast`,
  `\pnhdchapfirst`, `\pnhdchaplast`, `\pnhdsectfirst`, `\pnhdsectlast`,
  `\pnhdnamefirst`, and `\pnhdnamelast` are deprecated in favor of the new
  `ltmarks` based mark classes.
    - For the sake of stability, the package still provides a "legacy" version
      of these variables, set using `ltmarks` data.  This is meant to provide
      a window of opportunity for users to migrate to the new system smoothly,
      but *migrate you must*, since *these variables will be removed in the
      future*.  Migrating should range somewhere between "very easy" and
      "trivial", and intervention is only needed if you used any of these
      variables to build custom headers.  See the User manual for updated
      examples.
    - Also note that this "legacy version" of the variables require one more
      compilation run to converge, so there's also a clear benefit for you to
      adjust sooner rather than later.

## [v0.4.2](https://github.com/gusbrs/postnotes/compare/v0.4.1...v0.4.2) (2024-11-27)

### Fixed
- Be more careful in expanding content.

## [v0.4.1](https://github.com/gusbrs/postnotes/compare/v0.4.0...v0.4.1) (2024-11-14)

### Fixed
- Explicitly set `\@currentHref` before storing data at `\postnote`.

## [v0.4.0](https://github.com/gusbrs/postnotes/compare/v0.3.0...v0.4.0) (2024-11-04)

*WARNING*: You may need to clear your .aux files after this update.
- (Internally, the macro used in the .aux file, `\post@note`, used to take two
  arguments, but now it takes four.)

### Added
- Provide (experimental) `counteraux` option: full automation of notes
  numbering and sequence capable of handling both multiple passes from
  measuring operations and floats shuffling the sequence of notes.
  `\postnote`s set inside floats may float past `\printpostnotes` and belong
  to the section where they are actually typeset.
- Provide options `checkduplicates` and `checkfloats`, which issue warnings in
  case of duplicate notes from measuring passes and of notes order mismatch
  resulting from float placement.
- Provide `maybemulti` option, exposing to users a simple method to handle
  cases of duplicate notes resulting from measuring passes which was already
  used internally.
- Warning at `enddocument` for stray `\postnote`s left after the last
  `\printpostnotes`.
- Support for `xltabular` package.

### Fixed
- Fixed `style=endnotes` tagging error (see issue
  [#8](https://github.com/gusbrs/postnotes/issues/8))

### Changed
- Improved handling of nested notes, example added to the User manual.

### Removed
- Command `\postnotesectionx`, which had been deprecated since v0.2.0 from
  2022-12-28, has been removed.

## [v0.3.0](https://github.com/gusbrs/postnotes/compare/v0.2.8...v0.3.0) (2024-10-15)

### Added
- Provide `multiple` option, with functionality akin the the same named option
  from `footmisc`.
- Provide (experimental) support for PDF tagging. For this, the required LaTeX
  kernel version was bumped to 2024-06-01. Tagging support requires
  `testphase=phase-III` (`phase-II` with `listenv=none`).

## [v0.2.8](https://github.com/gusbrs/postnotes/compare/v0.2.7...v0.2.8) (2023-12-12)

### Fixed
- Fixed `multibool` test in `\__postnotes_verify_multipass:N`.

## [v0.2.7](https://github.com/gusbrs/postnotes/compare/v0.2.6...v0.2.7) (2023-11-14)

### Added
- Provide `\pnidnextnote`, with usage example in the manual.
- User manual example for section splitting using section redefinition.

### Changed
- Don't use `expl3` public scratch temporary variables.
- Prefer `e-type` expansion.
- Require 2023-11-01 LaTeX kernel.

## [v0.2.6](https://github.com/gusbrs/postnotes/compare/v0.2.5...v0.2.6) (2023-08-21)

### Fixed
- Check `if@filesw` before writing labels to the .aux file.
- Ensure `\post@note` is defined in the .aux file.

## [v0.2.5](https://github.com/gusbrs/postnotes/compare/v0.2.4...v0.2.5) (2023-06-16)

### Fixed
- Ensure `\par` at the end of `\printpostnotes`, see
  https://github.com/u-fischer/tagpdf/issues/68#issuecomment-1587343876 .

## [v0.2.4](https://github.com/gusbrs/postnotes/compare/v0.2.3...v0.2.4) (2023-06-12)

### Changed
- Use new `\lTblrMeasuringBool` for identifying measuring passes in
  `tabularray` tables.

### Fixed
- Don't inhibit `postnote` counter stepping in contexts which restore counter
  values in measuring passes to ensure proper measuring.
- Update User manual and regression tests for `l3kernel`'s renaming of
  `\bool_case_true:n(TF)` to `\bool_case:n(TF)`.

## [v0.2.3](https://github.com/gusbrs/postnotes/compare/v0.2.2...v0.2.3) (2023-02-21)

### Fixed
- Don't apply fix for "perhaps a missing \item" error for option
  `listenv=none`.

## [v0.2.2](https://github.com/gusbrs/postnotes/compare/v0.2.1...v0.2.2) (2023-02-15)

### Fixed
- Don't try to hyperlink `\postnotezref` when `zref-hyperref` is not loaded.
- "perhaps a missing \item" error for empty `\postnote`.

### Changed
- Renamed `postnotes/print/eachnote` hook to `postnotes/print/note/begin`.

## [v0.2.1](https://github.com/gusbrs/postnotes/compare/v0.2.0...v0.2.1) (2023-02-13)

### Fixed
- User manual typos.

### Changed
- To standardize hooks' names, the `postnotes/store/note` hook has been
  renamed to `postnotes/note/store`.

## [v0.2.0](https://github.com/gusbrs/postnotes/compare/v0.1.7...v0.2.0) (2022-12-28)

### Added
- `\postnote` option `markstr`, which can receive a string as value, and does
  not set `sortnum`.
- `\postnotesection` option `exp`, to expand the contents in place.

### Changed
- To simplify user input, `\postnote` option `mark` now requires a number as
  value, but it also sets `sortnum`.
- `\postnotesectionx` is deprecated in favor of the new `exp` option.
- Bumped the required kernel to 2022-06-01, so that we can use the new
  `\MakeLinkTarget` and the starred version of `\ref*` defined by the kernel,
  which simplifies the relation with `hyperref`.  All in all, `postnotes` no
  longer needs to use any internal `hyperref` commands.

## [v0.1.7](https://github.com/gusbrs/postnotes/compare/v0.1.6...v0.1.7) (2022-11-13)

### Added
- German localization (see issue
  [#2](https://github.com/gusbrs/postnotes/issues/2)).

## [v0.1.6](https://github.com/gusbrs/postnotes/compare/v0.1.5...v0.1.6) (2022-08-01)

### Removed
- Withdraw experimental attempt to support `biblatex`'s `refsegment`s and
  `refcontext`s until upstream support is available.

## [v0.1.5](https://github.com/gusbrs/postnotes/compare/v0.1.4...v0.1.5) (2022-07-07)

### Fixed
- Recompiled documentation with workaround for upstream `l3doc` bug.

## [v0.1.4](https://github.com/gusbrs/postnotes/compare/v0.1.3...v0.1.4) (2022-07-06)

### Added
- `zref-check` support.

## [v0.1.3](https://github.com/gusbrs/postnotes/compare/v0.1.2...v0.1.3) (2022-05-28)

### Fixed
- Prevent spurious space after `\post@note` in `.aux` file.

## [v0.1.2](https://github.com/gusbrs/postnotes/compare/v0.1.1...v0.1.2) (2022-04-27)

### Added
- `\postnotesectionx`, a version of `\postnotesection` which expands the
  content in place.
- French localization (see issue
  [#1](https://github.com/gusbrs/postnotes/issues/1)).

## [v0.1.1](https://github.com/gusbrs/postnotes/compare/v0.1.0...v0.1.1) (2022-04-21)

### Fixed
- Adjusted for CTAN release requirements.

## [v0.1.0](https://github.com/gusbrs/postnotes/releases/tag/v0.1.0) (2022-04-20)

### Added
- Initial release.
