Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4B21DF255
	for <linux-serial@vger.kernel.org>; Wed, 29 Jan 2025 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738168054; cv=none; b=aP1us4lzy575VGNqD0a+I4QGt7dLrFkba9w5SGDvkb5dD2JjZl3zrjGCgQAYM5KXEXKjwg7TVu230GlaHuNSr2lwmkbrmgA8KueJUR1W9ndv2om833dMEH0LfPqL9m3atjE1ZUecvZPZlOeiIWkHve2N617e+TpTSvbjCtBHxqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738168054; c=relaxed/simple;
	bh=eCIe90KSZZjMhV6TiRvo2SpTu80tDOCPWm0m8q0S1wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnC8DW7jA1arHdblp94xkb4ieK04DLOtaDTPrE+NdZPJ93dPbirYEjBA5Kfflee1STvRr/4dC1gqm+jM90S+uo4ZzdfmWQ1NeFAcFQtjjMMQWxY9XYA5SWANQRhfYhxvESkTrigVWpTB/DIZgxFzkibAKRppLqklcB59p7kJa18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FUkKoV6H; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FUkKoV6H"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2166651f752so13656095ad.3
        for <linux-serial@vger.kernel.org>; Wed, 29 Jan 2025 08:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738168052; x=1738772852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaOowRFYa0+jqNGGGruKV2+3LEXvyHbn984ywn70T5s=;
        b=FUkKoV6HOJDVlesUMJZ3ZMvtEtAYChGD+Ciduf8BREHknAtsbIHS/+FIMUxNy0P2xx
         TyJn+TruKL4JxTAc/Ef7GeZ5eKjvrONPts7lxeLQjuCvg7f/+J+DPyohoLzGkVOCbsbl
         HmVMoxUa/uGE+n1+m1BLSSz3asISJHgLxHBdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738168052; x=1738772852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaOowRFYa0+jqNGGGruKV2+3LEXvyHbn984ywn70T5s=;
        b=l40mjCbVj8UEPiBb4sdwbvocw38EWNB3ewLFmyArB7SgC3PKvcK4bbXdeBPVx7hh8Q
         M8Kb6g/IWG/07s9hqt3ZLcy2Rj0RRL7q2XwMxA9AZKPp5UShtn96kVtiQ6GLNziRc2hd
         lSDL5npPWyJIyachsmV32VVVDbhO67phEpkysRG6hZmuKMQoaMo8fYV/us5dJrd+P+KW
         LEw1kHTZONJ5yGKDZmcch4EN2N0LMt0yLjbSp1MBb/8KdYxt/qJfXAISzKAVt47QcwAX
         fcNTpVobAd/7QPILUyhgRNT6c3dF4Br6bqFUgiDQdK1eKt84uDJX0Cv60SShW8Mxao4H
         CVfw==
X-Forwarded-Encrypted: i=1; AJvYcCUH/5IhhcKPAEBbldj4QcYZXMRUn4PeccK/iEbfC2R7ZYrOAZcP5efg21sAhSkzjOFZ6gymu5hWShIu+q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT0Dgbtuv07MQsAqzPc44PBQSJh8OwGDXBMDOB/SLeoAIO92cd
	wgw2TZ1x6+lDayPzoAH6eJLU4pyhu3h9+vYo6/EFKM3gi2SUOesemEVQ0v4yDA==
X-Gm-Gg: ASbGncuzW4uMkVuwi56AReyJ7Tm6/PI33Hs8GYRAM9Gg8af1yZyPuykm2n1ssMSiOQg
	Lq/G043fICzSYlnFWjxfT2tQaV3/l9LCMSj67ddOkNcp+TOvBQRT47V5fIxgVxX2UcbINKB6Cxj
	YyrL7W1F28pZA2O8knfadIniMBnJub+sfatj7YB/wNx4Aq30DGxxRNLVtV2G8VDWETug7LjjRus
	C+c0NeUBPho3jbykzEujP0Ctenlx4ft1yQHxF8nSBRW+o3oXOg19dECjZqFFQtmJWA0Imjj1HdD
	wsi4t2gUvwTj2BqsGfFnwTCgX+vpf+MjSjI=
X-Google-Smtp-Source: AGHT+IEep8oa1oyp67kZc81SS3mOu+E4wpbyZri1DcdrjkAF5D1o6gTTmENkyrk+Z2nkxLrI6opl3g==
X-Received: by 2002:a05:6a20:9e46:b0:1db:eff0:6ae7 with SMTP id adf61e73a8af0-1ed7a5d5366mr5884564637.33.1738168052269;
        Wed, 29 Jan 2025 08:27:32 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fa8a:f68a:6cb9:40b2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac496cb4810sm10577009a12.66.2025.01.29.08.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 08:27:31 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Daniel Thompson <danielt@kernel.org>
Cc: "Dr . David Alan Gilbert" <linux@treblig.org>,
	kgdb-bugreport@lists.sourceforge.net,
	Anton Vorontsov <anton.vorontsov@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	linux-serial@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Revert "tty/serial: Add kgdb_nmi driver"
