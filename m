Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293773A7825
	for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776707828; cv=none; b=tKjk7VKQKw1H07B93kBLwOlnELv6LEnSkRkjbSglmzseR2+22P0eSqtoFa0UFeOOQIEyaB2q3grs0uDAom5vfb0sia1UgYVD2BCZn5WkAF5l/bFrM2+kaN9RclDGqF2ZkLH8G3VTf/4lX8qhukRObFfj2/pqHpYLR1zuWkzbhaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776707828; c=relaxed/simple;
	bh=G1EohMR4Uj836R+VS90BW4nCPmqXVGRk/2CnNiBnsTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I0Xxfwui9a2PT3xPnQTlhfDeQvbGFsMcRPYaSCj5Wp0EVuqnIvwUYQuySWh97M30prQATs44aTi4eMw+bQGf8VwSbCUuoWwAAm3B9K/mqpUvYC6A6F4ChAl4CRGLAOS+EKSdM9KJ/JsJeZ1Ty49X+1BcB5hLLBooBkTOOhXKCvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=mFV8rh/k; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="mFV8rh/k"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d7213b6ebso2239187f8f.3
        for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776707819; x=1777312619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9no0CNf8CBV1UslbTIN9PyBqYNH50pp7/5aEyk3+Y0Y=;
        b=mFV8rh/kUIyJRphc3LIrWLNK01l1HbUl74QMA9n44nxCKjaaGMTJXp5irMpqzEKWDI
         hjn65DgbzJk4B0cP/8U/kt8raCRDGrmQ6NeMrFK8jyXIK0ibVuglWcO2/nZ/IYPby/WR
         7KozR1xZuIIRfpDEQZDOSACXXUKUI0gYim2acs+d0ZZiwqa5J2HZK/jelq1hwDLWCFKc
         Z+64/cDh6VDGZ7g8DLVkWZQ72oHHW3KU0Q2t/brs9jH1WCUJ2V2halNr5NE+Rqntv26G
         6APmV4sG+veNf1CHfD/1UagnpgFr2Foap0nbuq7xUNlYvZEDJI25bfeCzMSAKTQoaquU
         92Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776707819; x=1777312619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9no0CNf8CBV1UslbTIN9PyBqYNH50pp7/5aEyk3+Y0Y=;
        b=sZ7ZY/STVs4Q7JYPTPruxosZHaXgvNBmZtzVRjViyd4z2JvWkI7aYkK45YlGm07d3p
         ndkb85oQ/ZRBP/QP39w0Tbwb995GO1wJSHSts9pp+P3VDJtzn9Lhv390ijzNjrRUnYS9
         S2GrKlNEo1ErBEBhpRXJQwSAzQbzx5UdrUUHm5WCsuF/uYWTDPDdVi+MohJ2iYzAsGp3
         1fVlWVtGhfulQ6edevJCXPQ6thD/wcs5P3dM7OwMbyEh5gGXVcJPJHWFlR6QWY4SPM9q
         H7fDSFMdSia5e3uh4RtMHxD2cpkhevxCjcvza7aSXEtsmqkq5TUlX+FiZ3kcreW6gYbP
         ix3A==
X-Forwarded-Encrypted: i=1; AFNElJ9Iz5xFgKmEjpJLXdlOUAo09mjK3dzTKbkSaq/2/2VsMuFrYs/yuNEQz1sbMZr3OD4clu9TVWRwsYI4guQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCNfSNIrLnGuWSBC6hxJ6pdj+Guim4himrrqiQePBe9wkTRF2k
	O1zL/Voigw2H6FElSgiUPTIb6a74qBoj+ui5coYMEib2Mf5+La9FiY5NxrFumnkBPy8=
X-Gm-Gg: AeBDievRBSc/1hH3RI4naQWQH271Vtywt4xpgXSSezhtdyRNaE2d3tg5pj97jyArw4Q
	AaYjoK2z2YLJ5+pOtMQciZQf/Tvbal3qPIw7CQCc9yfHKdJIlIZdxIqQ3Z3hFGip8yXggR6hu0l
	XD4pjKMfstoDPayy81DdQ9rtLxTDJYfhvhhxeUNtuSDRBmhAutm2PYsxhbRPNEOEfOB2FVFcbyg
	E1I1Yg5zorrhrdmi0Om5lhadjLOfb6arjtjN2oHpzUYbmXbaNypUFOeqHKAEo7R5kk0yd3KjGwd
	6DitrX22UQCFIicxHQt2XrW4sD4IpH0+BqTSVjNCZie63IRpafSJ7X0WOGvq9ORh23yyv7+R/7M
	OnNBc1g7ZeAi9s3iyoRRPEp2959yTgJxe6v6lUR0MhK0iujKpf4zeenz6z/+KdNx1w+lLQgILR2
	YE0kGxtENlvKezyMRHrECamyjvVVDJ/0vhwnqVSjUqSFjCk4EZhmVl07pqIRZtFA0Rn+y4lZvN9
	tKG7Vz4ucHDY0P+zJ3i+px7aA==
X-Received: by 2002:a05:6000:2212:b0:43d:7bc9:9b2c with SMTP id ffacd0b85a97d-43fe3dcb3c0mr22544734f8f.17.1776707818675;
        Mon, 20 Apr 2026 10:56:58 -0700 (PDT)
Received: from localhost (p200300f65f114e0868383d4176e8a9e8.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:6838:3d41:76e8:a9e8])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4e59f97sm34266718f8f.37.2026.04.20.10.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 10:56:57 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_pci: Consistently define pci_device_ids using named initializers
Date: Mon, 20 Apr 2026 19:56:48 +0200
Message-ID: <20260420175648.1709935-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=115709; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=G1EohMR4Uj836R+VS90BW4nCPmqXVGRk/2CnNiBnsTw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp5mjggAE0aMPG3xSf/P3qh07qErm4LcRmR96yM OSwF/9nfa+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaeZo4AAKCRCPgPtYfRL+ TtbGB/9ThPlQ+Lq7yOtujCPRIemq4UZxOtT5veWMOHFvdGPrx3YkJbK1EtLazavUVV7kVk59Mps n0bGFmvI0O3gDkwx58h9/XA8FJvSfSDYPHwECM/+3wDrKH3a+BKm4YkbcATVHiB8fc04CNsY5uF gkgAJ5C7NRiY8Eo3qUQQ4/3lzRx1fypQ54wo1l1GJUj7pyhaBHaIFKVEqyKeRxl8AwLQ1LxyMjJ 5KodExipxANe2kzzzx17r1FqeKLJKeFJ+aJ/AevEPxk9NO61TXxPt8PGSnd1xEhevqgSRHwXUHX WAbcpe1NRy2wGvssZk11f2vneKpTgKRpdoTOcZGbgjYBzCoO
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

... and PCI device helpers.

The various struct pci_device_id were defined using a mixture of
initialization by position and by name. Some use the PCI device helpers
(like PCI_DEVICE and PCI_DEVICE_SUB) and others don't.

Consistently use named initializers, drop assignments of 0 by position
for .class and .class_mask and use the PCI device helpers. Also use
consistent line-breaks and positioning for opening and closing curly
braces.

The secret plan is to make struct pci_device_id::driver_data an
anonymous union (similar to
https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/)
and that requires named initializers. But it's also a nice cleanup on
its own.

This patch doesn't change the compiled result; this was verified using
an amd64 allmodconfig with all debugging disabled.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

I started to do what I did in the patch linked above for firewire also
for pci. The 8250_pci driver needs quite some massaging for that. As I
wouldn't be surprised if this commit creates some discussion (e.g.
because I failed at being really consistent here, or my consistency
doesn't match the desired consistency by others), I sent this patch out
early to have this discussion separate from the union change.

Best regards
Uwe

 drivers/tty/serial/8250/8250_pci.c | 2990 ++++++++++++++--------------
 1 file changed, 1549 insertions(+), 1441 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 6cfd1b2af5b7..303769643643 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -3992,42 +3992,42 @@ static const struct pci_device_id blacklist[] = {
 
 	/* multi-io cards handled by parport_serial */
 	/* WCH CH353 2S1P */
-	{ PCI_VDEVICE(WCHCN, 0x7053), REPORT_CONFIG(PARPORT_SERIAL), },
+	{ PCI_VDEVICE(WCHCN, 0x7053), .driver_data = REPORT_CONFIG(PARPORT_SERIAL), },
 	/* WCH CH353 1S1P */
-	{ PCI_VDEVICE(WCHCN, 0x5053), REPORT_CONFIG(PARPORT_SERIAL), },
+	{ PCI_VDEVICE(WCHCN, 0x5053), .driver_data = REPORT_CONFIG(PARPORT_SERIAL), },
 	/* WCH CH382 2S1P */
-	{ PCI_VDEVICE(WCHIC, 0x3250), REPORT_CONFIG(PARPORT_SERIAL), },
+	{ PCI_VDEVICE(WCHIC, 0x3250), .driver_data = REPORT_CONFIG(PARPORT_SERIAL), },
 
 	/* Intel platforms with MID UART */
-	{ PCI_VDEVICE(INTEL, 0x081b), REPORT_8250_CONFIG(MID), },
-	{ PCI_VDEVICE(INTEL, 0x081c), REPORT_8250_CONFIG(MID), },
-	{ PCI_VDEVICE(INTEL, 0x081d), REPORT_8250_CONFIG(MID), },
-	{ PCI_VDEVICE(INTEL, 0x1191), REPORT_8250_CONFIG(MID), },
-	{ PCI_VDEVICE(INTEL, 0x18d8), REPORT_8250_CONFIG(MID), },
-	{ PCI_VDEVICE(INTEL, 0x19d8), REPORT_8250_CONFIG(MID), },
+	{ PCI_VDEVICE(INTEL, 0x081b), .driver_data = REPORT_8250_CONFIG(MID), },
+	{ PCI_VDEVICE(INTEL, 0x081c), .driver_data = REPORT_8250_CONFIG(MID), },
+	{ PCI_VDEVICE(INTEL, 0x081d), .driver_data = REPORT_8250_CONFIG(MID), },
+	{ PCI_VDEVICE(INTEL, 0x1191), .driver_data = REPORT_8250_CONFIG(MID), },
+	{ PCI_VDEVICE(INTEL, 0x18d8), .driver_data = REPORT_8250_CONFIG(MID), },
+	{ PCI_VDEVICE(INTEL, 0x19d8), .driver_data = REPORT_8250_CONFIG(MID), },
 
 	/* Intel platforms with DesignWare UART */
-	{ PCI_VDEVICE(INTEL, 0x0936), REPORT_8250_CONFIG(LPSS), },
-	{ PCI_VDEVICE(INTEL, 0x0f0a), REPORT_8250_CONFIG(LPSS), },
-	{ PCI_VDEVICE(INTEL, 0x0f0c), REPORT_8250_CONFIG(LPSS), },
-	{ PCI_VDEVICE(INTEL, 0x228a), REPORT_8250_CONFIG(LPSS), },
-	{ PCI_VDEVICE(INTEL, 0x228c), REPORT_8250_CONFIG(LPSS), },
-	{ PCI_VDEVICE(INTEL, 0x4b96), REPORT_8250_CONFIG(LPSS), },
-	{ PCI_VDEVICE(INTEL, 0x4b97), REPORT_8250_CONFIG(LPSS), },
-	{ PCI_VDEVICE(INTEL, 0x4b98), REPORT_8250_CONFIG(LPSS), },
-	{ PCI_VDEVICE(INTEL, 0x4b99), REPORT_8250_CONFIG(LPSS), },
-	{ PCI_VDEVICE(INTEL, 0x4b9a), REPORT_8250_CONFIG(LPSS), },
-	{ PCI_VDEVICE(INTEL, 0x4b9b), REPORT_8250_CONFIG(LPSS), },
-	{ PCI_VDEVICE(INTEL, 0x9ce3), REPORT_8250_CONFIG(LPSS), },
-	{ PCI_VDEVICE(INTEL, 0x9ce4), REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x0936), .driver_data = REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x0f0a), .driver_data = REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x0f0c), .driver_data = REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x228a), .driver_data = REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x228c), .driver_data = REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x4b96), .driver_data = REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x4b97), .driver_data = REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x4b98), .driver_data = REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x4b99), .driver_data = REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x4b9a), .driver_data = REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x4b9b), .driver_data = REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x9ce3), .driver_data = REPORT_8250_CONFIG(LPSS), },
+	{ PCI_VDEVICE(INTEL, 0x9ce4), .driver_data = REPORT_8250_CONFIG(LPSS), },
 
 	/* Exar devices */
