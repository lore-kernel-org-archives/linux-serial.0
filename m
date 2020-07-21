Return-Path: <SRS0=EuFA=BA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB28C433EA
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 12:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC53206E9
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 12:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uf70pNth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgGUMLS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgGUMLR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jul 2020 08:11:17 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16FFC061794
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 05:11:17 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 207so10643808pfu.3
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 05:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4Vrr3RPHrWaZucTwZmFhL/vg7dtTdfGT3O+wG1Ixzw=;
        b=uf70pNthNkaG3TDajmNXQMzUZC357fX+gxRyGvjVoSt7QCQD+VlLfXEpUgB7chSAz6
         FuBv3g5/v5cCY5sSHmWYxMWVGAcX/6yDmSmrb+oKCinGzeScKnAwpUZ1P+tEKAnRYfs7
         Ja0AJZGiOm2s51IyFYTYMx8IDbE4GLdwb3civ6b5D0rKMcUzzulkbxVSEtYE6V95wGUm
         7ha67V/Mww5u18Pk2tOxvaKnnyy6RxjLgpmbLlXCXHSMQpfu7ZV1qj97i1Nw1Xg1LfkO
         aay91kXJy6qnhoNRyr53om2Qs7jjUp+jzFAonpY8FVRxVINqOMymAN9HH4l0ENsgeQf6
         mQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4Vrr3RPHrWaZucTwZmFhL/vg7dtTdfGT3O+wG1Ixzw=;
        b=MOtfAVgb6+d2ttj+snybhpi9zQkLef5/coZiLnciuWMQRljN87knFpUSPWt3/QhxHL
         aQMHICbNCOAOTNQp98zsOi208TssCJO7pSWvXPVPyS8jCsVNviq1wNcxc3GtOm6d0Dm+
         rriRxPhF6JIVOgooKLSsDIy1fYo4CVN52OkfJbduNZ/kWnEXMutL1cejptWymxF5RyoT
         c+LTJBdXmAG3bZAK8Ih0i45sHWS/HEdp3Vtly12t000bmPRiyiBrLabqRJu8yxDpbsCY
         F9ItWD7FWfgh1wTt688DdA53ySVZOi8AtuIam1qD+HktmEdgnE968Z77NPVZj6ZxHCzR
         uE+A==
X-Gm-Message-State: AOAM532F/ybcRo79NaXfrbb96hvNCc1nR9rnFUnFfTjVXbjrQIPcxTIP
        qiVGCfahkg5SP3zkQcUtEz+zsw==
X-Google-Smtp-Source: ABdhPJzUr3AOufOgS8kYacmYw2lEJYaoNCrAwivO0iMkoijWQgmxOSdj3Ydl+zm0ckA2gH2pdb+CWA==
X-Received: by 2002:a65:63c8:: with SMTP id n8mr22380565pgv.232.1595333477168;
        Tue, 21 Jul 2020 05:11:17 -0700 (PDT)
Received: from localhost.localdomain ([117.210.211.74])
        by smtp.gmail.com with ESMTPSA id w9sm20601992pfq.178.2020.07.21.05.11.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 05:11:16 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     gregkh@linuxfoundation.org, daniel.thompson@linaro.org,
        dianders@chromium.org, linux-serial@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net
Cc:     jslaby@suse.com, linux@armlinux.org.uk, jason.wessel@windriver.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC 5/5] serial: Remove KGDB NMI serial driver
Date:   Tue, 21 Jul 2020 17:40:13 +0530
Message-Id: <1595333413-30052-6-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This driver provided a special ttyNMI0 port to enable NMI debugging
capabilities for kgdb but it remained in silos with the serial
core/drivers which made it a bit odd to enable using serial device
interrupt and hence remained unused.

But now with the serial core/drivers becoming NMI aware which in turn
provides NMI debugging capabilities via magic sysrq, there is no specific
reason to keep this special driver. So remove it instead.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tty/serial/Kconfig    |  19 ---
 drivers/tty/serial/Makefile   |   1 -
 drivers/tty/serial/kgdb_nmi.c | 383 ------------------------------------------
 drivers/tty/serial/kgdboc.c   |   8 -
 include/linux/kgdb.h          |  10 --
 5 files changed, 421 deletions(-)
 delete mode 100644 drivers/tty/serial/kgdb_nmi.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 780908d..625d283 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -176,25 +176,6 @@ config SERIAL_ATMEL_TTYAT
 
 	  Say Y if you have an external 8250/16C550 UART.  If unsure, say N.
 
