Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AB61E5714
	for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2026 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387259; cv=none; b=E8+2bgsMol2ZwUYHy2Rks/i8k9YSvQwMx2rdv/VEP+VARtolXlI4+hezViJEd4nTZ34nB08sfkQFQpvonUrMnlNUvyOxLRCtj22G32bqjf8DkobtlRqtI80qnVO4beY9sTs9GL9CfJuiuUDyNL+fAjarRxaZ4rgd4BlG9zJf7gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387259; c=relaxed/simple;
	bh=gOw1l/Dbfh+s7fFbmKJnuLWfgAINjsc2QmyhcYCRdP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S6bBohmOw3I3xjPk5WQhY9mx2Pl5Ep//7hOo97O25anUhiRRz/b4GH/OZYBQ+pXUndzUyTlIt/Ewp3IVf1liVqEGjmA8DoKnxsB9VDMqabOkq/zSVEusuJesMTZdv8JTN01OQG/wnNTx3X5/mjfgR/Rwx6PrY0QA/527xLl+bPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=gEjVGevI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="gEjVGevI"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48896199cbaso113611235e9.1
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2026 07:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777387249; x=1777992049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FMCMelAWFVfsamSnMSv8PSJ1S127wpDAcBpze9GkjPQ=;
        b=gEjVGevIahGcjS5I4C7W697R5pLGtBTzm7A3RwvoFo4MFOYnplxW/EMbb3Ool+nUON
         XH4S4l2oNwn2Fc/MYIWIGi8WWDKakkLU2snJT7VZfVX/k7P4K5z0G9vMCb9TxIYzy4pQ
         tUTVVsXbTp+YL11+KqHRaUb+ozeKvQqkeLXkz2EjeMPVMEaMHZmjrtjtWHeZ2LXpZnjB
         S0g2qwzQFIlSxgoG959mR+6IL5xwiVtp/P06tmG5dqiKbGhPq/knHn3E76A31+WRRbvM
         F1Aa0ru0/juzQK86Vo3ULaVOGNPFa56cdx8mhi5qbR39j3544Ca3ET8o/QvuldSeD83Z
         DV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777387249; x=1777992049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMCMelAWFVfsamSnMSv8PSJ1S127wpDAcBpze9GkjPQ=;
        b=OIcxHOwjYvkop/Grl27OokSaNsVOTd9LPDiL/3dBHO8gwpuLkD+mVzYPIJUp3MvTo1
         MTfDbJ2YN2iBbe38PxHblfhLFqP4by/ew/2Htq1RQlZKy55kvUbSohMS3n/GcxHuKWNA
         5oALH7+nZCtAqcn5SijM3OVAfkqdxd6puJ9e1NTUIvdH7eDoFDlJdkMvmHrYBbefyAE8
         aXvQ66aJxaS+WoMe+JRLL4sq2ZmdwGWgtuuWIFmtaAmO72aqghJlyHNvCmFJgi4SFiA2
         WvCGArkx1k6h+sO29ig6XAYbQXQViAH0JForFkOxq6puVrUcJILz4hJG98ZjEBuHeQUx
         7xiA==
X-Forwarded-Encrypted: i=1; AFNElJ+tWkqNvDPFpoSkotp8HtEe0ZjHPA3bYtr1R+gIgSgnFE8PsfF9ZcOBcn4rh9r/av9CU3ZahqSTQZT94KA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz60MtGlREuZA9ByN3BeJBMXn511aPOhk2WPV2sh1GG7W+0kCbL
	UXJqhucrXJ+llyftnoI5nSgEyJUREywlcXTHg9BuoAGLRgJfUj4Jk+NuQy3zON8wIgo=
X-Gm-Gg: AeBDietvG1gtqMMrHzYzBot9yR8SezotDarrX6Cr3FCvHfwLNuTjzORkbtJIBXNQaaM
	7wVJwI/AcOwimzVHwEdzz2IF5xIftz/qAkL38GM/0238c9pKDlsDrVQL0OIQo6LUMHdCfUVKVKE
	UGjfARt7AHdsl8ugWZGyHYmPg5QrYYsGH/ncjVZMwgV7DZMqW3okxIG4I+0M9NrPlaRbUJ/E59M
	2KuiTBTpkcLayufCyvQKm6pmv0A4sJc/PPql5HRHn89ZcG7FOB1mILN3kDd2xsl45oYy8xAXFOp
	c9J0QrYaPoDPdHRmB5WuEAtTE4G7yB6z60DPdP3xNdxm5fWCq01TvKYWZ9l/+KPY6AC+MMGyep4
	X6pDYxxNfReisyaCWuNxsMuF6xRYdS7D95OLjHwA2+2GMwPP9khyebpzEMokE/1FX6CouVOqdxU
	h+ynBz6A+ApTA4vszPsP30jTGYkjrsQHjPExJcfIzq1vgPeKHMCn1PLwsygB1md/hck7nNYvFnj
	pw2ynaRgdKCNjPusMh0/8/nqk5vylwDuNKo
X-Received: by 2002:a05:600c:3b0f:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48a77b061a5mr54152955e9.17.1777387248552;
        Tue, 28 Apr 2026 07:40:48 -0700 (PDT)
Received: from localhost (p200300f65f114e083adbfb3674088b9a.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:3adb:fb36:7408:8b9a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a775defe4sm46801325e9.7.2026.04.28.07.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:40:47 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] serial: 8250_pci: Consistently define pci_device_ids using named initializers
Date: Tue, 28 Apr 2026 16:40:33 +0200
Message-ID: <20260428144033.1037617-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=112910; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=gOw1l/Dbfh+s7fFbmKJnuLWfgAINjsc2QmyhcYCRdP8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp8MbiwyABQPKJ5CTJDtEKpVbG629FZ11VKqD7b X31A8ur4ziJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafDG4gAKCRCPgPtYfRL+ TviuCACv+0SsvkSnI8zW7KK9BdzQYo4CKWjcFvjNqpqJxIBSk3cwMayww2YZXA3byYQEZz03eJr 4gpe5fL0h/gM9w3sktOKpiZlZNbubkYi8HRtQGEMGFM9rzP5zsGwtsssN6dUhgoPDLizNK28vjD nbWwT1t1Y3wD6F1Vo8Qx1+c9uAqcBy0zqWnbi9Wc2Dw6C+enTzp2nvDdah2IbVLz3sGEqq39vna AQWhTj53DUqf6mUdaOXjS6D3z8HSu/uq627e7abx++FFzkWyWfO3ipIXmaiQvPTCdl+8d0nELh/ GgDyEx2VoFI/GJYv57TVpDekGSLmWJ30FZzKNPuVXHFS9S6o
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
an allmodconfig with several things disabled that make reproducible
builds harder on x86 and arm64.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

sashiko[1] found a few missing conversions in v2[2] that are addressed
here. (That happend because the formatting was different and so those
were not adapted by my semi-automatic conversion.)

I also used PCI_VDEVICE* where applicable now.

Best regards
Uwe

[1] https://sashiko.dev/#/patchset/20260427211423.2323211-2-u.kleine-koenig%40baylibre.com
[2] https://lore.kernel.org/20260427211423.2323211-2-u.kleine-koenig%40baylibre.com

 drivers/tty/serial/8250/8250_pci.c | 3120 ++++++++++++++--------------
 1 file changed, 1563 insertions(+), 1557 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 2fbd8f2603b5..3e5bc9e8d269 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -143,16 +143,15 @@ struct serial_private {
 #define PCIE_DEVICE_ID_AX99100		0x9100
 
 static const struct pci_device_id pci_use_msi[] = {
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
-			 0xA000, 0x1000) },
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9912,
-			 0xA000, 0x1000) },
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9922,
-			 0xA000, 0x1000) },
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_AX99100,
-			 0xA000, 0x1000) },
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP_3PAR, PCI_DEVICE_ID_HPE_PCI_SERIAL,
-			 PCI_ANY_ID, PCI_ANY_ID) },
+	{ PCI_VDEVICE_SUB(NETMOS, PCI_DEVICE_ID_NETMOS_9900,
+			  0xA000, 0x1000) },
+	{ PCI_VDEVICE_SUB(NETMOS, PCI_DEVICE_ID_NETMOS_9912,
+			  0xA000, 0x1000) },
+	{ PCI_VDEVICE_SUB(NETMOS, PCI_DEVICE_ID_NETMOS_9922,
+			  0xA000, 0x1000) },
+	{ PCI_VDEVICE_SUB(ASIX, PCI_DEVICE_ID_ASIX_AX99100,
+			  0xA000, 0x1000) },
+	{ PCI_VDEVICE(HP_3PAR, PCI_DEVICE_ID_HPE_PCI_SERIAL) },
 	{ PCI_DEVICE_SUB(PCIE_VENDOR_ID_ASIX, PCIE_DEVICE_ID_AX99100,
 			 0xA000, 0x1000) },
 	{ }