-	{ PCI_VDEVICE(EXAR, PCI_ANY_ID), REPORT_8250_CONFIG(EXAR), },
-	{ PCI_VDEVICE(COMMTECH, PCI_ANY_ID), REPORT_8250_CONFIG(EXAR), },
+	{ PCI_VDEVICE(EXAR, PCI_ANY_ID), .driver_data = REPORT_8250_CONFIG(EXAR), },
+	{ PCI_VDEVICE(COMMTECH, PCI_ANY_ID), .driver_data = REPORT_8250_CONFIG(EXAR), },
 
 	/* Pericom devices */
-	{ PCI_VDEVICE(PERICOM, PCI_ANY_ID), REPORT_8250_CONFIG(PERICOM), },
-	{ PCI_VDEVICE(ACCESSIO, PCI_ANY_ID), REPORT_8250_CONFIG(PERICOM), },
+	{ PCI_VDEVICE(PERICOM, PCI_ANY_ID), .driver_data = REPORT_8250_CONFIG(PERICOM), },
+	{ PCI_VDEVICE(ACCESSIO, PCI_ANY_ID), .driver_data = REPORT_8250_CONFIG(PERICOM), },
 
 	/* End of the black list */
 	{ }
@@ -4400,713 +4400,753 @@ static SIMPLE_DEV_PM_OPS(pciserial_pm_ops, pciserial_suspend_one,
 			 pciserial_resume_one);
 
 static const struct pci_device_id serial_pci_tbl[] = {
-	{	PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI1600,
-		PCI_DEVICE_ID_ADVANTECH_PCI1600_1611, PCI_ANY_ID, 0, 0,
-		pbn_b0_4_921600 },
-	/* Advantech use PCI_DEVICE_ID_ADVANTECH_PCI3620 (0x3620) as 'PCI_SUBVENDOR_ID' */
-	{	PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI3620,
-		PCI_DEVICE_ID_ADVANTECH_PCI3620, 0x0001, 0, 0,
-		pbn_b2_8_921600 },
-	/* Advantech also use 0x3618 and 0xf618 */
-	{	PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI3618,
-		PCI_DEVICE_ID_ADVANTECH_PCI3618, PCI_ANY_ID, 0, 0,
-		pbn_b0_4_921600 },
-	{	PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCIf618,
-		PCI_DEVICE_ID_ADVANTECH_PCI3618, PCI_ANY_ID, 0, 0,
-		pbn_b0_4_921600 },
-	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232, 0, 0,
-		pbn_b1_8_1382400 },
-	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_232, 0, 0,
-		pbn_b1_4_1382400 },
-	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_232, 0, 0,
-		pbn_b1_2_1382400 },
-	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232, 0, 0,
-		pbn_b1_8_1382400 },
-	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_232, 0, 0,
-		pbn_b1_4_1382400 },
-	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_232, 0, 0,
-		pbn_b1_2_1382400 },
-	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485, 0, 0,
-		pbn_b1_8_921600 },
-	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_4_4, 0, 0,
-		pbn_b1_8_921600 },
-	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485, 0, 0,
-		pbn_b1_4_921600 },
-	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485_2_2, 0, 0,
-		pbn_b1_4_921600 },
-	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_485, 0, 0,
-		pbn_b1_2_921600 },
-	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_2_6, 0, 0,
-		pbn_b1_8_921600 },
-	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH081101V1, 0, 0,
-		pbn_b1_8_921600 },
-	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH041101V1, 0, 0,
-		pbn_b1_4_921600 },
-	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_20MHZ, 0, 0,
-		pbn_b1_2_1250000 },
-	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_TITAN_2, 0, 0,
-		pbn_b0_2_1843200 },
-	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_TITAN_4, 0, 0,
-		pbn_b0_4_1843200 },
-	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
-		PCI_VENDOR_ID_AFAVLAB,
-		PCI_SUBDEVICE_ID_AFAVLAB_P061, 0, 0,
-		pbn_b0_4_1152000 },
-	{	PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_U530,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_bt_1_115200 },
-	{	PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_UCOMM2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_bt_2_115200 },
-	{	PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_UCOMM422,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_bt_4_115200 },
-	{	PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_UCOMM232,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_bt_2_115200 },
-	{	PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_COMM4,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_bt_4_115200 },
-	{	PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_COMM8,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_8_115200 },
-	{	PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_7803,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_8_460800 },
-	{	PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_UCOMM8,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_8_115200 },
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI1600,
+			       PCI_DEVICE_ID_ADVANTECH_PCI1600_1611, PCI_ANY_ID),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		/* Advantech use PCI_DEVICE_ID_ADVANTECH_PCI3620 (0x3620) as 'PCI_SUBVENDOR_ID' */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI3620,
+			       PCI_DEVICE_ID_ADVANTECH_PCI3620, 0x0001),
+		.driver_data = pbn_b2_8_921600,
+	}, {
+		/* Advantech also use 0x3618 and 0xf618 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI3618,
+			       PCI_DEVICE_ID_ADVANTECH_PCI3618, PCI_ANY_ID),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCIf618,
+			       PCI_DEVICE_ID_ADVANTECH_PCI3618, PCI_ANY_ID),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
+			       PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232),
+		.driver_data = pbn_b1_8_1382400,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
+			       PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_232),
+		.driver_data = pbn_b1_4_1382400,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
+			       PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_232),
+		.driver_data = pbn_b1_2_1382400,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
+			       PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232),
+		.driver_data = pbn_b1_8_1382400,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
+			       PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_232),
+		.driver_data = pbn_b1_4_1382400,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
+			       PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_232),
+		.driver_data = pbn_b1_2_1382400,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
+			       PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485),
+		.driver_data = pbn_b1_8_921600,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
+			       PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_4_4),
+		.driver_data = pbn_b1_8_921600,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
+			       PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485),
+		.driver_data = pbn_b1_4_921600,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
+			       PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485_2_2),
+		.driver_data = pbn_b1_4_921600,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
+			       PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_485),
+		.driver_data = pbn_b1_2_921600,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
+			       PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_2_6),
+		.driver_data = pbn_b1_8_921600,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
+			       PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH081101V1),
+		.driver_data = pbn_b1_8_921600,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
+			       PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH041101V1),
+		.driver_data = pbn_b1_4_921600,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
+			       PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_20MHZ),
+		.driver_data = pbn_b1_2_1250000,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
+			       PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_TITAN_2),
+		.driver_data = pbn_b0_2_1843200,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
+			       PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_TITAN_4),
+		.driver_data = pbn_b0_4_1843200,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
+			       PCI_VENDOR_ID_AFAVLAB, PCI_SUBDEVICE_ID_AFAVLAB_P061),
+		.driver_data = pbn_b0_4_1152000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_U530),
+		.driver_data = pbn_b2_bt_1_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_UCOMM2),
+		.driver_data = pbn_b2_bt_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_UCOMM422),
+		.driver_data = pbn_b2_bt_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_UCOMM232),
+		.driver_data = pbn_b2_bt_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_COMM4),
+		.driver_data = pbn_b2_bt_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_COMM8),
+		.driver_data = pbn_b2_8_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_7803),
+		.driver_data = pbn_b2_8_460800,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_UCOMM8),
+		.driver_data = pbn_b2_8_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_GTEK_SERIAL2),
+		.driver_data = pbn_b2_bt_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_SPCOM200),
+		.driver_data = pbn_b2_bt_2_921600,
+	}, {
+		/* VScom SPCOM800, from sl@s.pl */
+		PCI_DEVICE(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_SPCOM800),
+		.driver_data = pbn_b2_8_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_1077),
+		.driver_data = pbn_b2_4_921600,
+	}, {
+		/* Unknown card - subdevice 0x1584 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
+			       PCI_VENDOR_ID_PLX, PCI_SUBDEVICE_ID_UNKNOWN_0x1584),
+		.driver_data = pbn_b2_4_115200,
+	}, {
+		/* Unknown card - subdevice 0x1588 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
+			       PCI_VENDOR_ID_PLX, PCI_SUBDEVICE_ID_UNKNOWN_0x1588),
+		.driver_data = pbn_b2_8_115200,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
+			       PCI_SUBVENDOR_ID_KEYSPAN, PCI_SUBDEVICE_ID_KEYSPAN_SX2),
+		.driver_data = pbn_panacom,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_PANACOM, PCI_DEVICE_ID_PANACOM_QUADMODEM),
+		.driver_data = pbn_panacom4,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_PANACOM, PCI_DEVICE_ID_PANACOM_DUALMODEM),
+		.driver_data = pbn_panacom2,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
+			       PCI_VENDOR_ID_ESDGMBH, PCI_DEVICE_ID_ESDGMBH_CPCIASIO4),
+		.driver_data = pbn_b2_4_115200,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
+			       PCI_SUBVENDOR_ID_CHASE_PCIFAST, PCI_SUBDEVICE_ID_CHASE_PCIFAST4),
+		.driver_data = pbn_b2_4_460800,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
+			       PCI_SUBVENDOR_ID_CHASE_PCIFAST, PCI_SUBDEVICE_ID_CHASE_PCIFAST8),
+		.driver_data = pbn_b2_8_460800,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
+			       PCI_SUBVENDOR_ID_CHASE_PCIFAST, PCI_SUBDEVICE_ID_CHASE_PCIFAST16),
+		.driver_data = pbn_b2_16_460800,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
+			       PCI_SUBVENDOR_ID_CHASE_PCIFAST, PCI_SUBDEVICE_ID_CHASE_PCIFAST16FMC),
+		.driver_data = pbn_b2_16_460800,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
+			       PCI_SUBVENDOR_ID_CHASE_PCIRAS, PCI_SUBDEVICE_ID_CHASE_PCIRAS4),
+		.driver_data = pbn_b2_4_460800,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
+			       PCI_SUBVENDOR_ID_CHASE_PCIRAS, PCI_SUBDEVICE_ID_CHASE_PCIRAS8),
+		.driver_data = pbn_b2_8_460800,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
+			       PCI_SUBVENDOR_ID_EXSYS, PCI_SUBDEVICE_ID_EXSYS_4055),
+		.driver_data = pbn_b2_4_115200,
+	}, {
+		/*
+		 * Megawolf Romulus PCI Serial Card, from Mike Hudson
+		 * (Exoray@isys.ca)
+		 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_ROMULUS,
+			       0x10b5, 0x106a),
+		.driver_data = pbn_plx_romulus,
+	},
 
-	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_GTEK_SERIAL2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_bt_2_115200 },
-	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_SPCOM200,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_bt_2_921600 },
-	/*
-	 * VScom SPCOM800, from sl@s.pl
-	 */
-	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_SPCOM800,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_8_921600 },
-	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_1077,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_4_921600 },
-	/* Unknown card - subdevice 0x1584 */
-	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
-		PCI_VENDOR_ID_PLX,
-		PCI_SUBDEVICE_ID_UNKNOWN_0x1584, 0, 0,
-		pbn_b2_4_115200 },
-	/* Unknown card - subdevice 0x1588 */
-	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
-		PCI_VENDOR_ID_PLX,
-		PCI_SUBDEVICE_ID_UNKNOWN_0x1588, 0, 0,
-		pbn_b2_8_115200 },
-	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
-		PCI_SUBVENDOR_ID_KEYSPAN,
-		PCI_SUBDEVICE_ID_KEYSPAN_SX2, 0, 0,
-		pbn_panacom },
-	{	PCI_VENDOR_ID_PANACOM, PCI_DEVICE_ID_PANACOM_QUADMODEM,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_panacom4 },
-	{	PCI_VENDOR_ID_PANACOM, PCI_DEVICE_ID_PANACOM_DUALMODEM,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_panacom2 },
-	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
-		PCI_VENDOR_ID_ESDGMBH,
-		PCI_DEVICE_ID_ESDGMBH_CPCIASIO4, 0, 0,
-		pbn_b2_4_115200 },
-	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
-		PCI_SUBVENDOR_ID_CHASE_PCIFAST,
-		PCI_SUBDEVICE_ID_CHASE_PCIFAST4, 0, 0,
-		pbn_b2_4_460800 },
-	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
-		PCI_SUBVENDOR_ID_CHASE_PCIFAST,
-		PCI_SUBDEVICE_ID_CHASE_PCIFAST8, 0, 0,
-		pbn_b2_8_460800 },
-	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
-		PCI_SUBVENDOR_ID_CHASE_PCIFAST,
-		PCI_SUBDEVICE_ID_CHASE_PCIFAST16, 0, 0,
-		pbn_b2_16_460800 },
-	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
-		PCI_SUBVENDOR_ID_CHASE_PCIFAST,
-		PCI_SUBDEVICE_ID_CHASE_PCIFAST16FMC, 0, 0,
-		pbn_b2_16_460800 },
-	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
-		PCI_SUBVENDOR_ID_CHASE_PCIRAS,
-		PCI_SUBDEVICE_ID_CHASE_PCIRAS4, 0, 0,
-		pbn_b2_4_460800 },
-	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
-		PCI_SUBVENDOR_ID_CHASE_PCIRAS,
-		PCI_SUBDEVICE_ID_CHASE_PCIRAS8, 0, 0,
-		pbn_b2_8_460800 },
-	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
-		PCI_SUBVENDOR_ID_EXSYS,
-		PCI_SUBDEVICE_ID_EXSYS_4055, 0, 0,
-		pbn_b2_4_115200 },
-	/*
-	 * Megawolf Romulus PCI Serial Card, from Mike Hudson
-	 * (Exoray@isys.ca)
-	 */
-	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_ROMULUS,
-		0x10b5, 0x106a, 0, 0,
-		pbn_plx_romulus },
 	/*
 	 * Quatech cards. These actually have configurable clocks but for
 	 * now we just use the default.
 	 *
 	 * 100 series are RS232, 200 series RS422,
 	 */
