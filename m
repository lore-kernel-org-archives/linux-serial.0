Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9D7C001DE
	for <linux-serial@archiver.kernel.org>; Sun,  6 Aug 2023 09:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjHFJcs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 6 Aug 2023 05:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjHFJcn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 6 Aug 2023 05:32:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745D01BFC;
        Sun,  6 Aug 2023 02:32:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0433C6100A;
        Sun,  6 Aug 2023 09:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C192C433CB;
        Sun,  6 Aug 2023 09:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691314361;
        bh=plXfZ6NESmXmkMd2BEKNNu9j1SnUKyka5nXAMxoPibY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jszcQuU/5DSTnUmyu/OD+prBihCdWWfNBi3PvQsNEbzF/XlSESwy65RvAyyQjgwoo
         5SfXws34GtC7qrnzTNKj0vAU96o8+ByTIqQ9g7jOy00MRrAmM0IMWYHZN5s5I832i7
         pSJX0UjwOJKL1gxo9tiDA3vSEWc2XqUd0W0AnQcFiBxTV9XgQoBVSn+OXT1xSh27ik
         7AWShAct8DQVQLcqpjr2GQe+kYxdDjgG1v0meBZ13+Xss9fA0b+hEL5MvZRdr7OuNr
         IFU99Skw7uE02RbB1v2Tqpp57ICI61XhU1b7WI2AbmB58phtRGf68gtJ/tnz9cwl2u
         1K2z3oZr9Mmvw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] serial: 8250_dw: fall back to poll if there's no interrupt
Date:   Sun,  6 Aug 2023 17:20:56 +0800
Message-Id: <20230806092056.2467-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230806092056.2467-1-jszhang@kernel.org>
References: <20230806092056.2467-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When there's no irq(this can be due to various reasons, for example,
no irq from HW support, or we just want to use poll solution, and so
on), falling back to poll is still better than no support at all.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/tty/serial/8250/8250_dw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 7db51781289e..f4cafca1a7da 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -523,7 +523,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (!regs)
 		return dev_err_probe(dev, -EINVAL, "no registers defined\n");
 
-	irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq_optional(pdev, 0);
+	/* no interrupt -> fall back to polling */
+	if (irq == -ENXIO)
+		irq = 0;
 	if (irq < 0)
 		return irq;
 
-- 
2.40.1

