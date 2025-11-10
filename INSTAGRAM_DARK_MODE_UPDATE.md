# Instagram Dark Mode Color Palette Update

## Overview
The app's dark mode has been updated to use Instagram's iconic dark mode color scheme, providing a familiar and modern aesthetic for users.

## Color Changes

### Instagram Dark Mode Palette (Updated)

| Element | Color | Hex Code | Use Case |
|---------|-------|----------|----------|
| **Background** | Pure Black | #000000 | Main app background |
| **Card/Surface** | Very Dark Gray | #1A1A1A | Cards, modals, surfaces |
| **Surface Light** | Dark Gray | #262626 | Slightly elevated surfaces |
| **Primary Text** | Almost White | #FAFAFA | Main text content |
| **Secondary Text** | Medium Gray | #A8A8A8 | Helper text, captions |
| **Tertiary Text** | Darker Gray | #626262 | Disabled, subtle text |
| **Primary Accent** | Instagram Blue | #0095F6 | Links, buttons, CTAs |
| **Secondary Accent** | Instagram Green | #31A24C | Success states |

## Visual Characteristics

### Why Instagram Dark Mode?
1. **High Contrast**: Pure black background with light text for readability
2. **Premium Feel**: Clean and minimalist aesthetic
3. **Familiar**: Users recognize the Instagram blue (#0095F6)
4. **Accessibility**: Strong contrast ratios meet WCAG AA standards
5. **OLED Optimized**: Pure black (#000000) saves battery on OLED screens

## Comparison

### Before (Custom Blue Dark)
- Background: #0F111D (Dark blue)
- Cards: #1A1F35 (Blue-tinted)
- Primary Color: #6B5FFF (Purple-ish blue)
- Text: #FAFAFA / #B0B0B0

### After (Instagram Dark)
- Background: #000000 (Pure black)
- Cards: #1A1A1A (True dark gray)
- Primary Color: #0095F6 (Instagram blue)
- Text: #FAFAFA / #A8A8A8

## Implementation

All changes are in `lib/core/app_theme.dart`:
- Dark mode constants updated with Instagram palette
- Light mode remains unchanged
- Theme switching functionality preserved
- Backward compatibility maintained

## Testing

To see the changes:
1. Run: `flutter run`
2. Use the theme toggle to switch to dark mode
3. Observe the Instagram-style dark interface

## Additional Features

The dark mode now provides:
- ✅ OLED-friendly pure black background
- ✅ Instagram's signature blue (#0095F6) for interactive elements
- ✅ Better battery efficiency on OLED devices
- ✅ Improved visual hierarchy with true blacks and grays
- ✅ Professional Instagram aesthetic

## Future Enhancements

Consider adding:
- Theme persistence (remember user's preference)
- Scheduled theme switching (dark after sunset)
- Custom theme creator for users
- Export/import theme preferences
