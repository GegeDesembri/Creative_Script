import os
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.options import Options

# Chrome User Data
appdata_path = os.getenv('APPDATA').replace("Roaming", "") + 'Local\\Google\\Chrome\\User Data'
chrome_data = 'r"user-data-dir=' + repr(appdata_path)
print(chrome_data)

# Chrome Options
chrome_options = Options()
chrome_options.add_argument(chrome_data)
# chrome_options.add_argument("--headless")
# chrome_options.add_argument("--disable-extensions")
# chrome_options.add_argument("--disable-gpu")
# chrome_options.add_argument("--no-sandbox") ## Linux-only

# Browset Set Options
browser = webdriver.Chrome(ChromeDriverManager().install(), options=chrome_options)

# Launch Browser
browser.get('https://shopee.co.id/buyer/login?next=https%3A%2F%2Fshopee.co.id%2F')

# Actions
browser.find_element_by_css_selector('._1DQYn2').click()