-	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_QSC100,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_4_115200 },
-	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSC100,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_2_115200 },
-	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSC100E,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_2_115200 },
-	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSC200,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_2_115200 },
-	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSC200E,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_2_115200 },
-	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_QSC200,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_4_115200 },
-	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_ESC100D,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_8_115200 },
-	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_ESC100M,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_8_115200 },
-	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_QSCP100,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_4_115200 },
-	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSCP100,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_2_115200 },
-	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_QSCP200,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_4_115200 },
-	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSCP200,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_2_115200 },
-	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_QSCLP100,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_4_115200 },
-	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSCLP100,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_2_115200 },
-	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_SSCLP100,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_1_115200 },
-	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_QSCLP200,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_4_115200 },
-	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSCLP200,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_2_115200 },
-	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_SSCLP200,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_1_115200 },
-	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_ESCLP100,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_8_115200 },
-
-	{	PCI_VENDOR_ID_SPECIALIX, PCI_DEVICE_ID_OXSEMI_16PCI954,
-		PCI_VENDOR_ID_SPECIALIX, PCI_SUBDEVICE_ID_SPECIALIX_SPEED4,
-		0, 0,
-		pbn_b0_4_921600 },
-	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
-		PCI_SUBVENDOR_ID_SIIG, PCI_SUBDEVICE_ID_SIIG_QUARTET_SERIAL,
-		0, 0,
-		pbn_b0_4_1152000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0x9505,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_2_921600 },
-
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_QSC100),
+		.driver_data = pbn_b1_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSC100),
+		.driver_data = pbn_b1_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSC100E),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSC200),
+		.driver_data = pbn_b1_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSC200E),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_QSC200),
+		.driver_data = pbn_b1_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_ESC100D),
+		.driver_data = pbn_b1_8_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_ESC100M),
+		.driver_data = pbn_b1_8_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_QSCP100),
+		.driver_data = pbn_b1_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSCP100),
+		.driver_data = pbn_b1_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_QSCP200),
+		.driver_data = pbn_b1_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSCP200),
+		.driver_data = pbn_b1_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_QSCLP100),
+		.driver_data = pbn_b2_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSCLP100),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_SSCLP100),
+		.driver_data = pbn_b2_1_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_QSCLP200),
+		.driver_data = pbn_b2_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSCLP200),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_SSCLP200),
+		.driver_data = pbn_b2_1_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_ESCLP100),
+		.driver_data = pbn_b0_8_115200,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_SPECIALIX, PCI_DEVICE_ID_OXSEMI_16PCI954,
+			       PCI_VENDOR_ID_SPECIALIX, PCI_SUBDEVICE_ID_SPECIALIX_SPEED4),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
+			       PCI_SUBVENDOR_ID_SIIG, PCI_SUBDEVICE_ID_SIIG_QUARTET_SERIAL),
+		.driver_data = pbn_b0_4_1152000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0x9505),
+		.driver_data = pbn_b0_bt_2_921600,
+	}, {
 		/*
 		 * The below card is a little controversial since it is the
 		 * subject of a PCI vendor/device ID clash.  (See
 		 * www.ussg.iu.edu/hypermail/linux/kernel/0303.1/0516.html).
 		 * For now just used the hex ID 0x950a.
 		 */
-	{	PCI_VENDOR_ID_OXSEMI, 0x950a,
-		PCI_SUBVENDOR_ID_SIIG, PCI_SUBDEVICE_ID_SIIG_DUAL_00,
-		0, 0, pbn_b0_2_115200 },
-	{	PCI_VENDOR_ID_OXSEMI, 0x950a,
-		PCI_SUBVENDOR_ID_SIIG, PCI_SUBDEVICE_ID_SIIG_DUAL_30,
-		0, 0, pbn_b0_2_115200 },
-	{	PCI_VENDOR_ID_OXSEMI, 0x950a,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_2_1130000 },
-	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_C950,
-		PCI_VENDOR_ID_OXSEMI, PCI_SUBDEVICE_ID_OXSEMI_C950, 0, 0,
-		pbn_b0_1_921600 },
-	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_4_115200 },
-	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI952,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_2_921600 },
-	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI958,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_8_1152000 },
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_OXSEMI, 0x950a,
+			       PCI_SUBVENDOR_ID_SIIG, PCI_SUBDEVICE_ID_SIIG_DUAL_00),
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_OXSEMI, 0x950a,
+			       PCI_SUBVENDOR_ID_SIIG, PCI_SUBDEVICE_ID_SIIG_DUAL_30),
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0x950a),
+		.driver_data = pbn_b0_2_1130000,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_C950,
+			       PCI_VENDOR_ID_OXSEMI, PCI_SUBDEVICE_ID_OXSEMI_C950),
+		.driver_data = pbn_b0_1_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954),
+		.driver_data = pbn_b0_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI952),
+		.driver_data = pbn_b0_bt_2_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI958),
+		.driver_data = pbn_b2_8_1152000,
+	},
 
 	/*
 	 * Oxford Semiconductor Inc. Tornado PCI express device range.
 	 */
-	{	PCI_VENDOR_ID_OXSEMI, 0xc101,    /* OXPCIe952 1 Legacy UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc105,    /* OXPCIe952 1 Legacy UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc11b,    /* OXPCIe952 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc11f,    /* OXPCIe952 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc120,    /* OXPCIe952 1 Legacy UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc124,    /* OXPCIe952 1 Legacy UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc138,    /* OXPCIe952 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc13d,    /* OXPCIe952 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc140,    /* OXPCIe952 1 Legacy UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc141,    /* OXPCIe952 1 Legacy UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc144,    /* OXPCIe952 1 Legacy UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc145,    /* OXPCIe952 1 Legacy UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc158,    /* OXPCIe952 2 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_2_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc15d,    /* OXPCIe952 2 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_2_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc208,    /* OXPCIe954 4 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_4_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc20d,    /* OXPCIe954 4 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_4_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc308,    /* OXPCIe958 8 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_8_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc30d,    /* OXPCIe958 8 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_8_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc40b,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc40f,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc41b,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc41f,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc42b,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc42f,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc43b,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc43f,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc44b,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc44f,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc45b,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc45f,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc46b,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc46f,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc47b,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc47f,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc48b,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc48f,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc49b,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc49f,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc4ab,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc4af,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc4bb,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc4bf,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc4cb,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc4cf,    /* OXPCIe200 1 Native UART */
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_15625000 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc101),    /* OXPCIe952 1 Legacy UART */
+		.driver_data = pbn_b0_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc105),    /* OXPCIe952 1 Legacy UART */
+		.driver_data = pbn_b0_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc11b),    /* OXPCIe952 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc11f),    /* OXPCIe952 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc120),    /* OXPCIe952 1 Legacy UART */
+		.driver_data = pbn_b0_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc124),    /* OXPCIe952 1 Legacy UART */
+		.driver_data = pbn_b0_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc138),    /* OXPCIe952 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc13d),    /* OXPCIe952 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc140),    /* OXPCIe952 1 Legacy UART */
+		.driver_data = pbn_b0_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc141),    /* OXPCIe952 1 Legacy UART */
+		.driver_data = pbn_b0_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc144),    /* OXPCIe952 1 Legacy UART */
+		.driver_data = pbn_b0_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc145),    /* OXPCIe952 1 Legacy UART */
+		.driver_data = pbn_b0_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc158),    /* OXPCIe952 2 Native UART */
+		.driver_data = pbn_oxsemi_2_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc15d),    /* OXPCIe952 2 Native UART */
+		.driver_data = pbn_oxsemi_2_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc208),    /* OXPCIe954 4 Native UART */
+		.driver_data = pbn_oxsemi_4_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc20d),    /* OXPCIe954 4 Native UART */
+		.driver_data = pbn_oxsemi_4_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc308),    /* OXPCIe958 8 Native UART */
+		.driver_data = pbn_oxsemi_8_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc30d),    /* OXPCIe958 8 Native UART */
+		.driver_data = pbn_oxsemi_8_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc40b),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc40f),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc41b),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc41f),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc42b),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc42f),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc43b),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc43f),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc44b),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc44f),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc45b),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc45f),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc46b),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc46f),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc47b),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc47f),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc48b),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc48f),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc49b),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc49f),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc4ab),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc4af),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc4bb),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc4bf),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc4cb),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, 0xc4cf),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	},
 	/*
 	 * Mainpine Inc. IQ Express "Rev3" utilizing OxSemi Tornado
 	 */
