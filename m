Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA1C481CD;
	Mon, 20 Jan 2025 07:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737358369; cv=none; b=OlhnBwle1CgdbrdoPZJV3vefuhlv81+kHOk6X1VjcMOU/apZYnpiF1O6nFCkL2C2ouYX8ptCfhbEA5aINFMvbRyE/MQ2YCMGMBh74QcBYgdqoJSEgkjqAGAH8aBFXqjzEOhBvN29RPubLwErJsu71w3GPPb2J5vHk4REK01oSYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737358369; c=relaxed/simple;
	bh=7N/iOVQ67nvx/H36sN1C3IAYlW/kVAKC0o0rph8NvX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p9EvJdRsacFFHB2MhBOOotiTigTWmFmU5dfGgw4XsAF4QghtyNF1hZRESVtWNfYNUaLrfwrI74kxzRQ+DG6iAwX1Ui+OXcpvRyTKj5l7w8nlS+Qd6PTG9aXTWyKbb+epiS/ARR8wIdHyU7eeD+TZzaqLk4+UXAQyXh5bD+L+jhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=KsFKFhSV; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="KsFKFhSV"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id C68EC940168D;
	Mon, 20 Jan 2025 08:32:36 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Z8uRVxtcW6RP; Mon, 20 Jan 2025 08:32:36 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id A0D1D94016AD;
	Mon, 20 Jan 2025 08:32:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com A0D1D94016AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1737358356; bh=7HasRdKf5GmUzP+im2V7DHoeO1Szrg+8/6/OsrYHzeg=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=KsFKFhSV6U8fWYSG8yD9wsAuz5GoAe6T45M2UA4T3Tyys5i25e7phlfEggJDAe4LJ
	 gjOVwtX1y8vgICs8KbCz8bBOsyo+o3UNVbGlX4bji7qqeiQBU9Q1Ny4uDtuYcnjv9h
	 /4SzhQ1paBD3YJTyFtVR6WcHHUVEOqgb3QltmZIj4k7Hbg1MjL9/RASs+2bMeu1qOS
	 Ql1YohfhJ5XUOFIeHcJLOf9AoH4wDbiMtLuEgv3WP+XOMe+6GZQSDC7Hy8cUUKJsj3
	 WsCnzmW3dKXhjyYlEgHnGpw+O8fRJi0m1JDyP1VqJeUVg087bYsYfhfkvgbdA8Gl2r
	 jsRgytpn+fIqg==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id pqDWEQWEdzQF; Mon, 20 Jan 2025 08:32:36 +0100 (CET)
Received: from ws565760.. (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 5B475940168D;
	Mon, 20 Jan 2025 08:32:36 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hvilleneuve@dimonoff.com,
	andy@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lech.perczak@camlingroup.com,
	Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH v3] serial: sc16is7xx: Fix IRQ number check behavior
Date: Mon, 20 Jan 2025 08:32:34 +0100
Message-ID: <20250120073234.790315-1-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The logical meaning of the previous version is wrong due to a typo.
The rest of the patch expects polling =3D true for irq =3D 0;

The behaviour is fixed for irq =3D 0 as well as extended to negative
values because the irq parameter is an integer such that negative values
are not completely impossible. So negative values will also be treated as
a fallback to polling mode.

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

