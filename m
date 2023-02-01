Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8136C636CD
	for <linux-serial@archiver.kernel.org>; Wed,  1 Feb 2023 14:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjBAO1y (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Feb 2023 09:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjBAO1r (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Feb 2023 09:27:47 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3018F6813A
        for <linux-serial@vger.kernel.org>; Wed,  1 Feb 2023 06:27:44 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id eq11so863031edb.6
        for <linux-serial@vger.kernel.org>; Wed, 01 Feb 2023 06:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9PFvNqNRiBtgoK1FQlt2dgZjVa65hIZ+MQtdwTOsMQ=;
        b=VuJERbKWYOkgt/D8s8FOfDHVNd9glpziOVsTG+1JjLTYT7jGJy1VkNDZTgK1e3AjMi
         uiTHC7h8eh40cm5Ey0iOSL2dpFDm/v98ZQMIex6y23PczBzbg88bVdaUZNd0WWg/0jOA
         JzycDx1+F+NmAh/FdYq0uN6t5s2s+R5IAZ0CchzXlf2wZRO593HSjQ8BJOyjxZ9HWs/i
         uQzPZWRRcgdGxyi/Z+02V/ktq/h+yh9NWIrVbclaJyzIOW5XSGww95ZnYMue7FOCrd9+
         TUr+d6HsTGLjHygi10C1POXJ+GgaTvnL56wA9d+DVUKNX4J2/dVnsWp5U/y7xmxOeUQY
         vjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9PFvNqNRiBtgoK1FQlt2dgZjVa65hIZ+MQtdwTOsMQ=;
        b=0y0m4n3SsH/0RYtRmDqFwFT4C8lFjaOP0ahXJ4z4Kc3dTh9xb1e4dr9RPhi7yC/ytR
         B6C6JdZda4eidGx7SVDHsWqIhyXkqG9tRCIXmJMCbF5mjSN5PtT+78psk2SeRlL2mRCS
         0gfF3iZyQatiZKhWYeDU9OMdpGBk1HLvrkOxidAEHf0fwRxeRuN9Vd9qpV+ZuegRkU83
         B0bjnboscnxrh5zSi4FQe+HPQNDESTjH3Qi749D96BNi87D0dqJZdd4szFozW2iwgKSs
         MooytjgfxxLjG9GUmbcbguql49i6hATTdEASOCCHgxDi9meojWbCh6KE8f+F7Zz5thGs
         Twhw==
X-Gm-Message-State: AO0yUKX0qTlaoOZu4wZml1T8m/siNb80ACsz6C/34tPf5eWnvsjZYzQ4
        xggi8QN1AG1d/qAFtsLmDNc=
X-Google-Smtp-Source: AK7set9hYDxvOQi0xjHhLN/X3aYvdrUsus0F/Am0ploCUlkQQm6XutLDb+3FJsBgq+1sa7AWYzsHnw==
X-Received: by 2002:a50:ccd3:0:b0:47a:e008:8662 with SMTP id b19-20020a50ccd3000000b0047ae0088662mr2526553edj.34.1675261662685;
        Wed, 01 Feb 2023 06:27:42 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id cf8-20020a0564020b8800b004a18f2ffb86sm8975564edb.79.2023.02.01.06.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:27:42 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 3/7] serial: imx: do not sysrq broken chars
Date:   Wed,  1 Feb 2023 17:26:56 +0300
Message-Id: <20230201142700.4346-4-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230201142700.4346-1-sorganov@gmail.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230201142700.4346-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Do not call uart_handle_sysrq_char() if we got any receive error along with
the character, as we don't want random junk to be considered a sysrq.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e7fce31e460d..e709118fe85c 100644
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
@@ -942,6 +939,8 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 				flg = TTY_OVERRUN;
 
 			sport->port.sysrq = 0;
+		} else if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx)) {
+			continue;
 		}
 
 		if (sport->port.ignore_status_mask & URXD_DUMMY_READ)
-- 
2.30.1

