Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099208;
	b=i7E11AnbjDH6yDZFRyODQBJ4y/9liWh/dUiYIej7mi21n/PU7LquWwATltzJtp5+7rYc
	 fnBdrgpB6Im0Noxp76V93DRdoAPt5vDc1LDl3CnrlRT5eTk+w07hFHWK34+rx0eup1uj6
	 yo8CAZZeH0gT0M5JpFE9j5SHdfwOxgfx79wcvClPQm1OwF6Us11eMFdI8CI+PypzT3Sj/
	 KGEppR6VFCaycE9mK5nBb5NhKRkeow1f3MCqMLhVspJRIPoyPs9uMo1tIZ0UU5WPY6HSp
	 euaccfC++M+PrHNUx1wZUyLqIdGEIsFsw9C9M77fcLV4u7XlXWP9X4xG1/6MHCYZJSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099208;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=tDSrtNyy80ZHqgKUCbvvGf79WJiCCW1Xhn9IVWO2gXc=;
	b=hSJrz0jPfLofrZ0LRGgwhbOCp+MsKwVJ6XqCARCJnZKgYfKseSVKJul/14JaajZwW0UH
	 LmECBVuZ0Ts40VekoaAZAJat4ji3+fffXmU8b6lhqGK9X1gyT2TUCrrC7LAToSS2Ae/lk
	 oLyUgWzzrfCmGXQbjCEjnFbdY7vhtlcEjZ7FdF5bGbQv9G/aSEDT5JKIGfuOTgmtp3JgC
	 3lTfuo+qEKzeoLnWo24AhaCI7tLuXAnZm2rC2CLfMWdWk5obi614gvKRhRIvagZmLDlVP
	 FnFMq7MfVZYMzD+q79GHoGn82q6+PppiVrnR5Nm3RvCsAkJsVKV71sUoDXTs0R3eOYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Vyx6gPTz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F9606A323;
	Tue, 27 Oct 2026 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Vyx6gPTz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC3C1F031F3;
	Tue, 27 Oct 2026 11:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099207;
	bh=tDSrtNyy80ZHqgKUCbvvGf79WJiCCW1Xhn9IVWO2gXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Vyx6gPTzauVk+PfVw7hZNAGUO3dahjbYG2GlI5Sh7l+Z58MHpvigRWi6Vw90g3XNv
	 1Yhor6znDQu68CHx6R5HEVj9gKGsEoxjHarEOt2Lv2Sgir2eRrsn9q/mRNdG/OFwHI
	 bIQrq7SCkUgkwLW1lbq9O6jKgoH7oZRSBF403U0Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:28 +0100
Subject: [PATCH 02/24] serial: core: respect runtime PM when sending x_char
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261027-tty-llm-v1-2-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
In-Reply-To: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>, 
 Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc: Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Peter Hurley <peter@hurleysoftware.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Crescent Hsieh <crescentcy.hsieh@moxa.com>, Frank Li <Frank.Li@nxp.com>, 
 Sherry Sun <sherry.sun@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
 Olof Johansson <olof@lixom.net>, 
 =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
 Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Robert Baldyga <r.baldyga@samsung.com>, 
 Thomas Abraham <thomas.abraham@linaro.org>, 
 Kukjin Kim <kgene.kim@samsung.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, 
 Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Johan Hovold <johan@kernel.org>, 
 Karl Mehltretter <kmehltretter@gmail.com>, 
 John Ogness <john.ogness@linutronix.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
 Tony Lindgren <tony.lindgren@linux.intel.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=3883;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=mbJElPrglA5NE/q+KI/GSecuTgZMKDwvUnzZsePFflQ=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWveyXj+q81l8QqTSwipH7R9vb3ZcszCZtf3RefnnB
 +TuJLdO74hlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJPLVhmO+9ddXqrJZ1awV5
 3JfuXPguoEu4QYFhnv6vVweeTOnZrpJeefBlBa/thQ+7FgIA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

__uart_start() calls the start_tx operation only if the port is runtime
active.  Otherwise it asks for a resume, and
serial_port_runtime_resume() starts the transmitter.

uart_send_xchar() calls start_tx at once, under the port lock, whatever
the state of the device.  With 8250_omap, serial8250_start_tx() then
calls pm_runtime_get_sync() for a suspended device: that sleeps, and
omap8250_runtime_resume() takes the port lock again.  A tcflow(TCIOFF)
on an idle port is enough, if autosuspend has been enabled.  It was
allowed as long as that driver used pm_runtime_irq_safe().

Share the part of __uart_start() that deals with runtime PM.  A stopped
transmission still does not hold up an XON or XOFF character.  Let a
pending x_char count as work for serial_port_runtime_resume(), and keep
the port from being suspended with it.

Fixes: 8700a7ea5519 ("serial: 8250_omap: Drop pm_runtime_irq_safe()")
Cc: stable <stable@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>
Cc: Tony Lindgren <tony.lindgren@linux.intel.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/serial_core.c | 25 +++++++++++++++----------
 drivers/tty/serial/serial_port.c |  4 ++--
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c0deec0e6af4..b06d2649be34 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -135,17 +135,11 @@ static void uart_stop(struct tty_struct *tty)
 	uart_port_unlock_deref(port, flags);
 }
 
-static void __uart_start(struct uart_state *state)
+static void uart_port_start_tx(struct uart_port *port)
 {
-	struct uart_port *port = state->uart_port;
-	struct serial_port_device *port_dev;
+	struct serial_port_device *port_dev = port->port_dev;
 	int err;
 
-	if (!port || port->flags & UPF_DEAD || uart_tx_stopped(port))
-		return;
-
-	port_dev = port->port_dev;
-
 	/* Increment the runtime PM usage count for the active check below */
 	err = pm_runtime_get(&port_dev->dev);
 	if (err < 0 && err != -EINPROGRESS) {
@@ -164,6 +158,16 @@ static void __uart_start(struct uart_state *state)
 	pm_runtime_put_autosuspend(&port_dev->dev);
 }
 
+static void __uart_start(struct uart_state *state)
+{
+	struct uart_port *port = state->uart_port;
+
+	if (!port || port->flags & UPF_DEAD || uart_tx_stopped(port))
+		return;
+
+	uart_port_start_tx(port);
+}
+
 static void uart_start(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
@@ -718,8 +722,9 @@ static void uart_send_xchar(struct tty_struct *tty, u8 ch)
 	else {
 		guard(uart_port_lock_irqsave)(port);
 		port->x_char = ch;
-		if (ch)
-			port->ops->start_tx(port);
+		/* It goes out even if the transmission is stopped */
+		if (ch && !(port->flags & UPF_DEAD))
+			uart_port_start_tx(port);
 	}
 	uart_port_deref(port);
 }
diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index 2fc48cd63f6c..f2f7cdd3a54c 100644
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -23,8 +23,8 @@
 /* Only considers pending TX for now. Caller must take care of locking */
 static int __serial_port_busy(struct uart_port *port)
 {
-	return !uart_tx_stopped(port) &&
-		!kfifo_is_empty(&port->state->port.xmit_fifo);
+	return port->x_char || (!uart_tx_stopped(port) &&
+		!kfifo_is_empty(&port->state->port.xmit_fifo));
 }
 
 static int serial_port_runtime_resume(struct device *dev)

-- 
2.56.0

