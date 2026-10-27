Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099216;
	b=T1wWiGLjHuxl3MXCi1je5XacKX22AtVhMHuexuXq/FXhgz+SYTRj6fspAbeP+YD6nuJ6
	 Ingd7p6ONQjkNxrrJYvy5aOVQXC4YQYplXNleRWIi9cBKPeMRS1CdiI60NOVEzWIjYUix
	 itv2MSC3rEybcDAMyg+yrMwbHKyxMlRSAj848hl9vIJY48DbiZnNfZak8Ddq01tPvZyBc
	 tL+9+M1lYd8YVDpmkfqNIoI6r0CGDfoyTM6kIlA/XwC9IlinBiPUg3nMLOgP+DsEGPu0Y
	 ChUWOsOnT4dIQ7RaLmu2CTErQximaVJW1rsU69Z2M+PtP9PnfjddWhUgyJuEF6QeUbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099216;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5V+NTNXd/FXUpAJ/0YqChFjhlfLulYUqlSw66QLAoKQ=;
	b=BRHtJKhhD9Zo5/7MhrssVCSHflfQAr1cXIxiKUsWQ5UZ/iVAUYwB9ACKq9BYqFNNvHiG
	 CYidEVRgXU8RyHoIujzy86OP6hY7oqzsteI5LeVZ7uOBxyLtgkKQHRcOe3CrXq7AN86H1
	 r2m8475sSNAN9O/c3o6C9u7w0fAKgh2vgbBo4Fcq349PB+T8EI/QFzL9O82hQcv8qQ/vh
	 7eHa/16hdXILfdnTqsZfAAYOKdNQ/+oLi79ytOpfpyrjtPPtTLUoGDnajraLthYv53qRx
	 6BmC/PTYEvo1VGkoOAwffxghCUYm/7zvdHvYjqFrJzgXTSGONu1O15I8GbVmYaaNbIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=odiNqdLJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A277606A327;
	Tue, 27 Oct 2026 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=odiNqdLJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3457A1F031E0;
	Tue, 27 Oct 2026 11:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099215;
	bh=5V+NTNXd/FXUpAJ/0YqChFjhlfLulYUqlSw66QLAoKQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=odiNqdLJ+mcNhlxG37anjc84XhtwQNc1buTyV2kDMDIMNHPHhk3II4+H2wiO/VEls
	 MVOmXNL49A5SD2DSd3xWIffSuP6GMx4uZVvCKz6lQPTQMZIATPQKoNyKKa678jco1L
	 6zcGG7ZqR3PQJR1OSsB7juZBvEBwHzqbm5QdchLQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:31 +0100
Subject: [PATCH 05/24] serial: 8250: clear subdriver state on port
 unregister
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
Message-Id: <20261027-tty-llm-v1-5-99b0202ae546@linuxfoundation.org>
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
 John Ogness <john.ogness@linutronix.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
 Fushuai Wang <wangfushuai@baidu.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=2654;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=cMeH4DULlVmc9dyw8KyMoZoVsoB/ZNh5BBEA0k29aRE=;
 b=kA0DAAIRMUfUDdst+ykByyZiAGrghb2gw9mBMGux1l0evX8FOjPZW9Y2Fc/ph3xxeYxV3nCSy
 IhdBAARAgAdFiEE9LYMxb94wiFKMT3LMUfUDdst+ykFAmrghb0ACgkQMUfUDdst+yk++wCbBMxQ
 +Yz/VKNl1lhhrBZSnuzwY5UAn0IunEyLJkuSnMJln+1l6AB5tg2w
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Joshua Rogers <linux@joshua.hu>

When serial8250_unregister_port() re-adds a port as a fallback ISA port,
it only partially resets the port state via serial8250_init_port(). All
subdriver-owned function pointers and per-driver state copied during
registration (such as startup, shutdown, handle_break, get_mctrl,
set_mctrl, set_termios, private_data, dma, gpios, and rs485 callbacks)
are left intact. After the original driver module is unloaded, these
become dangling pointers that can trigger use-after-free on subsequent
port operations.

Clear all subdriver-copied fields and call serial8250_set_defaults() to
restore default I/O accessors before re-adding the fallback port.

Cc: stable <stable@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>
Cc: Fushuai Wang <wangfushuai@baidu.com>
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_core.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 0951d3e42e1f..673fde55828a 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -956,7 +956,35 @@ void serial8250_unregister_port(struct uart_8250_port *uart)
 		uart->port.dev = &serial8250_isa_devs->dev;
 		uart->port.port_id = uart->port.line;
 		uart->capabilities = 0;
+
+		/*
+		 * Clear subdriver-owned state copied by
+		 * serial8250_register_8250_port() to prevent dangling
+		 * pointers after the original driver module is unloaded.
+		 */
+		uart->port.private_data = NULL;
+		uart->port.set_termios = NULL;
+		uart->port.set_ldisc = NULL;
+		uart->port.get_mctrl = NULL;
+		uart->port.set_mctrl = NULL;
+		uart->port.get_divisor = NULL;
+		uart->port.set_divisor = NULL;
+		uart->port.startup = NULL;
+		uart->port.shutdown = NULL;
+		uart->port.throttle = NULL;
+		uart->port.unthrottle = NULL;
+		uart->port.handle_break = NULL;
+		uart->port.rs485_config = NULL;
+		memset(&uart->port.rs485, 0, sizeof(uart->port.rs485));
+		memset(&uart->port.rs485_supported, 0,
+		       sizeof(uart->port.rs485_supported));
+		uart->gpios = NULL;
+		uart->dma = NULL;
+		uart->rs485_start_tx = NULL;
+		uart->rs485_stop_tx = NULL;
+
 		serial8250_init_port(uart);
+		serial8250_set_defaults(uart);
 		serial8250_apply_quirks(uart);
 		uart_add_one_port(&serial8250_reg, &uart->port);
 	} else {

-- 
2.56.0

