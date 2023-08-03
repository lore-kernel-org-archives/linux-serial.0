Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E57C41513
	for <linux-serial@archiver.kernel.org>; Thu,  3 Aug 2023 17:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbjHCR7i (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Aug 2023 13:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbjHCR7h (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Aug 2023 13:59:37 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E5D1724;
        Thu,  3 Aug 2023 10:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=NtVULQH39DKaedRtvAsV3bMzfjaWkHxn2qJBTDS6TXw=; b=h
        1LiUYoNFnb/Nx7OJHz7bnlKYuFrNhtAAQWQ3w0vQWEov+q0mzGIAzZ4kUikS7n32XgfneR0YPO0H/
        Q8eGyjqG/jzxQIRlA3u3MQ/Tg86HAoGYxxYrtjAtUlcW+fTudJmvpck9LGlae2AGQdHEvmq7mFcpp
        CGS5HswBWAOfIFSI=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:49824 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qRcbm-0002rm-0M; Thu, 03 Aug 2023 13:59:34 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     hugo@hugovil.com, linux-serial@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org
Date:   Thu,  3 Aug 2023 13:59:31 -0400
Message-Id: <20230803175931.981625-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH] serial: max310x: fix typos in comments
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

cotroller -> controller.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 416d553b73a7..04f4404fd2f4 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1400,7 +1400,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	}
 
 #ifdef CONFIG_GPIOLIB
-	/* Setup GPIO cotroller */
+	/* Setup GPIO controller */
 	s->gpio.owner		= THIS_MODULE;
 	s->gpio.parent		= dev;
 	s->gpio.label		= devtype->name;

base-commit: 426263d5fb400ccde5444748693dc75bda18f01e
-- 
2.30.2

