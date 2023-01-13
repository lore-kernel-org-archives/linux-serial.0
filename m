Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1DEC54EBD
	for <linux-serial@archiver.kernel.org>; Fri, 13 Jan 2023 18:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjAMSoV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Jan 2023 13:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjAMSny (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Jan 2023 13:43:54 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF2D392F5
        for <linux-serial@vger.kernel.org>; Fri, 13 Jan 2023 10:43:51 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o20so2368645lfk.5
        for <linux-serial@vger.kernel.org>; Fri, 13 Jan 2023 10:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4rfVI/XJr5X+KumzfTQcZa08y9SOr59F+VA0vvNt8Y=;
        b=HiA03k7vO+25XVOg1p3rcNpZ+bitaCG9UPkD8GsVXWwB8igzePAu2VcREZWn5HvjwJ
         QWqMWKFsk42V1qIx92+u8sF9cje9g6hgZvtMcTi0dqaHY1MWnKp9j7K7Z27u2UDcXjQC
         jVyzWwj7nh3+fEFxrGWaJInUv3RaPLlxdvjVj2E6zbnkctwxQcoMACOIs/wX5bHxAixG
         UfXaJ/9F3QUIcjMqtYQew/mcVjC9TY98VYivwNzaBBh6uU/l/U5iyMFrtZBxQIKa6ADq
         pRQttmB0Kphnf+l240qyAAxXQ4DpGPCuF0Qe5bM1w1NVdkkxQslUapQrGKxtSmc9AJ2t
         zJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4rfVI/XJr5X+KumzfTQcZa08y9SOr59F+VA0vvNt8Y=;
        b=VW63JH5Sxhu2l9LUPqsS6M1e5or8zN5GWKyMI6H/XrxKVkRZuW0n4C4GqYAn68VvKi
         LgFgcCb2Ntg6dgRhPdgK7N8pjSy7K/4NOVnqK+pAWEaLb2tM5cCQUoJGI1xQo0g3lK+l
         VBPeg9iK99zH1BQjQc0VBbH0T+qPfi/UV1l/7n7lylMFcLdvjs6XIqK2HL9/HUr0kyHp
         o57+lpFBMxJL18eTqVME8ssWLlCCw4n6Q90/BGLc1eTmh/s0gS8ZM5tcrUAppcCbh/rS
         Kqncp/yDNVncvVLF6FtY5ZMGkI8/ATF5BrIJzbA9mE5FIFzX7DEGUgdgezP6XRIYoQJe
         wHhg==
X-Gm-Message-State: AFqh2kqcGUuk8FjEMQDIxC1LnEoF481vlxqGAONPqGEKbg/LG8n7bssb
        PQAEMfXieOQmTklOqCn0MmA2oZA9aZA=
X-Google-Smtp-Source: AMrXdXsNvkqfT6j8HmsmKrH7FqifRSqm0j/FphLvcrSiVbhnqJHZdakyCGULs2BXzKrIEAyuSm6Ctg==
X-Received: by 2002:ac2:484c:0:b0:4a4:68b8:c2b6 with SMTP id 12-20020ac2484c000000b004a468b8c2b6mr252565lfy.13.1673635431051;
        Fri, 13 Jan 2023 10:43:51 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o11-20020ac2434b000000b004cc9ddce3adsm1261439lfl.82.2023.01.13.10.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 10:43:50 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 7/8] serial: imx: use readl() to optimize FIFO reading loop
Date:   Fri, 13 Jan 2023 21:43:33 +0300
Message-Id: <20230113184334.287130-8-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230113184334.287130-1-sorganov@gmail.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230113184334.287130-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use readl() instead of heavier imx_uart_readl() in the Rx ISR, as we know
we read registers that must not be cached.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index be00362b8b67..f4236e8995fa 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -890,14 +890,15 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 	struct imx_port *sport = dev_id;
 	unsigned int rx, flg;
 	struct tty_port *port = &sport->port.state->port;
+	typeof(sport->port.membase) membase = sport->port.membase;
 	u32 usr2;
 
 	/* If we received something, check for 0xff flood */
-	usr2 = imx_uart_readl(sport, USR2);
+	usr2 = readl(membase + USR2);
 	if (usr2 & USR2_RDR)
 		imx_uart_check_flood(sport, usr2);
 
-	while ((rx = imx_uart_readl(sport, URXD0)) & URXD_CHARRDY) {
+	while ((rx = readl(membase + URXD0)) & URXD_CHARRDY) {
 		flg = TTY_NORMAL;
 		sport->port.icount.rx++;
 
-- 
2.30.1