@@ -4040,42 +4039,42 @@ static const struct pci_device_id blacklist[] = {
 
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
@@ -4448,713 +4447,753 @@ static SIMPLE_DEV_PM_OPS(pciserial_pm_ops, pciserial_suspend_one,
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
+		PCI_VDEVICE_SUB(ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI1600,
+				PCI_DEVICE_ID_ADVANTECH_PCI1600_1611, PCI_ANY_ID),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		/* Advantech use PCI_DEVICE_ID_ADVANTECH_PCI3620 (0x3620) as 'PCI_SUBVENDOR_ID' */
+		PCI_VDEVICE_SUB(ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI3620,
+				PCI_DEVICE_ID_ADVANTECH_PCI3620, 0x0001),
+		.driver_data = pbn_b2_8_921600,
+	}, {
+		/* Advantech also use 0x3618 and 0xf618 */
+		PCI_VDEVICE_SUB(ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI3618,
+				PCI_DEVICE_ID_ADVANTECH_PCI3618, PCI_ANY_ID),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_VDEVICE_SUB(ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCIf618,
+				PCI_DEVICE_ID_ADVANTECH_PCI3618, PCI_ANY_ID),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_VDEVICE_SUB(V3, PCI_DEVICE_ID_V3_V960,
+				PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232),
+		.driver_data = pbn_b1_8_1382400,
+	}, {
+		PCI_VDEVICE_SUB(V3, PCI_DEVICE_ID_V3_V960,
+				PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_232),
+		.driver_data = pbn_b1_4_1382400,
+	}, {
+		PCI_VDEVICE_SUB(V3, PCI_DEVICE_ID_V3_V960,
+				PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_232),
+		.driver_data = pbn_b1_2_1382400,
+	}, {
+		PCI_VDEVICE_SUB(V3, PCI_DEVICE_ID_V3_V351,
+				PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232),
+		.driver_data = pbn_b1_8_1382400,
+	}, {
+		PCI_VDEVICE_SUB(V3, PCI_DEVICE_ID_V3_V351,
+				PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_232),
+		.driver_data = pbn_b1_4_1382400,
+	}, {
+		PCI_VDEVICE_SUB(V3, PCI_DEVICE_ID_V3_V351,
+				PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_232),
+		.driver_data = pbn_b1_2_1382400,
+	}, {
+		PCI_VDEVICE_SUB(V3, PCI_DEVICE_ID_V3_V351,
+				PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485),
+		.driver_data = pbn_b1_8_921600,
+	}, {
+		PCI_VDEVICE_SUB(V3, PCI_DEVICE_ID_V3_V351,
+				PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_4_4),
+		.driver_data = pbn_b1_8_921600,
+	}, {
+		PCI_VDEVICE_SUB(V3, PCI_DEVICE_ID_V3_V351,
+				PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485),
+		.driver_data = pbn_b1_4_921600,
+	}, {
+		PCI_VDEVICE_SUB(V3, PCI_DEVICE_ID_V3_V351,
+				PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485_2_2),
+		.driver_data = pbn_b1_4_921600,
+	}, {
+		PCI_VDEVICE_SUB(V3, PCI_DEVICE_ID_V3_V351,
+				PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_485),
+		.driver_data = pbn_b1_2_921600,
+	}, {
+		PCI_VDEVICE_SUB(V3, PCI_DEVICE_ID_V3_V351,
+				PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_2_6),
+		.driver_data = pbn_b1_8_921600,
+	}, {
+		PCI_VDEVICE_SUB(V3, PCI_DEVICE_ID_V3_V351,
+				PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH081101V1),
+		.driver_data = pbn_b1_8_921600,
+	}, {
+		PCI_VDEVICE_SUB(V3, PCI_DEVICE_ID_V3_V351,
+				PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH041101V1),
+		.driver_data = pbn_b1_4_921600,
+	}, {
+		PCI_VDEVICE_SUB(V3, PCI_DEVICE_ID_V3_V351,
+				PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_20MHZ),
+		.driver_data = pbn_b1_2_1250000,
+	}, {
+		PCI_VDEVICE_SUB(OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
+				PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_TITAN_2),
+		.driver_data = pbn_b0_2_1843200,
+	}, {
+		PCI_VDEVICE_SUB(OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
+				PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_TITAN_4),
+		.driver_data = pbn_b0_4_1843200,
+	}, {
+		PCI_VDEVICE_SUB(OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
+				PCI_VENDOR_ID_AFAVLAB, PCI_SUBDEVICE_ID_AFAVLAB_P061),
+		.driver_data = pbn_b0_4_1152000,
+	}, {
+		PCI_VDEVICE(SEALEVEL, PCI_DEVICE_ID_SEALEVEL_U530),
+		.driver_data = pbn_b2_bt_1_115200,
+	}, {
+		PCI_VDEVICE(SEALEVEL, PCI_DEVICE_ID_SEALEVEL_UCOMM2),
+		.driver_data = pbn_b2_bt_2_115200,
+	}, {
+		PCI_VDEVICE(SEALEVEL, PCI_DEVICE_ID_SEALEVEL_UCOMM422),
+		.driver_data = pbn_b2_bt_4_115200,
+	}, {
+		PCI_VDEVICE(SEALEVEL, PCI_DEVICE_ID_SEALEVEL_UCOMM232),
+		.driver_data = pbn_b2_bt_2_115200,
+	}, {
+		PCI_VDEVICE(SEALEVEL, PCI_DEVICE_ID_SEALEVEL_COMM4),
+		.driver_data = pbn_b2_bt_4_115200,
+	}, {
+		PCI_VDEVICE(SEALEVEL, PCI_DEVICE_ID_SEALEVEL_COMM8),
+		.driver_data = pbn_b2_8_115200,
+	}, {
+		PCI_VDEVICE(SEALEVEL, PCI_DEVICE_ID_SEALEVEL_7803),
+		.driver_data = pbn_b2_8_460800,
+	}, {
+		PCI_VDEVICE(SEALEVEL, PCI_DEVICE_ID_SEALEVEL_UCOMM8),
+		.driver_data = pbn_b2_8_115200,
+	}, {
+		PCI_VDEVICE(PLX, PCI_DEVICE_ID_PLX_GTEK_SERIAL2),
+		.driver_data = pbn_b2_bt_2_115200,
+	}, {
+		PCI_VDEVICE(PLX, PCI_DEVICE_ID_PLX_SPCOM200),
+		.driver_data = pbn_b2_bt_2_921600,
+	}, {
+		/* VScom SPCOM800, from sl@s.pl */
+		PCI_VDEVICE(PLX, PCI_DEVICE_ID_PLX_SPCOM800),
+		.driver_data = pbn_b2_8_921600,
+	}, {
+		PCI_VDEVICE(PLX, PCI_DEVICE_ID_PLX_1077),
+		.driver_data = pbn_b2_4_921600,
+	}, {
+		/* Unknown card - subdevice 0x1584 */
+		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9050,
+				PCI_VENDOR_ID_PLX, PCI_SUBDEVICE_ID_UNKNOWN_0x1584),
+		.driver_data = pbn_b2_4_115200,
+	}, {
+		/* Unknown card - subdevice 0x1588 */
+		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9050,
+				PCI_VENDOR_ID_PLX, PCI_SUBDEVICE_ID_UNKNOWN_0x1588),
+		.driver_data = pbn_b2_8_115200,
+	}, {
+		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9050,
+				PCI_SUBVENDOR_ID_KEYSPAN, PCI_SUBDEVICE_ID_KEYSPAN_SX2),
+		.driver_data = pbn_panacom,
+	}, {
+		PCI_VDEVICE(PANACOM, PCI_DEVICE_ID_PANACOM_QUADMODEM),
+		.driver_data = pbn_panacom4,
+	}, {
+		PCI_VDEVICE(PANACOM, PCI_DEVICE_ID_PANACOM_DUALMODEM),
+		.driver_data = pbn_panacom2,
+	}, {
+		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9030,
+				PCI_VENDOR_ID_ESDGMBH, PCI_DEVICE_ID_ESDGMBH_CPCIASIO4),
+		.driver_data = pbn_b2_4_115200,
+	}, {
+		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9050,
+				PCI_SUBVENDOR_ID_CHASE_PCIFAST, PCI_SUBDEVICE_ID_CHASE_PCIFAST4),
+		.driver_data = pbn_b2_4_460800,
+	}, {
+		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9050,
+				PCI_SUBVENDOR_ID_CHASE_PCIFAST, PCI_SUBDEVICE_ID_CHASE_PCIFAST8),
+		.driver_data = pbn_b2_8_460800,
+	}, {
+		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9050,
+				PCI_SUBVENDOR_ID_CHASE_PCIFAST, PCI_SUBDEVICE_ID_CHASE_PCIFAST16),
+		.driver_data = pbn_b2_16_460800,
+	}, {
+		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9050,
+				PCI_SUBVENDOR_ID_CHASE_PCIFAST, PCI_SUBDEVICE_ID_CHASE_PCIFAST16FMC),
+		.driver_data = pbn_b2_16_460800,
+	}, {
+		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9050,
+				PCI_SUBVENDOR_ID_CHASE_PCIRAS, PCI_SUBDEVICE_ID_CHASE_PCIRAS4),
+		.driver_data = pbn_b2_4_460800,
+	}, {
+		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9050,
+				PCI_SUBVENDOR_ID_CHASE_PCIRAS, PCI_SUBDEVICE_ID_CHASE_PCIRAS8),
+		.driver_data = pbn_b2_8_460800,
+	}, {
+		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9050,
+				PCI_SUBVENDOR_ID_EXSYS, PCI_SUBDEVICE_ID_EXSYS_4055),
+		.driver_data = pbn_b2_4_115200,
+	}, {
+		/*
+		 * Megawolf Romulus PCI Serial Card, from Mike Hudson
+		 * (Exoray@isys.ca)
+		 */
+		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_ROMULUS,
+				0x10b5, 0x106a),
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
+		PCI_VDEVICE(QUATECH, PCI_DEVICE_ID_QUATECH_QSC100),
+		.driver_data = pbn_b1_4_115200,
+	}, {
+		PCI_VDEVICE(QUATECH, PCI_DEVICE_ID_QUATECH_DSC100),
+		.driver_data = pbn_b1_2_115200,
+	}, {
+		PCI_VDEVICE(QUATECH, PCI_DEVICE_ID_QUATECH_DSC100E),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(QUATECH, PCI_DEVICE_ID_QUATECH_DSC200),
+		.driver_data = pbn_b1_2_115200,
+	}, {
+		PCI_VDEVICE(QUATECH, PCI_DEVICE_ID_QUATECH_DSC200E),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(QUATECH, PCI_DEVICE_ID_QUATECH_QSC200),
+		.driver_data = pbn_b1_4_115200,
+	}, {
+		PCI_VDEVICE(QUATECH, PCI_DEVICE_ID_QUATECH_ESC100D),
+		.driver_data = pbn_b1_8_115200,
+	}, {
+		PCI_VDEVICE(QUATECH, PCI_DEVICE_ID_QUATECH_ESC100M),
+		.driver_data = pbn_b1_8_115200,
+	}, {
+		PCI_VDEVICE(QUATECH, PCI_DEVICE_ID_QUATECH_QSCP100),
+		.driver_data = pbn_b1_4_115200,
+	}, {
+		PCI_VDEVICE(QUATECH, PCI_DEVICE_ID_QUATECH_DSCP100),
+		.driver_data = pbn_b1_2_115200,
+	}, {
+		PCI_VDEVICE(QUATECH, PCI_DEVICE_ID_QUATECH_QSCP200),
+		.driver_data = pbn_b1_4_115200,
+	}, {
+		PCI_VDEVICE(QUATECH, PCI_DEVICE_ID_QUATECH_DSCP200),
+		.driver_data = pbn_b1_2_115200,
+	}, {
+		PCI_VDEVICE(QUATECH, PCI_DEVICE_ID_QUATECH_QSCLP100),
+		.driver_data = pbn_b2_4_115200,
+	}, {
+		PCI_VDEVICE(QUATECH, PCI_DEVICE_ID_QUATECH_DSCLP100),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(QUATECH, PCI_DEVICE_ID_QUATECH_SSCLP100),
+		.driver_data = pbn_b2_1_115200,
+	}, {
+		PCI_VDEVICE(QUATECH, PCI_DEVICE_ID_QUATECH_QSCLP200),
+		.driver_data = pbn_b2_4_115200,
+	}, {
+		PCI_VDEVICE(QUATECH, PCI_DEVICE_ID_QUATECH_DSCLP200),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(QUATECH, PCI_DEVICE_ID_QUATECH_SSCLP200),
+		.driver_data = pbn_b2_1_115200,
+	}, {
+		PCI_VDEVICE(QUATECH, PCI_DEVICE_ID_QUATECH_ESCLP100),
+		.driver_data = pbn_b0_8_115200,
+	}, {
+		PCI_VDEVICE_SUB(SPECIALIX, PCI_DEVICE_ID_OXSEMI_16PCI954,
+				PCI_VENDOR_ID_SPECIALIX, PCI_SUBDEVICE_ID_SPECIALIX_SPEED4),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_VDEVICE_SUB(OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
+				PCI_SUBVENDOR_ID_SIIG, PCI_SUBDEVICE_ID_SIIG_QUARTET_SERIAL),
+		.driver_data = pbn_b0_4_1152000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0x9505),
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
+		PCI_VDEVICE_SUB(OXSEMI, 0x950a,
+				PCI_SUBVENDOR_ID_SIIG, PCI_SUBDEVICE_ID_SIIG_DUAL_00),
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		PCI_VDEVICE_SUB(OXSEMI, 0x950a,
+				PCI_SUBVENDOR_ID_SIIG, PCI_SUBDEVICE_ID_SIIG_DUAL_30),
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0x950a),
+		.driver_data = pbn_b0_2_1130000,
+	}, {
+		PCI_VDEVICE_SUB(OXSEMI, PCI_DEVICE_ID_OXSEMI_C950,
+				PCI_VENDOR_ID_OXSEMI, PCI_SUBDEVICE_ID_OXSEMI_C950),
+		.driver_data = pbn_b0_1_921600,
+	}, {
+		PCI_VDEVICE(OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954),
+		.driver_data = pbn_b0_4_115200,
+	}, {
+		PCI_VDEVICE(OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI952),
+		.driver_data = pbn_b0_bt_2_921600,
+	}, {
+		PCI_VDEVICE(OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI958),
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
+		PCI_VDEVICE(OXSEMI, 0xc101),    /* OXPCIe952 1 Legacy UART */
+		.driver_data = pbn_b0_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc105),    /* OXPCIe952 1 Legacy UART */
+		.driver_data = pbn_b0_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc11b),    /* OXPCIe952 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc11f),    /* OXPCIe952 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc120),    /* OXPCIe952 1 Legacy UART */
+		.driver_data = pbn_b0_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc124),    /* OXPCIe952 1 Legacy UART */
+		.driver_data = pbn_b0_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc138),    /* OXPCIe952 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc13d),    /* OXPCIe952 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc140),    /* OXPCIe952 1 Legacy UART */
+		.driver_data = pbn_b0_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc141),    /* OXPCIe952 1 Legacy UART */
+		.driver_data = pbn_b0_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc144),    /* OXPCIe952 1 Legacy UART */
+		.driver_data = pbn_b0_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc145),    /* OXPCIe952 1 Legacy UART */
+		.driver_data = pbn_b0_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc158),    /* OXPCIe952 2 Native UART */
+		.driver_data = pbn_oxsemi_2_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc15d),    /* OXPCIe952 2 Native UART */
+		.driver_data = pbn_oxsemi_2_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc208),    /* OXPCIe954 4 Native UART */
+		.driver_data = pbn_oxsemi_4_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc20d),    /* OXPCIe954 4 Native UART */
+		.driver_data = pbn_oxsemi_4_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc308),    /* OXPCIe958 8 Native UART */
+		.driver_data = pbn_oxsemi_8_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc30d),    /* OXPCIe958 8 Native UART */
+		.driver_data = pbn_oxsemi_8_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc40b),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc40f),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc41b),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc41f),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc42b),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc42f),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc43b),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc43f),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc44b),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc44f),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc45b),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc45f),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc46b),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc46f),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc47b),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc47f),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc48b),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc48f),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc49b),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc49f),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc4ab),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc4af),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc4bb),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc4bf),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc4cb),    /* OXPCIe200 1 Native UART */
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		PCI_VDEVICE(OXSEMI, 0xc4cf),    /* OXPCIe200 1 Native UART */
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
+		PCI_VDEVICE_SUB(MAINPINE, 0x4000,
+				PCI_VENDOR_ID_MAINPINE, 0x4001),
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		/* IQ Express 2 Port V.34 Super-G3 Fax */
+		PCI_VDEVICE_SUB(MAINPINE, 0x4000,
+				PCI_VENDOR_ID_MAINPINE, 0x4002),
+		.driver_data = pbn_oxsemi_2_15625000,
+	}, {
+		/* IQ Express 4 Port V.34 Super-G3 Fax */
+		PCI_VDEVICE_SUB(MAINPINE, 0x4000,
+				PCI_VENDOR_ID_MAINPINE, 0x4004),
+		.driver_data = pbn_oxsemi_4_15625000,
+	}, {
+		/* IQ Express 8 Port V.34 Super-G3 Fax */
+		PCI_VDEVICE_SUB(MAINPINE, 0x4000,
+				PCI_VENDOR_ID_MAINPINE, 0x4008),
+		.driver_data = pbn_oxsemi_8_15625000,
+	},
 
 	/*
 	 * Digi/IBM PCIe 2-port Async EIA-232 Adapter utilizing OxSemi Tornado
 	 */
