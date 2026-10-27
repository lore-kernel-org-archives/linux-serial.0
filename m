Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099224;
	b=LMVII0CnX9/cBvUvNWCN5Ta44w+26TAttyP5SD5a8f4l6UU+EjoWNL3Iu5thaD+8IrB4
	 fcHLpIJAzGC/Qb8fEuxUBnUv+lh/DtNgscZjgxBdLv/jmzrO8L/rZJOi3j28NAMfdve53
	 R6pQs6ZHsusXh4orO32pu9DpF+JbBztVjMu824k9Mzv5NPP+xJrZjJvZkvPmQNfUuYH4z
	 1yp752hya/UxX0FW5qxGmATiIoqZp2AhFPpNBRdsMKU+eq65pNvuya4/xTj68ECQOcvbM
	 1ZSCnXPcqJsQMvTxlxumgKv0TTwb+yjq19LS/xZDdAbR1p57s1aPtgj7YUPSuZZR51g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099224;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0BxhNABijuEYtfvBMCNZDK1Q2xJ35VU9HWCHtBe1cHc=;
	b=Zp01CzuW1A6PnYKxB2CRi7EToJ0nDiMj30jHrAso+BY5jH9so9ftstK1YL0Mh7UUjxVJ
	 uGvljRrdpj5MzpPWd3+muwOdppHC51Wkbx0fwT9gzfZEpmkv/xOhz8Z7jad2e4ZG0I18P
	 afzbnZ0AY7Dm0W8eiTVX59lpJRS7vQP+FrfBXhsOS8aKmhW7dYgb9XGlDeuinFPojw6sL
	 Sz0kXGi6byQk1yrsMKpaalvZiMSDrd26neS/yMR0onCyIt+BuXoSVG0qcn1KSuK64tbOW
	 N7m2CjwFbH7flFhrfeW/jEvbpRHQZRKaX3WavZFqZQHVbMbUsxLho19QFfRtEqT7OUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fNKAKxKW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA7960A5BD2;
	Tue, 27 Oct 2026 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fNKAKxKW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506181F031F3;
	Tue, 27 Oct 2026 11:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099224;
	bh=0BxhNABijuEYtfvBMCNZDK1Q2xJ35VU9HWCHtBe1cHc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fNKAKxKW2vorbJpI9f+vQjNQ2+G6vKaT8L8ksTv3BhXM04jNWgPeccCJOEI7jlCq8
	 T4BcoXJTVgq9jBicgNiOQn8Pqu45SEMeWpVC6VLnDcH9UFqpfgL9PrpQrMFDUWAsag
	 pgmk/LXJpnn397kYEBhubYCZ9QKPAzGoKYmPxIao=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:34 +0100
Subject: [PATCH 08/24] serial: 8250: cancel overrun backoff work on port
 shutdown and unregister
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
Message-Id: <20261027-tty-llm-v1-8-99b0202ae546@linuxfoundation.org>
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Fushuai Wang <wangfushuai@baidu.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
 Moteen Shah <m-shah@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable <stable@kernel.org>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=3183;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=wsoFdOYqQYtg024AcXoqOIpLWYt/kp1qgch/Dt5u0z8=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWveJlWT9/Sr6NHvyt+Krr+caS4TH6d69bcpqqSQq9
 ZyhpGRTRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAExk8ySGBQ0yi3hbI1svizo9
 5Fv0buPRO08MVzDMZLRoziicn9YuIyv8bq7vRutSu2NFAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Joshua Rogers <linux@joshua.hu>

The overrun_backoff delayed work can be scheduled from IRQ handlers in
8250_fsl.c and 8250_omap.c via schedule_delayed_work(). However, this
work is never canceled in the shutdown or unregister paths, so it can
fire after the port has been torn down, causing stale hardware access or
use-after-free.

The existing synchronize_irq() calls in the shutdown path only
synchronize with the IRQ handler itself, not with workqueue callbacks
that the handler has already enqueued. Add cancel_delayed_work_sync()
after the IRQ is quiesced in serial8250_do_shutdown() (the generic
shutdown path used by FSL and others), omap_8250_shutdown() (the
OMAP-specific shutdown path), and serial8250_unregister_port() (the
module unload / hot-unplug path).

Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Joshua Rogers <linux@joshua.hu>
Cc: Fushuai Wang <wangfushuai@baidu.com>
Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>
Cc: Moteen Shah <m-shah@ti.com>
Cc: Kendall Willis <k-willis@ti.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: stable <stable@kernel.org>
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_core.c | 3 +++
 drivers/tty/serial/8250/8250_omap.c | 3 +++
 drivers/tty/serial/8250/8250_port.c | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 5730ef97f836..af94ed4e633e 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -950,6 +950,9 @@ void serial8250_unregister_port(struct uart_8250_port *uart)
 
 	serial8250_em485_free(uart);
 
+	if (uart->overrun_backoff_time_ms)
+		cancel_delayed_work_sync(&uart->overrun_backoff);
+
 	uart_remove_one_port(&serial8250_reg, &uart->port);
 	if (serial8250_isa_devs) {
 		uart->port.flags &= ~UPF_BOOT_AUTOCONF;
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 29a203ed93fd..07ebed6ac6c9 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -786,6 +786,9 @@ static void omap_8250_shutdown(struct uart_port *port)
 
 	disable_irq_nosync(port->irq);
 
+	if (up->overrun_backoff_time_ms)
+		cancel_delayed_work_sync(&up->overrun_backoff);
+
 	serial8250_release_dma(up);
 	up->dma = NULL;
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 4afebd96e062..710d2a28b918 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2497,6 +2497,9 @@ void serial8250_do_shutdown(struct uart_port *port)
 
 	synchronize_irq(port->irq);
 
+	if (up->overrun_backoff_time_ms)
+		cancel_delayed_work_sync(&up->overrun_backoff);
+
 	if (up->dma)
 		serial8250_release_dma(up);
 

-- 
2.56.0

