import os
import time
from selenium import webdriver

selenium_url = os.environ['SELENIUM_URL']
website_url = 'https://example.com'

options = webdriver.ChromeOptions()
options.add_argument('--kiosk')

driver = webdriver.Remote(
  command_executor=selenium_url,
  options=options,
)

driver.get(website_url)

time.sleep(3)

driver.save_screenshot('screenshot.png')

driver.quit()