-	{	PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_2_OX_IBM,
-		PCI_SUBVENDOR_ID_IBM, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_2_15625000 },
+	{
+		PCI_VDEVICE_SUB(DIGI, PCIE_DEVICE_ID_NEO_2_OX_IBM,
+				PCI_SUBVENDOR_ID_IBM, PCI_ANY_ID),
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
+		PCI_VDEVICE(ENDRUN, PCI_DEVICE_ID_ENDRUN_1588),
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
+		PCI_VDEVICE_SUB(SBSMODULARIO, PCI_DEVICE_ID_OCTPRO,
+				PCI_SUBVENDOR_ID_SBSMODULARIO, PCI_SUBDEVICE_ID_OCTPRO232),
+		.driver_data = pbn_sbsxrsio,
+	}, {
+		PCI_VDEVICE_SUB(SBSMODULARIO, PCI_DEVICE_ID_OCTPRO,
+				PCI_SUBVENDOR_ID_SBSMODULARIO, PCI_SUBDEVICE_ID_OCTPRO422),
+		.driver_data = pbn_sbsxrsio,
+	}, {
+		PCI_VDEVICE_SUB(SBSMODULARIO, PCI_DEVICE_ID_OCTPRO,
+				PCI_SUBVENDOR_ID_SBSMODULARIO, PCI_SUBDEVICE_ID_POCTAL232),
+		.driver_data = pbn_sbsxrsio,
+	}, {
+		PCI_VDEVICE_SUB(SBSMODULARIO, PCI_DEVICE_ID_OCTPRO,
+				PCI_SUBVENDOR_ID_SBSMODULARIO, PCI_SUBDEVICE_ID_POCTAL422),
+		.driver_data = pbn_sbsxrsio,
+	},
 
 	/*
 	 * Digitan DS560-558, from jimd@esoft.com
 	 */
