Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6024B24A7E8;
	Thu, 16 Jan 2025 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019931; cv=none; b=jSCqqY9a6GTA1I2NCj8YVcy+rIN82MBiTa6p2ZrigFtnWO/e/VWl/aHdtVewshUlYXBmMrsjjOHba50NPpeFa9OHXVYIh5jUomgQChdtQ5BSSSu1w+8acjG1qFPpFPgcdKD4zWwzrGx1Q1q4DDc9Rl/esMnw+4VnQdby7s4OpXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019931; c=relaxed/simple;
	bh=lIN7P90ftjeYJvHdDPHU9m/e47bSQRwdqf8ZxIgfcSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaBOuI+xI3ohkOBuiMtfys5phrOYKNUGhJcdwD8DsOH62AxTz9Z66iEV3anw3p8VHzl7t1Xh5bVl5Uz7hz6Z1k2qaJ7/+CEO1sybHPekTbM8IrXNp+gVrjxKvRHsYQivgtyNj9NKMu6JKzkWiPK9yXKj+7NhOmcLmpY9oDYO+8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=M32wdg4h; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="M32wdg4h"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 7F1D2941A5C2;
	Thu, 16 Jan 2025 10:32:07 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id CQrheBnyeH4q; Thu, 16 Jan 2025 10:32:07 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 54B2C941A5C4;
	Thu, 16 Jan 2025 10:32:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 54B2C941A5C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1737019927; bh=EmuGLc7hyUVKP+KRilFrQ0kcjMKMQqLXNfk92sc5DuM=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=M32wdg4hea+r5DUpHi6cCHRQcg2hgr6G3LZTgI/IWTpSNetauPervYF+eEH1oRE/R
	 1FgPg4gSl9eSM3nQyxF4aVBtSOxzb/3b5U2uIwFmR/GC+bQnWpI6P/pS30CXAU70oM
	 /tPkm/f7EygDEisBGL7/53mE79oTgFuIYm7jf2p4Q3It2+7Bon/jwk+UdUR/EwfHSp
	 EJv5h1nuKOqjAHc2ukLDGI/fVcn10PrHCVZ2vKR8G+JUDtdQeGKsc2Y7Rwgwlts3Re
	 +bcyVfFqnnaa1yFLRc4FxYP6U3FpKGKVma6rEJCiX/u6kgdvGbMQXNP35FKxUw07Ct
	 MCy+iwLWXnycQ==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id dR02InO0rTLw; Thu, 16 Jan 2025 10:32:07 +0100 (CET)
Received: from ws565760.. (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id CE4E5941A5C2;
	Thu, 16 Jan 2025 10:32:06 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hvilleneuve@dimonoff.com,
	andy@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lech.perczak@camlingroup.com,
	Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH v1] serial: sc16is7xx: Extend IRQ check for negative valus
Date: Thu, 16 Jan 2025 10:32:03 +0100
Message-ID: <20250116093203.460215-1-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <Z4jLU75SU53VGsRU@smile.fi.intel.com>
References: <Z4jLU75SU53VGsRU@smile.fi.intel.com>
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

