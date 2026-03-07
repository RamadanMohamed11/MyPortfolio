/// Centralized responsive breakpoint definitions for the portfolio.
///
/// Three layout tiers:
/// - **Mobile**  (width < [mobile]):  Single-column, drawer nav.
/// - **Tablet**  ([mobile] ≤ width < [desktop]):  Desktop structure with
///   compact header + drawer for nav. Avoids the cramped inline-nav issue.
/// - **Desktop** (width ≥ [desktop]):  Full desktop layout with inline nav.
class Breakpoints {
  Breakpoints._();

  /// Widths below this are considered **mobile**.
  static const double mobile = 600;

  /// Widths at or above this are considered **desktop**.
  /// Between [mobile] and [desktop] is the **tablet** zone.
  static const double desktop = 900;
}
