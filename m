Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28D425A643;
	Fri, 17 Jan 2025 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737134318; cv=none; b=ZAukBo0V3gl76S97erYpxfRANDep/hEj3BRur2h3XXKalGFUM0j6E4IlMh36QmkFOVZQfeQfGuiEzzETez4fEOMP19nRSgU5/rMoF2u/fVeJzpz/rFXuRMLIdOrPhKedLuIObKjygjyQUC4E2nHHyZGtZ4gkd7yFEEbNsI41UKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737134318; c=relaxed/simple;
	bh=4PrXiveGZKNZge81P3vjBVwgLfYHhIVF3Q9brW0znoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uwDh7zO7qKKdY4OJYGHge5rjPyp6Vu3faclBn5OH2/kcvaBm6JYAr4OL2Y5pZ2yrSfa05a53pxShmoZGl02CqUuX9P6delXvmHqq+inlEyrT80aT9iaQDzwl151ikV0XF9aXmbgG+6YLS46kRpgHP0bzUw1lzQ2CcA+FcudwZs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=hh4QWKKj; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="hh4QWKKj"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id E8BB29400109;
	Fri, 17 Jan 2025 18:18:25 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id I1ftgrEjNNMY; Fri, 17 Jan 2025 18:18:25 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id BC8B2940010A;
	Fri, 17 Jan 2025 18:18:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com BC8B2940010A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1737134305; bh=yegHBCc7QKZmhTb2e7C9tWvi0MY9a5iriP+r8QZZgdE=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=hh4QWKKj1YqLJuZj5n/iSHYCxVCLYUo2JrKVwZBLM8Zu2newNMSzAC6MkKqB1pLEw
	 3av50O9nDTFsZPq82IByuAQulbMPEJxR0z5sG18O++2MgAMmTtCDfoiJTLP6XspgTQ
	 LIIx1BbF/BSNFDHTkuxi+XA9PB1WFW0qCvBwx8HatZZa1F+50RTtYwZCcbHZuwhKBV
	 q7CnuDROTk0ZdcCs7P3krherTKO8cbV47SGxjZ35M1ImO71PTXf8W8b1kSyVKwOQyH
	 zltPe4f2nf025bze1ib+O8d9aGHoHQ5UQWLq3wSQh+kqlUnkq0Cv7IF2EJ7t56n/hp
	 jp52PJ67q810A==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id oruwbIBdkqe8; Fri, 17 Jan 2025 18:18:25 +0100 (CET)
Received: from ws565760.. (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 73ACE9400109;
	Fri, 17 Jan 2025 18:18:25 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hvilleneuve@dimonoff.com,
	andy@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lech.perczak@camlingroup.com,
	Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH v2] serial: sc16is7xx: Extend IRQ check for negative values
Date: Fri, 17 Jan 2025 18:18:22 +0100
Message-ID: <20250117171822.775876-1-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix the IRQ check to treat the negative values as No IRQ.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
---
V2:
There are no changes to the patch itself. The previous patch submission
had a very weird structure within the discussion thread:
https://lkml.org/lkml/2025/1/16/398
This is simply a new thread opened for better handling.
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

