# Git Explorer

![header][header_image_url]

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Flutter Firebase CI/CD][ci_badge]][ci_badge_link]

Git Explorer is a Flutter application that offers a seamless experience for exploring GitHub repositories, issues, and pull requests.

## Features

- Dark & Light theme support
- GitHub-inspired theme
- Repository search
- Detailed repository view
- Issues browser
- Pull requests overview

## Installation

1. **Clone the repository:**

      ```sh
      git clone https://github.com/makjac/git_explorer.git
      ```

2. **Configure Environment Variables (optional):**

    Although this step is optional, it is recommended as it will increase your GitHub API's hourly rate limit.

    - Create a `.dart_define` file in the root directory:

      ```sh
      touch .dart_define/api-keys.dev.json
      ```

    - Add the following content to `.dart_define`:

      ```json
      {
          "GITHUB_AUTHORIZATION": "your_github_personal_access_token"
      }
      ```

    - To generate a personal access token for GitHub, follow these steps:

      - Go to [GitHub Tokens settings][generate_token_url].
      - Click **Generate new token**.
      - Copy the generated token and replace `"your_github_personal_access_token"` with it in the `.dart_define` file.

3. **Build Runner Setup:**

    - Run the build_runner to generate necessary files:

      ```sh
      dart run build_runner build
      ```

4. **Run the application:**

    - Simply run the following command:

      ```sh
      flutter run --dart-define-from-file .dart_define/api-keys.dev.json
      ```

## Running Tests

### Unit Tests

To run the unit tests for the application, use the following command:

```sh
flutter test
```

## Screenshots

![screenshot_0][git_explorer_search_dark]
![screenshot_1][git_explorer_search_light]
![screenshot_2][git_explorer_repo_page]
![screenshot_3][git_explorer_issues_page]
![screenshot_4][git_explorer_pull_request_page]
![screenshot_5][git_explorer_settings_page]

<!-- end:excluded_rules_table -->

[header_image_url]: https://raw.githubusercontent.com/makjac/images/refs/heads/main/git_explorer/git_explorer_banner.png

[ci_badge]: https://github.com/makjac/git_explorer/actions/workflows/test.yml/badge.svg
[ci_badge_link]: https://github.com/makjac/git_explorer/actions/workflows/test.yml

[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis

[generate_token_url]: https://github.com/settings/tokens

[git_explorer_search_dark]: https://raw.githubusercontent.com/makjac/images/refs/heads/main/git_explorer/git_explorer_search_dark.png
[git_explorer_search_light]: https://raw.githubusercontent.com/makjac/images/refs/heads/main/git_explorer/git_explorer_search_light.png
[git_explorer_repo_page]: https://raw.githubusercontent.com/makjac/images/refs/heads/main/git_explorer/git_explorer_repo_page.png
[git_explorer_issues_page]: https://raw.githubusercontent.com/makjac/images/refs/heads/main/git_explorer/git_explorer_issues_page.png
[git_explorer_pull_request_page]: https://raw.githubusercontent.com/makjac/images/refs/heads/main/git_explorer/git_explorer_pull_request_page.png
[git_explorer_settings_page]: https://raw.githubusercontent.com/makjac/images/refs/heads/main/git_explorer/git_explorer_settings_page.png
