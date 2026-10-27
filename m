Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099251;
	b=ElOauyuOqyVf/4PI7m7sDkPHgbtvQb2GA61a9Ww3eQSPW0NF9jrSX3c18IdbveEn63k8
	 GFN/3ZIGJF/YpqqAuQPUkP/xB9cLuNfdQXp0DuWKT9ph9RnieWOwZ4J2Y6FKB+9GEd04q
	 njH4+Hj2PAdofbfYOmJO7GdefhNqAmIiLIQuDsh1UWgBEMc90xriGAzrZ6JR3EYQJwjnn
	 4w/ijIpQZ7EZsDYd4s8xe/vSvF6PIexVDYZIb0t9WLgls/PljoQznpx3FrYOyR9kbUZfI
	 epEkeWKF1Aei6uK0/16GR2gyZqwPR9/MX2w6k0Qfj0eqbhkiOo/rY8wzhNIg5rVcskw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099251;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=LmFYO9q8aHV3jXtCeg+1TpTcQaYP/vBmoA7b4hJD89E=;
	b=DeqkNFspuGUDeYmSSySd0S0ZnxeCa9aVeXLNGXz0CwQP2sdpKOBbL18SHskBr6j8KWkk
	 4AwnvZ0mcDBHGmgloa2nqgtv7MpVm/bVLoRkGLp0UsgLcJNOefaCfJWnWsK4oOkj+evmu
	 VKx2StIeFosuAqmbjT7LgpEaOJKhCi0OZ39vLdnvOESRnhML89vXh4R1habVTHu+XpJn8
	 HYIr420O7e7S1Wbord2NzDRE6CuThbs1WgHiRgYaJ+bMbBi0GCoXXWhKVKf/pYiho1fc8
	 qsGuJ+U4Qycwj9CSRQ3WAf2Jydq9x15ibnV9Fd9Cn9ozs37yGbAK/kH7487IndFnaJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=woku000l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA31606E7F8;
	Tue, 27 Oct 2026 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=woku000l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5581F031E6;
	Tue, 27 Oct 2026 11:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099251;
	bh=LmFYO9q8aHV3jXtCeg+1TpTcQaYP/vBmoA7b4hJD89E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=woku000lxuAqiwy3NYW8oA1WWgEvS02a4ROvMSt1k95stU2lkkUhQ2o+nK2WW00PK
	 Db1orD3M1O4a+Gt6Z1lViT1/KvP18yZ5cPHPzpCKxhI6KLjdn+UZX2X1GnUn3T+0dV
	 umMZXvrdLLLm9rOukUb5w8Lau3h45fTt3QYNq1PA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:44 +0100
Subject: [PATCH 18/24] serial: fsl_lpuart: fix tty ref of wakeup event
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
Message-Id: <20261027-tty-llm-v1-18-99b0202ae546@linuxfoundation.org>
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
 Peng Fan <peng.fan@nxp.com>, Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=7PndLWziLhFxVf15LX4uO3S84WcvtpCFzOrbOnnsIEc=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWvedW1TjGF3KsWPVrrnS4cwtnf+uPJnLF7/55bK9W
 97sC3nq1xHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQATuV3BMM+2syirRiBvR5mg
 ybVnshdjaw+mPGKYZ7ppnaDDFXPXW9urTkYHtzjz68xcCAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

To report a wakeup event, lpuart_resume_noirq() gets the tty with
tty_port_tty_get() and never puts it: each wakeup by the UART leaks a
reference, and the tty is not freed when it is closed.

With no_console_suspend, the function also gets there for a console
which is not open.  Then tty_port_tty_get() returns NULL, which is
dereferenced.

Fixes: 18bdfccf3c30 ("tty: serial: fsl_lpuart: Add missing wakeup event reporting")
Cc: stable <stable@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/fsl_lpuart.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c8575c965203..e54b4c44db42 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -3113,8 +3113,14 @@ static int lpuart_resume_noirq(struct device *dev)
 			/* check whether lpuart wakeup was triggered */
 			wake_active = stat & (UARTSTAT_RDRF | UARTSTAT_RXEDGIF);
 
-			if (wake_active && irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq)))
-				pm_wakeup_event(tty_port_tty_get(port)->dev, 0);
+			if (wake_active && irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq))) {
+				struct tty_struct *tty = tty_port_tty_get(port);
+
+				if (tty) {
+					pm_wakeup_event(tty->dev, 0);
+					tty_kref_put(tty);
+				}
+			}
 		}
 	}
 

-- 
2.56.0

