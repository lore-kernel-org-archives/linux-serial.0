Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A4913B29B;
	Thu, 13 Feb 2025 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739435123; cv=none; b=u/Myv3A25CMTPu+SFWQddTQ1sW+dUEwbCtm4qoRXcjIQDEQkNzAkVIOIA48SNQtIzuSOeX9cs6lnZjPcACJUN/xd5vguWRiBi8oCCD0EpfALoxLQRpHTk81rfWlyP7/71EYRjJK7D0k5rA6ts7LlrWpiySvvfkqST1/g2G2x8Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739435123; c=relaxed/simple;
	bh=pwk+dztJppaCknOtlmswpl1Nc0rglnoPuLQh88jBP2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s2if12+8IzXrJ5CILxKY8KX/BdI81ayny2kOC1lHN6144BzJdFALVwLeG1sXtWMbghmzDd4kQdm0ZcroYqWK4Dz7Ma+yIjC/VK6Ia3csVo05pXbI1tTTFYLG8dDxB4y7w1jiSbxQX6xylHk5zux7ruHiSff1E49+f3yfcCPSPSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VkIKt/Ja; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VkIKt/Ja"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 033D04318E;
	Thu, 13 Feb 2025 08:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739435119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=le1Ksyac8fZ2fSaqKx+npcfn/t1FWRIiocLUuxo9FG8=;
	b=VkIKt/Ja/dnkpAhbUq3MDKMNpEHEIIaupb5o/vPvLedwkDH6S1TKYZoEUL2qDQyq3vsbYh
	JbhMkovbLIgkeEZo5syuJSlAQOn/6TBTKJDvrxq77taD/6E/exYgPO8uj/Sl81l16U+4fh
	PG78iFIR7WYcB4GC3D4mHoBZOd2d/GUDQcK9KutRQgv8Py70Y/xgSt8MLQ8B0v0WHJVEL7
	KJ4DUV2yoJBKpCVpMugMvYJXGbVhXzeYwzBT1SVN+p+MCkUwIyZ4qo0joyRAb5Nv73MEsO
	fnRv9jSGiyQxiCFtya1jJUvnJPXLP1aA9KTxAXZsdJx5bSoMfUAofNrydK4H3A==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Thu, 13 Feb 2025 09:25:04 +0100
Subject: [PATCH] serial: mctrl_gpio: add parameter to skip sync
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250213-atomic_sleep_mctrl_serial_gpio-v1-1-201ee6a148ad@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAF+srWcC/x3NQQqAIBBA0avErBPKMKSrRIjZWAOWohJBdPes5
 d+8f0PCSJhgqG6IeFIif5Ro6wrMpo8VGS2lgTdcNLztmM5+J6OSQwxqNzk69RHaqTWQZ1IK21u
 chRQzFCREtHT9g3F6nhc08M99cAAAAA==
X-Change-ID: 20250213-atomic_sleep_mctrl_serial_gpio-885f6feb585b
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-stm32@st-md-mailman.stormreply.com, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegiedvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudekveeftdeifedvfefgvdfgjeduieevudeltdeulefhhefgiedvhfethffgffegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgdujedvrddujedrtddrudgnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduledprhgtphhtthhopehshhgrfihnghhuoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepkhgvrhhnvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehgrhgvghhkhhesl
 hhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegtlhgruhguihhurdgsvgiinhgvrgesthhugihonhdruggvvhdprhgtphhtthhopehlihhnuhigqdhsthhmfedvsehsthdqmhguqdhmrghilhhmrghnrdhsthhorhhmrhgvphhlhidrtghomhdprhgtphhtthhopehmtghoqhhuvghlihhnrdhsthhmfedvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhitghhrghrugdrghgvnhhouhgusegsohhothhlihhnrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

The following splat has been observed on a SAMA5D27 platform using
atmel_serial:

