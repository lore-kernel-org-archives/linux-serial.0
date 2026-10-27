Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099249;
	b=QzA4gSvrSdXZzC7338ylYETe+u7goY2Op65KulVjiDiGDw5nBPdIfRD7/ckn2OB5NYaL
	 4Qpz00gToUdQPWOpZO8JHkjCK0QQ1lwNhMZ/GzA2KSfFT0NRxiJCYWzhmtEa4ofHkNkIW
	 u62ZyWcVNRgERHLwO9U11/a9T7lb3hOj+ItfBZd/dmlcI12EtEN4Dx58R2NznWDJIgl93
	 hxgRoqZGBXMOOqpQFqqo6u3MKBy3F7AQe9Wgce4bXUL66WPdpABxtUCuLkCXb5SA65ViM
	 9Dhebujipro+jXbfJm47PCqXm/X2vwjMkRr44cYwtLyS/hmq9sua/tZ+6HrSGQMM26Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099249;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+7vTR01S7b+SPrLDby0xgmE9w+qgR4IvyOvbvo/4vaA=;
	b=r0PE9x45TPY0qhOEFLwMaiPiTklbRTDZYo6H3AshEFZ+Dd4myEvBPn5rnLIsfLInntyC
	 AgwPeEbEGcZVa5fA6uCi2IVezrTZYdOTWsmFLGVreQUebKg21YVLUMnT09uMZ5IrB4Ere
	 T1Wm/+qW09wwkMYEtFg2vFxAT4qmuL1L0JVKidLLHURk5PB4yiFd7gQuenlF0CfX/xmAz
	 OJ2BNhrLyCSMl1GtgX9cjPlZStcdqvhhPP66qKrnXmVWWCi1ISBWpRayc+5i6uzRV/6bP
	 BC1Ag+YCKU8h9wR016o3bCvgmQ/19Cj2OdTrnZi6uzDXFq95TdPucHS0e9H7v78JzYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xeMwpc0c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FFE606E7ED;
	Tue, 27 Oct 2026 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xeMwpc0c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA711F01282;
	Tue, 27 Oct 2026 11:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099248;
	bh=+7vTR01S7b+SPrLDby0xgmE9w+qgR4IvyOvbvo/4vaA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=xeMwpc0cNyC3jRcK10FLCqZDCipoFmsGzZPJD0qmEB6yQ89s7cnNLSjSXj5uBpcts
	 pIQjjWhVbS5GRG4+EqyJw1r9GSjkoMuyrniKf/atmqMnqCgANtkNjNg0pIbCIq3Kat
	 64s6NypelhAP6iHoSoUHZORpgJBufe/D6TtmSrPI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:43 +0100
Subject: [PATCH 17/24] serial: 8250_mxpcie: handle hangup during break
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-tty-llm-v1-17-99b0202ae546@linuxfoundation.org>
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
 Linmao Li <lilinmao@kylinos.cn>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=2777;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=J91DkBMBgSffmt7KPliGKD/HKZr1NJIz2mRXJ5MJI0o=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWvelXTFkmnT8h8YO2ZMrC7M+2jgz+Ukqq0e+edc9J
 62kp6moI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACYyPY1hfuDBq9OT234sd9/Y
 /s3zyrHT4jPmP2eYzb7lfwW/VlP1I5MJ/MYi6s4nMoL7AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

Ending a software break on a Moxa PCIe port in RS-485 2-wire mode
dereferences a NULL tty pointer if the port was hung up while the break
was being sent.

send_break() calls ->break_ctl(tty, -1), sleeps for the break duration
and then calls ->break_ctl(tty, 0), without excluding a concurrent
hangup. A hangup (a modem DCD drop, or the session leader exiting while
another process of the session is in TCSBRK/TCSBRKP) runs uart_hangup(),
which shuts the port down and clears port->state->port.tty. The second
call still reaches mxpcie8250_software_break_ctl() through
uart_break_ctl(), which then does:

    struct tty_struct *tty = port->state->port.tty;
    ...
    baud = tty_get_baud_rate(tty);

with tty == NULL.

The bug was found by code inspection and has not been reproduced.

Fix by taking a reference to the port's tty with tty_port_tty_get() and
only restoring the divisor when a tty is still attached; a hung up port
is shut down, and the next open programs the divisor again through
set_termios().

Fixes: ade78d3d253c ("serial: 8250_mxpcie: add break support for RS485 using MUEx50 features")
Cc: stable <stable@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linmao Li <lilinmao@kylinos.cn>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 4935a5d1c1a3..b3418c1ccb05 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -412,7 +412,7 @@ static int mxpcie8250_handle_irq(struct uart_port *port)
 static void mxpcie8250_software_break_ctl(struct uart_port *port, int break_state)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	struct tty_struct *tty = port->state->port.tty;
+	struct tty_struct *tty;
 	unsigned int baud, quot;
 	u8 sfr, tx_byte = 0x01;
 
@@ -439,9 +439,14 @@ static void mxpcie8250_software_break_ctl(struct uart_port *port, int break_stat
 
 		serial_out(up, UART_FCR, UART_FCR_CLEAR_XMIT);
 
-		baud = tty_get_baud_rate(tty);
-		quot = uart_get_divisor(port, baud);
-		serial8250_do_set_divisor(port, baud, quot);
+		/* A hangup during the break detaches the tty */
+		tty = tty_port_tty_get(&port->state->port);
+		if (tty) {
+			baud = tty_get_baud_rate(tty);
+			quot = uart_get_divisor(port, baud);
+			serial8250_do_set_divisor(port, baud, quot);
+			tty_kref_put(tty);
+		}
 		serial_out(up, UART_LCR, up->lcr);
 	}
 }

-- 
2.56.0