-	{	PCI_VENDOR_ID_ATT, PCI_DEVICE_ID_ATT_VENUS_MODEM,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_1_115200 },
+	{
+		PCI_VDEVICE(ATT, PCI_DEVICE_ID_ATT_VENUS_MODEM),
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
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_100),
+		.driver_data = pbn_b0_1_921600,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_200),
+		.driver_data = pbn_b0_2_921600,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_400),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_800B),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_100L),
+		.driver_data = pbn_b1_1_921600,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_200L),
+		.driver_data = pbn_b1_bt_2_921600,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_400L),
+		.driver_data = pbn_b0_bt_4_921600,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_800L),
+		.driver_data = pbn_b0_bt_8_921600,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_200I),
+		.driver_data = pbn_b4_bt_2_921600,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_400I),
+		.driver_data = pbn_b4_bt_4_921600,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_800I),
+		.driver_data = pbn_b4_bt_8_921600,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_400EH),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_800EH),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_800EHB),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_100E),
+		.driver_data = pbn_titan_1_4000000,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_200E),
+		.driver_data = pbn_titan_2_4000000,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_400E),
+		.driver_data = pbn_titan_4_4000000,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_800E),
+		.driver_data = pbn_titan_8_4000000,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_200EI),
+		.driver_data = pbn_titan_2_4000000,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_200EISI),
+		.driver_data = pbn_titan_2_4000000,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_200V3),
+		.driver_data = pbn_b0_bt_2_921600,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_400V3),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_410V3),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_800V3),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_VDEVICE(TITAN, PCI_DEVICE_ID_TITAN_800V3B),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_VDEVICE(SIIG, PCI_DEVICE_ID_SIIG_1S_10x_550),
+		.driver_data = pbn_b2_1_460800,
+	}, {
+		PCI_VDEVICE(SIIG, PCI_DEVICE_ID_SIIG_1S_10x_650),
+		.driver_data = pbn_b2_1_460800,
+	}, {
+		PCI_VDEVICE(SIIG, PCI_DEVICE_ID_SIIG_1S_10x_850),
+		.driver_data = pbn_b2_1_460800,
+	}, {
+		PCI_VDEVICE(SIIG, PCI_DEVICE_ID_SIIG_2S_10x_550),
+		.driver_data = pbn_b2_bt_2_921600,
+	}, {
+		PCI_VDEVICE(SIIG, PCI_DEVICE_ID_SIIG_2S_10x_650),
+		.driver_data = pbn_b2_bt_2_921600,
+	}, {
+		PCI_VDEVICE(SIIG, PCI_DEVICE_ID_SIIG_2S_10x_850),
+		.driver_data = pbn_b2_bt_2_921600,
+	}, {
+		PCI_VDEVICE(SIIG, PCI_DEVICE_ID_SIIG_4S_10x_550),
+		.driver_data = pbn_b2_bt_4_921600,
+	}, {
+		PCI_VDEVICE(SIIG, PCI_DEVICE_ID_SIIG_4S_10x_650),
+		.driver_data = pbn_b2_bt_4_921600,
+	}, {
+		PCI_VDEVICE(SIIG, PCI_DEVICE_ID_SIIG_4S_10x_850),
+		.driver_data = pbn_b2_bt_4_921600,
+	}, {
+		PCI_VDEVICE(SIIG, PCI_DEVICE_ID_SIIG_1S_20x_550),
+		.driver_data = pbn_b0_1_921600,
+	}, {
+		PCI_VDEVICE(SIIG, PCI_DEVICE_ID_SIIG_1S_20x_650),
+		.driver_data = pbn_b0_1_921600,
+	}, {
+		PCI_VDEVICE(SIIG, PCI_DEVICE_ID_SIIG_1S_20x_850),
+		.driver_data = pbn_b0_1_921600,
+	}, {
+		PCI_VDEVICE(SIIG, PCI_DEVICE_ID_SIIG_2S_20x_550),
+		.driver_data = pbn_b0_bt_2_921600,
+	}, {
+		PCI_VDEVICE(SIIG, PCI_DEVICE_ID_SIIG_2S_20x_650),
+		.driver_data = pbn_b0_bt_2_921600,
+	}, {
+		PCI_VDEVICE(SIIG, PCI_DEVICE_ID_SIIG_2S_20x_850),
+		.driver_data = pbn_b0_bt_2_921600,
+	}, {
+		PCI_VDEVICE(SIIG, PCI_DEVICE_ID_SIIG_4S_20x_550),
+		.driver_data = pbn_b0_bt_4_921600,
+	}, {
+		PCI_VDEVICE(SIIG, PCI_DEVICE_ID_SIIG_4S_20x_650),
+		.driver_data = pbn_b0_bt_4_921600,
+	}, {
+		PCI_VDEVICE(SIIG, PCI_DEVICE_ID_SIIG_4S_20x_850),
+		.driver_data = pbn_b0_bt_4_921600,
+	}, {
+		PCI_VDEVICE(SIIG, PCI_DEVICE_ID_SIIG_8S_20x_550),
+		.driver_data = pbn_b0_bt_8_921600,
+	}, {
+		PCI_VDEVICE(SIIG, PCI_DEVICE_ID_SIIG_8S_20x_650),
+		.driver_data = pbn_b0_bt_8_921600,
+	}, {
+		PCI_VDEVICE(SIIG, PCI_DEVICE_ID_SIIG_8S_20x_850),
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
+		PCI_VDEVICE_SUB(COMPUTONE, PCI_DEVICE_ID_COMPUTONE_PG,
+				PCI_SUBVENDOR_ID_COMPUTONE, PCI_SUBDEVICE_ID_COMPUTONE_PG4),
+		.driver_data = pbn_computone_4,
+	}, {
+		PCI_VDEVICE_SUB(COMPUTONE, PCI_DEVICE_ID_COMPUTONE_PG,
+				PCI_SUBVENDOR_ID_COMPUTONE, PCI_SUBDEVICE_ID_COMPUTONE_PG8),
+		.driver_data = pbn_computone_8,
+	}, {
+		PCI_VDEVICE_SUB(COMPUTONE, PCI_DEVICE_ID_COMPUTONE_PG,
+				PCI_SUBVENDOR_ID_COMPUTONE, PCI_SUBDEVICE_ID_COMPUTONE_PG6),
+		.driver_data = pbn_computone_6,
+	},
 