-	{	PCI_VENDOR_ID_MAINPINE, 0x4000,	/* IQ Express 1 Port V.34 Super-G3 Fax */
-		PCI_VENDOR_ID_MAINPINE, 0x4001, 0, 0,
-		pbn_oxsemi_1_15625000 },
-	{	PCI_VENDOR_ID_MAINPINE, 0x4000,	/* IQ Express 2 Port V.34 Super-G3 Fax */
-		PCI_VENDOR_ID_MAINPINE, 0x4002, 0, 0,
-		pbn_oxsemi_2_15625000 },
-	{	PCI_VENDOR_ID_MAINPINE, 0x4000,	/* IQ Express 4 Port V.34 Super-G3 Fax */
-		PCI_VENDOR_ID_MAINPINE, 0x4004, 0, 0,
-		pbn_oxsemi_4_15625000 },
-	{	PCI_VENDOR_ID_MAINPINE, 0x4000,	/* IQ Express 8 Port V.34 Super-G3 Fax */
-		PCI_VENDOR_ID_MAINPINE, 0x4008, 0, 0,
-		pbn_oxsemi_8_15625000 },
+	{
+		/* IQ Express 1 Port V.34 Super-G3 Fax */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, 0x4000,
+			       PCI_VENDOR_ID_MAINPINE, 0x4001),
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		/* IQ Express 2 Port V.34 Super-G3 Fax */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, 0x4000,
+			       PCI_VENDOR_ID_MAINPINE, 0x4002),
+		.driver_data = pbn_oxsemi_2_15625000,
+	}, {
+		/* IQ Express 4 Port V.34 Super-G3 Fax */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, 0x4000,
+			       PCI_VENDOR_ID_MAINPINE, 0x4004),
+		.driver_data = pbn_oxsemi_4_15625000,
+	}, {
+		/* IQ Express 8 Port V.34 Super-G3 Fax */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, 0x4000,
+			       PCI_VENDOR_ID_MAINPINE, 0x4008),
+		.driver_data = pbn_oxsemi_8_15625000,
+	},
 
 	/*
 	 * Digi/IBM PCIe 2-port Async EIA-232 Adapter utilizing OxSemi Tornado
 	 */
-	{	PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_2_OX_IBM,
-		PCI_SUBVENDOR_ID_IBM, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_2_15625000 },
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_2_OX_IBM,
+			       PCI_SUBVENDOR_ID_IBM, PCI_ANY_ID),
+		.driver_data = pbn_oxsemi_2_15625000,
+	},
+
 	/*
 	 * EndRun Technologies. PCI express device range.
 	 * EndRun PTP/1588 has 2 Native UARTs utilizing OxSemi 952.
 	 */
-	{	PCI_VENDOR_ID_ENDRUN, PCI_DEVICE_ID_ENDRUN_1588,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_2_15625000 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_ENDRUN, PCI_DEVICE_ID_ENDRUN_1588),
+		.driver_data = pbn_oxsemi_2_15625000,
+	},
 
 	/*
 	 * SBS Technologies, Inc. P-Octal and PMC-OCTPRO cards,
 	 * from skokodyn@yahoo.com
 	 */
-	{	PCI_VENDOR_ID_SBSMODULARIO, PCI_DEVICE_ID_OCTPRO,
-		PCI_SUBVENDOR_ID_SBSMODULARIO, PCI_SUBDEVICE_ID_OCTPRO232, 0, 0,
-		pbn_sbsxrsio },
-	{	PCI_VENDOR_ID_SBSMODULARIO, PCI_DEVICE_ID_OCTPRO,
-		PCI_SUBVENDOR_ID_SBSMODULARIO, PCI_SUBDEVICE_ID_OCTPRO422, 0, 0,
-		pbn_sbsxrsio },
-	{	PCI_VENDOR_ID_SBSMODULARIO, PCI_DEVICE_ID_OCTPRO,
-		PCI_SUBVENDOR_ID_SBSMODULARIO, PCI_SUBDEVICE_ID_POCTAL232, 0, 0,
-		pbn_sbsxrsio },
-	{	PCI_VENDOR_ID_SBSMODULARIO, PCI_DEVICE_ID_OCTPRO,
-		PCI_SUBVENDOR_ID_SBSMODULARIO, PCI_SUBDEVICE_ID_POCTAL422, 0, 0,
-		pbn_sbsxrsio },
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_SBSMODULARIO, PCI_DEVICE_ID_OCTPRO,
+			       PCI_SUBVENDOR_ID_SBSMODULARIO, PCI_SUBDEVICE_ID_OCTPRO232),
+		.driver_data = pbn_sbsxrsio,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_SBSMODULARIO, PCI_DEVICE_ID_OCTPRO,
+			       PCI_SUBVENDOR_ID_SBSMODULARIO, PCI_SUBDEVICE_ID_OCTPRO422),
+		.driver_data = pbn_sbsxrsio,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_SBSMODULARIO, PCI_DEVICE_ID_OCTPRO,
+			       PCI_SUBVENDOR_ID_SBSMODULARIO, PCI_SUBDEVICE_ID_POCTAL232),
+		.driver_data = pbn_sbsxrsio,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_SBSMODULARIO, PCI_DEVICE_ID_OCTPRO,
+			       PCI_SUBVENDOR_ID_SBSMODULARIO, PCI_SUBDEVICE_ID_POCTAL422),
+		.driver_data = pbn_sbsxrsio,
+	},
 
 	/*
 	 * Digitan DS560-558, from jimd@esoft.com
 	 */
-	{	PCI_VENDOR_ID_ATT, PCI_DEVICE_ID_ATT_VENUS_MODEM,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_1_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_ATT, PCI_DEVICE_ID_ATT_VENUS_MODEM),
+		.driver_data = pbn_b1_1_115200,
+	},
 
 	/*
 	 * Titan Electronic cards
 	 *  The 400L and 800L have a custom setup quirk.
 	 */
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_100,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_921600 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_2_921600 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_4_921600 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800B,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_4_921600 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_100L,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_1_921600 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200L,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_bt_2_921600 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400L,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_4_921600 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800L,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_8_921600 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200I,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b4_bt_2_921600 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400I,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b4_bt_4_921600 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800I,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b4_bt_8_921600 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400EH,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_4_921600 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800EH,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_4_921600 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800EHB,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_4_921600 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_100E,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_titan_1_4000000 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200E,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_titan_2_4000000 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400E,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_titan_4_4000000 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800E,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_titan_8_4000000 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200EI,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_titan_2_4000000 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200EISI,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_titan_2_4000000 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200V3,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_2_921600 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400V3,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_4_921600 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_410V3,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_4_921600 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800V3,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_4_921600 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800V3B,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_4_921600 },
-
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_10x_550,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_1_460800 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_10x_650,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_1_460800 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_10x_850,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_1_460800 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_10x_550,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_bt_2_921600 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_10x_650,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_bt_2_921600 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_10x_850,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_bt_2_921600 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_10x_550,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_bt_4_921600 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_10x_650,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_bt_4_921600 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_10x_850,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_bt_4_921600 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_20x_550,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_921600 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_20x_650,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_921600 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_20x_850,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_921600 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_20x_550,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_2_921600 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_20x_650,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_2_921600 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_20x_850,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_2_921600 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_20x_550,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_4_921600 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_20x_650,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_4_921600 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_20x_850,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_4_921600 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_8S_20x_550,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_8_921600 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_8S_20x_650,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_8_921600 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_8S_20x_850,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_8_921600 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_100),
+		.driver_data = pbn_b0_1_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200),
+		.driver_data = pbn_b0_2_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800B),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_100L),
+		.driver_data = pbn_b1_1_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200L),
+		.driver_data = pbn_b1_bt_2_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400L),
+		.driver_data = pbn_b0_bt_4_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800L),
+		.driver_data = pbn_b0_bt_8_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200I),
+		.driver_data = pbn_b4_bt_2_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400I),
+		.driver_data = pbn_b4_bt_4_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800I),
+		.driver_data = pbn_b4_bt_8_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400EH),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800EH),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800EHB),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_100E),
+		.driver_data = pbn_titan_1_4000000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200E),
+		.driver_data = pbn_titan_2_4000000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400E),
+		.driver_data = pbn_titan_4_4000000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800E),
+		.driver_data = pbn_titan_8_4000000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200EI),
+		.driver_data = pbn_titan_2_4000000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200EISI),
+		.driver_data = pbn_titan_2_4000000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200V3),
+		.driver_data = pbn_b0_bt_2_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400V3),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_410V3),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800V3),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800V3B),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_10x_550),
+		.driver_data = pbn_b2_1_460800,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_10x_650),
+		.driver_data = pbn_b2_1_460800,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_10x_850),
+		.driver_data = pbn_b2_1_460800,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_10x_550),
+		.driver_data = pbn_b2_bt_2_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_10x_650),
+		.driver_data = pbn_b2_bt_2_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_10x_850),
+		.driver_data = pbn_b2_bt_2_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_10x_550),
+		.driver_data = pbn_b2_bt_4_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_10x_650),
+		.driver_data = pbn_b2_bt_4_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_10x_850),
+		.driver_data = pbn_b2_bt_4_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_20x_550),
+		.driver_data = pbn_b0_1_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_20x_650),
+		.driver_data = pbn_b0_1_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_20x_850),
+		.driver_data = pbn_b0_1_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_20x_550),
+		.driver_data = pbn_b0_bt_2_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_20x_650),
+		.driver_data = pbn_b0_bt_2_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_20x_850),
+		.driver_data = pbn_b0_bt_2_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_20x_550),
+		.driver_data = pbn_b0_bt_4_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_20x_650),
+		.driver_data = pbn_b0_bt_4_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_20x_850),
+		.driver_data = pbn_b0_bt_4_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_8S_20x_550),
+		.driver_data = pbn_b0_bt_8_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_8S_20x_650),
+		.driver_data = pbn_b0_bt_8_921600,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_8S_20x_850),
+		.driver_data = pbn_b0_bt_8_921600,
+	},
 
 	/*
 	 * Computone devices submitted by Doug McNash dmcnash@computone.com
 	 */
-	{	PCI_VENDOR_ID_COMPUTONE, PCI_DEVICE_ID_COMPUTONE_PG,
-		PCI_SUBVENDOR_ID_COMPUTONE, PCI_SUBDEVICE_ID_COMPUTONE_PG4,
-		0, 0, pbn_computone_4 },
-	{	PCI_VENDOR_ID_COMPUTONE, PCI_DEVICE_ID_COMPUTONE_PG,
-		PCI_SUBVENDOR_ID_COMPUTONE, PCI_SUBDEVICE_ID_COMPUTONE_PG8,
-		0, 0, pbn_computone_8 },
-	{	PCI_VENDOR_ID_COMPUTONE, PCI_DEVICE_ID_COMPUTONE_PG,
-		PCI_SUBVENDOR_ID_COMPUTONE, PCI_SUBDEVICE_ID_COMPUTONE_PG6,
-		0, 0, pbn_computone_6 },
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_COMPUTONE, PCI_DEVICE_ID_COMPUTONE_PG,
+			       PCI_SUBVENDOR_ID_COMPUTONE, PCI_SUBDEVICE_ID_COMPUTONE_PG4),
+		.driver_data = pbn_computone_4,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_COMPUTONE, PCI_DEVICE_ID_COMPUTONE_PG,
+			       PCI_SUBVENDOR_ID_COMPUTONE, PCI_SUBDEVICE_ID_COMPUTONE_PG8),
+		.driver_data = pbn_computone_8,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_COMPUTONE, PCI_DEVICE_ID_COMPUTONE_PG,
+			       PCI_SUBVENDOR_ID_COMPUTONE, PCI_SUBDEVICE_ID_COMPUTONE_PG6),
+		.driver_data = pbn_computone_6,
+	},
 
-	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI95N,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi },
-	{	PCI_VENDOR_ID_TIMEDIA, PCI_DEVICE_ID_TIMEDIA_1889,
-		PCI_VENDOR_ID_TIMEDIA, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_1_921600 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI95N),
+		.driver_data = pbn_oxsemi,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_TIMEDIA, PCI_DEVICE_ID_TIMEDIA_1889,
+			       PCI_VENDOR_ID_TIMEDIA, PCI_ANY_ID),
+		.driver_data = pbn_b0_bt_1_921600,
+	},
 
 	/*
 	 * Sunix PCI serial boards
 	 */
