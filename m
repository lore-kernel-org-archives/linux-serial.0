Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099221;
	b=zBoD48/Oi2pPjdITIzfQOPUYUZV1zNO2bgb7zSB5c0iTRS3H471WtwPSn5qg6VrVzJAw
	 jnNe317XwI4w5ABqXBd/EZHSBcpdMMqSDn7JQLq8UEPcR6U2F8JXNk/n/zC56EUucCXHx
	 Atmf7h2lYSads7Pk+jcj/M/XnjBpDRfykVPFfNMMClRZHCxLhYIJTDCocA30lJNkRCmHJ
	 afxJVbVftpYeFNBcwuoeHMy7fJw0TBi2RlWra94ySlwgZpZPfc6ynxn7gna3mnnKrjera
	 +cq2X0RdUEx9/IJwlxOAeJjTFRo5+uMJxt3vrbefcRXDTvpjhQE6mCAzRYQTcPPF67g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099221;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=XqA2CBJjhMJL8Mk8j5Ut9pRVYsUXltzgvTWbgwZcBrI=;
	b=GtglF/znDXOAvj3F+kj16qoNkG2L2XMYR4LLMEdiLPoXkykJZenL1aKNfbpUaJ8UyHK9
	 7K18AHzsLZxUF/GIb7P4Kl22q2FeLxOtp4fvNkrRE45PyB0gRZ0nX2zSfOLKq62z0ylvN
	 MkzoMk0Rq6SoD4ZMSGskU4u3ziD4KpPKxJQ3TX0BWIXnEEYvye4jnR8aI21/NpDahnqDT
	 yudQms23Nh6f147xr4gpw2+tlVt134/y1PQVH+F/6AwqDea+j3HpyvG4HJ+DfWFtiQnpU
	 Cx5W3LNlrMHgi4qWr3mK+PgFiIUwBE/FknrkN+Q/IYHLp0ENsfVX2lNyrVoFUJfsq9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sy8QuPrx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABC760A382C;
	Tue, 27 Oct 2026 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sy8QuPrx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA291F031FA;
	Tue, 27 Oct 2026 11:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099221;
	bh=XqA2CBJjhMJL8Mk8j5Ut9pRVYsUXltzgvTWbgwZcBrI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=sy8QuPrxG7yg4yPsDSh3Jangxdh41s9mOCxymi3pPipnljocXw6YU/c7y8Mk6fBJY
	 JtmKhjiY+izhKbZteRtJayeynGy7czJg4wBXWzNkzbPotw11ItDSJSCuBaVeqYC8tZ
	 Hk4VHyjWig30QIVpqNQt4mnKrS1fwKCnsltdh0mk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:33 +0100
Subject: [PATCH 07/24] serial: 8250: hold hash_mutex across irq_info lookup
 and linking
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
Message-Id: <20261027-tty-llm-v1-7-99b0202ae546@linuxfoundation.org>
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
 Fushuai Wang <wangfushuai@baidu.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1880;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=k/IznmFdPUBiWkkVnhpei1rTD3fXdpdQNK/Q/j9Fml0=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWvfx7Jxxm1n51N6NPTN/Ppc/EPP1wZVM1x3SGUdEd
 s0LnLLxZkcsC4MgE4OsmCLLl208R/dXHFL0MrQ9DTOHlQlkCAMXpwBM5I8xw1yB4ktlWicEBe/r
 5i7ztPp70qbqoDDDgu4QzVTdyfy3A+x+FLEtUeOZ+O1iBwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Joshua Rogers <linux@joshua.hu>

serial_get_or_create_irq_info() released hash_mutex before returning the
irq_info pointer, allowing serial_unlink_irq_chain() on another CPU to
free the irq_info before serial_link_irq_chain() could link its port,
causing a use-after-free. Hold hash_mutex in serial_link_irq_chain() for
its entire scope so the irq_info lifetime is protected across both
lookup and linking.

Cc: stable <stable@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Fushuai Wang <wangfushuai@baidu.com>
Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 673fde55828a..5730ef97f836 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -131,12 +131,11 @@ static void serial_do_unlink(struct irq_info *i, struct uart_8250_port *up)
  * - find the corresponding info in the hashtable and return it, or
  * - allocate a new one, add it to the hashtable and return it.
  */
+/* Caller must hold hash_mutex */
 static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_port *up)
 {
 	struct irq_info *i;
 
-	guard(mutex)(&hash_mutex);
-
 	hash_for_each_possible(irq_lists, i, node, up->port.irq)
 		if (i->irq == up->port.irq)
 			return i;
@@ -157,6 +156,8 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 	struct irq_info *i;
 	int ret;
 
+	guard(mutex)(&hash_mutex);
+
 	i = serial_get_or_create_irq_info(up);
 	if (IS_ERR(i))
 		return PTR_ERR(i);

-- 
2.56.0

