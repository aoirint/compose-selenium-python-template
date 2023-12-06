import os
import time
from argparse import ArgumentParser

from selenium import webdriver


def main() -> None:
    env_selenium_url = os.environ.get("SELENIUM_URL") or None

    parser = ArgumentParser()
    parser.add_argument(
        "--website_url",
        type=str,
        default="https://example.com",
    )
    parser.add_argument(
        "--selenium_url",
        type=str,
        default=env_selenium_url,
        required=env_selenium_url is None,
    )
    args = parser.parse_args()

    selenium_url: str = args.selenium_url
    website_url: str = args.website_url

    options = webdriver.ChromeOptions()
    options.add_argument("--kiosk")  # type: ignore[no-untyped-call]

    driver = webdriver.Remote(
        command_executor=selenium_url,
        options=options,
    )

    driver.get(website_url)

    time.sleep(3)

    driver.save_screenshot("screenshot.png")

    driver.quit()