-	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI95N,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi },
-	{	PCI_VENDOR_ID_TIMEDIA, PCI_DEVICE_ID_TIMEDIA_1889,
-		PCI_VENDOR_ID_TIMEDIA, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_1_921600 },
+	{
+		PCI_VDEVICE(OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI95N),
+		.driver_data = pbn_oxsemi,
+	}, {
+		PCI_VDEVICE_SUB(TIMEDIA, PCI_DEVICE_ID_TIMEDIA_1889,
+				PCI_VENDOR_ID_TIMEDIA, PCI_ANY_ID),
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
+		PCI_VDEVICE_SUB(SUNIX, PCI_DEVICE_ID_SUNIX_1999,
+				PCI_VENDOR_ID_SUNIX, 0x0001),
+		.driver_data = pbn_sunix_pci_1s,
+	}, {
+		PCI_VDEVICE_SUB(SUNIX, PCI_DEVICE_ID_SUNIX_1999,
+				PCI_VENDOR_ID_SUNIX, 0x0002),
+		.driver_data = pbn_sunix_pci_2s,
+	}, {
+		PCI_VDEVICE_SUB(SUNIX, PCI_DEVICE_ID_SUNIX_1999,
+				PCI_VENDOR_ID_SUNIX, 0x0004),
+		.driver_data = pbn_sunix_pci_4s,
+	}, {
+		PCI_VDEVICE_SUB(SUNIX, PCI_DEVICE_ID_SUNIX_1999,
+				PCI_VENDOR_ID_SUNIX, 0x0084),
+		.driver_data = pbn_sunix_pci_4s,
+	}, {
+		PCI_VDEVICE_SUB(SUNIX, PCI_DEVICE_ID_SUNIX_1999,
+				PCI_VENDOR_ID_SUNIX, 0x0008),
+		.driver_data = pbn_sunix_pci_8s,
+	}, {
+		PCI_VDEVICE_SUB(SUNIX, PCI_DEVICE_ID_SUNIX_1999,
+				PCI_VENDOR_ID_SUNIX, 0x0088),
+		.driver_data = pbn_sunix_pci_8s,
+	}, {
+		PCI_VDEVICE_SUB(SUNIX, PCI_DEVICE_ID_SUNIX_1999,
+				PCI_VENDOR_ID_SUNIX, 0x0010),
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
+		PCI_VDEVICE(AFAVLAB, PCI_DEVICE_ID_AFAVLAB_P028),
+		.driver_data = pbn_b0_bt_8_115200,
+	}, {
+		PCI_VDEVICE(AFAVLAB, PCI_DEVICE_ID_AFAVLAB_P030),
+		.driver_data = pbn_b0_bt_8_115200,
+	}, {
+		PCI_VDEVICE(LAVA, PCI_DEVICE_ID_LAVA_DSERIAL),
+		.driver_data = pbn_b0_bt_2_115200,
+	}, {
+		PCI_VDEVICE(LAVA, PCI_DEVICE_ID_LAVA_QUATRO_A),
+		.driver_data = pbn_b0_bt_2_115200,
+	}, {
+		PCI_VDEVICE(LAVA, PCI_DEVICE_ID_LAVA_QUATRO_B),
+		.driver_data = pbn_b0_bt_2_115200,
+	}, {
+		PCI_VDEVICE(LAVA, PCI_DEVICE_ID_LAVA_OCTO_A),
+		.driver_data = pbn_b0_bt_4_460800,
+	}, {
+		PCI_VDEVICE(LAVA, PCI_DEVICE_ID_LAVA_OCTO_B),
+		.driver_data = pbn_b0_bt_4_460800,
+	}, {
+		PCI_VDEVICE(LAVA, PCI_DEVICE_ID_LAVA_PORT_PLUS),
+		.driver_data = pbn_b0_bt_2_460800,
+	}, {
+		PCI_VDEVICE(LAVA, PCI_DEVICE_ID_LAVA_QUAD_A),
+		.driver_data = pbn_b0_bt_2_460800,
+	}, {
+		PCI_VDEVICE(LAVA, PCI_DEVICE_ID_LAVA_QUAD_B),
+		.driver_data = pbn_b0_bt_2_460800,
+	}, {
+		PCI_VDEVICE(LAVA, PCI_DEVICE_ID_LAVA_SSERIAL),
+		.driver_data = pbn_b0_bt_1_115200,
+	}, {
+		PCI_VDEVICE(LAVA, PCI_DEVICE_ID_LAVA_PORT_650),
+		.driver_data = pbn_b0_bt_1_460800,
+	},
 
 	/*
 	 * Korenix Jetcard F0/F1 cards (JC1204, JC1208, JC1404, JC1408).
@@ -5164,560 +5203,533 @@ static const struct pci_device_id serial_pci_tbl[] = {
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
+		PCI_VDEVICE_SUB(KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
+				0x1204, 0x0004),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_VDEVICE_SUB(KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
+				0x1208, 0x0004),
+		.driver_data = pbn_b0_4_921600,
+	},
+/*	{
+		PCI_VDEVICE_SUB(KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
+				0x1402, 0x0002),
+		.driver_data = pbn_b0_2_921600,
+	}, */
+/*	{
+		PCI_VDEVICE_SUB(KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
+				0x1404, 0x0004),
+		.driver_data = pbn_b0_4_921600,
+	}, */
+	{
+		PCI_VDEVICE_SUB(KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF1,
+				0x1208, 0x0004),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_VDEVICE_SUB(KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF2,
+				0x1204, 0x0004),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_VDEVICE_SUB(KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF2,
+				0x1208, 0x0004),
+		.driver_data = pbn_b0_4_921600,
+	}, {
+		PCI_VDEVICE_SUB(KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF3,
+				0x1208, 0x0004),
+		.driver_data = pbn_b0_4_921600,
+	},
 	/*
 	 * Dell Remote Access Card 4 - Tim_T_Murphy@Dell.com
 	 */
-	{	PCI_VENDOR_ID_DELL, PCI_DEVICE_ID_DELL_RAC4,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_1_1382400 },
+	{
+		PCI_VDEVICE(DELL, PCI_DEVICE_ID_DELL_RAC4),
+		.driver_data = pbn_b1_1_1382400,
+	},
 
 	/*
 	 * Dell Remote Access Card III - Tim_T_Murphy@Dell.com
 	 */
-	{	PCI_VENDOR_ID_DELL, PCI_DEVICE_ID_DELL_RACIII,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b1_1_1382400 },
+	{
+		PCI_VDEVICE(DELL, PCI_DEVICE_ID_DELL_RACIII),
+		.driver_data = pbn_b1_1_1382400,
+	},
 
 	/*
 	 * RAStel 2 port modem, gerg@moreton.com.au
 	 */
-	{	PCI_VENDOR_ID_MORETON, PCI_DEVICE_ID_RASTEL_2PORT,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b2_bt_2_115200 },
+	{
+		PCI_VDEVICE(MORETON, PCI_DEVICE_ID_RASTEL_2PORT),
+		.driver_data = pbn_b2_bt_2_115200,
+	},
 
 	/*
 	 * EKF addition for i960 Boards form EKF with serial port
 	 */
-	{	PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_80960_RP,
-		0xE4BF, PCI_ANY_ID, 0, 0,
-		pbn_intel_i960 },
+	{
+		PCI_VDEVICE_SUB(INTEL, PCI_DEVICE_ID_INTEL_80960_RP,
+				0xE4BF, PCI_ANY_ID),
+		.driver_data = pbn_intel_i960,
+	},
 
 	/*
 	 * Xircom Cardbus/Ethernet combos
 	 */
-	{	PCI_VENDOR_ID_XIRCOM, PCI_DEVICE_ID_XIRCOM_X3201_MDM,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_115200 },
+	{
+		PCI_VDEVICE(XIRCOM, PCI_DEVICE_ID_XIRCOM_X3201_MDM),
+		.driver_data = pbn_b0_1_115200,
+	},
 	/*
 	 * Xircom RBM56G cardbus modem - Dirk Arnold (temp entry)
 	 */
