Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C924C3DA78
	for <linux-serial@archiver.kernel.org>; Fri, 13 Jan 2023 18:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjAMSoH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Jan 2023 13:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjAMSnt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Jan 2023 13:43:49 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F4B1EC5D
        for <linux-serial@vger.kernel.org>; Fri, 13 Jan 2023 10:43:48 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id y25so34307599lfa.9
        for <linux-serial@vger.kernel.org>; Fri, 13 Jan 2023 10:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEuxX1Ll6053jaM5wYHpbycjGtKOkT1kwUWem6LtYrM=;
        b=Qv3ZTHYSreLfmMGbsEJVQeKAj0Rsp2AJskikpPzMRGkYLhwu1mXNJoM40qhoqE2Q2N
         uvKLSM6tPyqNDvP4FVR3V6bs2ptSBvEAVoyXwumN6eTN6gmMZayssMjpShx1E4HGJTqa
         842DzUOAgACQtCZe2pgOxXqw55+UfF5XeL9RPfyv798meJ2/U2jWSkOrSTnNXYu7r9cW
         Jc9TJUmBENDr2gbsacQroSK/NgVhIDxBwCDR/svbH7hn/C6RCxVAR6kETLPsU/aHg1DF
         Es4c2eRfGJrbmAUPRjeiqpkg3bDP304P1eL60EgJgkQjZTPku1KA2VIQF4nWu9aKlqwH
         GuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEuxX1Ll6053jaM5wYHpbycjGtKOkT1kwUWem6LtYrM=;
        b=AaYoVvTOKIDcYVwN7mvTIRivoCoIqS4PKQ4kJe76vBkl9STqlf7b9nep7dEOICIxg6
         07zPMDMzYHKQ4kD18060kRVLZhxeAPITVLtUOBOny2BuDLVX5o7VaeQ5FP4jUhOIkKW8
         0s5u0qruee7RuW3ZMNtB4usCIWh6vLNLtRmH0Uc/ZDxmndiakwF4xaiAWTTPYNkTK80C
         XjzPbRfoYVZF5VWI7FgIXV5BJYjpHXIVrlgN+4FQcSnX9oJ42tJYFmhYsxYDNx65/7Vg
         aRFY1Bs5nYTBZZqtXG3pFKEupKm/zbuGBYYn3rWKhZ5sVmbzCjNG1Q6EpydLf7hQL9xy
         AqEA==
X-Gm-Message-State: AFqh2krO8P/+EkrHfhza/9ZSziaNyaS2E1K3d4vgBJo92YhbKlizqTg9
        sPMvALYKrHRjtLvFm6J4BPExhlRSkz8=
X-Google-Smtp-Source: AMrXdXvFqBm0yaQK2e38U4fE47XqSrNqGwyGOCkcCBfg8zyQzVL6ozWAI3Dhet38lYjyS8B+I/lR5Q==
X-Received: by 2002:a05:6512:10d0:b0:4cb:4374:cc78 with SMTP id k16-20020a05651210d000b004cb4374cc78mr16172770lfg.26.1673635426335;
        Fri, 13 Jan 2023 10:43:46 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o11-20020ac2434b000000b004cc9ddce3adsm1261439lfl.82.2023.01.13.10.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 10:43:45 -0800 (PST)
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
Subject: [PATCH 4/8] serial: imx: do not break from FIFO reading loop prematurely
Date:   Fri, 13 Jan 2023 21:43:30 +0300
Message-Id: <20230113184334.287130-5-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230113184334.287130-1-sorganov@gmail.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230113184334.287130-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is no reason to prematurely break out of FIFO reading loop, and it
might cause needless reenters into ISR, so keep reading until FIFO is
empty.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1c950112a598..b96b0edc7854 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -888,7 +888,7 @@ static void imx_uart_check_flood(struct imx_port *sport, u32 usr2)
 static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 {
 	struct imx_port *sport = dev_id;
-	unsigned int rx, flg, ignored = 0;
+	unsigned int rx, flg;
 	struct tty_port *port = &sport->port.state->port;
 	u32 usr2;
 
@@ -921,11 +921,8 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 			if (rx & URXD_OVRRUN)
 				sport->port.icount.overrun++;
 
-			if (rx & sport->port.ignore_status_mask) {
-				if (++ignored > 100)
-					goto out;
+			if (rx & sport->port.ignore_status_mask)
 				continue;
-			}
 
 			rx &= (sport->port.read_status_mask | 0xFF);
 
@@ -943,13 +940,12 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 			continue;
 
 		if (sport->port.ignore_status_mask & URXD_DUMMY_READ)
-			goto out;
+			continue;
 
 		if (tty_insert_flip_char(port, rx, flg) == 0)
 			sport->port.icount.buf_overrun++;
 	}
 
-out:
 	tty_flip_buffer_push(port);
 
 	return IRQ_HANDLED;
-- 
2.30.1

