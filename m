Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2DFC004D4
	for <linux-serial@archiver.kernel.org>; Sat, 21 Jan 2023 15:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjAUPhS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Jan 2023 10:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjAUPhP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Jan 2023 10:37:15 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60F72C647
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 07:36:57 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bk15so20786522ejb.9
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 07:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9PFvNqNRiBtgoK1FQlt2dgZjVa65hIZ+MQtdwTOsMQ=;
        b=QEjQ5FTQ1p1l7Cd4SDXPKJZ6sDaKO4pSMir4BAS6hvoSdAFJ0cS+qBajfbwJV2pTJO
         x2WivqetX72P82ztk/8BSNaqx/ZIMtwfufirIk+npl3/cZ8qUhMakCz94H1xBr/3WHxh
         ywOmBlRnzvzzAP8cTsedv1lwu0D4+7aE74grKArkKVJ+WIeykONRA4PRV9/ucaH3FIYA
         LKA0BxbFTXdRw785gtB1QIJ/DUO6JseDP+AXJDDPl7HIx8xK5E3MxQEVEZJp0Lev81sl
         IJcbkwi+HZW2xqNRDkhDwV452ClQoPHLJKYRFMy1rg93qxkbztTQSFp0g2diIisN/LBz
         YhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9PFvNqNRiBtgoK1FQlt2dgZjVa65hIZ+MQtdwTOsMQ=;
        b=4D6ayM65y0V8Zwdpf4lgQGELHfdntp1ITp3qYioPheYUjp/MzMECOS6WwHuYYY8N1r
         YrDihjaD3XQr4wGLwyYIRvxsXqLprm6zZImo3mm4MQx18cqRt+srtw2cUivqdSkAQ5BN
         aEPsEJYfVqmmccLn1vBmfovnoysDsUe08nn+loDtHI1ws0dXhdKOVB9dKu+RZf5mCAtm
         DiJINq5jy7uWYDqjxi2ZRzAqBk/oMdVmuOJuzhuNXVuynzSZ37TlXovkGMqignFA+jOt
         caDbtE/sPNpWQknXuq05wdRbeUpOQZJBX9vnT8X6dm6aNVf+0Fnj+9NP43ii9BBaUuWf
         T4tA==
X-Gm-Message-State: AFqh2kqQtej3MKTjovf8RNpsqt46LKsfq0hyUEesLwYJ32Da27o8C6uh
        zoGTDgKFvOvL6gQqP2yv5vWjDF2N1K8=
X-Google-Smtp-Source: AMrXdXu8317LXKt67uugrjyibQpv8a3lJd/ELRzxu3nTo8TdR5m3rzZ6aUVDkVcdqpY+V2cnlpMPjQ==
X-Received: by 2002:a17:906:2612:b0:83f:384f:ea23 with SMTP id h18-20020a170906261200b0083f384fea23mr19222886ejc.57.1674315415953;
        Sat, 21 Jan 2023 07:36:55 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id vc10-20020a170907d08a00b008717a377125sm8187030ejc.85.2023.01.21.07.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 07:36:55 -0800 (PST)
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
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 3/7] serial: imx: do not sysrq broken chars
Date:   Sat, 21 Jan 2023 18:36:35 +0300
Message-Id: <20230121153639.15402-4-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230121153639.15402-1-sorganov@gmail.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230121153639.15402-1-sorganov@gmail.com>
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

