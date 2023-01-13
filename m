Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E977EC678D4
	for <linux-serial@archiver.kernel.org>; Fri, 13 Jan 2023 18:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjAMSnu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Jan 2023 13:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjAMSns (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Jan 2023 13:43:48 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E5B209
        for <linux-serial@vger.kernel.org>; Fri, 13 Jan 2023 10:43:46 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j17so34352960lfr.3
        for <linux-serial@vger.kernel.org>; Fri, 13 Jan 2023 10:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uSogoDZIxozQW5QEm2zGToSkpBWHSYVqPpGas5pKh8=;
        b=TR0PtLOgazeFx4JTnDSy1KbfiovsMAKfP5Httj5Bcv8O0FaCWJP41G6xvzqpsRhaTk
         tlnCXfjwHYb40BlO7LkuTjZSSycCwZWgp+ij13dWYzb/fPEE5/86IgJ4ShEvD8yhRWcS
         OORMkGKiNQx5xYcFM61F+2SfejYzUh/K/NSLME5HPh19Y7BlpbwIT6P5Vo3KbamsSf07
         vubxy6zIxbcIdcVhFi3wfGrI6TZxfyKHmMorp3+deiowuiaA+dam3XbKAErYVdUmiOap
         Qrh+u/gyVpqcS9VEnXoMFEFbPT7I674ryim/3s9J69M5q6MOr/TlaXtf9USozUW8bUoo
         pZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uSogoDZIxozQW5QEm2zGToSkpBWHSYVqPpGas5pKh8=;
        b=uTnVNP7Prb8PugB7uvYts8p+MgCQuhDJy/WpFzrclQv10gXYwCfNjpPvKVU+mSxBbZ
         LF9ctnr1jU1/evKMLN4pQrOramZohfMCTQEOgD08Tv6gkUclEy0rE5myw5/o3FEx0LmO
         aOs1ycShrX7R5akj7D8Fxbs6dWLi8IgHj/cIAKsXbpy2B/bXEMF5XIJx7Qu5vkaabRcn
         ML1kv7F4vy0l5pz+M7S5Cv826p+0aozxr3GL62pbap9o9F5FJPTSCx6z8vFI5BfnMriw
         JvMgRQMfltNzGyCSQVP867v5xsJLm3WaMAi9EbxKrkvtAsTEWxUJLmi+DakgFPrwA6UU
         lG5g==
X-Gm-Message-State: AFqh2kpdVaS9eDCZWkjEmyz5fZnuf/J0FDUTduHwv9e01MrKARwa7Uk2
        FQSdf1dSG4+xJ79aPGCGV0tAAbBqMDQ=
X-Google-Smtp-Source: AMrXdXv2v9QEPDicYWZ6C8d5dObmPqiC3pJ1vOYx0+av0mtu3SOR4E0mlyiirZ5mjQCR8HrdllC0GA==
X-Received: by 2002:a05:6512:2349:b0:4a4:68b9:66cd with SMTP id p9-20020a056512234900b004a468b966cdmr23194583lfu.24.1673635424853;
        Fri, 13 Jan 2023 10:43:44 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o11-20020ac2434b000000b004cc9ddce3adsm1261439lfl.82.2023.01.13.10.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 10:43:44 -0800 (PST)
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
Subject: [PATCH 3/8] serial: imx: do not sysrq broken chars
Date:   Fri, 13 Jan 2023 21:43:29 +0300
Message-Id: <20230113184334.287130-4-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230113184334.287130-1-sorganov@gmail.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230113184334.287130-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Do not call uart_handle_sysrq_char() if we got any receive error along with
the character, as we don't want random junk to be considered a sysrq.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e7fce31e460d..1c950112a598 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -911,9 +911,6 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 				continue;
 		}
 
-		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
-			continue;
-
 		if (unlikely(rx & URXD_ERR)) {
 			if (rx & URXD_BRK)
 				sport->port.icount.brk++;
@@ -942,7 +939,8 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 				flg = TTY_OVERRUN;
 
 			sport->port.sysrq = 0;
-		}
+		} else if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
+			continue;
 
 		if (sport->port.ignore_status_mask & URXD_DUMMY_READ)
 			goto out;
-- 
2.30.1