Date: Wed, 29 Jan 2025 08:25:50 -0800
Message-ID: <20250129082535.1.Ia095eac1ae357f87d23e7af2206741f5d40788f1@changeid>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
In-Reply-To: <20250129162700.848018-1-dianders@chromium.org>
References: <20250129162700.848018-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This reverts commit 0c57dfcc6c1d037243c2f8fbf62eab3633326ec0.

The functionality was supoosed to be used by a later patch in the
series that never landed [1]. Drop it.

NOTE: part of functionality was already reverted by commit
39d0be87438a ("serial: kgdb_nmi: Remove unused knock code"). Also note
that this revert is not a clean revert given code changes that have
happened in the meantime.

It's obvious that nobody is using this code since the two exposed
functions (kgdb_register_nmi_console() and
kgdb_unregister_nmi_console()) are both no-ops if
"arch_kgdb_ops.enable_nmi" is not defined. No architectures define it.

[1] https://lore.kernel.org/lkml/1348522080-32629-9-git-send-email-anton.vorontsov@linaro.org/

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/Kconfig    |  19 ---
 drivers/tty/serial/Makefile   |   1 -
 drivers/tty/serial/kgdb_nmi.c | 280 ----------------------------------
 drivers/tty/serial/kgdboc.c   |   8 -
 include/linux/kgdb.h          |   8 -
 5 files changed, 316 deletions(-)
 delete mode 100644 drivers/tty/serial/kgdb_nmi.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 976dae3bb1bb..f21cad6aaa47 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -179,25 +179,6 @@ config SERIAL_ATMEL_TTYAT
 
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
 	depends on ARCH_MESON || COMPILE_TEST
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 6ff74f0a9530..3019260d9120 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -96,6 +96,5 @@ obj-$(CONFIG_SERIAL_ZS)			+= zs.o
 # GPIOLIB helpers for modem control lines
 obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
 
-obj-$(CONFIG_SERIAL_KGDB_NMI) += kgdb_nmi.o
 obj-$(CONFIG_KGDB_SERIAL_CONSOLE) += kgdboc.o
 obj-$(CONFIG_SERIAL_NUVOTON_MA35D1) += ma35d1_serial.o
diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
deleted file mode 100644
index 2833708e369f..000000000000
--- a/drivers/tty/serial/kgdb_nmi.c
+++ /dev/null
@@ -1,280 +0,0 @@
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
-static unsigned int kgdb_nmi_tty_write_room(struct tty_struct *tty)
-{
-	/* Actually, we can handle any amount as we use polled writes. */
-	return 2048;
-}
-
-static ssize_t kgdb_nmi_tty_write(struct tty_struct *tty, const u8 *buf,
-				  size_t c)
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
-	kgdb_nmi_tty_driver = tty_alloc_driver(1, TTY_DRIVER_REAL_RAW);
-	if (IS_ERR(kgdb_nmi_tty_driver)) {
-		pr_err("%s: cannot allocate tty\n", __func__);
-		return PTR_ERR(kgdb_nmi_tty_driver);
-	}
-	kgdb_nmi_tty_driver->driver_name	= "ttyNMI";
-	kgdb_nmi_tty_driver->name		= "ttyNMI";
-	kgdb_nmi_tty_driver->num		= 1;
-	kgdb_nmi_tty_driver->type		= TTY_DRIVER_TYPE_SERIAL;
-	kgdb_nmi_tty_driver->subtype		= SERIAL_TYPE_NORMAL;
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
-	tty_driver_kref_put(kgdb_nmi_tty_driver);
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
-	tty_unregister_driver(kgdb_nmi_tty_driver);
-	tty_driver_kref_put(kgdb_nmi_tty_driver);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(kgdb_unregister_nmi_console);
diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 58ea1e1391ce..85f6c5a76e0f 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -186,8 +186,6 @@ static void cleanup_kgdboc(void)
 	if (configured != 1)
 		return;
 
-	if (kgdb_unregister_nmi_console())
-		return;
 	kgdboc_unregister_kbd();
 	kgdb_unregister_io_module(&kgdboc_io_ops);
 }
@@ -250,16 +248,10 @@ static int configure_kgdboc(void)
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
index 51ef131e66b7..14739952698b 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -306,14 +306,6 @@ extern const struct kgdb_arch		arch_kgdb_ops;
 
 extern unsigned long kgdb_arch_pc(int exception, struct pt_regs *regs);
 
-#ifdef CONFIG_SERIAL_KGDB_NMI
-extern int kgdb_register_nmi_console(void);
-extern int kgdb_unregister_nmi_console(void);
-#else
-static inline int kgdb_register_nmi_console(void) { return 0; }
-static inline int kgdb_unregister_nmi_console(void) { return 0; }
-#endif
-
 extern int kgdb_register_io_module(struct kgdb_io *local_kgdb_io_ops);
 extern void kgdb_unregister_io_module(struct kgdb_io *local_kgdb_io_ops);
 extern struct kgdb_io *dbg_io_ops;
-- 
2.48.1.262.g85cc9f2d1e-goog

