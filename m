Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A86935979
	for <linux-serial@vger.kernel.org>; Sun, 19 Jul 2026 22:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784499041; cv=none; b=rIuaWwxinbW5j1Sahn8EOexr7r1RWyBTDUtkBC083u4nyn1+Qomjh6a2Ai6d9BccDykeeCh2QZaP15DvEiNZWgqfbFFFXNsajoA/5FauS/gFlD7ckP7JVjT9di+ddeenxA0DL8KCQc/A3gxVOAuzRC7g5Fi/ZKl4GboU5CG4brI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784499041; c=relaxed/simple;
	bh=1RQ8k9otHSPFMO2zg/Ml6BOTg9wSwQhmSZS4Ik9eJdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=If6HWmqFTet8G2gWrz0md8YaqKQ8CNIZ5PVy7a1OFFgqbepgvSjbtTaze4POFXEfvAoouwk1zvel3xRjPXzACoUZCNC0QPUDxA0sCY9IljjeX94Lf0cXYGA6MdcYJGA3HjfXoo5mQ4IAco2ouMbTtr43Mxnf/UI+VpDgYWTIa94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsnXUo3H; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsnXUo3H"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49557167508so9526055e9.1
        for <linux-serial@vger.kernel.org>; Sun, 19 Jul 2026 15:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784499038; x=1785103838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pTekW+ENVi0Z1ogLAr2oe8Uj7dHDNrRZFKBwQW5P7mc=;
        b=GsnXUo3HH62IyRMU0vhv1SDvJlxtrqjHCH7T3PWFbazqfoYfnmJtpsbtQphdhecLD3
         FHrIxmITLvRoJEiYfA2AtK3ujlfJ7+ioi0yYd4CjQOgxFTve9wmgx92w9WLyV6RDVGvA
         jM3FmH0onpMjOgKZiquu58iQV9kxcgUMSjts8VOTFn0rqBp8d8AhGQD4KgFSIb1f2ju0
         ZgdrGdp/jPY3fcPk8z/jVdH8p+qYcSmw8x6D/Ik1kZLFyCE+upq2NT88feSF4JffiCEZ
         bL70K9g/QbFohYekyZGsjkdPn7X01vc3/ecx03eZkBQkDNKWVd90Gx4gu8YmAiFHTofH
         eD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784499038; x=1785103838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pTekW+ENVi0Z1ogLAr2oe8Uj7dHDNrRZFKBwQW5P7mc=;
        b=gqSzch/sUZiRFQxNOYkTJ8iLginMlPnW82oB378limPmybB7kc/CixyxLG6evQOv/d
         N+RBDelG5laHIO/W+QEknOghdx8EC5wUWyMo9+9dgWVFNU8cs8Yy5cEdocUjxwHo6i5D
         uNCn2Hdk9RmBAedqxmffrYVZ2D/rFUKvlS6MiX1p0Q3kbFoBhhE5VneEOxbbiOqqx0RI
         2XJYVIzIJFyDFvqKNhB9Hc8pmvU72CfS8q1taojZFdn2agOKhfb9AyMBrDgECImYvMKB
         q+w4s0YVYYtes+3jgPPtVX31E8BOxe7mDWAYhB4JM2WDb9SCVXqxnLYKMoIYjJ+WJqMD
         wsZA==
X-Forwarded-Encrypted: i=1; AHgh+RppmDDKmM3iVr1ExTHzqu3dn/szOxCQrMwPhvgZZg9qbvSAmAtTrS0rSnV9PqH5+k6GfB79OmzV4fxi4Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcNFeemVjAWgcdYh1ihTPNPs3eXexHLtwY3m/o/jFROxhzwuzB
	Dqm0J1FLFawokSOryslcsS3HRe1oJPLnw7HNEjFBREiOU/NKICynVAvs
X-Gm-Gg: AfdE7cnAV3xEGHJ0clogr7GYWazkCAZQWJSUg880cBj3AlN/64fvxxsh90QJBtnntcw
	Ry3zSVOLtoU+SaplvUPlebeDc98YtMvxvI5Ryww/IRQqzBZnDGAcl4DFs+sZCZfi/CHWUw2pUpf
	jgry4n8e2sBTVu8iUuyCGW773y6ga8tNJgO5hN9Hk+cG1W9HFS3PpLTP9hGI1eBndx+j7wUQFQT
	WQtF351uJ6navp5KJ7Q7OgW5WRckxkbLNhL2n2v4KO9fjn5/9oavnS7eetuA38r6Snw7bgFyVZb
	MxtIIHJR4u3G2O3bD7asoAxQaLkRnsKGpOiM/+M3cfaS2+qsLf0oDJsuRV+7qy2zUgmOCDml7nN
	yIgUGCv3joE5wXxZn4pZYEHS0WKAK83RLGpqM/J7Kc+2pDY2lHoJ+zMMqNCncCkjsjBlHzO8ina
	BMU/OF8kbP3oRFjcLIay+zhYrCpYw23NzMnk2Hm09jR6Fl1coTSAX6odKTfGsGkFoBTqNmR+oIP
	fQig3wflUgk50L9ER8wo0AyazxzhcnP5lBQm+Z/fYUnr3JsLEtLeb/chSQsuDYqaVDazbnTfEN3
	OoGsJJuYLICYCJ/qbMbrGWJb
