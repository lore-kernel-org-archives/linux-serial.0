Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3143DD505
	for <linux-serial@vger.kernel.org>; Tue,  5 May 2026 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966261; cv=none; b=pAuxCYiXyLBqjPyVkkOz3d4OmbLQI+tC7ygIi5qeih62JInS000A+18gAz/8kVsaIGykhdwZ42Nsdcja3KDBKPunGQUqMxxKKEE4/Uezu97XJ1IJb25jeJ0o6oTHkA0fTppJh4fjVur9daox/VBIuA1ToR2ymAJu8Q/jPz/C4N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966261; c=relaxed/simple;
	bh=/UpE1UNcwchg1Y9VdeZE39/R1Nq1x7H30NWCv538Ec4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F/t0Z30JQfwY1H4TlJxOVxi2E15XzuvzJXo3gk39SluRUPKaBcPUnLlIJGoU1LdDLDIbhT69JdATN50WYxJ9kkt+P4bFTTGMc0YDS8G2U4PbeFyS2RwUhRTsSQbg12jvl/d0S2i8M4b5VsN3yoiZvjqcYOyao6aTzej32aDvODk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=vcfh1huP; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="vcfh1huP"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d64313c39so3465872f8f.3
        for <linux-serial@vger.kernel.org>; Tue, 05 May 2026 00:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777966256; x=1778571056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kf/oOS5r8iW2RgiZUnxJUAr+rDZ+oMCyJYQpERo87AY=;
        b=vcfh1huPIH5CTcDq0uW/Jn+UlvXcMWsxKtUxFggFwJny7Ef1lTgyXjntte4y22Slr8
         /ZZCZ65vMVoCwIHZHJj5K9wzoio7bh1mi9SC0dziwnB0MDUhtXK9rQ1vCUZtHv/EBYwm
         UqmPujBF2TiKAUQPIECZ8c7CVWHcMKq95R0sf5QksRY+4Qut1OE6vR+KyMI9WPnkupfZ
         p6lVVerqcRtEpDp7+LdkfbMJHBaOzZslFgn4puVv75/RCDmqvvDvBpxob3unShMq/NVs
         rZmlrsuKKvYY3zGVQJegt1Q8NoSGBNJx91NYhdNUEZArIV3+W0XRLzmrvoEnKbIrQgbF
         6jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777966256; x=1778571056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kf/oOS5r8iW2RgiZUnxJUAr+rDZ+oMCyJYQpERo87AY=;
        b=dnXLQp7mirRUwW8gLN1LlLG72QAonj0CrSD3pcHsQX92Jr0s1Z86THk8t+2M7vJa4F
         7zMNRk+MVyeHFmPZxlG5jz0FhE4xaayYqv/P6/6H3R01K29hseNYUSVVVOWJCS7tcD+p
         5Mus6vPHA+g03mkk2xY0l0oFX4IdsknbGiy9obP6/f1XVC+lEcGODJXs6qadAYm98mc8
         CyZPZlBqX+9tSxwUON+QIHUbfr/AOoPaJt5ZKtvN0d0ZXDiY+ssTqkNXRkxRe159VUgK
         ZHYJ/+I/HD7JnwELLfZVw3hABZlEQvGo6zBGr5G2eui0HFDRSddhI6L4O9lTKRh3riPC
         Mr8A==
X-Gm-Message-State: AOJu0YwButAtn5ObnleJb8aU/+8YJ2oyAm2oLeX2hybiA0LaJg6U3AjK
	teNShdggUm6Yup1n9IoUDgqeq1DjVPEGZck9zBlbeB1aSbbGkED//XbihqFBnprrSlg=
X-Gm-Gg: AeBDieseQb7WuSdZJ9bxJ93DcbclVn3Lt5+HoFlBCpNBle2VblzPgCOT10/GNNwENvb
	3dv6OfqP/0Y2PF6SZU3Dumi1LXGjPLIeFYo5IzMSrH62XCu8Q8Ii7nKRJ2uAYxZ0ZmT0XtgCGmk
	M/c2POqVCCifWuO3oSn04QY3ABFon4/urM71+h7TGEVofXBc6ssjbFuJ/CCWMW3Xh7pjy+LnI1J
	fxG5sbvKkOVxG9gMpblv6sRGY0ygxlUVWZI4xGrIz0VI5UW9d4iUKRyJrcfyDhHgGfO3H5KrcQf
	ejYbWzI7BEgZiiaotOT8iWn+7koz3Ie7PacJHGyW+mHDI1tEXjL/it9vL/dVM5T7KcZEkYA7KKD
	dTansnvNCHtODyUUeAJZD/gqAvYWxSKnGS1oWVEshV0RF15ZCzR3mDkgc2b5bn6Q6ntIeKpwPRJ
	jjd/t6LDrN3MD85ffXWAeEm4ditXI/cWkZsyWic2xPNlAtQBW0ecjzVxQODy2AcieEU1cxxZBcC
	BoET0/H47a6lVPpg897EWOZYg==