-	{	PCI_VENDOR_ID_XIRCOM, PCI_DEVICE_ID_XIRCOM_RBM56G,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_115200 },
+	{
+		PCI_VDEVICE(XIRCOM, PCI_DEVICE_ID_XIRCOM_RBM56G),
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
+		PCI_VDEVICE_SUB(ROCKWELL, 0x1004, 0x1048, 0x1500),
+		.driver_data = pbn_b1_1_115200,
+	}, {
+		PCI_VDEVICE_SUB(SGI, PCI_DEVICE_ID_SGI_IOC3, 0xFF00, 0),
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
+		PCI_VDEVICE_SUB(HP, PCI_DEVICE_ID_HP_DIVA,
+				PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_DIVA_RMP3),
+		.driver_data = pbn_b1_1_115200,
+	}, {
+		PCI_VDEVICE(HP, PCI_DEVICE_ID_HP_DIVA),
+		.driver_data = pbn_b0_5_115200,
+	}, {
+		PCI_VDEVICE(HP, PCI_DEVICE_ID_HP_DIVA_AUX),
+		.driver_data = pbn_b2_1_115200,
+	}, {
+		/* HPE PCI serial device */
+		PCI_VDEVICE(HP_3PAR, PCI_DEVICE_ID_HPE_PCI_SERIAL),
+		.driver_data = pbn_b1_1_115200,
+	}, {
+		PCI_VDEVICE(DCI, PCI_DEVICE_ID_DCI_PCCOM2),
+		.driver_data = pbn_b3_2_115200,
+	}, {
+		PCI_VDEVICE(DCI, PCI_DEVICE_ID_DCI_PCCOM4),
+		.driver_data = pbn_b3_4_115200,
+	}, {
+		PCI_VDEVICE(DCI, PCI_DEVICE_ID_DCI_PCCOM8),
+		.driver_data = pbn_b3_8_115200,
+	}, {
+		/* Topic TP560 Data/Fax/Voice 56k modem (reported by Evan Clarke) */
+		PCI_VDEVICE(TOPIC, PCI_DEVICE_ID_TOPIC_TP560),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		/* ITE */
+		PCI_VDEVICE(ITE, PCI_DEVICE_ID_ITE_8872),
+		.driver_data = pbn_b1_bt_1_115200,
+	}, {
+		/* IntaShield IS-100 */
+		PCI_VDEVICE(INTASHIELD, 0x0D60),
+		.driver_data = pbn_b2_1_115200,
+	}, {
+		/* IntaShield IS-200; 135a.0d80 */
+		PCI_VDEVICE(INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS200),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		/* IntaShield IS-400; 135a.0dc0 */
+		PCI_VDEVICE(INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS400),
+		.driver_data = pbn_b2_4_115200,
+	}, {
+		/* IntaShield IX-100 */
+		PCI_VDEVICE(INTASHIELD, 0x4027),
+		.driver_data = pbn_oxsemi_1_15625000,
+	}, {
+		/* IntaShield IX-200 */
+		PCI_VDEVICE(INTASHIELD, 0x4028),
+		.driver_data = pbn_oxsemi_2_15625000,
+	}, {
+		/* IntaShield IX-400 */
+		PCI_VDEVICE(INTASHIELD, 0x4029),
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
+		PCI_VDEVICE(INTASHIELD, 0x0BA1),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x0BA2),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x0BA3),
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
+		PCI_VDEVICE(INTASHIELD, 0x0AA1),
+		.driver_data = pbn_b2_1_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x0AA2),
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
+		PCI_VDEVICE(INTASHIELD, 0x0CA1),
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
+		PCI_VDEVICE(INTASHIELD, 0x0D21),
+		.class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
+		.class_mask = 0xffff00,
+		.driver_data = pbn_b2_4_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x0E34),
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
+		PCI_VDEVICE(INTASHIELD, 0x0841),
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
+		PCI_VDEVICE(INTASHIELD, 0x0881),
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
+		PCI_VDEVICE(INTASHIELD, 0x08E1),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x08E2),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x08E3),
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
+		PCI_VDEVICE(INTASHIELD, 0x08C1),
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
+		PCI_VDEVICE(INTASHIELD, 0x08A1),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x08A2),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x08A3),
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
+		PCI_VDEVICE(INTASHIELD, 0x0A61),
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
+		PCI_VDEVICE(INTASHIELD, 0x0B01),
+		.driver_data = pbn_b2_4_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x0B02),
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
+		PCI_VDEVICE(INTASHIELD, 0x0A81),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x0A82),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x0A83),
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
+		PCI_VDEVICE(INTASHIELD, 0x0C41),
+		.driver_data = pbn_b2_4_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x0C42),
+		.driver_data = pbn_b2_4_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x0C43),
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
+		PCI_VDEVICE(INTASHIELD, 0x0921),
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
+		PCI_VDEVICE(INTASHIELD, 0x09A1),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x09A2),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x09A3),
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
+		PCI_VDEVICE(INTASHIELD, 0x0D41),
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
+		PCI_VDEVICE(INTASHIELD, 0x0AC1),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x0AC2),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x0AC3),
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
+		PCI_VDEVICE(INTASHIELD, 0x0B21),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x0B22),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x0B23),
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
+		PCI_VDEVICE(INTASHIELD, 0x0C01),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x0C02),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x0C03),
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
+		PCI_VDEVICE(INTASHIELD, 0x0C21),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x0C22),
+		.driver_data = pbn_b2_2_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x0C23),
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
+		PCI_VDEVICE(INTASHIELD, 0x4005),
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x4019),
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
+		PCI_VDEVICE(INTASHIELD, 0x4004),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x4016),
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
+		PCI_VDEVICE(INTASHIELD, 0x4006),
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x4015),
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
+		PCI_VDEVICE(INTASHIELD, 0x400A),
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
+		PCI_VDEVICE(INTASHIELD, 0x0E41),
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
+		PCI_VDEVICE(INTASHIELD, 0x400E),
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
+		PCI_VDEVICE(INTASHIELD, 0x400C),
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
+		PCI_VDEVICE(INTASHIELD, 0x400B),
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
+		PCI_VDEVICE(INTASHIELD, 0x400F),
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
+		PCI_VDEVICE(INTASHIELD, 0x4010),
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
+		PCI_VDEVICE(INTASHIELD, 0x4000),
+		.driver_data = pbn_b0_4_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x4011),
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
+		PCI_VDEVICE(INTASHIELD, 0x401D),
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
+		PCI_VDEVICE(INTASHIELD, 0x4009),
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x4018),
+		.driver_data = pbn_oxsemi_2_15625000,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x401E),
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
+		PCI_VDEVICE(INTASHIELD, 0x4002),
+		.driver_data = pbn_b0_4_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x4013),
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
+		PCI_VDEVICE(INTASHIELD, 0x4008),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_VDEVICE(INTASHIELD, 0x4017),
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
+		PCI_VDEVICE(INTASHIELD, 0x4026),
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
+		PCI_VDEVICE(INTASHIELD, 0x4021),
+		.driver_data = pbn_oxsemi_1_15625000,
+	},
 
 	/*
 	 * Perle PCI-RAS cards
 	 */
