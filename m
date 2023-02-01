Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C2AC05027
	for <linux-serial@archiver.kernel.org>; Wed,  1 Feb 2023 14:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjBAO1l (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Feb 2023 09:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjBAO1k (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Feb 2023 09:27:40 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA5968123
        for <linux-serial@vger.kernel.org>; Wed,  1 Feb 2023 06:27:38 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v13so17828061eda.11
        for <linux-serial@vger.kernel.org>; Wed, 01 Feb 2023 06:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7M/mJ7SCNh4ZJGAikXzxUOzNkw+apH6YFH5D003Vlk=;
        b=YCV9rjm9hwPGBjF/U6m6hl3htwsbU7UYhS2JNw9dMTznu4FRziIoesjJF+5OC4AzoM
         2QGZyoAfUhBJkJhCMZXkng4q7dcZvg5mQC6t39Pi0CYtCRssb5YJPxPQiJcaHHKB4q7e
         R+vtxXJfwcl1/POy1Bz6W8t//ntc80M3DENyJ6jPbitZSX2NPkBDSi/b4O15VZS+lvUr
         Cf5a5qUpjykhGQuqRW/Qoet9YRiEwbH34eUXbJDIYP0quwt/vMOou5iS+UEHVl5rwigq
         J0r+VcNx6dSU+/TzqAPnJlk1owOdm5OnO+AyZ8FSr/QViJPnWLqwM9+sh8AcL0UzbTir
         TTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7M/mJ7SCNh4ZJGAikXzxUOzNkw+apH6YFH5D003Vlk=;
        b=JpJ65JOLzaTtFulMu7zpUygwm8bLckOUdJWEL5vGphEknfSxuX519/+hcc0krw1nG9
         dp1JQ0t9p6Jys4x/CfU7iHS9mIaT7WaF4WKgsW7xIISu89B45J7rozrlzQOlyGq5CjDX
         9hpCuEjPikMLY5NvBJrOhXS5HK4i//aQod7NRkJ99/JeQFcwVzadISUcio9yDyywIoNR
         sj/wDId28oZktK1/yIzc6XxoTCXTa+4rJRn9i6MbRpDrECKjn9lS8c+y4A9aDvojBbBL
         3wyqw6xfuLlQobIkMJr3qJon+2YcTwUBSQE/O/V39p7YTU4sLtHaP1QthApG8Nvs98EL
         rFhw==
X-Gm-Message-State: AO0yUKW33/0M7jRG2VIv3JbZ0pPt6XqM3UNJCxRAG5LBckvWMBVF1eey
        1pICFFjcKJkm58hX48XXFCg=
X-Google-Smtp-Source: AK7set/kIaaIMRID/oW2tAkrVicv8XG1FLdewEBb0dVt5JtW47COnx/zMjBZxbdlj4jdV9pkrVK+tA==
X-Received: by 2002:aa7:c48a:0:b0:4a2:4abc:29be with SMTP id m10-20020aa7c48a000000b004a24abc29bemr2268247edq.35.1675261657151;
        Wed, 01 Feb 2023 06:27:37 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id cf8-20020a0564020b8800b004a18f2ffb86sm8975564edb.79.2023.02.01.06.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:27:36 -0800 (PST)
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
Subject: [PATCH v1 RESEND 0/7] serial: imx: work-around for hardware RX flood, and then isr improvements
Date:   Wed,  1 Feb 2023 17:26:53 +0300
Message-Id: <20230201142700.4346-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87bko4e65y.fsf@osv.gnss.ru>
References: <87bko4e65y.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

These series contain a work-around for hardware RX flood in first 2
commits, and then further cleanups and optimizations of the receive IRQ
handler.

WARNING: the flood fix is extensively tested with older version of the
kernel with DMA turned off. The DMA path is tested only a bit, as DMA has
receive problems on my kernel version.

Changes in v1:

  * Missing braces fixed.

  * Withdrawn patch optimizing imx_uart_readl() -> readl(), on request of
    Uwe Kleine-König.

Sergey Organov (7):
  serial: imx: factor-out common code to imx_uart_soft_reset()
  serial: imx: work-around for hardware RX flood
  serial: imx: do not sysrq broken chars
  serial: imx: do not break from FIFO reading loop prematurely
  serial: imx: remove redundant USR2 read from FIFO reading loop
  serial: imx: stop using USR2 in FIFO reading loop
  serial: imx: refine local variables in rxint()

 drivers/tty/serial/imx.c | 225 ++++++++++++++++++++++++---------------
 1 file changed, 140 insertions(+), 85 deletions(-)

Interdiff against v0:
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 45327ff6dd14..447b9060d9df 100644
--- b/drivers/tty/serial/imx.c
+++ a/drivers/tty/serial/imx.c
@@ -889,14 +889,15 @@
 {
 	struct imx_port *sport = dev_id;
 	struct tty_port *port = &sport->port.state->port;
+	typeof(sport->port.membase) membase = sport->port.membase;
 	u32 usr2, rx;
 
 	/* If we received something, check for 0xff flood */
-	usr2 = imx_uart_readl(sport, USR2);
+	usr2 = readl(membase + USR2);
 	if (usr2 & USR2_RDR)
 		imx_uart_check_flood(sport, usr2);
 
-	while ((rx = imx_uart_readl(sport, URXD0)) & URXD_CHARRDY) {
+	while ((rx = readl(membase + URXD0)) & URXD_CHARRDY) {
 		unsigned int flg = TTY_NORMAL;
 		sport->port.icount.rx++;
 
@@ -928,9 +929,8 @@
 				flg = TTY_OVERRUN;
 
 			sport->port.sysrq = 0;
-		} else if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx)) {
+		} else if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
 			continue;
-		}
 
 		if (sport->port.ignore_status_mask & URXD_DUMMY_READ)
 			continue;
+- 
2.30.1