X-Received: by 2002:a05:6000:2407:b0:43f:e272:edff with SMTP id ffacd0b85a97d-44bb32fd8b5mr20795785f8f.4.1777966255961;
        Tue, 05 May 2026 00:30:55 -0700 (PDT)
Received: from localhost (p200300f65f114e082236c6257eff72a1.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:2236:c625:7eff:72a1])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45052483166sm2515475f8f.7.2026.05.05.00.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:30:55 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dave Jiang <dave.jiang@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Kees Cook <kees@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH] serial: jsm: Use named initializers for struct pci_device_id
Date: Tue,  5 May 2026 09:30:44 +0200
Message-ID: <20260505073044.2258674-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4956; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=/UpE1UNcwchg1Y9VdeZE39/R1Nq1x7H30NWCv538Ec4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp+ZykFbMjoBaL8OaUI8o4ojfpT+BWiJO/QNov7 AfUFLtPpcaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafmcpAAKCRCPgPtYfRL+ Ti6pCACLT+f+jdGW7v+Oe3schOllsgVCNFrJTwRg70tDHFyXaAXVvRTr6T/aYHyeonk/Q2iO3MA koAGL6PdAB8kno2p2kgQRA0gpIU0u4wBcg0cbZCWCdEQ8vf+RhzhjatJiqS402BG5gzRotyklBU nEQcWEjMIbgNTZ8L7rgPEyvjymRbnaYiOIEKGref7yiUpLPLtX2b7YoSfC3K5a4Xb7O4rETzPSO eFzB479WKzIEm9X0QHnurCdPRIpL8jP41iqyr4h8XF+H+047Li3Po8EGsdOdE4AnqJ+lRGTH7SL Hp6vGxOBQ6cN+QF5DQkPLqXyTCMNNXuhJfEcDGlpLa5e0QGO
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Initializing structures using list initializers is harder to read than
using named initializers. Seeing the member name is more ideomatic and
easier to understand.

Use named initializers for the driver's pci_device_id array. While at it
also drop an explicit zero in the terminating array entry.

There are no changes to the compiled result of the array; verified with
builds for x86 and arm64.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this is a preparing change for making struct pci_device_id::driver_data an
anonymous union (similar to
https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/).
This requires named initializers for .driver_data. But even without that
this is a nice cleanup making the array better readable.

Having said that I didn't find where .driver_data is used, so unless I
missed something the assignments can just go away???

For earlier patches of this type against other drivers I got the
feedback to use PCI_DEVICE_DATA() but I don't like that as it mixes
hardware properties (.vendor and .device) with driver specific software
properties (.driver_data) and thus I prefer the explicit listing
(involving more repetition) over the shorter variant (being more opaque
and harder to read).

Best regards
Uwe

 drivers/tty/serial/jsm/jsm_driver.c | 75 +++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_driver.c b/drivers/tty/serial/jsm/jsm_driver.c
index 4b73e51f83fb..422cac8d8d71 100644
--- a/drivers/tty/serial/jsm/jsm_driver.c
+++ b/drivers/tty/serial/jsm/jsm_driver.c
@@ -296,25 +296,62 @@ static void jsm_remove_one(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id jsm_pci_tbl[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9), 0, 0, 0 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9PRI), 0, 0, 1 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2RJ45), 0, 0, 2 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2RJ45PRI), 0, 0, 3 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_4_IBM), 0, 0, 4 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_DIGI_NEO_8), 0, 0, 5 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_4), 0, 0, 6 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_1_422), 0, 0, 7 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_1_422_485), 0, 0, 8 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2_422_485), 0, 0, 9 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_8), 0, 0, 10 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_4), 0, 0, 11 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_4RJ45), 0, 0, 12 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_8RJ45), 0, 0, 13 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_CLASSIC_4), 0, 0, 14 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_CLASSIC_4_422), 0, 0, 15 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_CLASSIC_8), 0, 0, 16 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_CLASSIC_8_422), 0, 0, 17 },
-	{ 0, }
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9),
+		.driver_data = 0,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9PRI),
+		.driver_data = 1,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2RJ45),
+		.driver_data = 2,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2RJ45PRI),
+		.driver_data = 3,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_4_IBM),
+		.driver_data = 4,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_DIGI_NEO_8),
+		.driver_data = 5,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_4),
+		.driver_data = 6,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_1_422),
+		.driver_data = 7,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_1_422_485),
+		.driver_data = 8,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2_422_485),
+		.driver_data = 9,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_8),
+		.driver_data = 10,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_4),
+		.driver_data = 11,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_4RJ45),
+		.driver_data = 12,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_8RJ45),
+		.driver_data = 13,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_CLASSIC_4),
+		.driver_data = 14,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_CLASSIC_4_422),
+		.driver_data = 15,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_CLASSIC_8),
+		.driver_data = 16,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_CLASSIC_8_422),
+		.driver_data = 17,
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, jsm_pci_tbl);
 

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

