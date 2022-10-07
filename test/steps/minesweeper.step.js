const { Given, When, Then } = require('@cucumber/cucumber');
const { expect } = require('@playwright/test');

const url = 'http://127.0.0.1:5500/minesweeper.html';

async function cellDiscover(string) {
	await page.click(`[data-testid="${string}"]`, { force: true });
}

//Background scenario
Given("the user opens the app",async function() {
    await page.goto(url);
})