const { Given, When, Then } = require('@cucumber/cucumber');
const { expect } = require('@playwright/test');

const url = 'http://127.0.0.1:5500/';

async function cellDiscover(cell) {
	await page.click(`[data-testid="${cell}"]`, { force: true });
}

Given("the user opens the app", async function() {
    await page.goto(url);
})

// el given lo llama cada vez que sale el mismo con el mismo nombre.
//await = espera a que cargen los datos de documento. 


Given("the user loads the following mock data: {string}", async function (mockData) {
    await page.goto(url+"?mockData="+mockData);
})

Then("the flag counter should be {string}", async function (counter) {
    const flagCounter =  await page.locator("data-testid=flag-counter").innerText;
    expect(flagCounter).toBe(counter);
})