BUG: sleeping function called from invalid context at kernel/irq/manage.c:738
in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 27, name: kworker/u5:0
preempt_count: 1, expected: 0
INFO: lockdep is turned off.
irq event stamp: 0
hardirqs last  enabled at (0): [<00000000>] 0x0
hardirqs last disabled at (0): [<c01588f0>] copy_process+0x1c4c/0x7bec
softirqs last  enabled at (0): [<c0158944>] copy_process+0x1ca0/0x7bec
softirqs last disabled at (0): [<00000000>] 0x0
CPU: 0 UID: 0 PID: 27 Comm: kworker/u5:0 Not tainted 6.13.0-rc7+ #74
Hardware name: Atmel SAMA5
Workqueue: hci0 hci_power_on [bluetooth]
Call trace:
  unwind_backtrace from show_stack+0x18/0x1c
  show_stack from dump_stack_lvl+0x44/0x70
  dump_stack_lvl from __might_resched+0x38c/0x598
  __might_resched from disable_irq+0x1c/0x48
  disable_irq from mctrl_gpio_disable_ms+0x74/0xc0
  mctrl_gpio_disable_ms from atmel_disable_ms.part.0+0x80/0x1f4
  atmel_disable_ms.part.0 from atmel_set_termios+0x764/0x11e8
  atmel_set_termios from uart_change_line_settings+0x15c/0x994
  uart_change_line_settings from uart_set_termios+0x2b0/0x668
  uart_set_termios from tty_set_termios+0x600/0x8ec
  tty_set_termios from ttyport_set_flow_control+0x188/0x1e0
  ttyport_set_flow_control from wilc_setup+0xd0/0x524 [hci_wilc]
  wilc_setup [hci_wilc] from hci_dev_open_sync+0x330/0x203c [bluetooth]
  hci_dev_open_sync [bluetooth] from hci_dev_do_open+0x40/0xb0 [bluetooth]
  hci_dev_do_open [bluetooth] from hci_power_on+0x12c/0x664 [bluetooth]
  hci_power_on [bluetooth] from process_one_work+0x998/0x1a38
  process_one_work from worker_thread+0x6e0/0xfb4
  worker_thread from kthread+0x3d4/0x484
  kthread from ret_from_fork+0x14/0x28

This warning is emitted when trying to toggle, at the highest level,
some flow control (with serdev_device_set_flow_control) in a device
driver. At the lowest level, the atmel_serial driver is using
serial_mctrl_gpio lib to enable/disable the corresponding IRQs
accordingly.  The warning emitted by CONFIG_DEBUG_ATOMIC_SLEEP is due to
disable_irq (called in mctrl_gpio_disable_ms) being possibly called in
some atomic context (some tty drivers perform modem lines configuration
in regions protected by port lock).

Add a flag to mctrl_gpio_disable_ms to allow controlling whether the
function should block, depending the context in which it is called.
Update mctrl_gpio_disable_ms calls with the relevant flag value,
depending on whether the call is protected by some port lock.

Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
This series follows a report made here:
https://lore.kernel.org/linux-serial/3d227ebe-1ee6-4d57-b1ec-78be59af7244@bootlin.com/
---
 drivers/tty/serial/8250/8250_port.c    | 2 +-
 drivers/tty/serial/atmel_serial.c      | 2 +-
 drivers/tty/serial/imx.c               | 2 +-
 drivers/tty/serial/serial_mctrl_gpio.c | 9 +++++++--
 drivers/tty/serial/serial_mctrl_gpio.h | 4 ++--
 drivers/tty/serial/sh-sci.c            | 2 +-
 drivers/tty/serial/stm32-usart.c       | 2 +-
 7 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d7976a21cca9ce50557ca5f13bb01448ced0728b..b234c6c1fe8b3dae4efc2091c8aecf1f1dddc9f8 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1680,7 +1680,7 @@ static void serial8250_disable_ms(struct uart_port *port)
 	if (up->bugs & UART_BUG_NOMSR)
 		return;
 