-	{       PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
-		PCI_SUBVENDOR_ID_PERLE, PCI_SUBDEVICE_ID_PCI_RAS4,
-		0, 0, pbn_b2_4_921600 },
-	{       PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
-		PCI_SUBVENDOR_ID_PERLE, PCI_SUBDEVICE_ID_PCI_RAS8,
-		0, 0, pbn_b2_8_921600 },
+	{
+		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9030,
+				PCI_SUBVENDOR_ID_PERLE, PCI_SUBDEVICE_ID_PCI_RAS4),
+		.driver_data = pbn_b2_4_921600,
+	},
+	{
+		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9030,
+				PCI_SUBVENDOR_ID_PERLE, PCI_SUBDEVICE_ID_PCI_RAS8),
+		.driver_data = pbn_b2_8_921600,
+	},
 
 	/*
 	 * Mainpine series cards: Fairly standard layout but fools
@@ -5725,375 +5737,343 @@ static const struct pci_device_id serial_pci_tbl[] = {
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
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x0200),
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		/* RockForceQUATRO */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x0300),
+		.driver_data = pbn_b0_4_115200,
+	}, {
+		/* RockForceDUO+ */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x0400),
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		/* RockForceQUATRO+ */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x0500),
+			.driver_data = pbn_b0_4_115200,
+	}, {
+		/* RockForce+ */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x0600),
+			.driver_data = pbn_b0_2_115200,
+	}, {
+		/* RockForce+ */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x0700),
+			.driver_data = pbn_b0_4_115200,
+	}, {
+		/* RockForceOCTO+ */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x0800),
+			.driver_data = pbn_b0_8_115200,
+	}, {
+		/* RockForceDUO+ */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x0C00),
+			.driver_data = pbn_b0_2_115200,
+	}, {
+		/* RockForceQUARTRO+ */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x0D00),
+			.driver_data = pbn_b0_4_115200,
+	}, {
+		/* RockForceOCTO+ */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x1D00),
+			.driver_data = pbn_b0_8_115200,
+	}, {
+		/* RockForceD1 */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x2000),
+			.driver_data = pbn_b0_1_115200,
+	}, {
+		/* RockForceF1 */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x2100),
+			.driver_data = pbn_b0_1_115200,
+	}, {	/* RockForceD2 */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x2200),
+			.driver_data = pbn_b0_2_115200,
+	}, {	/* RockForceF2 */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x2300),
+			.driver_data = pbn_b0_2_115200,
+	}, {
+		/* RockForceD4 */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x2400),
+			.driver_data = pbn_b0_4_115200,
+	}, {
+		/* RockForceF4 */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x2500),
+			.driver_data = pbn_b0_4_115200,
+	}, {
+		/* RockForceD8 */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x2600),
+			.driver_data = pbn_b0_8_115200,
+	}, {
+		/* RockForceF8 */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x2700),
+			.driver_data = pbn_b0_8_115200,
+	}, {
+		/* IQ Express D1 */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x3000),
+			.driver_data = pbn_b0_1_115200,
+	}, {
+		/* IQ Express F1 */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x3100),
+			.driver_data = pbn_b0_1_115200,
+	}, {
+		/* IQ Express D2 */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x3200),
+			.driver_data = pbn_b0_2_115200,
+	}, {
+		/* IQ Express F2 */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x3300),
+			.driver_data = pbn_b0_2_115200,
+	}, {
+		/* IQ Express D4 */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x3400),
+			.driver_data = pbn_b0_4_115200,
+	}, {
+		/* IQ Express F4 */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x3500),
+			.driver_data = pbn_b0_4_115200,
+	}, {
+		/* IQ Express D8 */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x3C00),
+			.driver_data = pbn_b0_8_115200,
+	}, {
+		/* IQ Express F8 */
+		PCI_VDEVICE_SUB(MAINPINE, PCI_DEVICE_ID_MAINPINE_PBRIDGE,
+				PCI_VENDOR_ID_MAINPINE, 0x3D00),
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
+		PCI_VDEVICE(PASEMI, 0xa004),
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
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PCI23216),
+		.driver_data = pbn_b1_16_115200,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PCI2328),
+		.driver_data = pbn_b1_8_115200,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PCI2324),
+		.driver_data = pbn_b1_bt_4_115200,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PCI2322),
+		.driver_data = pbn_b1_bt_2_115200,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PCI2324I),
+		.driver_data = pbn_b1_bt_4_115200,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PCI2322I),
+		.driver_data = pbn_b1_bt_2_115200,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PXI8420_23216),
+		.driver_data = pbn_b1_16_115200,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PXI8420_2328),
+		.driver_data = pbn_b1_8_115200,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PXI8420_2324),
+		.driver_data = pbn_b1_bt_4_115200,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PXI8420_2322),
+		.driver_data = pbn_b1_bt_2_115200,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PXI8422_2324),
+		.driver_data = pbn_b1_bt_4_115200,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PXI8422_2322),
+		.driver_data = pbn_b1_bt_2_115200,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PXI8430_2322),
+		.driver_data = pbn_ni8430_2,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PCI8430_2322),
+		.driver_data = pbn_ni8430_2,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PXI8430_2324),
+		.driver_data = pbn_ni8430_4,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PCI8430_2324),
+		.driver_data = pbn_ni8430_4,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PXI8430_2328),
+		.driver_data = pbn_ni8430_8,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PCI8430_2328),
+		.driver_data = pbn_ni8430_8,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PXI8430_23216),
+		.driver_data = pbn_ni8430_16,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PCI8430_23216),
+		.driver_data = pbn_ni8430_16,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PXI8432_2322),
+		.driver_data = pbn_ni8430_2,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PCI8432_2322),
+		.driver_data = pbn_ni8430_2,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PXI8432_2324),
+		.driver_data = pbn_ni8430_4,
+	}, {
+		PCI_VDEVICE(NI, PCI_DEVICE_ID_NI_PCI8432_2324),
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
-		PCI_DEVICE_ID_ADDIDATA_APCI7500,
-		PCI_ANY_ID,
-		PCI_ANY_ID,
-		0,
-		0,
-		pbn_b0_4_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
-		PCI_DEVICE_ID_ADDIDATA_APCI7420,
-		PCI_ANY_ID,
-		PCI_ANY_ID,
-		0,
-		0,
-		pbn_b0_2_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
-		PCI_DEVICE_ID_ADDIDATA_APCI7300,
-		PCI_ANY_ID,
-		PCI_ANY_ID,
-		0,
-		0,
-		pbn_b0_1_115200 },
-
-	{	PCI_VENDOR_ID_AMCC,
-		PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800,
-		PCI_ANY_ID,
-		PCI_ANY_ID,
-		0,
-		0,
-		pbn_b1_8_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
-		PCI_DEVICE_ID_ADDIDATA_APCI7500_2,
-		PCI_ANY_ID,
-		PCI_ANY_ID,
-		0,
-		0,
-		pbn_b0_4_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
-		PCI_DEVICE_ID_ADDIDATA_APCI7420_2,
-		PCI_ANY_ID,
-		PCI_ANY_ID,
-		0,
-		0,
-		pbn_b0_2_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
-		PCI_DEVICE_ID_ADDIDATA_APCI7300_2,
-		PCI_ANY_ID,
-		PCI_ANY_ID,
-		0,
-		0,
-		pbn_b0_1_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
-		PCI_DEVICE_ID_ADDIDATA_APCI7500_3,
-		PCI_ANY_ID,
-		PCI_ANY_ID,
-		0,
-		0,
-		pbn_b0_4_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
-		PCI_DEVICE_ID_ADDIDATA_APCI7420_3,
-		PCI_ANY_ID,
-		PCI_ANY_ID,
-		0,
-		0,
-		pbn_b0_2_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
-		PCI_DEVICE_ID_ADDIDATA_APCI7300_3,
-		PCI_ANY_ID,
-		PCI_ANY_ID,
-		0,
-		0,
-		pbn_b0_1_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
-		PCI_DEVICE_ID_ADDIDATA_APCI7800_3,
-		PCI_ANY_ID,
-		PCI_ANY_ID,
-		0,
-		0,
-		pbn_b0_8_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
-		PCI_DEVICE_ID_ADDIDATA_APCIe7500,
-		PCI_ANY_ID,
-		PCI_ANY_ID,
-		0,
-		0,
-		pbn_ADDIDATA_PCIe_4_3906250 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
-		PCI_DEVICE_ID_ADDIDATA_APCIe7420,
-		PCI_ANY_ID,
-		PCI_ANY_ID,
-		0,
-		0,
-		pbn_ADDIDATA_PCIe_2_3906250 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
-		PCI_DEVICE_ID_ADDIDATA_APCIe7300,
-		PCI_ANY_ID,
-		PCI_ANY_ID,
-		0,
-		0,
-		pbn_ADDIDATA_PCIe_1_3906250 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
-		PCI_DEVICE_ID_ADDIDATA_APCIe7800,
-		PCI_ANY_ID,
-		PCI_ANY_ID,
-		0,
-		0,
-		pbn_ADDIDATA_PCIe_8_3906250 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
-		PCI_DEVICE_ID_ADDIDATA_CPCI7500,
-		PCI_ANY_ID,
-		PCI_ANY_ID,
-		0,
-		0,
-		pbn_b0_4_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
-		PCI_DEVICE_ID_ADDIDATA_CPCI7500_NG,
-		PCI_ANY_ID,
-		PCI_ANY_ID,
-		0,
-		0,
-		pbn_b0_4_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
-		PCI_DEVICE_ID_ADDIDATA_CPCI7420_NG,
-		PCI_ANY_ID,
-		PCI_ANY_ID,
-		0,
-		0,
-		pbn_b0_2_115200 },
-
-	{	PCI_VENDOR_ID_ADDIDATA,
-		PCI_DEVICE_ID_ADDIDATA_CPCI7300_NG,
-		PCI_ANY_ID,
-		PCI_ANY_ID,
-		0,
-		0,
-		pbn_b0_1_115200 },
-
-	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
-		PCI_VENDOR_ID_IBM, 0x0299,
-		0, 0, pbn_b0_bt_2_115200 },
+	{
+		PCI_VDEVICE(ADDIDATA, PCI_DEVICE_ID_ADDIDATA_APCI7500),
+		.driver_data = pbn_b0_4_115200,
+	}, {
+		PCI_VDEVICE(ADDIDATA, PCI_DEVICE_ID_ADDIDATA_APCI7420),
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		PCI_VDEVICE(ADDIDATA, PCI_DEVICE_ID_ADDIDATA_APCI7300),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_VDEVICE(AMCC, PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800),
+		.driver_data = pbn_b1_8_115200,
+	}, {
+		PCI_VDEVICE(ADDIDATA, PCI_DEVICE_ID_ADDIDATA_APCI7500_2),
+		.driver_data = pbn_b0_4_115200,
+	}, {
+		PCI_VDEVICE(ADDIDATA, PCI_DEVICE_ID_ADDIDATA_APCI7420_2),
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		PCI_VDEVICE(ADDIDATA, PCI_DEVICE_ID_ADDIDATA_APCI7300_2),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_VDEVICE(ADDIDATA, PCI_DEVICE_ID_ADDIDATA_APCI7500_3),
+		.driver_data = pbn_b0_4_115200,
+	}, {
+		PCI_VDEVICE(ADDIDATA, PCI_DEVICE_ID_ADDIDATA_APCI7420_3),
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		PCI_VDEVICE(ADDIDATA, PCI_DEVICE_ID_ADDIDATA_APCI7300_3),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_VDEVICE(ADDIDATA, PCI_DEVICE_ID_ADDIDATA_APCI7800_3),
+		.driver_data = pbn_b0_8_115200,
+	}, {
+		PCI_VDEVICE(ADDIDATA, PCI_DEVICE_ID_ADDIDATA_APCIe7500),
+		.driver_data = pbn_ADDIDATA_PCIe_4_3906250,
+	}, {
+		PCI_VDEVICE(ADDIDATA, PCI_DEVICE_ID_ADDIDATA_APCIe7420),
+		.driver_data = pbn_ADDIDATA_PCIe_2_3906250,
+	}, {
+		PCI_VDEVICE(ADDIDATA, PCI_DEVICE_ID_ADDIDATA_APCIe7300),
+		.driver_data = pbn_ADDIDATA_PCIe_1_3906250,
+	}, {
+		PCI_VDEVICE(ADDIDATA, PCI_DEVICE_ID_ADDIDATA_APCIe7800),
+		.driver_data = pbn_ADDIDATA_PCIe_8_3906250,
+	}, {
+		PCI_VDEVICE(ADDIDATA, PCI_DEVICE_ID_ADDIDATA_CPCI7500),
+		.driver_data = pbn_b0_4_115200,
+	}, {
+		PCI_VDEVICE(ADDIDATA, PCI_DEVICE_ID_ADDIDATA_CPCI7500_NG),
+		.driver_data = pbn_b0_4_115200,
+	}, {
+		PCI_VDEVICE(ADDIDATA, PCI_DEVICE_ID_ADDIDATA_CPCI7420_NG),
+		.driver_data = pbn_b0_2_115200,
+	}, {
+		PCI_VDEVICE(ADDIDATA, PCI_DEVICE_ID_ADDIDATA_CPCI7300_NG),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_VDEVICE_SUB(NETMOS, PCI_DEVICE_ID_NETMOS_9835,
+				PCI_VENDOR_ID_IBM, 0x0299),
+		.driver_data = pbn_b0_bt_2_115200,
+	},
 
 	/*
 	 * other NetMos 9835 devices are most likely handled by the
@@ -6101,157 +6081,183 @@ static const struct pci_device_id serial_pci_tbl[] = {
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
+		PCI_VDEVICE_SUB(NETMOS, PCI_DEVICE_ID_NETMOS_9901,
+				0xA000, 0x1000),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		/* the 9901 is a rebranded 9912 */
+		PCI_VDEVICE_SUB(NETMOS, PCI_DEVICE_ID_NETMOS_9912,
+				0xA000, 0x1000),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_VDEVICE_SUB(NETMOS, PCI_DEVICE_ID_NETMOS_9922,
+				0xA000, 0x1000),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_VDEVICE_SUB(NETMOS, PCI_DEVICE_ID_NETMOS_9904,
+				0xA000, 0x1000),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_VDEVICE_SUB(NETMOS, PCI_DEVICE_ID_NETMOS_9900,
+				0xA000, 0x1000),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_VDEVICE_SUB(NETMOS, PCI_DEVICE_ID_NETMOS_9900,
+				0xA000, 0x3002),
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
+		PCI_VDEVICE_SUB(NETMOS, PCI_DEVICE_ID_NETMOS_9865,
+				0xA000, 0x1000),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_VDEVICE_SUB(NETMOS, PCI_DEVICE_ID_NETMOS_9865,
+				0xA000, 0x3002),
+		.driver_data = pbn_b0_bt_2_115200,
+	}, {
+		PCI_VDEVICE_SUB(NETMOS, PCI_DEVICE_ID_NETMOS_9865,
+				0xA000, 0x3004),
+		.driver_data = pbn_b0_bt_4_115200,
+	},
 
 	/*
 	 * ASIX AX99100 PCIe to Multi I/O Controller
 	 */
