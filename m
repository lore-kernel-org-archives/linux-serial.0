Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099235;
	b=HDpvlAHqrhcUe7wWzYPmWaN3Nt4g/37DI0xSRX0+ceE+3XCk3XwperOwS5hfqr8/1z71
	 71tGWQPLKWypArT7Ri+gRzQbFTUVVTS4J0q3w5PfpKWBdDRpSB3vxw4TribljSguKaish
	 J90G7pKM3ZDfW+1aK82BVSJPGb3NrX5SDXKWAFkN1WYMae+7OCCc8uvXzMdZCcgzeD7eQ
	 S1knKYy5Z0GPuZFbkqmGNe2urTZHy1mSYOc8F2tx0I5pPRi4JgkpB9CBPvah56arPV4Oo
	 9ku0FedjOSmVcFM/WWflM4iqRQ3FNd/F2EogtYlC6tcWvlSx5x2kH3WdRhUhEI67DDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099235;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=u61oG47lPDoppb+rnmEcG1thgVkYapIzrmDnE46FM5U=;
	b=IMt16kEmQaTgLC74ebzfNzfOX2tCAE6BbJPJX3uUdGt9nWzXiLZLtSBm0o6wqAw0uQ3l
	 2fvS3i+6GtJztE8RW4vDNOowJvTpYxKe4hePlGxJnwECUOtu9BYIFRN+Yb+t0d2sexoB0
	 X/VcjGRlcdPsHOzTWXwkSuw8aHEJizJyLVs8fpNjtkuURT/Bvs93K2QiZsz1rICAglZKe
	 sIF4d6B6VSmL0DA2uXsp5Yb4U5aukiv1B33sFt/Fax/Fi4hJoX17Aq4EW+7/qUlGBpbXU
	 qsNs4H7hd1yJ4Ar2VWmO04cm4FzhwUWSQxdEtYLRDlhqpt+/BJi5PMydOB4gmzdTc9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ImuO0x4Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABED60A261F;
	Tue, 27 Oct 2026 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ImuO0x4Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457C61F01284;
	Tue, 27 Oct 2026 11:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099234;
	bh=u61oG47lPDoppb+rnmEcG1thgVkYapIzrmDnE46FM5U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ImuO0x4QL0pXAAlya0C+FSZ0m5dsV9qH1Og9Q2d0mo4W4zFgXEBpX/eqrDdwlgto+
	 AgOpDv0O2y3G/jyE1QZDnwaPG3+y64WbEmIX2nn48FNTjzaRV7dLRSkbo5OvQyfFyf
	 WrMJhoLTvPghI5lEvYNnYjq9Q2VlQJEYZ1L2v2S0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:38 +0100
Subject: [PATCH 12/24] serial: 8250: dfl: add bounds check for
 device-provided regshift
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
Message-Id: <20261027-tty-llm-v1-12-99b0202ae546@linuxfoundation.org>
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
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, stable <stable@kernel.org>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=IuR1CyUmhJC/qSvNyvXTNqc7uRsREHRKL7KbFSnzqSg=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWvd9m72491n5rLf7DK+9cZ5ip/RqS/OCV0ocnUU3L
 sktidc/1RHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQAXMWKYX54aF7mxZX3RtagX
 EfK3p8wNTv6dxjA/UfywRk+Ki0xna99iCdeT0y32/ckEAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Joshua Rogers <linux@joshua.hu>

The DFL UART driver reads regshift from the FPGA feature parameters
without validating it, which can cause undefined behavior or
out-of-bounds MMIO access in the 8250 core's offset << regshift
calculations. Cap regshift at 4 to reject unreasonable values.

Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: stable <stable@kernel.org>
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_dfl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dfl.c b/drivers/tty/serial/8250/8250_dfl.c
index 1343375897a8..72938990ea81 100644
--- a/drivers/tty/serial/8250/8250_dfl.c
+++ b/drivers/tty/serial/8250/8250_dfl.c
@@ -84,6 +84,10 @@ static int dfl_uart_get_params(struct dfl_device *dfl_dev, struct uart_8250_port
 		return dev_err_probe(dev, ret, "missing REG_LAYOUT param\n");
 
 	uart->port.regshift = FIELD_GET(DFHv1_PARAM_REG_LAYOUT_SHIFT, reg_layout);
+	if (uart->port.regshift > 4)
+		return dev_err_probe(dev, -EINVAL, "unsupported reg-shift %u\n",
+				     uart->port.regshift);
+
 	reg_width = FIELD_GET(DFHv1_PARAM_REG_LAYOUT_WIDTH, reg_layout);
 	switch (reg_width) {
 	case 4:

-- 
2.56.0