-	mctrl_gpio_disable_ms(up->gpios);
+	mctrl_gpio_disable_ms(up->gpios, false);
 
 	up->ier &= ~UART_IER_MSI;
 	serial_port_out(port, UART_IER, up->ier);
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index f44f9d20a97440c9aea41e9ebe34c34d4dfa0a1c..eac0c266bd2fc13b0563c82b29f13f46df718625 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -700,7 +700,7 @@ static void atmel_disable_ms(struct uart_port *port)
 
 	atmel_port->ms_irq_enabled = false;
 
-	mctrl_gpio_disable_ms(atmel_port->gpios);
+	mctrl_gpio_disable_ms(atmel_port->gpios, false);
 
 	if (!mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_CTS))
 		idr |= ATMEL_US_CTSIC;
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 9c59ec128bb4fc0ff54cb9a1a66eabbc9e391a9a..af894a176a2fabea5374a35be5a63f453be5da96 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1608,7 +1608,7 @@ static void imx_uart_shutdown(struct uart_port *port)
 		imx_uart_dma_exit(sport);
 	}
 
-	mctrl_gpio_disable_ms(sport->gpios);
+	mctrl_gpio_disable_ms(sport->gpios, true);
 
 	uart_port_lock_irqsave(&sport->port, &flags);
 	ucr2 = imx_uart_readl(sport, UCR2);
diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index 8855688a5b6c09f073349bd144586f54331d891f..caef2be955eef95cc2efd508bc9ada2c948e3bf4 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -325,8 +325,10 @@ EXPORT_SYMBOL_GPL(mctrl_gpio_enable_ms);
 /**
  * mctrl_gpio_disable_ms - disable irqs and handling of changes to the ms lines
  * @gpios: gpios to disable
+ * @sync: true if function should block until any pending IRQ handler has
+ * executed
  */
-void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
+void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios, bool sync)
 {
 	enum mctrl_gpio_idx i;
 
@@ -342,7 +344,10 @@ void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
 		if (!gpios->irq[i])
 			continue;
 
-		disable_irq(gpios->irq[i]);
+		if (sync)
+			disable_irq(gpios->irq[i]);
+		else
+			disable_irq_nosync(gpios->irq[i]);
 	}
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_disable_ms);
diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/serial/serial_mctrl_gpio.h
index fc76910fb105a3d560e824baa43e9515576e895a..20f68dc3d63711214e1e65d22b8334b093dfc6fa 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.h
+++ b/drivers/tty/serial/serial_mctrl_gpio.h
@@ -89,7 +89,7 @@ void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios);
 /*
  * Disable gpio interrupts to report status line changes.
  */
-void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios);
+void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios, bool sync);
 
 /*
  * Enable gpio wakeup interrupts to enable wake up source.
@@ -148,7 +148,7 @@ static inline void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios)
 {
 }
 
-static inline void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
+static inline void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios, bool sync)
 {
 }
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b1ea48f38248eb42d98353daa289bbe67191d201..5d6d6d9af2eece94bdecb47933e1448dbb921114 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2298,7 +2298,7 @@ static void sci_shutdown(struct uart_port *port)
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
 	s->autorts = false;
-	mctrl_gpio_disable_ms(to_sci_port(port)->gpios);
+	mctrl_gpio_disable_ms(to_sci_port(port)->gpios, true);
 
 	uart_port_lock_irqsave(port, &flags);
 	sci_stop_rx(port);
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 1ec5d8c3aef8ddbca615a149c2fe81c90c83a22b..354894d4b468a51690568e83310b8400764e56a6 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -944,7 +944,7 @@ static void stm32_usart_enable_ms(struct uart_port *port)
 
 static void stm32_usart_disable_ms(struct uart_port *port)
 {
-	mctrl_gpio_disable_ms(to_stm32_port(port)->gpios);
+	mctrl_gpio_disable_ms(to_stm32_port(port)->gpios, true);
 }
 
 /* Transmit stop */

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250213-atomic_sleep_mctrl_serial_gpio-885f6feb585b

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

