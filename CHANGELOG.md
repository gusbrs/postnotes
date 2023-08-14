# Changelog

## [Unreleased](https://github.com/gusbrs/postnotes/compare/v0.2.5...HEAD)

### Fixed
- Check `if@filesw` before writing labels to the .aux file.

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