-	{	PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
-		PCI_VENDOR_ID_SUNIX, 0x0001, 0, 0,
-		pbn_sunix_pci_1s },
-	{	PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
-		PCI_VENDOR_ID_SUNIX, 0x0002, 0, 0,
-		pbn_sunix_pci_2s },
-	{	PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
-		PCI_VENDOR_ID_SUNIX, 0x0004, 0, 0,
-		pbn_sunix_pci_4s },
-	{	PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
-		PCI_VENDOR_ID_SUNIX, 0x0084, 0, 0,
-		pbn_sunix_pci_4s },
-	{	PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
-		PCI_VENDOR_ID_SUNIX, 0x0008, 0, 0,
-		pbn_sunix_pci_8s },
-	{	PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
-		PCI_VENDOR_ID_SUNIX, 0x0088, 0, 0,
-		pbn_sunix_pci_8s },
-	{	PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
-		PCI_VENDOR_ID_SUNIX, 0x0010, 0, 0,
-		pbn_sunix_pci_16s },
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
+			       PCI_VENDOR_ID_SUNIX, 0x0001),
+		.driver_data = pbn_sunix_pci_1s,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
+			       PCI_VENDOR_ID_SUNIX, 0x0002),
+		.driver_data = pbn_sunix_pci_2s,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
+			       PCI_VENDOR_ID_SUNIX, 0x0004),
+		.driver_data = pbn_sunix_pci_4s,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
+			       PCI_VENDOR_ID_SUNIX, 0x0084),
+		.driver_data = pbn_sunix_pci_4s,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
+			       PCI_VENDOR_ID_SUNIX, 0x0008),
+		.driver_data = pbn_sunix_pci_8s,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
+			       PCI_VENDOR_ID_SUNIX, 0x0088),
+		.driver_data = pbn_sunix_pci_8s,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
+			       PCI_VENDOR_ID_SUNIX, 0x0010),
+		.driver_data = pbn_sunix_pci_16s,
+	},
 
 	/*
 	 * AFAVLAB serial card, from Harald Welte <laforge@gnumonks.org>
 	 */
-	{	PCI_VENDOR_ID_AFAVLAB, PCI_DEVICE_ID_AFAVLAB_P028,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_8_115200 },
-	{	PCI_VENDOR_ID_AFAVLAB, PCI_DEVICE_ID_AFAVLAB_P030,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_8_115200 },
-
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_DSERIAL,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_2_115200 },
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUATRO_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_2_115200 },
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUATRO_B,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_2_115200 },
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_OCTO_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_4_460800 },
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_OCTO_B,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_4_460800 },
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_PORT_PLUS,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_2_460800 },
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUAD_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_2_460800 },
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUAD_B,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_2_460800 },
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_SSERIAL,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_1_115200 },
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_PORT_650,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_1_460800 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_AFAVLAB, PCI_DEVICE_ID_AFAVLAB_P028),
+		.driver_data = pbn_b0_bt_8_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_AFAVLAB, PCI_DEVICE_ID_AFAVLAB_P030),
+		.driver_data = pbn_b0_bt_8_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_DSERIAL),
+		.driver_data = pbn_b0_bt_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUATRO_A),
+		.driver_data = pbn_b0_bt_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUATRO_B),
+		.driver_data = pbn_b0_bt_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_OCTO_A),
+		.driver_data = pbn_b0_bt_4_460800,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_OCTO_B),
+		.driver_data = pbn_b0_bt_4_460800,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_PORT_PLUS),
+		.driver_data = pbn_b0_bt_2_460800,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUAD_A),
+		.driver_data = pbn_b0_bt_2_460800,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUAD_B),
+		.driver_data = pbn_b0_bt_2_460800,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_SSERIAL),
+		.driver_data = pbn_b0_bt_1_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_PORT_650),
+		.driver_data = pbn_b0_bt_1_460800,
+	},
 
 	/*
 	 * Korenix Jetcard F0/F1 cards (JC1204, JC1208, JC1404, JC1408).
@@ -5116,560 +5156,532 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	 * Note that JC140x are RS422/485 cards which require ox950
 	 * ACR = 0x10, and as such are not currently fully supported.
 	 */
-	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
-		0x1204, 0x0004, 0, 0,
-		pbn_b0_4_921600 },
-	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
-		0x1208, 0x0004, 0, 0,
-		pbn_b0_4_921600 },
-/*	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
-		0x1402, 0x0002, 0, 0,
-		pbn_b0_2_921600 }, */
-/*	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
-		0x1404, 0x0004, 0, 0,
-		pbn_b0_4_921600 }, */
-	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF1,
-		0x1208, 0x0004, 0, 0,
-		pbn_b0_4_921600 },
-
-	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF2,
-		0x1204, 0x0004, 0, 0,
-		pbn_b0_4_921600 },
-	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF2,
-		0x1208, 0x0004, 0, 0,
-		pbn_b0_4_921600 },
-	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF3,
-		0x1208, 0x0004, 0, 0,
-		pbn_b0_4_921600 },
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
+			       0x1204, 0x0004),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
+			       0x1208, 0x0004),
+		.driver_data = pbn_b0_4_921600,
+	},
+/*	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
+			       0x1402, 0x0002),
+		.driver_data = pbn_b0_2_921600,
+	}, */
+/*	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
+			       0x1404, 0x0004),
+		.driver_data = pbn_b0_4_921600,
+	}, */
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF1,
+			       0x1208, 0x0004),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF2,
+			       0x1204, 0x0004),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF2,
+			       0x1208, 0x0004),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF3,
+			       0x1208, 0x0004),
+		.driver_data = pbn_b0_4_921600,
+	},
 	/*
 	 * Dell Remote Access Card 4 - Tim_T_Murphy@Dell.com
 	 */
-	{	PCI_VENDOR_ID_DELL, PCI_DEVICE_ID_DELL_RAC4,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_1_1382400 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_DELL, PCI_DEVICE_ID_DELL_RAC4),
+		.driver_data = pbn_b1_1_1382400,
+	},
 
 	/*
 	 * Dell Remote Access Card III - Tim_T_Murphy@Dell.com
 	 */
-	{	PCI_VENDOR_ID_DELL, PCI_DEVICE_ID_DELL_RACIII,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_1_1382400 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_DELL, PCI_DEVICE_ID_DELL_RACIII),
+		.driver_data = pbn_b1_1_1382400,
+	},
 
 	/*
 	 * RAStel 2 port modem, gerg@moreton.com.au
 	 */
-	{	PCI_VENDOR_ID_MORETON, PCI_DEVICE_ID_RASTEL_2PORT,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_bt_2_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_MORETON, PCI_DEVICE_ID_RASTEL_2PORT),
+		.driver_data = pbn_b2_bt_2_115200,
+	},
 
 	/*
 	 * EKF addition for i960 Boards form EKF with serial port
 	 */
-	{	PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_80960_RP,
-		0xE4BF, PCI_ANY_ID, 0, 0,
-		pbn_intel_i960 },
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_80960_RP,
+			       0xE4BF, PCI_ANY_ID),
+		.driver_data = pbn_intel_i960,
+	},
 
 	/*
 	 * Xircom Cardbus/Ethernet combos
 	 */
-	{	PCI_VENDOR_ID_XIRCOM, PCI_DEVICE_ID_XIRCOM_X3201_MDM,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_XIRCOM, PCI_DEVICE_ID_XIRCOM_X3201_MDM),
+		.driver_data = pbn_b0_1_115200,
+	},
 	/*
 	 * Xircom RBM56G cardbus modem - Dirk Arnold (temp entry)
 	 */
-	{	PCI_VENDOR_ID_XIRCOM, PCI_DEVICE_ID_XIRCOM_RBM56G,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_XIRCOM, PCI_DEVICE_ID_XIRCOM_RBM56G),
+		.driver_data = pbn_b0_1_115200,
+	},
 
 	/*
 	 * Untested PCI modems, sent in from various folks...
 	 */
 
-	/*
-	 * Elsa Model 56K PCI Modem, from Andreas Rath <arh@01019freenet.de>
-	 */
-	{	PCI_VENDOR_ID_ROCKWELL, 0x1004,
-		0x1048, 0x1500, 0, 0,
-		pbn_b1_1_115200 },
-
-	{	PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3,
-		0xFF00, 0, 0, 0,
-		pbn_sgi_ioc3 },
+	{
+		/* Elsa Model 56K PCI Modem, from Andreas Rath <arh@01019freenet.de> */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ROCKWELL, 0x1004, 0x1048, 0x1500),
+		.driver_data = pbn_b1_1_115200,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3, 0xFF00, 0),
+		.driver_data = pbn_sgi_ioc3,
+	},
 
 	/*
 	 * HP Diva card
 	 */
-	{	PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_DIVA,
-		PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_DIVA_RMP3, 0, 0,
-		pbn_b1_1_115200 },
-	{	PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_DIVA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_5_115200 },
-	{	PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_DIVA_AUX,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_1_115200 },
-	/* HPE PCI serial device */
-	{	PCI_VENDOR_ID_HP_3PAR, PCI_DEVICE_ID_HPE_PCI_SERIAL,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_1_115200 },
-
-	{	PCI_VENDOR_ID_DCI, PCI_DEVICE_ID_DCI_PCCOM2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b3_2_115200 },
-	{	PCI_VENDOR_ID_DCI, PCI_DEVICE_ID_DCI_PCCOM4,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b3_4_115200 },
-	{	PCI_VENDOR_ID_DCI, PCI_DEVICE_ID_DCI_PCCOM8,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b3_8_115200 },
-	/*
-	 * Topic TP560 Data/Fax/Voice 56k modem (reported by Evan Clarke)
-	 */
-	{	PCI_VENDOR_ID_TOPIC, PCI_DEVICE_ID_TOPIC_TP560,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_115200 },
-	/*
-	 * ITE
-	 */
-	{	PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_8872,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b1_bt_1_115200 },
-
-	/*
-	 * IntaShield IS-100
-	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0D60,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_1_115200 },
-	/*
-	 * IntaShield IS-200
-	 */
-	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS200,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,	/* 135a.0d80 */
-		pbn_b2_2_115200 },
-	/*
-	 * IntaShield IS-400
-	 */
-	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS400,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,    /* 135a.0dc0 */
-		pbn_b2_4_115200 },
-	/*
-	 * IntaShield IX-100
-	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4027,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_oxsemi_1_15625000 },
-	/*
-	 * IntaShield IX-200
-	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4028,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_oxsemi_2_15625000 },
-	/*
-	 * IntaShield IX-400
-	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4029,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_oxsemi_4_15625000 },
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_DIVA,
+			       PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_DIVA_RMP3),
+		.driver_data = pbn_b1_1_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_DIVA),
+		.driver_data = pbn_b0_5_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_DIVA_AUX),
+		.driver_data = pbn_b2_1_115200,
+	}, {
+		/* HPE PCI serial device */
+		PCI_DEVICE(PCI_VENDOR_ID_HP_3PAR, PCI_DEVICE_ID_HPE_PCI_SERIAL),
+		.driver_data = pbn_b1_1_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_DCI, PCI_DEVICE_ID_DCI_PCCOM2),
+		.driver_data = pbn_b3_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_DCI, PCI_DEVICE_ID_DCI_PCCOM4),
+		.driver_data = pbn_b3_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_DCI, PCI_DEVICE_ID_DCI_PCCOM8),
+		.driver_data = pbn_b3_8_115200,
+	}, {
+		/* Topic TP560 Data/Fax/Voice 56k modem (reported by Evan Clarke) */
+		PCI_DEVICE(PCI_VENDOR_ID_TOPIC, PCI_DEVICE_ID_TOPIC_TP560),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		/* ITE */
+		PCI_DEVICE(PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_8872),
+		.driver_data = pbn_b1_bt_1_115200,
+	}, {
+		/* IntaShield IS-100 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0D60),
+		.driver_data = pbn_b2_1_115200,
+	}, {
+		/* IntaShield IS-200; 135a.0d80 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS200),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		/* IntaShield IS-400; 135a.0dc0 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS400),
+		.driver_data = pbn_b2_4_115200,
+	}, {
+		/* IntaShield IX-100 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x4027),
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		/* IntaShield IX-200 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x4028),
+		.driver_data = pbn_oxsemi_2_15625000,
+	}, {
+		/* IntaShield IX-400 */
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x4029),
+		.driver_data = pbn_oxsemi_4_15625000,
+	},
 	/* Brainboxes Devices */
 	/*
 	* Brainboxes UC-101
 	*/
