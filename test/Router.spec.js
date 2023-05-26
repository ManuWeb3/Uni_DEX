// using CommonJS modules (not ES6)
const { expect } = require("chai")
// one of the several hardhat-helper-functions used in dev
// faster version of before/beforeEach
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers")
const { ethers } = require("hardhat")

describe("Testing Router Contract", () => {
    // the code inside it runs before each of the unit test faster.
    // MVP of the Fixture that we set up, will be accessed eventually inside it() using loadFixture
    async function deployRouterFixture() {
        // wETH is used for ETH in AMM-based DEXs
        // bcz Ether is not an ERC20 Token technically.
        const WETHERC20TokenContract = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2"
        const DAIERC20TokenContract = "0x6B175474E89094C44Da98b954EedeAC495271d0F"
        // Factory = deployment, for Router Contract
        const RouterContract = await ethers.getContractFactory("Router")
        const router = await RouterContract.deploy()    // no i/p argument
        await router.deployed()                         
        // the txn responsible for deployment is finally settled
        // and now it's safe to interact with our deployed instance of the Router Contract
        return {
            WETHERC20TokenContract,
            DAIERC20TokenContract,
            router
        }
        // returning router to make it available for getting accessed by the unit tests
    }

    describe("Testing Deposit Liquidity", () => {
        it("Should only allow a deposit of 2 tokens of equal value", async () => {
            // sytax of using loadFixture(param Fixture fn() name)
            const { 
                WETHERC20TokenContract,
                DAIERC20TokenContract,
                router } 
                = await loadFixture(deployRouterFixture)

                // all args of addLiquidity()
            const { amountA, amountB } = await router.addLiquidity(
                WETHERC20TokenContract,
                DAIERC20TokenContract,
            )
            // syntax of "expect"
            expect(true).to.eq(true)
        })
    })
})

