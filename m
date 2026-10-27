Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099227;
	b=dicG8AWa09EA7Rnw4mRRUe2rydlXXMRCIh8iDAtUi8dkOEi8rSgwIJu0nfZwDvzL0tGK
	 fs+CLDZFGU5Y6RGsyLrEgSUaJE2mCucGOyJ/uHEyt6C3p4XfxrGW//WeWM37yeSdwoA97
	 jpRBK3K1S3ElHtV2LPlFCaVVPmIGkgalqvMCrj1u2AuAw+oc6c6Vwr+5cZIUtAnuwrEfp
	 b+jndj5pfJSxnhQ8HLtN0grqiFc/oTkWSBiyr4IT/utm5aHLHsqakTvwsAjCrWzaQm2Ze
	 nGI5OFbXK5O4popuGBtJ3QEf6XjoD19DEzzj3LH593NOuHwssysTzgdmjHg2STAYFwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099227;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=QtL11rxVJmAwnbel7IAtr9pOF3JZyhp6lXqBMk4rHx8=;
	b=39dZaQbUCgIRJk7xDkOqktZRiHLHJ/8KoilkDfA1SDsAvoB5dhRc+4EJULGu7cyHJbf4
	 BwGLOnt50gK1w3eEwBEfsOg1LLsx7Oli1QxGxjJ6MU9/fP/U8yZKf3PLXWUidIxbYb88r
	 vsaZ31NOujEAUWWXa3pJflRHxKqQU6wsYqSHBZFybqwKZs0kobjQen3gn81jjt6JEe4+X
	 J4n0NCG/6G+yAnTWQEXpsbCUUcOuuc00kYvAzt0j3xOsG0DcEp1fJmwI5cBSL2hjW9pHF
	 3PTuRhCrQt/ulyUE9qfYGAtbodn8NYJ0ZG/xzZS5D9Hnoha+nMhOnfVyCAMO4g+gXzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0VbrqGLE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110F260A5BDC;
	Tue, 27 Oct 2026 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0VbrqGLE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7641F01284;
	Tue, 27 Oct 2026 11:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099226;
	bh=QtL11rxVJmAwnbel7IAtr9pOF3JZyhp6lXqBMk4rHx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=0VbrqGLENzXe1DsYCc5sVFIRG4Rw1K93WsLR8B7JM8SWAi6cfZvY5E6zQheLTk28d
	 TgSNXtfzFAx+harEejRV8I2TA9nykcTl1DR6aXSH3LWH/RN2AyiBwkFoNYYfgShfp1
	 XMWF7A37I7NTl4M1vxgfsQ1j0SXoHYsW5kcCT+cQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:35 +0100
Subject: [PATCH 09/24] serial: 8250: 8250_bcm7271: fix DMA address
 truncation to 32 bits
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
Message-Id: <20261027-tty-llm-v1-9-99b0202ae546@linuxfoundation.org>
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
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=LUfnWxBJ9SNJuBB9QAlOBS65F4TRPtf13AE27ythx8A=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWvfl3lm1UnNxmZFQ2YY6zbpHX7WbYz/2bGAL1Qw+e
 Ixpc9KxjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiISTzDgunhe+pj+ubERT+p
 Xd9Vd3T7yzWHgaK7Lq3oM6n66DRJTvaqZaTqpW/LvrACAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Joshua Rogers <linux@joshua.hu>

The local variable daddr is declared as u32 but assigned from dma_addr_t
fields (priv->rx_addr and priv->tx_addr), which are 64-bit on ARM64.
This silently truncates the upper 32 bits, causing upper_32_bits(daddr)
to always produce zero when programming the UART DMA descriptor high
address registers.  Change the type to dma_addr_t to preserve the full
DMA address.

Cc: Al Cooper <alcooperx@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: stable <stable@kernel.org>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 974d9af146a1..4fdd261e55f5 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -315,7 +315,7 @@ static int brcmuart_arbitration(struct brcmuart_priv *priv, bool acquire)
 
 static void brcmuart_init_dma_hardware(struct brcmuart_priv *priv)
 {
-	u32 daddr;
+	dma_addr_t daddr;
 	u32 value;
 	int x;
 

-- 
2.56.0