-	{       PCI_VENDOR_ID_INTASHIELD, 0x0BA1,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
-	{       PCI_VENDOR_ID_INTASHIELD, 0x0BA2,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
-	{       PCI_VENDOR_ID_INTASHIELD, 0x0BA3,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0BA1),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0BA2),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0BA3),
+		.driver_data = pbn_b2_2_115200,
+	},
 	/*
 	 * Brainboxes UC-235/246
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0AA1,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_1_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0AA2,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_1_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0AA1),
+		.driver_data = pbn_b2_1_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0AA2),
+		.driver_data = pbn_b2_1_115200,
+	},
 	/*
 	 * Brainboxes UC-253/UC-734
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0CA1,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0CA1),
+		.driver_data = pbn_b2_2_115200,
+	},
 	/*
 	 * Brainboxes UC-260/271/701/756
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0D21,
-		PCI_ANY_ID, PCI_ANY_ID,
-		PCI_CLASS_COMMUNICATION_MULTISERIAL << 8, 0xffff00,
-		pbn_b2_4_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0E34,
-		PCI_ANY_ID, PCI_ANY_ID,
-		PCI_CLASS_COMMUNICATION_MULTISERIAL << 8, 0xffff00,
-		pbn_b2_4_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0D21),
+		.class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
+		.class_mask = 0xffff00,
+		.driver_data = pbn_b2_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0E34),
+		.class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
+		.class_mask = 0xffff00,
+		.driver_data = pbn_b2_4_115200,
+	},
 	/*
 	 * Brainboxes UC-268
 	 */
-	{       PCI_VENDOR_ID_INTASHIELD, 0x0841,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_4_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0841),
+		.driver_data = pbn_b2_4_115200,
+	},
 	/*
 	 * Brainboxes UC-275/279
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0881,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_8_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0881),
+		.driver_data = pbn_b2_8_115200,
+	},
 	/*
 	 * Brainboxes UC-302
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x08E1,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x08E2,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x08E3,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x08E1),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x08E2),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x08E3),
+		.driver_data = pbn_b2_2_115200,
+	},
 	/*
 	 * Brainboxes UC-310
 	 */
-	{       PCI_VENDOR_ID_INTASHIELD, 0x08C1,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x08C1),
+		.driver_data = pbn_b2_2_115200,
+	},
 	/*
 	 * Brainboxes UC-313
 	 */
-	{       PCI_VENDOR_ID_INTASHIELD, 0x08A1,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
-	{       PCI_VENDOR_ID_INTASHIELD, 0x08A2,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
-	{       PCI_VENDOR_ID_INTASHIELD, 0x08A3,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x08A1),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x08A2),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x08A3),
+		.driver_data = pbn_b2_2_115200,
+	},
 	/*
 	 * Brainboxes UC-320/324
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0A61,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_1_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0A61),
+		.driver_data = pbn_b2_1_115200,
+	},
 	/*
 	 * Brainboxes UC-346
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0B01,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_4_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0B02,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_4_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0B01),
+		.driver_data = pbn_b2_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0B02),
+		.driver_data = pbn_b2_4_115200,
+	},
 	/*
 	 * Brainboxes UC-357
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0A81,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0A82,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0A83,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0A81),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0A82),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0A83),
+		.driver_data = pbn_b2_2_115200,
+	},
 	/*
 	 * Brainboxes UC-368
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0C41,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_4_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0C42,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_4_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0C43,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_4_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0C41),
+		.driver_data = pbn_b2_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0C42),
+		.driver_data = pbn_b2_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0C43),
+		.driver_data = pbn_b2_4_115200,
+	},
 	/*
 	 * Brainboxes UC-420
 	 */
-	{       PCI_VENDOR_ID_INTASHIELD, 0x0921,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_4_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0921),
+		.driver_data = pbn_b2_4_115200,
+	},
 	/*
 	 * Brainboxes UC-607
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x09A1,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x09A2,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x09A3,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x09A1),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x09A2),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x09A3),
+		.driver_data = pbn_b2_2_115200,
+	},
 	/*
 	 * Brainboxes UC-836
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0D41,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_4_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0D41),
+		.driver_data = pbn_b2_4_115200,
+	},
 	/*
 	 * Brainboxes UP-189
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0AC1,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0AC2,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0AC3,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0AC1),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0AC2),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0AC3),
+		.driver_data = pbn_b2_2_115200,
+	},
 	/*
 	 * Brainboxes UP-200
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0B21,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0B22,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0B23,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0B21),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0B22),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0B23),
+		.driver_data = pbn_b2_2_115200,
+	},
 	/*
 	 * Brainboxes UP-869
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0C01,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0C02,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0C03,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0C01),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0C02),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0C03),
+		.driver_data = pbn_b2_2_115200,
+	},
 	/*
 	 * Brainboxes UP-880
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0C21,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0C22,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0C23,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0C21),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0C22),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0C23),
+		.driver_data = pbn_b2_2_115200,
+	},
 	/*
 	 * Brainboxes PX-101
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4005,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b0_2_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4019,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_oxsemi_2_15625000 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x4005),
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x4019),
+		.driver_data = pbn_oxsemi_2_15625000,
+	},
 	/*
 	 * Brainboxes PX-235/246
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4004,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b0_1_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4016,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_oxsemi_1_15625000 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x4004),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x4016),
+		.driver_data = pbn_oxsemi_1_15625000,
+	},
 	/*
 	 * Brainboxes PX-203/PX-257
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4006,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b0_2_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4015,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_oxsemi_2_15625000 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x4006),
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x4015),
+		.driver_data = pbn_oxsemi_2_15625000,
+	},
 	/*
 	 * Brainboxes PX-260/PX-701
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x400A,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_oxsemi_4_15625000 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x400A),
+		.driver_data = pbn_oxsemi_4_15625000,
+	},
 	/*
 	 * Brainboxes PX-275/279
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0E41,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_8_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0E41),
+		.driver_data = pbn_b2_8_115200,
+	},
 	/*
 	 * Brainboxes PX-310
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x400E,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_oxsemi_2_15625000 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x400E),
+		.driver_data = pbn_oxsemi_2_15625000,
+	},
 	/*
 	 * Brainboxes PX-313
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x400C,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_oxsemi_2_15625000 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x400C),
+		.driver_data = pbn_oxsemi_2_15625000,
+	},
 	/*
 	 * Brainboxes PX-320/324/PX-376/PX-387
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x400B,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_oxsemi_1_15625000 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x400B),
+		.driver_data = pbn_oxsemi_1_15625000,
+	},
 	/*
 	 * Brainboxes PX-335/346
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x400F,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_oxsemi_4_15625000 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x400F),
+		.driver_data = pbn_oxsemi_4_15625000,
+	},
 	/*
 	 * Brainboxes PX-368
 	 */
-	{       PCI_VENDOR_ID_INTASHIELD, 0x4010,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_oxsemi_4_15625000 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x4010),
+		.driver_data = pbn_oxsemi_4_15625000,
+	},
 	/*
 	 * Brainboxes PX-420
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4000,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b0_4_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4011,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_oxsemi_4_15625000 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x4000),
+		.driver_data = pbn_b0_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x4011),
+		.driver_data = pbn_oxsemi_4_15625000,
+	},
 	/*
 	 * Brainboxes PX-475
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x401D,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_oxsemi_1_15625000 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x401D),
+		.driver_data = pbn_oxsemi_1_15625000,
+	},
 	/*
 	 * Brainboxes PX-803/PX-857
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4009,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b0_2_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4018,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_oxsemi_2_15625000 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x401E,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_oxsemi_2_15625000 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x4009),
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x4018),
+		.driver_data = pbn_oxsemi_2_15625000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x401E),
+		.driver_data = pbn_oxsemi_2_15625000,
+	},
 	/*
 	 * Brainboxes PX-820
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4002,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b0_4_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4013,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_oxsemi_4_15625000 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x4002),
+		.driver_data = pbn_b0_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x4013),
+		.driver_data = pbn_oxsemi_4_15625000,
+	},
 	/*
 	 * Brainboxes PX-835/PX-846
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4008,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b0_1_115200 },
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4017,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_oxsemi_1_15625000 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x4008),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x4017),
+		.driver_data = pbn_oxsemi_1_15625000,
+	},
 	/*
 	 * Brainboxes XC-235
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4026,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_oxsemi_1_15625000 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x4026),
+		.driver_data = pbn_oxsemi_1_15625000,
+	},
 	/*
 	 * Brainboxes XC-475
 	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x4021,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_oxsemi_1_15625000 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x4021),
+		.driver_data = pbn_oxsemi_1_15625000,
+	},
 
 	/*
 	 * Perle PCI-RAS cards
 	 */
-	{       PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
+	{
+		PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
 		PCI_SUBVENDOR_ID_PERLE, PCI_SUBDEVICE_ID_PCI_RAS4,
-		0, 0, pbn_b2_4_921600 },
-	{       PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
+		.driver_data = pbn_b2_4_921600,
+	}, {
+		PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
 		PCI_SUBVENDOR_ID_PERLE, PCI_SUBDEVICE_ID_PCI_RAS8,
-		0, 0, pbn_b2_8_921600 },
+		.driver_data = pbn_b2_8_921600,
+	},
 
 	/*
 	 * Mainpine series cards: Fairly standard layout but fools
@@ -5677,375 +5689,439 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	 * unmatched communications subclasses in the PCI Express case
 	 */
 
