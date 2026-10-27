Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099230;
	b=O1lor2zf1B4/z37j0776CUChNPFp62Z5aZmEQfaapAaLM1Oo2KEsceyTc7tD1lNzOXww
	 P3cD0z7GYyye8WEzrkRaDNxQONn9TiDqHxgGh0MJBMga/pJeJEO8N/K5rE/WE8vxUZfL7
	 esIsAVZ9a2l8ydR2Pm4jK63nGvXXEm7HCi6Q+ML+Y7Xsr0OECGy2a8yjP2sC28Cug4sS5
	 8cDRNYTcdvIJj9W5WsUAQ21twfa8NO8hp28YE3SCP2Q9FbZyhakH1OMUvzNL4Zz3VZ+Am
	 uhJYuNbIn/1jpl+QWdfkyxhSZID4TNU44iAKZHrLc7X4u8XzFrc10GJHlZU+4xG+LgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099230;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=SBUXsm2Glbmq/xc2iMDGALM78KKVeQy6HcffzQ5brds=;
	b=v6FQuRNX89KRPUx0VgS64GNGZxixPYQOPyR6U+OpfZHoC4EgbHIOckCsvH61bR4gkrrm
	 iO9HUYLIRO+wo6T4bV21vh8kijlQ2ejBgY/cKdhKxORNtoRsIlS8O004C+4Aa9aMuuoO4
	 m1CHKWpCLJZuTPFJjZ4U+QzRFWgRjfC+BheqCrGunUS9qM6rcfMqafWWvDc7OzDFubJWC
	 fkiiBjY/c8OXBq+dH7lXJVUofFCtdkkziTqLoVZJyM5GVH0isNXULs/WEkeLJ/cSvNJ8o
	 Y8g83RdLhlcK7PjiGG4tbTUOYnHOrPL6N1XJ+SKMO2/xAoIYrZWGYJC/WhQFhuTjn+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=d0fl9iTr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FA4606A33D;
	Tue, 27 Oct 2026 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=d0fl9iTr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28B11F01284;
	Tue, 27 Oct 2026 11:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099229;
	bh=SBUXsm2Glbmq/xc2iMDGALM78KKVeQy6HcffzQ5brds=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=d0fl9iTrf7/Vh8qCvr9D4rtisAL9qxQgRCytNEF55prl6cOXCWATLwRVqpy5+4x2T
	 6s8CGUUUbzYG3CXZChQQcOvzMDXQM0SSXfd/dE1HTFapxWX0yrvqj3kEN/k2NVdQW/
	 I7HaWV9YkAdEtg3PbkUcI+ATQi3LnEUNye88Xq9U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:36 +0100
Subject: [PATCH 10/24] serial: 8250: pericom: validate port offset against
 BAR length
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
Message-Id: <20261027-tty-llm-v1-10-99b0202ae546@linuxfoundation.org>
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=TLap2Ak0d1LKnfE7R+MmhsL0EtK05TZodWA14547btk=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWvfZirfl+OvNNt6q8mmffLJqZEvjuSm1pZsUeM5ck
 em5Z6PUEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABP5PJNhwS71i3d1tR3kXveU
 TrtTk9RUnFb7n2GubMzTnmcrrqvcXntm1RJm3/6AHGEHAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Joshua Rogers <linux@joshua.hu>

The fourth port on 4-port Pericom devices uses offset 0x38 instead of
the linear 0x18, but maxnr is computed assuming uniform 8-byte spacing.
A malicious PCI device with an undersized BAR could cause I/O access
outside the assigned resource. Check that offset + 8 fits within the BAR
before registering each port.

Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: stable <stable@kernel.org>
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_pericom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pericom.c b/drivers/tty/serial/8250/8250_pericom.c
index bbbf48c6d07d..f7a7a3f737be 100644
--- a/drivers/tty/serial/8250/8250_pericom.c
+++ b/drivers/tty/serial/8250/8250_pericom.c
@@ -123,6 +123,9 @@ static int pericom8250_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	for (i = 0; i < nr && i < maxnr; i++) {
 		unsigned int offset = (i == 3 && nr == 4) ? 0x38 : i * 0x8;
 
+		if (offset + 8 > pci_resource_len(pdev, bar))
+			break;
+
 		uart.port.iobase = pci_resource_start(pdev, bar) + offset;
 
 		dev_dbg(&pdev->dev, "Setup PCI port: port %lx, irq %d, type %d\n",

-- 
2.56.0

