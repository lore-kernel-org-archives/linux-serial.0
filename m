Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482A64BF94F;
	Mon, 12 Oct 2026 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826278; cv=none; b=OU0a+CSNr4CH0Vv+r5s9l48tvFPbv3rODuytFY/IQC6J2GAU4Zs25XVuPFHXaYT+oS2s4rUkhHfVNRXQw6AqxOsTpJ86JDjQsOuDyg48u1wBk5SOTR7R6dEMq4WuppCvPsjFu7KCZpwCGHXPtaPcbuzxZloDHbcBog7NjVRLtGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826278; c=relaxed/simple;
	bh=GCubckKkvtS/EOiOIxWc0YpDQoyEYzgiiDMrguNF01I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e9sON7JbSh0AIt0x5PiZRAa1+ysFwjEtpr6C7aGK/RquIS2uAZp/l/CgFjSMnUAQzKxuXS2Yu3gRusVYtW+yofvuCTiMocp9PvIPHS6fFaEh+r4N0yzyg/yE6eQQlUDr92qMaUMIYHBrxP1ds1RxTdZ0KkLU4SDC9uUWcuVI0+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+yV1LXp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+yV1LXp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2AE0C2BD00;
	Mon, 12 Oct 2026 17:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791826278;
	bh=GCubckKkvtS/EOiOIxWc0YpDQoyEYzgiiDMrguNF01I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=n+yV1LXpWIReonDDWt5VY/94r5W7mn9LSUdbaSU74X22ZvNylW1VNDIY5XbkjhTTS
	 SQ6oC1TSkfSL7dgiIHB3BXMF/AuCBuRWUyTQPgP0xFI1jDxOHagtZuMpvnTzj1bUO/
	 j1wUTFoDMUDAWfjAvYp8qi82UuR1LXLPxZTCKcQCRf8DDAh5xpgMCB8R91cfPBaR5V
	 rJklVrmmig9DAlWGBLCftjBb23G4uG8mMDe6xk7GwNM9FqRrV5tVOcGMuRH+SVyUtJ
	 wl5iDzLKskBCtp9ZgoaJTKs5oyRnIGGmdXgRbXyu7y2NWkIpN/LqOz04cyRomU+RAP
	 bhazAde6dETDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF91DCA9EDE;
	Mon, 12 Oct 2026 17:31:17 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 12 Oct 2026 20:31:24 +0300
Subject: [PATCH v4 10/10] MAINTAINERS: Add entry for Cortina Systems CS75xx
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-b4-cs75xx-v4-10-df250d903682@gmail.com>
References: <20261012-b4-cs75xx-v4-0-df250d903682@gmail.com>
In-Reply-To: <20261012-b4-cs75xx-v4-0-df250d903682@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Drew Fustini <fustini@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Jason Li <jason.li@cortina-access.com>, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791826275; l=1124;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=NwAetqwg8dZTsEYKE0lK90ntL9PQOHqCts3OMdvEgqE=;
 b=gD/lajkp6aakN54TRwqEiJb1/VfUGhcjzDONHf3KkYw1H7rqzEjVyCXTFyvD0YVtlP3SPUqpr
 ctM++Kj0Y30Ak24GeWT1G47vXmUeZo4MmcTG1o+Pt63xXmHNGADsIoQ
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

From: Fil Dunsky <filipp.dunsky@gmail.com>

Add an entry covering the Cortina Systems CS75xx platform code, device
trees, bindings and UART driver.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d137a339..176046436 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2914,6 +2914,17 @@ F:	tools/perf/tests/shell/coresight/*
 F:	tools/perf/util/cs-etm-decoder/*
 F:	tools/perf/util/cs-etm.*
 
+ARM/CORTINA SYSTEMS CS75XX ARM ARCHITECTURE
+M:	Fil Dunsky <filipp.dunsky@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/cortina.yaml
+F:	Documentation/devicetree/bindings/serial/cortina,cs7542-uart.yaml
+F:	arch/arm/boot/dts/cortina/
+F:	arch/arm/include/debug/cs75xx.S
+F:	arch/arm/mach-goldengate/
+F:	drivers/tty/serial/cortina-uart.c
+
 ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE
 M:	Hans Ulli Kroll <ulli.kroll@googlemail.com>
 M:	Linus Walleij <linusw@kernel.org>

-- 
2.53.0


