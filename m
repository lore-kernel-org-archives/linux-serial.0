Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AE01891AB;
	Tue, 21 Jan 2025 07:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737443918; cv=none; b=UchzP3aqMKc3qS4asRalUa87Clzg6Qs6juBG5is2nLsEfCtyxDNZKZlJDl5pL4TCQ3DJz+c0UnkEBA67KKxYazuoYiTpPfGX3u4pXse1/bqASmSOPgsWzItmDKMZ8Y/ybwnAQO5FJtBMTTdkNQj5aNkBT0OdHIkseV5Ehyl8BJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737443918; c=relaxed/simple;
	bh=e0mjIAIvR09AkyymerNITCIpdq9s6E+b17uxOKf3pwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eYiJr/eJNvAD1t3X4ImTeDRnG2w1WEVoAK97r4sU6uNjZKNy3um/XaE1RaNCITbBCzO5hYeG3R7hH9Yw+BbHmrdUObi0cwxpoR+jO2BumwPWu58swOJ28uoJx1ynwqF04KKuWyWCw0XMbIyEirqD8kKJruMTSNkm4jgBuNClAF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=STUXmvIq; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="STUXmvIq"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id CE94994016B0;
	Tue, 21 Jan 2025 08:18:27 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id JLQs50ooaeWm; Tue, 21 Jan 2025 08:18:27 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id A85E494016B8;
	Tue, 21 Jan 2025 08:18:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com A85E494016B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1737443907; bh=sphf/MpbKuVV5P349dEFXng0WPX6tR9YF0ADjA+yzBo=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=STUXmvIqjdeoujuqTZzL/CkH7TNSS51oh1NvZazt4wVL9nJJ9Xlq6C4a1RUc1UtfS
	 DHG8Xhn/ACS34PSN2UedQpzUR0Yls+TPvpgpokXVD999mhycqa7TC3qzqtzKZWZJeR
	 nBjeOId0rn/LoKDgC/q82B6Nl9TDeFEeBR8ik4g4MgKzRegl08JgKtvUYznshRBKSx
	 I4Nlb9yJELyEZoRjPhM5QHPOBZaC7KbSgtn6zDe6OrvSeYzZuaP4R8oaVXW9fv0TRa
	 YVfpQG+Xh88RiiFqSLG2/OGV0w28RPC2n4vJonYmG2ERCCfW6rytdQL+pWAITM9HOs
	 3xJ4TgIMKkLkg==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id FRkCQG_hPAWj; Tue, 21 Jan 2025 08:18:27 +0100 (CET)
Received: from ws565760.. (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 5E3B194016B0;
	Tue, 21 Jan 2025 08:18:27 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hvilleneuve@dimonoff.com,
	andy@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lech.perczak@camlingroup.com,
	Maarten.Brock@sttls.nl,
	Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH v4] serial: sc16is7xx: Fix IRQ number check behavior
Date: Tue, 21 Jan 2025 08:18:19 +0100
Message-ID: <20250121071819.1346672-1-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The logical meaning of the previous version is wrong due to a typo.

If the IRQ equals 0, no interrupt pin is available and polling mode
shall be used.

Additionally, this fix adds a check for IRQ < 0 to increase robustness,
because documentation still says that negative IRQ values cannot be
absolutely ruled-out.

Fixes: 104c1b9dde9d859dd01bd2d ("serial: sc16is7xx: Add polling mode if n=
o IRQ pin is available")

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
---
V2:
There are no changes to the patch itself. The previous patch submission
had a very weird structure within the discussion thread:
https://lore.kernel.org/all/20250116093203.460215-1-andre.werner@systec-e=
lectronic.com/
This is simply a new thread opened for better handling.
V3:
Add Fixes tag and update commit message description.
V4:
Rephrase commit message.
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7x=
x.c
index 7b51cdc274fd..560f45ed19ae 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1561,7 +1561,7 @@ int sc16is7xx_probe(struct device *dev, const struc=
t sc16is7xx_devtype *devtype,
 	/* Always ask for fixed clock rate from a property. */
 	device_property_read_u32(dev, "clock-frequency", &uartclk);
=20
-	s->polling =3D !!irq;
+	s->polling =3D (irq <=3D 0);
 	if (s->polling)
 		dev_dbg(dev,
 			"No interrupt pin definition, falling back to polling mode\n");
--=20
2.48.0