-	{	/* RockForceDUO */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x0200,
-		0, 0, pbn_b0_2_115200 },
-	{	/* RockForceQUATRO */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x0300,
-		0, 0, pbn_b0_4_115200 },
-	{	/* RockForceDUO+ */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x0400,
-		0, 0, pbn_b0_2_115200 },
-	{	/* RockForceQUATRO+ */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x0500,
-		0, 0, pbn_b0_4_115200 },
-	{	/* RockForce+ */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x0600,
-		0, 0, pbn_b0_2_115200 },
-	{	/* RockForce+ */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x0700,
-		0, 0, pbn_b0_4_115200 },
-	{	/* RockForceOCTO+ */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x0800,
-		0, 0, pbn_b0_8_115200 },
-	{	/* RockForceDUO+ */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x0C00,
-		0, 0, pbn_b0_2_115200 },
-	{	/* RockForceQUARTRO+ */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x0D00,
-		0, 0, pbn_b0_4_115200 },
-	{	/* RockForceOCTO+ */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x1D00,
-		0, 0, pbn_b0_8_115200 },
-	{	/* RockForceD1 */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x2000,
-		0, 0, pbn_b0_1_115200 },
-	{	/* RockForceF1 */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x2100,
-		0, 0, pbn_b0_1_115200 },
-	{	/* RockForceD2 */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x2200,
-		0, 0, pbn_b0_2_115200 },
-	{	/* RockForceF2 */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x2300,
-		0, 0, pbn_b0_2_115200 },
-	{	/* RockForceD4 */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x2400,
-		0, 0, pbn_b0_4_115200 },
-	{	/* RockForceF4 */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x2500,
-		0, 0, pbn_b0_4_115200 },
-	{	/* RockForceD8 */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x2600,
-		0, 0, pbn_b0_8_115200 },
-	{	/* RockForceF8 */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x2700,
-		0, 0, pbn_b0_8_115200 },
-	{	/* IQ Express D1 */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x3000,
-		0, 0, pbn_b0_1_115200 },
-	{	/* IQ Express F1 */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x3100,
-		0, 0, pbn_b0_1_115200 },
-	{	/* IQ Express D2 */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x3200,
-		0, 0, pbn_b0_2_115200 },
-	{	/* IQ Express F2 */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x3300,
-		0, 0, pbn_b0_2_115200 },
-	{	/* IQ Express D4 */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x3400,
-		0, 0, pbn_b0_4_115200 },
-	{	/* IQ Express F4 */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x3500,
-		0, 0, pbn_b0_4_115200 },
-	{	/* IQ Express D8 */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x3C00,
-		0, 0, pbn_b0_8_115200 },
-	{	/* IQ Express F8 */
-		PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
-		PCI_VENDOR_ID_MAINPINE, 0x3D00,
-		0, 0, pbn_b0_8_115200 },
+	{
+		/* RockForceDUO */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x0200),
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		/* RockForceQUATRO */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x0300),
+		.driver_data = pbn_b0_4_115200,
+	}, {
+		/* RockForceDUO+ */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x0400),
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		/* RockForceQUATRO+ */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x0500),
+			.driver_data = pbn_b0_4_115200,
+	}, {
+		/* RockForce+ */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x0600),
+			.driver_data = pbn_b0_2_115200,
+	}, {
+		/* RockForce+ */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x0700),
+			.driver_data = pbn_b0_4_115200,
+	}, {
+		/* RockForceOCTO+ */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x0800),
+			.driver_data = pbn_b0_8_115200,
+	}, {
+		/* RockForceDUO+ */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x0C00),
+			.driver_data = pbn_b0_2_115200,
+	}, {
+		/* RockForceQUARTRO+ */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x0D00),
+			.driver_data = pbn_b0_4_115200,
+	}, {
+		/* RockForceOCTO+ */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x1D00),
+			.driver_data = pbn_b0_8_115200,
+	}, {
+		/* RockForceD1 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x2000),
+			.driver_data = pbn_b0_1_115200,
+	}, {
+		/* RockForceF1 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x2100),
+			.driver_data = pbn_b0_1_115200,
+	}, {	/* RockForceD2 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x2200),
+			.driver_data = pbn_b0_2_115200,
+	}, {	/* RockForceF2 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x2300),
+			.driver_data = pbn_b0_2_115200,
+	}, {
+		/* RockForceD4 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x2400),
+			.driver_data = pbn_b0_4_115200,
+	}, {
+		/* RockForceF4 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x2500),
+			.driver_data = pbn_b0_4_115200,
+	}, {
+		/* RockForceD8 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x2600),
+			.driver_data = pbn_b0_8_115200,
+	}, {
+		/* RockForceF8 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x2700),
+			.driver_data = pbn_b0_8_115200,
+	}, {
+		/* IQ Express D1 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x3000),
+			.driver_data = pbn_b0_1_115200,
+	}, {
+		/* IQ Express F1 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x3100),
+			.driver_data = pbn_b0_1_115200,
+	}, {
+		/* IQ Express D2 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x3200),
+			.driver_data = pbn_b0_2_115200,
+	}, {
+		/* IQ Express F2 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x3300),
+			.driver_data = pbn_b0_2_115200,
+	}, {
+		/* IQ Express D4 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x3400),
+			.driver_data = pbn_b0_4_115200,
+	}, {
+		/* IQ Express F4 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x3500),
+			.driver_data = pbn_b0_4_115200,
+	}, {
+		/* IQ Express D8 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x3C00),
+			.driver_data = pbn_b0_8_115200,
+	}, {
+		/* IQ Express F8 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+			       PCI_VENDOR_ID_MAINPINE, 0x3D00),
+			.driver_data = pbn_b0_8_115200,
+	},
 
-
-	/*
-	 * PA Semi PA6T-1682M on-chip UART
-	 */
-	{	PCI_VENDOR_ID_PASEMI, 0xa004,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_pasemi_1682M },
+	{
+		/* PA Semi PA6T-1682M on-chip UART */
+		PCI_DEVICE(PCI_VENDOR_ID_PASEMI, 0xa004),
+		.driver_data = pbn_pasemi_1682M,
+	},
 
 	/*
 	 * National Instruments
 	 */
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI23216,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_16_115200 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI2328,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_8_115200 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI2324,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_bt_4_115200 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI2322,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_bt_2_115200 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI2324I,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_bt_4_115200 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI2322I,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_bt_2_115200 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8420_23216,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_16_115200 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8420_2328,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_8_115200 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8420_2324,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_bt_4_115200 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8420_2322,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_bt_2_115200 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8422_2324,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_bt_4_115200 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8422_2322,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_bt_2_115200 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8430_2322,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_ni8430_2 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI8430_2322,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_ni8430_2 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8430_2324,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_ni8430_4 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI8430_2324,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_ni8430_4 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8430_2328,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_ni8430_8 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI8430_2328,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_ni8430_8 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8430_23216,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_ni8430_16 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI8430_23216,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_ni8430_16 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8432_2322,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_ni8430_2 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI8432_2322,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_ni8430_2 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8432_2324,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_ni8430_4 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI8432_2324,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_ni8430_4 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI23216),
+		.driver_data = pbn_b1_16_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI2328),
+		.driver_data = pbn_b1_8_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI2324),
+		.driver_data = pbn_b1_bt_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI2322),
+		.driver_data = pbn_b1_bt_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI2324I),
+		.driver_data = pbn_b1_bt_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI2322I),
+		.driver_data = pbn_b1_bt_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8420_23216),
+		.driver_data = pbn_b1_16_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8420_2328),
+		.driver_data = pbn_b1_8_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8420_2324),
+		.driver_data = pbn_b1_bt_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8420_2322),
+		.driver_data = pbn_b1_bt_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8422_2324),
+		.driver_data = pbn_b1_bt_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8422_2322),
+		.driver_data = pbn_b1_bt_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8430_2322),
+		.driver_data = pbn_ni8430_2,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI8430_2322),
+		.driver_data = pbn_ni8430_2,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8430_2324),
+		.driver_data = pbn_ni8430_4,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI8430_2324),
+		.driver_data = pbn_ni8430_4,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8430_2328),
+		.driver_data = pbn_ni8430_8,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI8430_2328),
+		.driver_data = pbn_ni8430_8,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8430_23216),
+		.driver_data = pbn_ni8430_16,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI8430_23216),
+		.driver_data = pbn_ni8430_16,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8432_2322),
+		.driver_data = pbn_ni8430_2,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI8432_2322),
+		.driver_data = pbn_ni8430_2,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8432_2324),
+		.driver_data = pbn_ni8430_4,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI8432_2324),
+		.driver_data = pbn_ni8430_4,
+	},
 
 	/*
 	 * MOXA
 	 */
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102E),	    pbn_moxa_2 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102EL),    pbn_moxa_2 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102N),	    pbn_moxa_2 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104EL_A),  pbn_moxa_4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104N),	    pbn_moxa_4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP112N),	    pbn_moxa_2 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114EL),    pbn_moxa_4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114N),	    pbn_moxa_4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_A), pbn_moxa_8 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_B), pbn_moxa_8 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118EL_A),  pbn_moxa_8 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118E_A_I), pbn_moxa_8 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132EL),    pbn_moxa_2 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132N),     pbn_moxa_2 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134EL_A),  pbn_moxa_4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134N),	    pbn_moxa_4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP138E_A),   pbn_moxa_8 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A),  pbn_moxa_8 },
+	{
+		PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102E),
+		.driver_data = pbn_moxa_2,
+	}, {
+		PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102EL),
+		.driver_data = pbn_moxa_2,
+	}, {
+		PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102N),
+		.driver_data = pbn_moxa_2,
+	}, {
+		PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104EL_A),
+		.driver_data = pbn_moxa_4,
+	}, {
+		PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104N),
+		.driver_data = pbn_moxa_4,
+	}, {
+		PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP112N),
+		.driver_data = pbn_moxa_2,
+	}, {
+		PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114EL),
+		.driver_data = pbn_moxa_4,
+	}, {
+		PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114N),
+		.driver_data = pbn_moxa_4,
+	}, {
+		PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_A),
+		.driver_data = pbn_moxa_8,
+	}, {
+		PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_B),
+		.driver_data = pbn_moxa_8,
+	}, {
+		PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118EL_A),
+		.driver_data = pbn_moxa_8,
+	}, {
+		PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118E_A_I),
+		.driver_data = pbn_moxa_8,
+	}, {
+		PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132EL),
+		.driver_data = pbn_moxa_2,
+	}, {
+		PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132N),
+		.driver_data = pbn_moxa_2,
+	}, {
+		PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134EL_A),
+		.driver_data = pbn_moxa_4,
+	}, {
+		PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134N),
+		.driver_data = pbn_moxa_4,
+	}, {
+		PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP138E_A),
+		.driver_data = pbn_moxa_8,
+	}, {
+		PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A),
+		.driver_data = pbn_moxa_8,
+	},
 
 	/*
 	* ADDI-DATA GmbH communication cards <info@addi-data.com>
 	*/
