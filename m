Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E82D202963
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783551932; cv=none; b=V5mZvQ3l4hir0VB4b69TWhU4en+yXnD7Bf21eiuCs+GXhOmcX5l5K77MzSVuc+V+uy8WnTvvp9l1bYQCoccpf2NDyw8XjW00aEqU+TlVl2k/0huDUa2SogzGX2RF1hii5lv6WRrZj4bAYkdBKpln5EgFfAoXShX2COYmG5SvyMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783551932; c=relaxed/simple;
	bh=pxwFae8oQYIJ+tVbS+0gejs3gvGftrxImNMdrZuamc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=G8tXZri4XUKpTdVl8BEMPho/JrhEXGOcCT3rCGSwPys8QrZuHVe10wVnsaIhuSw4J63kpfbBXPNH55z+xv1L9eikfzVLlpRV+AhZ8xxoywBZtSFvQlXyEE/23Jw0MqiMu7VcjkCvFZ7EAzwS9gZ9/ow5GiHYRYN8u8rIKXrbEd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bbp1+VGV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bbp1+VGV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6C81F000E9;
	Wed,  8 Jul 2026 23:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783551931;
	bh=bR4oe1Yez12AzmAsGhXVBJqsRMQ89riJ0un5WqWg9rc=;
	h=From:Date:Subject:To:Cc;
	b=Bbp1+VGVoO+xSBT9TmXw/LnB/RjUXLyVrPjWDTJK19r5LQ9oPCyt43o4aTEPgmcJn
	 n8YRZ3l3Q7ATqVnsDRRjZJGtAOeD5Lp2fMOPV5SzIpTeEtWk6iGrVF+PfeRcCVZOIi
	 vv8VsqcZr9xtx8YAsRbhiVpQkP/HK9VSC/DrpbdvuzYb+m8LGQ0Sm4ytd1eEAjJZwp
	 KXyclCP4mX/9IiVGfCUw57s3brWTyO8Lm8/xHafehitGrpvukYk7qB9lIa7L3YwDkw
	 MuwCb6GNPcpTls6/8hVqvLDURPPOJ8YKoeQxgKO4jGgoMh29caO0jXEtqJozoVjLfo
	 fdWLMlwfRRVdA==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 09 Jul 2026 01:05:19 +0200
Subject: [PATCH] serial: 8250: handle ixp4xx register endianness correctly
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-ixp4xx-serial-hackfix-v1-1-cd1c29d02183@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CMBAAv0L2zCa1oKZ8hXAo29WuGmhaJU0a/
 m7R40wyUyBxFE4wNAUib5JkXSqc2gbI2+XOKK4yaKUv6qoMSg59znhk9oXe0vMmGelMzihHZE0
 HtQ2Rq/59x+nP6TM/mN7HDPb9Cx9CJDx5AAAA
X-Change-ID: 20260709-ixp4xx-serial-hackfix-c5cd90dcca93
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-serial@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2

From: Arnd Bergmann <arnd@arndb.de>

Unlike modern SoCs that just work in both big-endian and little-endian
mode using the readl()/writel() or readb()/writeb() accessors, the
internal registers on ixp4xx behave like native-endian 32-bit registers
in both modes, which requires adjusting the register address
when using 8-bit access.

The existing dts files are written for big-endian kernels and 8-bit
access, which does not work with little-endian kernels.

Add a quirk that makes the 8250 OF driver:

1. Mask off any hardcoded offset.
2. Add the += 3 offset if and only if we are running on big endian.

This should work in all combinations of big-endian and little-endian
kernels with either variant of the DTS file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[linusw@kernel.org: Modified to just play with the offset]
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/tty/serial/8250/8250_of.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 81644d40b09a..859dff3af0eb 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -122,6 +122,17 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	if (ret)
 		goto err_pmruntime;
 
+	if (IS_ENABLED(CONFIG_CPU_XSCALE) && type == PORT_XSCALE) {
+		/*
+		 * Adjust for BE32 register accesses: drop any hardcoded
+		 * address for the big endian byte target, add it explicitly
+		 * if running on BE32.
+		 */
+		port->mapbase &= ~3;
+		if (IS_ENABLED(CONFIG_CPU_ENDIAN_BE32))
+			port->mapbase += 3;
+	}
+
 	/* Get clk rate through clk driver if present */
 	if (!port->uartclk) {
 		struct clk *bus_clk;

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260709-ixp4xx-serial-hackfix-c5cd90dcca93

Best regards,
--  
Linus Walleij <linusw@kernel.org>

