Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39154197A8B;
	Thu, 16 Jan 2025 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737016505; cv=none; b=CoksiHgvFR4cGAHoq325LUpAme6/uEzHp+qndw+4n7f0JsfpDrTq0YE+gRZqrUV+2YtRH3mtSuaq9kWvJ3jiJBH7B1wxuIVPfXbuwZL318qGB9p+DXahCED1Gd5DayyXTdfkV2eTiYLSONUzA8XNOXxdkMUGbBg/jN7PkRT+DTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737016505; c=relaxed/simple;
	bh=H7hgqIkekRzIXoLmR3VUlIlz5d57PEdzxR8VBzE4Htc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5uZ6v6zAD/Xus/W/F8Lz1F/cqO3WspLLpHZ4kdbhySLAXf32uppnCP47b+GL9VJHSzVOIjhgsj5lBdN8qhdOcz3EVhhb0OFohD6ilNGvfiTOU2HiLeCvLTiO7pQWYCc1WQsexU81H6kxq02UL1mSz/tqSoSNbGA+Owcob9fm4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=Al3ScE+d; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="Al3ScE+d"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 8FBDB941A5C4;
	Thu, 16 Jan 2025 09:34:54 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id VHuVqWKbc2eR; Thu, 16 Jan 2025 09:34:54 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 67AD9941A5C5;
	Thu, 16 Jan 2025 09:34:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 67AD9941A5C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1737016494; bh=Pu0Amd2RPZzblyT2QHOYqs2IO/DVPufLr9cfl9fOv+E=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=Al3ScE+djaGqcaRpNElrrp3KXlSePs/i/ZGssBVSpNl6rbzpaulAAVS6XOrBGuIKx
	 SPROtC72A5WlkfkqFiejqdAeTwGocUovD/ETxufbRlqMtrhY40YgbsbFNUoDu/iRe4
	 j/+qz+04ZdRGJ5buoWR/jXKrUd91Y0MjwEturRto64tisyrNJfFm7AxFDL9ECifaZJ
	 OFen52z+QDu/++9hP8QwHxGV1Ej2jIqYy/yBgToq6aW0Hi3PRpMJtL9OmUpgi+3G39
	 mPHprzerXYQrGQ3vK880n5gFj/RUJe20dUjerJ/fmAKfJ7gYa6wvv+jqTxsbW5Vr9I
	 p4Hl8WydL5m5A==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Y2VPxt_55F37; Thu, 16 Jan 2025 09:34:54 +0100 (CET)
Received: from ws565760.. (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 0F264941A5C4;
	Thu, 16 Jan 2025 09:34:54 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hvilleneuve@dimonoff.com,
	andy@kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lech.perczak@camlingroup.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH v7] serial: sc16is7xx: Add polling mode if no IRQ pin is available
Date: Thu, 16 Jan 2025 09:34:47 +0100
Message-ID: <20250116083447.453615-1-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <CAHp75Vc==m3mE1TtxjHnpwL-d8W4rFnKreu7XB7MWspJKCCOGA@mail.gmail.com>
References: <CAHp75Vc==m3mE1TtxjHnpwL-d8W4rFnKreu7XB7MWspJKCCOGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fall back to polling mode if no interrupt is configured because there
is no possibility to connect the interrupt pin.

If no interrupt pin is available the driver uses a delayed worker to
poll the state of interrupt status registers (IIR).

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
Link: https://lore.kernel.org/r/20250110073104.1029633-2-andre.werner@sys=
tec-electronic.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
V2:
- Change warning for polling mode to debug log entry
- Correct typo: Resuse -> Reuse
- Format define with missing tabs for SC16IS7XX_POLL_PERIOD
- Format struct declaration sc16is7xx_one_config with missing tabs for po=
lling and shutdown
- Adapt dtbinding with new polling feature
V3:
- Use suffix with units and drop a comment SC16IS7XX_POLL_PERIOD_MS. Sorr=
y for that miss.
- Make Kernel lowercase.
V4:
- Reword commit messages for better understanding.
- Remove 'shutdown' property for canceling delayed worker.
- Rename worker function: sc16is7xx_transmission_poll -> sc16is7xx_poll_p=
roc
- Unify argument for worker functions: kthread_work *work -> kthread_work=
 *ws
V5:
- Replace of_property check with IRQ number check to set polling
  property. This will add support for usage without device tree
  definitions. Thanks for that advice.
- Add blank line es requested.
V6:
- Use polling mode for IRQ numbers <=3D 0 which encounter no valid IRQ
  were found/defined.
V7:
- Try to improve and unify comments as requested.
- Fix typo in commit message: pull -> poll
---
 drivers/tty/serial/sc16is7xx.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7x=
x.c
index 7b51cdc274fd..348ddc3103cd 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -868,10 +868,12 @@ static void sc16is7xx_poll_proc(struct kthread_work=
 *ws)
 {
 	struct sc16is7xx_port *s =3D container_of(ws, struct sc16is7xx_port, po=
ll_work.work);
=20
-	/* Reuse standard IRQ handler. Interrupt ID is unused in this context. =
*/
+	/*
+	 * Reuse standard IRQ handler. Interrupt ID is unused in this
+	 * context and set to zero.
+	 */
 	sc16is7xx_irq(0, s);
=20
-	/* Setup delay based on SC16IS7XX_POLL_PERIOD_MS */
 	kthread_queue_delayed_work(&s->kworker, &s->poll_work,
 				   msecs_to_jiffies(SC16IS7XX_POLL_PERIOD_MS));
 }
@@ -1561,7 +1563,7 @@ int sc16is7xx_probe(struct device *dev, const struc=
t sc16is7xx_devtype *devtype,
 	/* Always ask for fixed clock rate from a property. */
 	device_property_read_u32(dev, "clock-frequency", &uartclk);
=20
-	s->polling =3D !!irq;
+	s->polling =3D (irq <=3D 0);
 	if (s->polling)
 		dev_dbg(dev,
 			"No interrupt pin definition, falling back to polling mode\n");
@@ -1694,7 +1696,7 @@ int sc16is7xx_probe(struct device *dev, const struc=
t sc16is7xx_devtype *devtype,
 #endif
=20
 	if (s->polling) {
-		/* Initialize kernel thread for polling */
+		/* Initialize a kthread work struct that is dedicated to polling */
 		kthread_init_delayed_work(&s->poll_work, sc16is7xx_poll_proc);
 		return 0;
 	}
--=20
2.48.0