X-Received: by 2002:a05:600c:3586:b0:493:e504:cbef with SMTP id 5b1f17b1804b1-4954a38def9mr127029085e9.0.1784499037536;
        Sun, 19 Jul 2026 15:10:37 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-aeaf-bd01-78a0-2a2d-507f-c97c.310.pool.telefonica.de. [2a02:3100:aeaf:bd01:78a0:2a2d:507f:c97c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955370d78csm114492445e9.12.2026.07.19.15.10.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Jul 2026 15:10:36 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] serial: core: do fallible allocations before the console can be registered
Date: Mon, 20 Jul 2026 00:10:11 +0200
Message-Id: <20260719221014.44354-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260719221014.44354-1-kmehltretter@gmail.com>
References: <20260719221014.44354-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

serial_core_add_one_port() allocates uport->tty_groups after
uart_configure_port() has already registered the port's console. If
that allocation fails, the function returns -ENOMEM with the console
still registered, and the driver's probe error path then tears down
the port state the console callbacks depend on.

Reproduced with fault injection on qemu's raspi1ap board. Failing the
tty_groups allocation during a PL011 sysfs bind makes
uart_add_one_port() return -ENOMEM. pl011_register_port() then clears
amba_ports[0], but ttyAMA0 remains registered as a console. The nbcon
printer thread dereferences the NULL entry and oopses:

  Unhandled fault: page domain fault (0x01b) at 0x00000178
  CPU: 0 UID: 0 PID: 43 Comm: pr/ttyAMA0 Not tainted 7.2.0-rc3+ #1
  PC is at pl011_console_write_thread+0x2c/0x168

This is not PL011-specific: the failing allocation is in serial core,
after uart_configure_port() has registered the console, so any console
UART driver is exposed. On i.MX the retained console references a
devm-allocated port that the failed probe frees, causing a
use-after-free. Reproduced on qemu's mcimx6ul-evk using the same
fail-nth harness under KASAN:

  BUG: KASAN: slab-use-after-free in imx_uart_console_write_thread+0x50/0x278
  Read of size 4 at addr c5246048 by task pr/ttymxc0/63
   imx_uart_console_write_thread from nbcon_emit_next_record+0x360/0x50c
   nbcon_emit_next_record from nbcon_emit_one+0x140/0x184
  Allocated by task 1:
   devm_kmalloc from imx_uart_probe+0x90/0xa5c
  Freed by task 1:
   devres_release_all from device_unbind_cleanup+0x38/0xdc
   device_unbind_cleanup from really_probe+0x2b4/0x388

The pre-existing kasprintf() failure path has a related problem: it
returns with state->uart_port already pointing at a port whose probe
is about to unwind and free it.

Reorder the function so the uport->name and uport->tty_groups
allocations both happen before the port is linked into the driver
state table and before uart_configure_port() registers the console:

 1. Allocate uport->name.
 2. Allocate the tty_groups array with room for three entries
    unconditionally (serial core group, optional driver group, NULL
    terminator). The optional group cannot be examined at this point:
    config_port() may only supply uport->attr_group during
    uart_configure_port(), e.g. 8250 sets it after autodetection.
 3. Only then link the port into the driver state table and run
    uart_configure_port().
 4. Fill in the optional attr_group slot afterwards.

A fail-nth sweep over the whole bind path on both boards left the
console unregistered after every failed bind and did not reproduce the
i.MX use-after-free.

Fixes: 266dcff03eed ("Serial: allow port drivers to have a default attribute group")
Fixes: f7048b15900f ("tty: serial_core: Add name field to uart_port struct")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/serial/serial_core.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a530ad372b43..887b1dd80ad2 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3056,7 +3056,6 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	struct uart_state *state;
 	struct tty_port *port;
 	struct device *tty_dev;
-	int num_groups;
 
 	if (uport->line >= drv->nr)
 		return -EINVAL;
@@ -3068,6 +3067,23 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	if (state->uart_port)
 		return -EINVAL;
 
+	uport->name = kasprintf(GFP_KERNEL, "%s%u", drv->dev_name,
+				drv->tty_driver->name_base + uport->line);
+	if (!uport->name)
+		return -ENOMEM;
+
+	/*
+	 * uart_configure_port() may set uport->attr_group and register the
+	 * console. Allocate room for both groups and a NULL terminator first.
+	 */
+	uport->tty_groups = kzalloc_objs(*uport->tty_groups, 3);
+	if (!uport->tty_groups) {
+		kfree(uport->name);
+		uport->name = NULL;
+		return -ENOMEM;
+	}
+	uport->tty_groups[0] = &tty_dev_attr_group;
+
 	/* Link the port to the driver state table and vice versa */
 	atomic_set(&state->refcount, 1);
 	init_waitqueue_head(&state->remove_wait);
@@ -3084,10 +3100,6 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	state->pm_state = UART_PM_STATE_UNDEFINED;
 	uart_port_set_cons(uport, drv->cons);
 	uport->minor = drv->tty_driver->minor_start + uport->line;
-	uport->name = kasprintf(GFP_KERNEL, "%s%u", drv->dev_name,
-				drv->tty_driver->name_base + uport->line);
-	if (!uport->name)
-		return -ENOMEM;
 
 	if (uport->cons && uport->dev)
 		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
@@ -3102,15 +3114,6 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 
 	port->console = uart_console(uport);
 
-	num_groups = 2;
-	if (uport->attr_group)
-		num_groups++;
-
-	uport->tty_groups = kzalloc_objs(*uport->tty_groups, num_groups);
-	if (!uport->tty_groups)
-		return -ENOMEM;
-
-	uport->tty_groups[0] = &tty_dev_attr_group;
 	if (uport->attr_group)
 		uport->tty_groups[1] = uport->attr_group;
 
-- 
2.53.0
