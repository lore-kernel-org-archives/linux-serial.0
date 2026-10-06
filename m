Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AFC4A5EC1;
	Tue,  6 Oct 2026 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310664; cv=none; b=Je7LDFwBSub5izzynG/HBQMcYIRlwSuJA/oMHe5CUAFaAmIVeBV2Ou2BZml0rNFKwv2QFy3UDWuRQMIPsKun0AKEgBoBU70wQ1ac/8n7nkGfXoF58rYaZwJ7mGdiYW94Kvey9xXzJxD8bSzVES/D5HeV+9BznCRkQzQn3TMtWsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310664; c=relaxed/simple;
	bh=BjWxHmsLEH0SVveGL4HTYUroNUO888S1zBNgvUYLkZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e3nlT5ZqXdDMV+Bg2xHR9WtgvefKiJA4hyXc3tKeponeXwbAEgh/8yTlsqVozWFKckdwPnFrI5XwbReGdyGAPNP8b8MAJhRc/YiHgfQ80+ECqFzinj6FpBAk8EMQiFOSY2dyOFgtmLZi5z0YSZQq+++FFKyC/+RO0TyzwELRt3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDJieL9g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDJieL9g"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84070C4DDED;
	Tue,  6 Oct 2026 18:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791310662;
	bh=BjWxHmsLEH0SVveGL4HTYUroNUO888S1zBNgvUYLkZU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tDJieL9gBha5Whx1zbhrg1kRcvhZqvEJUu8JF4fvDS9GmG8owQ3vMXuD+GrS9DPQ3
	 TpOwVtDII3Td9WBU1bUv20lEQkvx0lR5UDUJER6dD9l5p5+ml9Gno7DZ7/owa4ihBj
	 k1c8S0gcFMX2UKl/beXuxft+Z6PrzEPvN9gR3EtlNloW20HLK250yXwV62HHNbYD7r
	 jHsto61Y5OWyqUUN7/LIyeXgxv+P+ir1w4HVRTQiIgINVMwmlv7SCVZsNxyJ94i8sO
	 MKk5rw7ZsydUaPlX2XwjJb/v52jzvgiAwomq1T25UIwmq+KDSlt1aftkaMylgoNxPP
	 i6BCDgr4yOzjw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA27CA6004;
	Tue,  6 Oct 2026 18:17:42 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 06 Oct 2026 21:17:48 +0300
Subject: [PATCH RFC v2 10/10] MAINTAINERS: Add entry for Cortina Systems
 CS75xx
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-b4-cs75xx-v2-10-b7d6e1e24d44@gmail.com>
References: <20261006-b4-cs75xx-v2-0-b7d6e1e24d44@gmail.com>
In-Reply-To: <20261006-b4-cs75xx-v2-0-b7d6e1e24d44@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791310660; l=1080;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=KQ/+3VAdigl4kwxZYIuZSDfZ4T78ueMxRlHwhzxmwNw=;
 b=7KvKRGaqNDW5OX43nLPUhokhncdMOhtbU40dZDdC//3LNaz+XtruasMy2Bx/CLKrE8jOH5i+Y
 1OVigl0sTjWBlV6DvEQpGM1XF+IrdEqA4Rl+E889ZJwXqjRdeOkYHfR
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

From: Fil Dunsky <filipp.dunsky@gmail.com>

Add an entry covering the Cortina Systems CS75xx platform code, device
trees, bindings and UART driver.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d137a33994..176046436cf 100644
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


