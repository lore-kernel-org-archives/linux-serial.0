Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2A6C7619A
	for <linux-serial@archiver.kernel.org>; Wed,  5 Apr 2023 11:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbjDELTb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Apr 2023 07:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbjDELTV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Apr 2023 07:19:21 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BB655BF
        for <linux-serial@vger.kernel.org>; Wed,  5 Apr 2023 04:19:18 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id o20so33996092ljp.3
        for <linux-serial@vger.kernel.org>; Wed, 05 Apr 2023 04:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1680693556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zr/D5jNM2LuXAy18BJTEshOX4//SxsyRmKq3m/Ky3gI=;
        b=G9FWY+CpPfemuV18tJp6I5vV57uHa/pLP3g//2sgPcuUwKxV0b3TVvXhtqAoI2KL00
         /ckoEBXMtK1cJVVRR/+xWZomqZzUgF4N/R+PfWGIB1HJY0YyjnoaGRX/cMkD4RSRfDY6
         Lh5nIQJBvoZKXPSjLkTiA0PkTOON8WaBivU8VJl1xCMHKhoKrcljsLXZzkjwedPo4PnS
         CR3d1L1FPJHgzzrBkWxExiqrISe17twWvHrbf3hSLMA/SwxbYd/xEpFAaO23cMPFlUqr
         LcY6ua9Y0RVORVZeADqyFUOtjKi+jsU2I7OzMZUvBGRrmttfKj0t7Om7rIHwLcfr0iY9
         Gb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680693556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zr/D5jNM2LuXAy18BJTEshOX4//SxsyRmKq3m/Ky3gI=;
        b=gZfnjKULyCFPM+Abo7hqckcIB44x5KscNyguiafT89Uz2zNNTdaTDT5BCmq06TCkqT
         ObGPUVoMsSBSo/06w61xlNZdTb1fz0HI6I4yexGLTxwHq5nNoebhRvNvX+or+X1Ftqml
         Qgs1+zRzqDgHCX/G/FLEJClOEiIudOmGijDgm9Wv9wJ6V9EBBog3s+tEfk0HdJzz62qb
         otRe7YDCjYm/GVTK7Kt3WkKv2bUTqQ5+pqSj+1EQm/TjNu0/90Ln15OFjoT/iJHeNMn5
         ZWN3TTRiog8YWTV3UZtaR8rCwm4hykyBR9+8Sk3+Ei+7miDs7xFe4yCcyT8WgL1zzvff
         OUyg==
X-Gm-Message-State: AAQBX9ebVvj6HmkSvKgFi6fR+w0Ec7/8op3ZimyD70Yh6+hyUXFqyook
        HIbeH5Inz/DtgjwgdFYCsGrX4w==
X-Google-Smtp-Source: AKy350YQqgmQKs1sXMC5Gzd7+xiWL9laj+6oTJUkXJ/tKNBCCRr3fHGHNkMXn6grPljCzkj8S0/SQQ==
X-Received: by 2002:a2e:9784:0:b0:295:a930:d7a3 with SMTP id y4-20020a2e9784000000b00295a930d7a3mr1859021lji.15.1680693556605;
        Wed, 05 Apr 2023 04:19:16 -0700 (PDT)
Received: from lmajczak1-l.roam.corp.google.com ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id i19-20020a2e8093000000b0029f3e2efbb9sm2817730ljg.90.2023.04.05.04.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 04:19:16 -0700 (PDT)
From:   Lukasz Majczak <lma@semihalf.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        upstream@semihalf.com, Lukasz Majczak <lma@semihalf.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 2/2] serial: core: enable FIFO after resume
Date:   Wed,  5 Apr 2023 13:15:59 +0200
Message-Id: <20230405111559.110220-3-lma@semihalf.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230405111559.110220-1-lma@semihalf.com>
References: <20230405111559.110220-1-lma@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The "serial/8250: Use fifo in 8250 console driver" commit
has revealed an issue of not re-enabling FIFO after resume.
The problematic path is inside uart_resume_port() function.
First, when the console device is re-enabled,
a call to uport->ops->set_termios() internally initializes FIFO
(in serial8250_do_set_termios()), although further code
disables it by issuing ops->startup() (pointer to serial8250_do_startup,
internally calling serial8250_clear_fifos()).
There is even a comment saying "Clear the FIFO buffers and disable them.
(they will be reenabled in set_termios())", but in this scenario,
set_termios() has been called already and FIFO remains disabled.

This patch address the issue by reversing the order - first checks
if tty port is suspended and performs actions accordingly
(e.g. call to ops->startup()), then tries to re-enable
the console device after suspend (and call to uport->ops->set_termios()).

Signed-off-by: Lukasz Majczak <lma@semihalf.com>
Cc: <stable@vger.kernel.org> # 6.1+
---
 drivers/tty/serial/serial_core.c | 54 ++++++++++++++++----------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 394a05c09d87..57a153adba3a 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2406,33 +2406,6 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 	put_device(tty_dev);
 	uport->suspended = 0;
 
-	/*
-	 * Re-enable the console device after suspending.
-	 */
-	if (uart_console(uport)) {
-		/*
-		 * First try to use the console cflag setting.
-		 */
-		memset(&termios, 0, sizeof(struct ktermios));
-		termios.c_cflag = uport->cons->cflag;
-		termios.c_ispeed = uport->cons->ispeed;
-		termios.c_ospeed = uport->cons->ospeed;
-
-		/*
-		 * If that's unset, use the tty termios setting.
-		 */
-		if (port->tty && termios.c_cflag == 0)
-			termios = port->tty->termios;
-
-		if (console_suspend_enabled)
-			uart_change_pm(state, UART_PM_STATE_ON);
-		uport->ops->set_termios(uport, &termios, NULL);
-		if (!console_suspend_enabled && uport->ops->start_rx)
-			uport->ops->start_rx(uport);
-		if (console_suspend_enabled)
-			console_start(uport->cons);
-	}
-
 	if (tty_port_suspended(port)) {
 		const struct uart_ops *ops = uport->ops;
 		int ret;
@@ -2471,6 +2444,33 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 		tty_port_set_suspended(port, false);
 	}
 
+	/*
+	 * Re-enable the console device after suspending.
+	 */
+	if (uart_console(uport)) {
+		/*
+		 * First try to use the console cflag setting.
+		 */
+		memset(&termios, 0, sizeof(struct ktermios));
+		termios.c_cflag = uport->cons->cflag;
+		termios.c_ispeed = uport->cons->ispeed;
+		termios.c_ospeed = uport->cons->ospeed;
+
+		/*
+		 * If that's unset, use the tty termios setting.
+		 */
+		if (port->tty && termios.c_cflag == 0)
+			termios = port->tty->termios;
+
+		if (console_suspend_enabled)
+			uart_change_pm(state, UART_PM_STATE_ON);
+		uport->ops->set_termios(uport, &termios, NULL);
+		if (!console_suspend_enabled && uport->ops->start_rx)
+			uport->ops->start_rx(uport);
+		if (console_suspend_enabled)
+			console_start(uport->cons);
+	}
+
 	mutex_unlock(&port->mutex);
 
 	return 0;
-- 
2.40.0.577.gac1e443424-goog

