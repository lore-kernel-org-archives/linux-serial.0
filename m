Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099238;
	b=1pccqZJ9IDQr6NObdFd9xih79TgwNQkJiJnxSNFYOxdCgLvRTJVepZ9eFhpF++GJvqj4
	 BLc0fbX8mCCEkPdpO/OROi6UTm+bCRRcIVJbmba2DgIS4ActRxC4txYLrgTuHL9nKyGFE
	 9abH7lhBcLgeUUHpWi9qkDw0OrBSrGdwXosZ158S5dWg6bwiXFnHaXUFmZqVEz+AuKCK6
	 SB2URoj/KXj97xcVQelxozP+qUj8AvlqzZ9sKN6wsZL2XOwjC+mYJExd4rLzbha57nZPr
	 9jFCUG/Xas0mBxrRzY4vf0dugn06C5GRYrPZPGxSctm1rWD6bAxZ/jifaC+LsZbtkFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099238;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=vD1jTWqtXiCJaOFY7ysa8bRWzXlRgV4QDz6T6YnAmCU=;
	b=jrHNnXvxwfJEd7xmIahUG2aIej51x7OHiI3LcE6E37RMsEzWtZUbH7knMZ6WqAsniVG9
	 phdLQy1bdlchflHMK+FKMMVGaNj21AOEceTwJvcP/rBwGRsHvPD7VxrLIFwzBqEpw+7L9
	 Gvy9zm17zvfEq4mB7AbJtxVW6MgjYL+SGFNq6sbDxGTRBCEhxMSAYrPSgSHY/caKkJSgX
	 LRPGJmCqxKltGE9Ms2R6CSqR+Qh3oVw9Vulth7i2OEktjrYiO+oSzMpr+ay8CR7Mkd2lZ
	 4Y7Y359WWZaKRMpmOweQES4/Kl5aO2kKIR9AJdHs4590MjW1yM8xvJtGGEbDV6gM9Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=pLja4xfx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE73606A328;
	Tue, 27 Oct 2026 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=pLja4xfx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64F41F01284;
	Tue, 27 Oct 2026 11:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099237;
	bh=vD1jTWqtXiCJaOFY7ysa8bRWzXlRgV4QDz6T6YnAmCU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=pLja4xfxl18+I0vl2XQ523U2zznM6cbZfrjd3DeiL0syEWv1ObGxza4Xa6DAEJw1Q
	 S96xJsNB2RqrEIAQsCAbDYCCf30dDhr1HTFP1Quq/Z1ew9TmJjkNnMFhZzZQ8Z3hNI
	 q/eervKBNchaJgm2nvmmEalTU3CuU47AUVEQ3ibc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:39 +0100
Subject: [PATCH 13/24] serial: 8250: dfl: validate MMIO resource size and
 regshift
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
Message-Id: <20261027-tty-llm-v1-13-99b0202ae546@linuxfoundation.org>
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
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
 Danilo Krummrich <dakr@kernel.org>, stable <stable@kernel.org>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1872;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=geRbow0y0oPsi11Ohd54N4uiXAMV7cZtOCEM55kcKsE=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWvddn2+8NFMtIqs4a31YinqXUM/61+a5fex7d/29Z
 /jhg+iRjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiIcT/DgjWchat/h6okMW86
 khI68baWT73jZYYFRzOm8YsZSvnetO/Y4yEoVV5/2cYCAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Joshua Rogers <linux@joshua.hu>

The driver passes the DFL feature's raw MMIO resource to the 8250 core
without verifying that the resource covers the full UART register
window.  Add a regshift sanity check and validate that the MMIO resource
is large enough for 8250 register accesses up to register 7 at the
configured register spacing and access width.

Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Joshua Rogers <linux@joshua.hu>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: stable <stable@kernel.org>
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_dfl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dfl.c b/drivers/tty/serial/8250/8250_dfl.c
index 72938990ea81..e9329935bc47 100644
--- a/drivers/tty/serial/8250/8250_dfl.c
+++ b/drivers/tty/serial/8250/8250_dfl.c
@@ -110,6 +110,7 @@ static int dfl_uart_probe(struct dfl_device *dfl_dev)
 {
 	struct device *dev = &dfl_dev->dev;
 	struct uart_8250_port uart = { };
+	resource_size_t min_size;
 	int ret;
 
 	uart.port.flags = UPF_IOREMAP;
@@ -120,6 +121,17 @@ static int dfl_uart_probe(struct dfl_device *dfl_dev)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed uart feature walk\n");
 
+	if (uart.port.regshift > 3)
+		return dev_err_probe(dev, -EINVAL,
+				     "unsupported regshift %u\n",
+				     uart.port.regshift);
+
+	min_size = (7 << uart.port.regshift) +
+		   ((uart.port.iotype == UPIO_MEM32) ? 4 : 2);
+	if (uart.port.mapsize < min_size)
+		return dev_err_probe(dev, -EINVAL,
+				     "MMIO resource too small for register layout\n");
+
 	if (dfl_dev->num_irqs == 1)
 		uart.port.irq = dfl_dev->irqs[0];
 

-- 
2.56.0