-config SERIAL_KGDB_NMI
-	bool "Serial console over KGDB NMI debugger port"
-	depends on KGDB_SERIAL_CONSOLE
-	help
-	  This special driver allows you to temporary use NMI debugger port
-	  as a normal console (assuming that the port is attached to KGDB).
-
-	  Unlike KDB's disable_nmi command, with this driver you are always
-	  able to go back to the debugger using KGDB escape sequence ($3#33).
-	  This is because this console driver processes the input in NMI
-	  context, and thus is able to intercept the magic sequence.
-
-	  Note that since the console interprets input and uses polling
-	  communication methods, for things like PPP you still must fully
-	  detach debugger port from the KGDB NMI (i.e. disable_nmi), and
-	  use raw console.
-
-	  If unsure, say N.
-
 config SERIAL_MESON
 	tristate "Meson serial port support"
 	depends on ARCH_MESON
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index d056ee6..9ea6263 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -93,5 +93,4 @@ obj-$(CONFIG_SERIAL_SIFIVE)	+= sifive.o
 # GPIOLIB helpers for modem control lines
 obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
 
-obj-$(CONFIG_SERIAL_KGDB_NMI) += kgdb_nmi.o
 obj-$(CONFIG_KGDB_SERIAL_CONSOLE) += kgdboc.o
diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
deleted file mode 100644
index 6004c0c..0000000
--- a/drivers/tty/serial/kgdb_nmi.c
+++ /dev/null
@@ -1,383 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * KGDB NMI serial console
- *
- * Copyright 2010 Google, Inc.
- *		  Arve Hjønnevåg <arve@android.com>
- *		  Colin Cross <ccross@android.com>
- * Copyright 2012 Linaro Ltd.
- *		  Anton Vorontsov <anton.vorontsov@linaro.org>
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/compiler.h>
-#include <linux/slab.h>
-#include <linux/errno.h>
-#include <linux/atomic.h>
-#include <linux/console.h>
-#include <linux/tty.h>
-#include <linux/tty_driver.h>
-#include <linux/tty_flip.h>
-#include <linux/serial_core.h>
-#include <linux/interrupt.h>
-#include <linux/hrtimer.h>
-#include <linux/tick.h>
-#include <linux/kfifo.h>
-#include <linux/kgdb.h>
-#include <linux/kdb.h>
-
-static int kgdb_nmi_knock = 1;
-module_param_named(knock, kgdb_nmi_knock, int, 0600);
-MODULE_PARM_DESC(knock, "if set to 1 (default), the special '$3#33' command " \
-			"must be used to enter the debugger; when set to 0, " \
-			"hitting return key is enough to enter the debugger; " \
-			"when set to -1, the debugger is entered immediately " \
-			"upon NMI");
-
-static char *kgdb_nmi_magic = "$3#33";
-module_param_named(magic, kgdb_nmi_magic, charp, 0600);
-MODULE_PARM_DESC(magic, "magic sequence to enter NMI debugger (default $3#33)");
-
-static atomic_t kgdb_nmi_num_readers = ATOMIC_INIT(0);
-
-static int kgdb_nmi_console_setup(struct console *co, char *options)
-{
-	arch_kgdb_ops.enable_nmi(1);
-
-	/* The NMI console uses the dbg_io_ops to issue console messages. To
-	 * avoid duplicate messages during kdb sessions we must inform kdb's
-	 * I/O utilities that messages sent to the console will automatically
-	 * be displayed on the dbg_io.
-	 */
-	dbg_io_ops->cons = co;
-
-	return 0;
-}
-
-static void kgdb_nmi_console_write(struct console *co, const char *s, uint c)
-{
-	int i;
-
-	for (i = 0; i < c; i++)
-		dbg_io_ops->write_char(s[i]);
-}
-
-static struct tty_driver *kgdb_nmi_tty_driver;
-
-static struct tty_driver *kgdb_nmi_console_device(struct console *co, int *idx)
-{
-	*idx = co->index;
-	return kgdb_nmi_tty_driver;
-}
-
-static struct console kgdb_nmi_console = {
-	.name	= "ttyNMI",
-	.setup  = kgdb_nmi_console_setup,
-	.write	= kgdb_nmi_console_write,
-	.device	= kgdb_nmi_console_device,
-	.flags	= CON_PRINTBUFFER | CON_ANYTIME,
-	.index	= -1,
-};
-
-/*
- * This is usually the maximum rate on debug ports. We make fifo large enough
- * to make copy-pasting to the terminal usable.
- */
-#define KGDB_NMI_BAUD		115200
-#define KGDB_NMI_FIFO_SIZE	roundup_pow_of_two(KGDB_NMI_BAUD / 8 / HZ)
-
-struct kgdb_nmi_tty_priv {
-	struct tty_port port;
-	struct timer_list timer;
-	STRUCT_KFIFO(char, KGDB_NMI_FIFO_SIZE) fifo;
-};
-
-static struct tty_port *kgdb_nmi_port;
-
-static void kgdb_tty_recv(int ch)
-{
-	struct kgdb_nmi_tty_priv *priv;
-	char c = ch;
-
-	if (!kgdb_nmi_port || ch < 0)
-		return;
-	/*
-	 * Can't use port->tty->driver_data as tty might be not there. Timer
-	 * will check for tty and will get the ref, but here we don't have to
-	 * do that, and actually, we can't: we're in NMI context, no locks are
-	 * possible.
-	 */
-	priv = container_of(kgdb_nmi_port, struct kgdb_nmi_tty_priv, port);
-	kfifo_in(&priv->fifo, &c, 1);
-}
-
-static int kgdb_nmi_poll_one_knock(void)
-{
-	static int n;
-	int c = -1;
-	const char *magic = kgdb_nmi_magic;
-	size_t m = strlen(magic);
-	bool printch = false;
-
-	c = dbg_io_ops->read_char();
-	if (c == NO_POLL_CHAR)
-		return c;
-
-	if (!kgdb_nmi_knock && (c == '\r' || c == '\n')) {
-		return 1;
-	} else if (c == magic[n]) {
-		n = (n + 1) % m;
-		if (!n)
-			return 1;
-		printch = true;
-	} else {
-		n = 0;
-	}
-
-	if (atomic_read(&kgdb_nmi_num_readers)) {
-		kgdb_tty_recv(c);
-		return 0;
-	}
-
-	if (printch) {
-		kdb_printf("%c", c);
-		return 0;
-	}
-
-	kdb_printf("\r%s %s to enter the debugger> %*s",
-		   kgdb_nmi_knock ? "Type" : "Hit",
-		   kgdb_nmi_knock ? magic  : "<return>", (int)m, "");
-	while (m--)
-		kdb_printf("\b");
-	return 0;
-}
-
-/**
- * kgdb_nmi_poll_knock - Check if it is time to enter the debugger
- *
- * "Serial ports are often noisy, especially when muxed over another port (we
- * often use serial over the headset connector). Noise on the async command
- * line just causes characters that are ignored, on a command line that blocked
- * execution noise would be catastrophic." -- Colin Cross
- *
- * So, this function implements KGDB/KDB knocking on the serial line: we won't
- * enter the debugger until we receive a known magic phrase (which is actually
- * "$3#33", known as "escape to KDB" command. There is also a relaxed variant
- * of knocking, i.e. just pressing the return key is enough to enter the
- * debugger. And if knocking is disabled, the function always returns 1.
- */
-bool kgdb_nmi_poll_knock(void)
-{
-	if (kgdb_nmi_knock < 0)
-		return true;
-
-	while (1) {
-		int ret;
-
-		ret = kgdb_nmi_poll_one_knock();
-		if (ret == NO_POLL_CHAR)
-			return false;
-		else if (ret == 1)
-			break;
-	}
-	return true;
-}
-
-/*
- * The tasklet is cheap, it does not cause wakeups when reschedules itself,
- * instead it waits for the next tick.
- */
-static void kgdb_nmi_tty_receiver(struct timer_list *t)
-{
-	struct kgdb_nmi_tty_priv *priv = from_timer(priv, t, timer);
-	char ch;
-
-	priv->timer.expires = jiffies + (HZ/100);
-	add_timer(&priv->timer);
-
-	if (likely(!atomic_read(&kgdb_nmi_num_readers) ||
-		   !kfifo_len(&priv->fifo)))
-		return;
-
-	while (kfifo_out(&priv->fifo, &ch, 1))
-		tty_insert_flip_char(&priv->port, ch, TTY_NORMAL);
-	tty_flip_buffer_push(&priv->port);
-}
-
-static int kgdb_nmi_tty_activate(struct tty_port *port, struct tty_struct *tty)
-{
-	struct kgdb_nmi_tty_priv *priv =
-	    container_of(port, struct kgdb_nmi_tty_priv, port);
-
-	kgdb_nmi_port = port;
-	priv->timer.expires = jiffies + (HZ/100);
-	add_timer(&priv->timer);
-
-	return 0;
-}
-
-static void kgdb_nmi_tty_shutdown(struct tty_port *port)
-{
-	struct kgdb_nmi_tty_priv *priv =
-	    container_of(port, struct kgdb_nmi_tty_priv, port);
-
-	del_timer(&priv->timer);
-	kgdb_nmi_port = NULL;
-}
-
-static const struct tty_port_operations kgdb_nmi_tty_port_ops = {
-	.activate	= kgdb_nmi_tty_activate,
-	.shutdown	= kgdb_nmi_tty_shutdown,
-};
-
-static int kgdb_nmi_tty_install(struct tty_driver *drv, struct tty_struct *tty)
-{
-	struct kgdb_nmi_tty_priv *priv;
-	int ret;
-
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	INIT_KFIFO(priv->fifo);
-	timer_setup(&priv->timer, kgdb_nmi_tty_receiver, 0);
-	tty_port_init(&priv->port);
-	priv->port.ops = &kgdb_nmi_tty_port_ops;
-	tty->driver_data = priv;
-
-	ret = tty_port_install(&priv->port, drv, tty);
-	if (ret) {
-		pr_err("%s: can't install tty port: %d\n", __func__, ret);
-		goto err;
-	}
-	return 0;
-err:
-	tty_port_destroy(&priv->port);
-	kfree(priv);
-	return ret;
-}
-
-static void kgdb_nmi_tty_cleanup(struct tty_struct *tty)
-{
-	struct kgdb_nmi_tty_priv *priv = tty->driver_data;
-
-	tty->driver_data = NULL;
-	tty_port_destroy(&priv->port);
-	kfree(priv);
-}
-
-static int kgdb_nmi_tty_open(struct tty_struct *tty, struct file *file)
-{
-	struct kgdb_nmi_tty_priv *priv = tty->driver_data;
-	unsigned int mode = file->f_flags & O_ACCMODE;
-	int ret;
-
-	ret = tty_port_open(&priv->port, tty, file);
-	if (!ret && (mode == O_RDONLY || mode == O_RDWR))
-		atomic_inc(&kgdb_nmi_num_readers);
-
-	return ret;
-}
-
-static void kgdb_nmi_tty_close(struct tty_struct *tty, struct file *file)
-{
-	struct kgdb_nmi_tty_priv *priv = tty->driver_data;
-	unsigned int mode = file->f_flags & O_ACCMODE;
-
-	if (mode == O_RDONLY || mode == O_RDWR)
-		atomic_dec(&kgdb_nmi_num_readers);
-
-	tty_port_close(&priv->port, tty, file);
-}
-
-static void kgdb_nmi_tty_hangup(struct tty_struct *tty)
-{
-	struct kgdb_nmi_tty_priv *priv = tty->driver_data;
-
-	tty_port_hangup(&priv->port);
-}
-
-static int kgdb_nmi_tty_write_room(struct tty_struct *tty)
-{
-	/* Actually, we can handle any amount as we use polled writes. */
-	return 2048;
-}
-
-static int kgdb_nmi_tty_write(struct tty_struct *tty, const unchar *buf, int c)
-{
-	int i;
-
-	for (i = 0; i < c; i++)
-		dbg_io_ops->write_char(buf[i]);
-	return c;
-}
-
-static const struct tty_operations kgdb_nmi_tty_ops = {
-	.open		= kgdb_nmi_tty_open,
-	.close		= kgdb_nmi_tty_close,
-	.install	= kgdb_nmi_tty_install,
-	.cleanup	= kgdb_nmi_tty_cleanup,
-	.hangup		= kgdb_nmi_tty_hangup,
-	.write_room	= kgdb_nmi_tty_write_room,
-	.write		= kgdb_nmi_tty_write,
-};
-
-int kgdb_register_nmi_console(void)
-{
-	int ret;
-
-	if (!arch_kgdb_ops.enable_nmi)
-		return 0;
-
-	kgdb_nmi_tty_driver = alloc_tty_driver(1);
-	if (!kgdb_nmi_tty_driver) {
-		pr_err("%s: cannot allocate tty\n", __func__);
-		return -ENOMEM;
-	}
-	kgdb_nmi_tty_driver->driver_name	= "ttyNMI";
-	kgdb_nmi_tty_driver->name		= "ttyNMI";
-	kgdb_nmi_tty_driver->num		= 1;
-	kgdb_nmi_tty_driver->type		= TTY_DRIVER_TYPE_SERIAL;
-	kgdb_nmi_tty_driver->subtype		= SERIAL_TYPE_NORMAL;
-	kgdb_nmi_tty_driver->flags		= TTY_DRIVER_REAL_RAW;
-	kgdb_nmi_tty_driver->init_termios	= tty_std_termios;
-	tty_termios_encode_baud_rate(&kgdb_nmi_tty_driver->init_termios,
-				     KGDB_NMI_BAUD, KGDB_NMI_BAUD);
-	tty_set_operations(kgdb_nmi_tty_driver, &kgdb_nmi_tty_ops);
-
-	ret = tty_register_driver(kgdb_nmi_tty_driver);
-	if (ret) {
-		pr_err("%s: can't register tty driver: %d\n", __func__, ret);
-		goto err_drv_reg;
-	}
-
-	register_console(&kgdb_nmi_console);
-
-	return 0;
-err_drv_reg:
-	put_tty_driver(kgdb_nmi_tty_driver);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(kgdb_register_nmi_console);
-
-int kgdb_unregister_nmi_console(void)
-{
-	int ret;
-
-	if (!arch_kgdb_ops.enable_nmi)
-		return 0;
-	arch_kgdb_ops.enable_nmi(0);
-
-	ret = unregister_console(&kgdb_nmi_console);
-	if (ret)
-		return ret;
-
-	ret = tty_unregister_driver(kgdb_nmi_tty_driver);
-	if (ret)
-		return ret;
-	put_tty_driver(kgdb_nmi_tty_driver);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(kgdb_unregister_nmi_console);
diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 84ffede..e959e72 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -158,8 +158,6 @@ static void cleanup_kgdboc(void)
 	if (configured != 1)
 		return;
 
-	if (kgdb_unregister_nmi_console())
-		return;
 	kgdboc_unregister_kbd();
 	kgdb_unregister_io_module(&kgdboc_io_ops);
 }
@@ -210,16 +208,10 @@ static int configure_kgdboc(void)
 	if (err)
 		goto noconfig;
 
-	err = kgdb_register_nmi_console();
-	if (err)
-		goto nmi_con_failed;
-
 	configured = 1;
 
 	return 0;
 
-nmi_con_failed:
-	kgdb_unregister_io_module(&kgdboc_io_ops);
 noconfig:
 	kgdboc_unregister_kbd();
 	configured = 0;
diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 529116b..2e8c5de 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -294,16 +294,6 @@ extern const struct kgdb_arch		arch_kgdb_ops;
 
 extern unsigned long kgdb_arch_pc(int exception, struct pt_regs *regs);
 
-#ifdef CONFIG_SERIAL_KGDB_NMI
-extern int kgdb_register_nmi_console(void);
-extern int kgdb_unregister_nmi_console(void);
-extern bool kgdb_nmi_poll_knock(void);
-#else
-static inline int kgdb_register_nmi_console(void) { return 0; }
-static inline int kgdb_unregister_nmi_console(void) { return 0; }
-static inline bool kgdb_nmi_poll_knock(void) { return true; }
-#endif
-
 extern int kgdb_register_io_module(struct kgdb_io *local_kgdb_io_ops);
 extern void kgdb_unregister_io_module(struct kgdb_io *local_kgdb_io_ops);
 extern struct kgdb_io *dbg_io_ops;
-- 
2.7.4

