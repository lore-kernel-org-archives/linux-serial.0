Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD95A23D2A3;
	Sat, 10 Jan 2026 02:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768013214; cv=none; b=puav2CaupdG890DRzOHY6p/Tj39tXvfBbJRbzHP/2SOUZaJHWaA5u+gB5/JaZnXhklP5wchOP7ccsJ6DMxxgurY/2+lSHbKMKJgxJ3o/SKAU8stcOIj8Wfwv49rraJeH38T6DSnj/hxNKjJFP3ypr65SwT7LXKZ2otSDNjlHRPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768013214; c=relaxed/simple;
	bh=+BYuWtFv/XD2qRphe2CsoPtoHBClY2P0EnzOb7khs3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMX29B+pByJE27nLdFSubJ+faTkzB32kUG2PlFii5AQEohzeuJTos10TTapIVrpzUPW9N6G8BycDRV0+RzgpBdPOfFqrLjsIr1cmgVcLFYuepIJjbb2RmNBlIbiYmTMKaz7S4JWaig7fwmnvYNQ+cpeTI5a1b8fvvwtIMQxRioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=c7jZjyRg; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=c7jZjyRg; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="c7jZjyRg";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="c7jZjyRg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1768013211; bh=+BYuWtFv/XD2qRphe2CsoPtoHBClY2P0EnzOb7khs3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c7jZjyRgclnJ9qJAJncJGwCVsEBdzb8cMGVRKLYAAagW2iDOGsDjxbyWy5LhOOEkw
	 3YYTs0YVZDerI28SUqSydaAuq9ztVoTGR8vXpWGxYdBLkR4jxK8g1e0qq/9/uHAdFK
	 p+GRRbtAPuLX7LDsycjquqqkPWznXWKlN41+TxCcBYArc6pIA5q2n/oCUx+ZKulOpY
	 dWaOKQ1ygR0DikB1sWyLLd91UFPbEovqGCHOGWMJPjlYMLOryGU8Jp6GzVd8ek8bkn
	 6SLqyqlVE73anYrOWt09y3jFH67Izd5/fC2yhHITVqUSJbSxcb9Gmte/NM9VIexImv
	 mRyDrSMoQ8oFw==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 6C7453EB821;
	Sat, 10 Jan 2026 02:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1768013211; bh=+BYuWtFv/XD2qRphe2CsoPtoHBClY2P0EnzOb7khs3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c7jZjyRgclnJ9qJAJncJGwCVsEBdzb8cMGVRKLYAAagW2iDOGsDjxbyWy5LhOOEkw
	 3YYTs0YVZDerI28SUqSydaAuq9ztVoTGR8vXpWGxYdBLkR4jxK8g1e0qq/9/uHAdFK
	 p+GRRbtAPuLX7LDsycjquqqkPWznXWKlN41+TxCcBYArc6pIA5q2n/oCUx+ZKulOpY
	 dWaOKQ1ygR0DikB1sWyLLd91UFPbEovqGCHOGWMJPjlYMLOryGU8Jp6GzVd8ek8bkn
	 6SLqyqlVE73anYrOWt09y3jFH67Izd5/fC2yhHITVqUSJbSxcb9Gmte/NM9VIexImv
	 mRyDrSMoQ8oFw==
Received: from mail.mleia.com (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id BE6123EB823;
	Sat, 10 Jan 2026 02:46:50 +0000 (UTC)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Lubomir Rintel <lkundrak@v3.sk>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] arm: dts: lpc32xx: Add ns16550a compatible value to UART device tree nodes
Date: Sat, 10 Jan 2026 04:46:47 +0200
Message-ID: <20260110024647.3389345-3-vz@mleia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260110024647.3389345-1-vz@mleia.com>
References: <20260110024647.3389345-1-vz@mleia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20260110_024651_461707_31A473D0 
X-CRM114-Status: GOOD (  12.88  )

NXP LPC32xx SoC has 4 16550A compatible UARTs with a difference of minor
significance, which is expectedly handled in the 8250 serial driver.

Reflect this fact in the platform device tree file by adding the expected
compatible value.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
index e94df78def18..8fa1848943f8 100644
--- a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
@@ -263,8 +263,7 @@ i2s1: i2s@2009c000 {
 
 			/* UART5 first since it is the default console, ttyS0 */
 			uart5: serial@40090000 {
-				/* actually, ns16550a w/ 64 byte fifos! */
-				compatible = "nxp,lpc3220-uart";
+				compatible = "nxp,lpc3220-uart", "ns16550a";
 				reg = <0x40090000 0x1000>;
 				interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
 				reg-shift = <2>;
@@ -273,7 +272,7 @@ uart5: serial@40090000 {
 			};
 
 			uart3: serial@40080000 {
-				compatible = "nxp,lpc3220-uart";
+				compatible = "nxp,lpc3220-uart", "ns16550a";
 				reg = <0x40080000 0x1000>;
 				interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
 				reg-shift = <2>;
@@ -282,7 +281,7 @@ uart3: serial@40080000 {
 			};
 
 			uart4: serial@40088000 {
-				compatible = "nxp,lpc3220-uart";
+				compatible = "nxp,lpc3220-uart", "ns16550a";
 				reg = <0x40088000 0x1000>;
 				interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
 				reg-shift = <2>;
@@ -291,7 +290,7 @@ uart4: serial@40088000 {
 			};
 
 			uart6: serial@40098000 {
-				compatible = "nxp,lpc3220-uart";
+				compatible = "nxp,lpc3220-uart", "ns16550a";
 				reg = <0x40098000 0x1000>;
 				interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
 				reg-shift = <2>;
-- 
2.43.0

