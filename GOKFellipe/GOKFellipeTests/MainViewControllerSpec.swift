//
//  MainViewControllerSpec.swift
//  GOKFellipeTests
//
//  Created by Fellipe Ricciardi Chiarello on 11/10/20.
//

import Quick
import Nimble
import UIKit
@testable import GOKFellipe

class MainViewControllerSpec: QuickSpec {
    override func spec() {
        describe("MainViewController") {
            let controller = MainViewController()
            
            beforeSuite {
                controller.loadViewIfNeeded()
                controller.viewDidLoad()
            }
            
            context("Check MainViewController is not Nil") {
                it("not nil") {
                    expect(controller).toNot(beNil())
                    expect(controller.cashLabel).toNot(beNil())
                    expect(controller.cashView).toNot(beNil())
                    expect(controller.productsLabel).toNot(beNil())
                    expect(controller.productsCollectionView).toNot(beNil())
                    expect(controller.firstCollectionView).toNot(beNil())
                }
            }
        }
        describe("FirstCollectionViewCell") {
            let controller = MainViewController()
            beforeSuite {
                controller.loadViewIfNeeded()
                controller.viewDidLoad()
            }
            
            context("Check if FirstCollectionViewCell is not nil"){
                it("collection not nil") {
                    expect(controller.firstCollectionView.numberOfSections).to(be(1))
                }
            }
        }
        describe("ProductsCollectionViewCell") {
            let controller = MainViewController()
            beforeSuite {
                controller.loadViewIfNeeded()
                controller.viewDidLoad()
            }
            
            context("Check if ProductsCollectionViewCell is not nil"){
                it("collection not nil") {
                    expect(controller.productsCollectionView.numberOfSections).to(be(1))
                }
            }
        }
    }
}
