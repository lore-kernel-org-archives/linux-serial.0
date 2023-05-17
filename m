Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F07CC77B75
	for <linux-serial@archiver.kernel.org>; Wed, 17 May 2023 14:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjEQOMm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 17 May 2023 10:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjEQOMl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 May 2023 10:12:41 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343FB1701;
        Wed, 17 May 2023 07:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=K0/NQ2Lp/XTRzOV/EA3J1QX3fKqgngHY8xvfRZV0kl8=; b=e
        RMkw991QT8kDW2JH5WUNnG3BeTR/C5yFP+Cd2xiwA+L9sVl5VyyqPiQZhBs08eOUP3yWtFhws9anA
        fwKb/8CSUzHybYQHsnQm0ro/HQLZjobkT9Qk9N1hfbYRPaCf4KF4nUU240PW7gkW0mLHUfkTfpj29
        S3uW9X26sa739Hv0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:59502 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pzHtI-0006nK-FO; Wed, 17 May 2023 10:12:32 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 17 May 2023 10:12:29 -0400
Message-Id: <20230517141229.3792446-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH] serial: sc16is7xx: fix syntax error in comments
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

cotroller -> controller

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index abad091baeea..5bd98e4316f5 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1501,7 +1501,7 @@ static int sc16is7xx_probe(struct device *dev,
 
 #ifdef CONFIG_GPIOLIB
 	if (devtype->nr_gpio) {
-		/* Setup GPIO cotroller */
+		/* Setup GPIO controller */
 		s->gpio.owner		 = THIS_MODULE;
 		s->gpio.parent		 = dev;
 		s->gpio.label		 = dev_name(dev);
-- 
2.30.2