-	{	PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_AX99100,
-		0xA000, 0x1000,
-		0, 0, pbn_b0_1_115200 },
+	{
+		PCI_VDEVICE_SUB(ASIX, PCI_DEVICE_ID_ASIX_AX99100,
+				0xA000, 0x1000),
+		.driver_data = pbn_b0_1_115200,
+	},
 
 	/* Intel CE4100 */
-	{	PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CE4100_UART,
-		PCI_ANY_ID,  PCI_ANY_ID, 0, 0,
-		pbn_ce4100_1_115200 },
+	{
+		PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_CE4100_UART),
+		.driver_data = pbn_ce4100_1_115200,
+	},
 
 	/*
 	 * Cronyx Omega PCI
 	 */
-	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_CRONYX_OMEGA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_omegapci },
+	{
+		PCI_VDEVICE(PLX, PCI_DEVICE_ID_PLX_CRONYX_OMEGA),
+		.driver_data = pbn_omegapci,
+	},
 
 	/*
 	 * Broadcom TruManage
 	 */
-	{	PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BROADCOM_TRUMANAGE,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_brcm_trumanage },
+	{
+		PCI_VDEVICE(BROADCOM, PCI_DEVICE_ID_BROADCOM_TRUMANAGE),
+		.driver_data = pbn_brcm_trumanage,
+	},
 
 	/*
 	 * AgeStar as-prs2-009
 	 */
-	{	PCI_VENDOR_ID_AGESTAR, PCI_DEVICE_ID_AGESTAR_9375,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, pbn_b0_bt_2_115200 },
+	{
+		PCI_VDEVICE(AGESTAR, PCI_DEVICE_ID_AGESTAR_9375),
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
+		PCI_VDEVICE(WCHCN, PCI_DEVICE_ID_WCHCN_CH353_4S),
+		.driver_data = pbn_b0_bt_4_115200,
+	}, {
+		PCI_VDEVICE(WCHCN, PCI_DEVICE_ID_WCHCN_CH353_2S1PF),
+		.driver_data = pbn_b0_bt_2_115200,
+	}, {
+		PCI_VDEVICE(WCHCN, PCI_DEVICE_ID_WCHCN_CH355_4S),
+		.driver_data = pbn_b0_bt_4_115200,
+	}, {
+		PCI_VDEVICE(WCHIC, PCI_DEVICE_ID_WCHIC_CH382_2S),
+		.driver_data = pbn_wch382_2,
+	}, {
+		PCI_VDEVICE(WCHIC, PCI_DEVICE_ID_WCHIC_CH384_4S),
+		.driver_data = pbn_wch384_4,
+	}, {
+		PCI_VDEVICE(WCHIC, PCI_DEVICE_ID_WCHIC_CH384_8S),
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
+		PCI_VDEVICE(REALTEK, 0x816a),
+		.driver_data = pbn_b0_1_115200,
+	}, {
+		PCI_VDEVICE(REALTEK, 0x816b),
+		.driver_data = pbn_b0_1_115200,
+	},
 
 	/* Systembase Multi I/O cards */
-	{ PCI_VDEVICE(SYSTEMBASE, 0x0008), pbn_b0_8_921600 },
+	{
+		PCI_VDEVICE(SYSTEMBASE, 0x0008),
+		.driver_data = pbn_b0_8_921600,
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
-		PCI_ANY_ID, PCI_ANY_ID,
-		PCI_CLASS_COMMUNICATION_SERIAL << 8,
-		0xffff00, pbn_default },
-	{	PCI_ANY_ID, PCI_ANY_ID,
-		PCI_ANY_ID, PCI_ANY_ID,
-		PCI_CLASS_COMMUNICATION_MODEM << 8,
-		0xffff00, pbn_default },
-	{	PCI_ANY_ID, PCI_ANY_ID,
-		PCI_ANY_ID, PCI_ANY_ID,
-		PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
-		0xffff00, pbn_default },
-	{ 0, }
+	{
+		PCI_DEVICE_CLASS(PCI_CLASS_COMMUNICATION_SERIAL << 8, 0xffff00),
+		.driver_data = pbn_default,
+	}, {
+		PCI_DEVICE_CLASS(PCI_CLASS_COMMUNICATION_MODEM << 8, 0xffff00),
+		.driver_data = pbn_default,
+	}, {
+		PCI_DEVICE_CLASS(PCI_CLASS_COMMUNICATION_MULTISERIAL << 8, 0xffff00),
+		.driver_data = pbn_default,
+	},
+	{ }
 };
 
 static pci_ers_result_t serial8250_io_error_detected(struct pci_dev *dev,

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
prerequisite-patch-id: a31e1d7b9e6310e9c453afcd2037468686cb552c
prerequisite-patch-id: 7779c63f16ef6f7247cdb71c89e66b27e299eb74
prerequisite-patch-id: 6f920b6f8c31dc0ad1689200c37680755c20ce8b
prerequisite-patch-id: d0d54f7acecd560cdeb6ea0c0e5ae77a50695d68
prerequisite-patch-id: 1fd68e883664147052540eea19769ea9e92d0138
prerequisite-patch-id: fff07090df18a39a361bbb091a3f17223b4606b4
-- 
2.47.3

