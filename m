Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099232;
	b=uwZ1OsdPkCfDuL2/e2al/IfdwMEJZfKhGRYEGJgx1xuFCftGMk64BjuHyjRseGD0Erf/
	 5rX5LyZUXGGwtpE/1h4rO3p9dCo88xD4SqkbDyeu+M6l1lKbuMCBec0NSq3ISW3vZud6e
	 hdqsA0edvbxLwX+N6jklUJzYIL1ctw3rkLf0VxjSAKfMcZ0ZgFptErmRGsX5iGIf0GIKh
	 z+cgy4Bkqx6wz3fTHHDtLWJaaMgqEnR/rySRsTlAox/YS7rQjYo008Q3NG7q3OmIlX/rC
	 PQq6FDgOjogV+ifMjy2d7OmWcEnSvfrZWapEzv9WS6MlN5jIRo9xqYoofs0WQMGk86w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099232;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=IS2f9CzmgPzLCWC2brqivclf2ZPHfhRDbonV89t5d1M=;
	b=gpzzt3urIWcy9w426ImRbNL5flHXYxv/QPzc0YSxc/vuBLigS2aVSvnpGJBibWwkm2SA
	 SEDEIXKrlW8XUi/dXDOkdiMcYB7tKgY0aqSUQHlOrWi2iIUp9Bnr450ITRfYNN0xEM5C0
	 saF8tJTiKAHMa+1rOTAKujPfnYKfkxaQ8QAw0HyqkWQvZvwpbb9CmQwzFVjh02Q9AcIS1
	 gl8IrHArJHxyrrEKvIvH2MSu2dvKy0pjPZc2OcnnyKysAVuz8LYtwJZKZe0Wftj9Ici6K
	 pa3ou0L1fvwh3fvepV9KDtpjLYv8RRWIOmR9VJMXVB37EDFf/VFUXVO21MGWyfxGSew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="bJMZ/a+5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8076A606A31B;
	Tue, 27 Oct 2026 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bJMZ/a+5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BF51F01280;
	Tue, 27 Oct 2026 11:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099232;
	bh=IS2f9CzmgPzLCWC2brqivclf2ZPHfhRDbonV89t5d1M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bJMZ/a+5Ad41npjc4pkXOzR34K8/ZY60Znl+w9Ezzxz2yxVDmNbN7PQ3hCT2Ja7ut
	 9G8V/a8lrpo+bZLxrZ4CXF7GL1AN/HJkmXRHqidShnpUvcpgFYsQuob7Kr/VNFdpi7
	 BvK3WS/UCYMD9yTGV4mQQq5d9RUCqZ/NNwHxsy5U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:37 +0100
Subject: [PATCH 11/24] serial: 8250: cap OxSemi Tornado UART count against
 BAR size
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
Message-Id: <20261027-tty-llm-v1-11-99b0202ae546@linuxfoundation.org>
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
 Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, 
 Marnix Rijnart <marnix.rijnart@iwell.eu>, stable <stable@kernel.org>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1879;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=VNWPqad47ORfVGxS6XN/YPqH0tGaIVf0nzG2TKO+/bY=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWveJ/RX8coGj8s7hkC0PJhbyqR8J8ZwX2XzCYPbfz
 ojt9upJHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRZcoMCw5Najq4w3qp+xy1
 N+2TjlVOqrF+oc4wT5Pzy33eJOXbxw6H87yaPf+35+9nzwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Joshua Rogers <linux@joshua.hu>

pci_oxsemi_tornado_init() reads the UART count from device-controlled
BAR0 memory without validation, allowing a malicious device to report up
to 255 ports. Cap the device-reported count against what actually fits
in the BAR using the Tornado register layout.

Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Marnix Rijnart <marnix.rijnart@iwell.eu>
Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: stable <stable@kernel.org>
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 1dda63be6b89..9919504334bb 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1083,6 +1083,7 @@ static int pci_oxsemi_tornado_init(struct pci_dev *dev)
 	u8 __iomem *p;
 	unsigned long deviceID;
 	unsigned int  number_uarts = 0;
+	resource_size_t bar_len;
 
 	if (!pci_oxsemi_tornado_p(dev))
 		return 0;
@@ -1095,6 +1096,15 @@ static int pci_oxsemi_tornado_init(struct pci_dev *dev)
 	/* Tornado device */
 	if (deviceID == 0x07000200) {
 		number_uarts = ioread8(p + 4);
+
+		/* Cap against BAR0 size (Tornado layout: 0x1000 + n * 0x200) */
+		bar_len = pci_resource_len(dev, 0);
+		if (bar_len >= 0x1000)
+			number_uarts = min_t(unsigned int, number_uarts,
+					     (bar_len - 0x1000) / 0x200);
+		else
+			number_uarts = 0;
+
 		pci_dbg(dev, "%d ports detected on %s PCI Express device\n",
 			number_uarts,
 			dev->vendor == PCI_VENDOR_ID_ENDRUN ?

-- 
2.56.0