-	{	PCI_VENDOR_ID_ADDIDATA,
+	{
+		PCI_VENDOR_ID_ADDIDATA,
 		PCI_DEVICE_ID_ADDIDATA_APCI7500,
 		PCI_ANY_ID,
 		PCI_ANY_ID,
 		0,
 		0,
-		pbn_b0_4_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
+		.driver_data = pbn_b0_4_115200,
+	}, {
+		PCI_VENDOR_ID_ADDIDATA,
 		PCI_DEVICE_ID_ADDIDATA_APCI7420,
 		PCI_ANY_ID,
 		PCI_ANY_ID,
 		0,
 		0,
-		pbn_b0_2_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		PCI_VENDOR_ID_ADDIDATA,
 		PCI_DEVICE_ID_ADDIDATA_APCI7300,
 		PCI_ANY_ID,
 		PCI_ANY_ID,
 		0,
 		0,
-		pbn_b0_1_115200 },
-
-	{	PCI_VENDOR_ID_AMCC,
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_VENDOR_ID_AMCC,
 		PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800,
 		PCI_ANY_ID,
 		PCI_ANY_ID,
 		0,
 		0,
-		pbn_b1_8_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
+		.driver_data = pbn_b1_8_115200,
+	}, {
+		PCI_VENDOR_ID_ADDIDATA,
 		PCI_DEVICE_ID_ADDIDATA_APCI7500_2,
 		PCI_ANY_ID,
 		PCI_ANY_ID,
 		0,
 		0,
-		pbn_b0_4_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
+		.driver_data = pbn_b0_4_115200,
+	}, {
+		PCI_VENDOR_ID_ADDIDATA,
 		PCI_DEVICE_ID_ADDIDATA_APCI7420_2,
 		PCI_ANY_ID,
 		PCI_ANY_ID,
 		0,
 		0,
-		pbn_b0_2_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		PCI_VENDOR_ID_ADDIDATA,
 		PCI_DEVICE_ID_ADDIDATA_APCI7300_2,
 		PCI_ANY_ID,
 		PCI_ANY_ID,
 		0,
 		0,
-		pbn_b0_1_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_VENDOR_ID_ADDIDATA,
 		PCI_DEVICE_ID_ADDIDATA_APCI7500_3,
 		PCI_ANY_ID,
 		PCI_ANY_ID,
 		0,
 		0,
-		pbn_b0_4_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
+		.driver_data = pbn_b0_4_115200,
+	}, {
+		PCI_VENDOR_ID_ADDIDATA,
 		PCI_DEVICE_ID_ADDIDATA_APCI7420_3,
 		PCI_ANY_ID,
 		PCI_ANY_ID,
 		0,
 		0,
-		pbn_b0_2_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		PCI_VENDOR_ID_ADDIDATA,
 		PCI_DEVICE_ID_ADDIDATA_APCI7300_3,
 		PCI_ANY_ID,
 		PCI_ANY_ID,
 		0,
 		0,
-		pbn_b0_1_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_VENDOR_ID_ADDIDATA,
 		PCI_DEVICE_ID_ADDIDATA_APCI7800_3,
 		PCI_ANY_ID,
 		PCI_ANY_ID,
 		0,
 		0,
-		pbn_b0_8_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
+		.driver_data = pbn_b0_8_115200,
+	}, {
+		PCI_VENDOR_ID_ADDIDATA,
 		PCI_DEVICE_ID_ADDIDATA_APCIe7500,
 		PCI_ANY_ID,
 		PCI_ANY_ID,
 		0,
 		0,
-		pbn_ADDIDATA_PCIe_4_3906250 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
+		.driver_data = pbn_ADDIDATA_PCIe_4_3906250,
+	}, {
+		PCI_VENDOR_ID_ADDIDATA,
 		PCI_DEVICE_ID_ADDIDATA_APCIe7420,
 		PCI_ANY_ID,
 		PCI_ANY_ID,
 		0,
 		0,
-		pbn_ADDIDATA_PCIe_2_3906250 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
+		.driver_data = pbn_ADDIDATA_PCIe_2_3906250,
+	}, {
+		PCI_VENDOR_ID_ADDIDATA,
 		PCI_DEVICE_ID_ADDIDATA_APCIe7300,
 		PCI_ANY_ID,
 		PCI_ANY_ID,
 		0,
 		0,
-		pbn_ADDIDATA_PCIe_1_3906250 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
+		.driver_data = pbn_ADDIDATA_PCIe_1_3906250,
+	}, {
+		PCI_VENDOR_ID_ADDIDATA,
 		PCI_DEVICE_ID_ADDIDATA_APCIe7800,
 		PCI_ANY_ID,
 		PCI_ANY_ID,
 		0,
 		0,
-		pbn_ADDIDATA_PCIe_8_3906250 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
+		.driver_data = pbn_ADDIDATA_PCIe_8_3906250,
+	}, {
+		PCI_VENDOR_ID_ADDIDATA,
 		PCI_DEVICE_ID_ADDIDATA_CPCI7500,
 		PCI_ANY_ID,
 		PCI_ANY_ID,
 		0,
 		0,
-		pbn_b0_4_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
+		.driver_data = pbn_b0_4_115200,
+	}, {
+		PCI_VENDOR_ID_ADDIDATA,
 		PCI_DEVICE_ID_ADDIDATA_CPCI7500_NG,
 		PCI_ANY_ID,
 		PCI_ANY_ID,
 		0,
 		0,
-		pbn_b0_4_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
+		.driver_data = pbn_b0_4_115200,
+	}, {
+		PCI_VENDOR_ID_ADDIDATA,
 		PCI_DEVICE_ID_ADDIDATA_CPCI7420_NG,
 		PCI_ANY_ID,
 		PCI_ANY_ID,
 		0,
 		0,
-		pbn_b0_2_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		PCI_VENDOR_ID_ADDIDATA,
 		PCI_DEVICE_ID_ADDIDATA_CPCI7300_NG,
 		PCI_ANY_ID,
 		PCI_ANY_ID,
 		0,
 		0,
-		pbn_b0_1_115200 },
-
-	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
 		PCI_VENDOR_ID_IBM, 0x0299,
-		0, 0, pbn_b0_bt_2_115200 },
+		0, 0,
+		.driver_data = pbn_b0_bt_2_115200,
+	},
 
 	/*
 	 * other NetMos 9835 devices are most likely handled by the
@@ -6053,153 +6129,185 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	 * before adding them here.
 	 */
 
-	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9901,
-		0xA000, 0x1000,
-		0, 0, pbn_b0_1_115200 },
-
-	/* the 9901 is a rebranded 9912 */
-	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9912,
-		0xA000, 0x1000,
-		0, 0, pbn_b0_1_115200 },
-
-	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9922,
-		0xA000, 0x1000,
-		0, 0, pbn_b0_1_115200 },
-
-	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9904,
-		0xA000, 0x1000,
-		0, 0, pbn_b0_1_115200 },
-
-	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
-		0xA000, 0x1000,
-		0, 0, pbn_b0_1_115200 },
-
-	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
-		0xA000, 0x3002,
-		0, 0, pbn_NETMOS9900_2s_115200 },
-
-	{	PCIE_VENDOR_ID_ASIX, PCIE_DEVICE_ID_AX99100,
-		0xA000, 0x1000,
-		0, 0, pbn_b0_1_115200 },
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9901,
+			       0xA000, 0x1000),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		/* the 9901 is a rebranded 9912 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9912,
+			       0xA000, 0x1000),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9922,
+			       0xA000, 0x1000),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9904,
+			       0xA000, 0x1000),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
+			       0xA000, 0x1000),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
+			       0xA000, 0x3002),
+		.driver_data = pbn_NETMOS9900_2s_115200,
+	}, {
+		PCI_DEVICE_SUB(PCIE_VENDOR_ID_ASIX, PCIE_DEVICE_ID_AX99100,
+			       0xA000, 0x1000),
+		.driver_data = pbn_b0_1_115200,
+	},
 
 	/*
 	 * Best Connectivity and Rosewill PCI Multi I/O cards
 	 */
 
-	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
-		0xA000, 0x1000,
-		0, 0, pbn_b0_1_115200 },
-
-	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
-		0xA000, 0x3002,
-		0, 0, pbn_b0_bt_2_115200 },
-
-	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
-		0xA000, 0x3004,
-		0, 0, pbn_b0_bt_4_115200 },
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
+			       0xA000, 0x1000),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
+			       0xA000, 0x3002),
+		.driver_data = pbn_b0_bt_2_115200,
+	}, {
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
+			       0xA000, 0x3004),
+		.driver_data = pbn_b0_bt_4_115200,
+	},
 
 	/*
 	 * ASIX AX99100 PCIe to Multi I/O Controller
 	 */
-	{	PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_AX99100,
-		0xA000, 0x1000,
-		0, 0, pbn_b0_1_115200 },
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_AX99100,
+			       0xA000, 0x1000),
+		.driver_data = pbn_b0_1_115200,
+	},
 
 	/* Intel CE4100 */
-	{	PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CE4100_UART,
-		PCI_ANY_ID,  PCI_ANY_ID, 0, 0,
-		pbn_ce4100_1_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CE4100_UART),
+		.driver_data = pbn_ce4100_1_115200,
+	},
 
 	/*
 	 * Cronyx Omega PCI
 	 */
-	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_CRONYX_OMEGA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_omegapci },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_CRONYX_OMEGA),
+		.driver_data = pbn_omegapci,
+	},
 
 	/*
 	 * Broadcom TruManage
 	 */
-	{	PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BROADCOM_TRUMANAGE,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_brcm_trumanage },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BROADCOM_TRUMANAGE),
+		.driver_data = pbn_brcm_trumanage,
+	},
 
 	/*
 	 * AgeStar as-prs2-009
 	 */
-	{	PCI_VENDOR_ID_AGESTAR, PCI_DEVICE_ID_AGESTAR_9375,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, pbn_b0_bt_2_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_AGESTAR, PCI_DEVICE_ID_AGESTAR_9375),
+		.driver_data = pbn_b0_bt_2_115200,
+	},
 
 	/*
 	 * WCH CH353 series devices: The 2S1P is handled by parport_serial
 	 * so not listed here.
 	 */
-	{	PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH353_4S,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, pbn_b0_bt_4_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH353_4S),
+		.driver_data = pbn_b0_bt_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH353_2S1PF),
+		.driver_data = pbn_b0_bt_2_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH355_4S),
+		.driver_data = pbn_b0_bt_4_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH382_2S),
+		.driver_data = pbn_wch382_2,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH384_4S),
+		.driver_data = pbn_wch384_4,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH384_8S),
+		.driver_data = pbn_wch384_8,
+	},
 
-	{	PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH353_2S1PF,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, pbn_b0_bt_2_115200 },
-
-	{	PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH355_4S,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, pbn_b0_bt_4_115200 },
-
-	{	PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH382_2S,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, pbn_wch382_2 },
-
-	{	PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH384_4S,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, pbn_wch384_4 },
-
-	{	PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH384_8S,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, pbn_wch384_8 },
 	/*
 	 * Realtek RealManage
 	 */
-	{	PCI_VENDOR_ID_REALTEK, 0x816a,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, pbn_b0_1_115200 },
-
-	{	PCI_VENDOR_ID_REALTEK, 0x816b,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, pbn_b0_1_115200 },
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x816a),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x816b),
+		.driver_data = pbn_b0_1_115200,
+	},
 
 	/* Fintek PCI serial cards */
-	{ PCI_DEVICE(0x1c29, 0x1104), .driver_data = pbn_fintek_4 },
-	{ PCI_DEVICE(0x1c29, 0x1108), .driver_data = pbn_fintek_8 },
-	{ PCI_DEVICE(0x1c29, 0x1112), .driver_data = pbn_fintek_12 },
-	{ PCI_DEVICE(0x1c29, 0x1204), .driver_data = pbn_fintek_F81504A },
-	{ PCI_DEVICE(0x1c29, 0x1208), .driver_data = pbn_fintek_F81508A },
-	{ PCI_DEVICE(0x1c29, 0x1212), .driver_data = pbn_fintek_F81512A },
+	{
+		PCI_DEVICE(0x1c29, 0x1104),
+		.driver_data = pbn_fintek_4,
+	}, {
+		PCI_DEVICE(0x1c29, 0x1108),
+		.driver_data = pbn_fintek_8,
+	}, {
+		PCI_DEVICE(0x1c29, 0x1112),
+		.driver_data = pbn_fintek_12,
+	}, {
+		PCI_DEVICE(0x1c29, 0x1204),
+		.driver_data = pbn_fintek_F81504A,
+	}, {
+		PCI_DEVICE(0x1c29, 0x1208),
+		.driver_data = pbn_fintek_F81508A,
+	}, {
+		PCI_DEVICE(0x1c29, 0x1212),
+		.driver_data = pbn_fintek_F81512A,
+	},
 
 	/* MKS Tenta SCOM-080x serial cards */
-	{ PCI_DEVICE(0x1601, 0x0800), .driver_data = pbn_b0_4_1250000 },
-	{ PCI_DEVICE(0x1601, 0xa801), .driver_data = pbn_b0_4_1250000 },
+	{
+		PCI_DEVICE(0x1601, 0x0800), .driver_data = pbn_b0_4_1250000,
+	}, {
+		PCI_DEVICE(0x1601, 0xa801), .driver_data = pbn_b0_4_1250000,
+	},
 
 	/* Amazon PCI serial device */
-	{ PCI_DEVICE(0x1d0f, 0x8250), .driver_data = pbn_b0_1_115200 },
+	{
+		PCI_DEVICE(0x1d0f, 0x8250), .driver_data = pbn_b0_1_115200,
+	},
 
 	/*
 	 * These entries match devices with class COMMUNICATION_SERIAL,
 	 * COMMUNICATION_MODEM or COMMUNICATION_MULTISERIAL
 	 */
-	{	PCI_ANY_ID, PCI_ANY_ID,
+	{
+		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_COMMUNICATION_SERIAL << 8,
-		0xffff00, pbn_default },
-	{	PCI_ANY_ID, PCI_ANY_ID,
+		0xffff00,
+		.driver_data = pbn_default,
+	}, {
+		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_COMMUNICATION_MODEM << 8,
-		0xffff00, pbn_default },
-	{	PCI_ANY_ID, PCI_ANY_ID,
+		0xffff00,
+		.driver_data = pbn_default,
+	}, {
+		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
-		0xffff00, pbn_default },
+		0xffff00,
+		.driver_data = pbn_default,
+	},
 	{ 0, }
 };
 

base-commit: 028ef9c96e96197026887c0f092424679298aae8
-- 
2.47.3

