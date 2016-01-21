//
//  GameScene.swift
//  飞机大战
//
//  Created by weiliang on 16/1/21.
//  Copyright (c) 2016年 weiliangMac. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var planeTexture = SKTexture(imageNamed: "Spaceship")//可以在Images.xcassets中找到默认飞船图片
    var plane:SKSpriteNode!
    var isTouched = false
    let myPlaneName = "weiliangPlane"
    let beginButtonName = "beginButton.png"
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, Swift!"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(myLabel)
        
        plane = SKSpriteNode(texture: planeTexture)
        plane.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.5);
        plane.setScale(0.5)
        plane.name = myPlaneName
        self.addChild(plane)
        
        let beginButton = SKSpriteNode(texture: SKTexture(imageNamed: beginButtonName))
        beginButton.position = CGPointMake(self.size.width/2,self.size.height * 0.8)
        beginButton.name = beginButtonName
        self.addChild(beginButton)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        let location:CGPoint! = (touches as NSSet).anyObject()?.locationInNode(self)
        let node = self.nodeAtPoint(location)
        if node.name == myPlaneName {
            isTouched = true// 手指点击到飞机
        }
        if node.name == beginButtonName
        {
            //游戏开始
            node.removeFromParent()
            // 启用计时器，控制每秒执行一次tickDown方法
            NSTimer.scheduledTimerWithTimeInterval(2,target:self,selector:Selector("beginGame"),userInfo:nil,repeats:true)
        }
    }
    /**
     *计时器每秒触发事件
     **/
    func beginGame()
    {
        print("开始")
        let enemyPlane = SKSpriteNode(texture: planeTexture)
        let width = Int(self.size.width)
        enemyPlane.position = CGPointMake(CGFloat(random()%width), self.size.height);
        enemyPlane.setScale(0.25)
        self.addChild(enemyPlane)
        
        let moveUp = SKAction.moveToY(0, duration:2)
        let fadeAway = SKAction.fadeOutWithDuration(0.25)
        let remove = SKAction.removeFromParent();
        let action = SKAction.sequence([moveUp,fadeAway,remove])
        enemyPlane.runAction(action)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if isTouched {
            let location:CGPoint! = (touches as NSSet).anyObject()?.locationInNode(self)
            plane.position = CGPointMake(location.x, location.y)
        }
        
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        isTouched = false
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}