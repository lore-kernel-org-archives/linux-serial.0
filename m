Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099240;
	b=N1nIHuaZoV44l4a+80J5ziMRn5B2nG64JAAkI1Cce3Vrz8m8rkqqZ3tkRMkotTYeelzz
	 tiPStiM940Cm8Eih87osGt8wHVGAwg9tlTOnAiPEC0AJs482MsJdt5C58qWqDHnnd+md2
	 fAzg7dImtYcjVDatJNcOLOsSkTBFph315cNnCnxqnI7gft4FVVH4ApYoNG4a/DRiJZzdE
	 SEp0h3zUUY/MtE/7TIgViWmF95aJ8za/Z/B45HWm+xyFST6BfiYEnYClsiWLv6c8DtolH
	 s0Sq/ON9kxn7snDyiTlz7QvHpRypEHK6taAw+KeRvVYs50r/raCpvXDLmSy8psq6ugA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099240;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=KZ994ocam/n30iySkH9yc+Fh3BXtqJaamSjGT3poDzI=;
	b=D50TEOfIbtbXJy0457Yt6p8kf+fjXlN0aRvwI+4S8oTNwgAZuUIl2EGGnNanUHI2fpal
	 ghPpPng+JYhrdC9yiG4+D7dQLtfMZMq8MhOZ0mumBImsGNbl9jBvQRJ+T5M76Peo+uL9O
	 RVGPohydhVD///1/HijtpFGY+ufPkD7wU224XkGBZFD2TxvXd8MQpQvR9eHijVbzLFJ+l
	 tlW907TavOPzn6s2nH2Pxg/LyfMEMIRlZvmQVdcChRpqnxYoR3HbzFuNY1y25EujPsQle
	 ijXmPZHRFraiklp3YTKIEKJZJsQedIQ1vCfk9sAQMElQBkIpMCdXhKlV5I5wtGkg7Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oLFBjTek;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A7D60A6F56;
	Tue, 27 Oct 2026 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oLFBjTek
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9156F1F01280;
	Tue, 27 Oct 2026 11:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099240;
	bh=KZ994ocam/n30iySkH9yc+Fh3BXtqJaamSjGT3poDzI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oLFBjTek9LnJQV/X8XyhUEBRbysnHcPYMZPlWPMBKhgEqi6O5J89ikhq+tIoSXH7y
	 CISB/NkLQOXwhaN1FRQBFi/tQvQjhGAfQFj22o3yqivV9OvBBX5xLog3olp56v40tq
	 xfW+FPV6YUMyjnlovm06TwnXOLvoXsMzcXWZXRN8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:40 +0100
Subject: [PATCH 14/24] serial: 8250: ioc3: store registered line number in
 driver data
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
Message-Id: <20261027-tty-llm-v1-14-99b0202ae546@linuxfoundation.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=944;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=84b/NyD3VhUBLLiv0UsO/+jPn1zicpFdxtv6bzA0peo=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWvfNeDvRecbkiy//bY5XTsgPMzWb6SM8iW/Sg035L
 ZozspIOd8SyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEgvYxzM8/9ko35HPTqdSt
 PYc/uO/wK17gvZNhntJDP8Wf1VN59x3IEJ5sGlBrWWh+DQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Joshua Rogers <linux@joshua.hu>

The registered line number returned by serial8250_register_8250_port()
was stored only in the local variable 'line' and never saved into
data->line, causing the remove path to always unregister line 0
instead of the correct port.

Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: stable <stable@kernel.org>
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_ioc3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_ioc3.c b/drivers/tty/serial/8250/8250_ioc3.c
index 088242de2eff..3ab50e04be45 100644
--- a/drivers/tty/serial/8250/8250_ioc3.c
+++ b/drivers/tty/serial/8250/8250_ioc3.c
@@ -63,6 +63,7 @@ static int serial8250_ioc3_probe(struct platform_device *pdev)
 	if (IS_ERR(uport))
 		return PTR_ERR(uport);
 
+	data->line = line;
 	platform_set_drvdata(pdev, uport);
 	return 0;
 }

-- 
2.56.0

