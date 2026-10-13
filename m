Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864AA47FB14;
	Tue, 13 Oct 2026 03:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863166; cv=none; b=BjtGwDV+hh56j8XGcfdIczLe/y8gm8NiPUNZbpDZ20+qOXXBtYRy648MbEhzQCti8KpURqYQiNE6WcnxYoWUbG891ZMBPPRxiHASv0ijFTDxOLT9t4F4VlxwmTFphYgcSmaQ49E0m0Apuy6c3/oqdeLeW3xCtU8Oabsylb0ebLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863166; c=relaxed/simple;
	bh=GCubckKkvtS/EOiOIxWc0YpDQoyEYzgiiDMrguNF01I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a0uDjlApngig0k6xSYprG++8mjBBfbDM4BFe68YdEnuXEoRdDgUk9HEYe65GiG/mkhyUIZm1RVSCzRpfiblN09SZsgZOFtI7a7s1J1HRsxHpkv0FIc/S0FUxaKUR92Ct5c5xD6uyOZeRYCgR4j35KV4A6Qo8ZdvyHVk+eVC4mU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8fM7r6F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8fM7r6F"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 405FAC4DDE2;
	Tue, 13 Oct 2026 03:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791863166;
	bh=GCubckKkvtS/EOiOIxWc0YpDQoyEYzgiiDMrguNF01I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=H8fM7r6FKJvons/kfOsRwGoXklXJbzawmxBAP7fzxhQI89RmPZmCPefi/ptUguIyO
	 +8u0F8bvEM7UHQSqkuRae0EZLFRZ+fgpDxl5j7oWRO0V3+rIf3m0YikQFLTmYQTpRx
	 pbAOFoJ45j0I2gQp5BYq8SGrnQuVpwfw5GOn3pA5WJtp6U14OSxwV251uXpcKL1jiL
	 rk49f0imH42oOW3yCx8+DDXPp5FJ5fRP4dT/R334npLnDy3ACFwZDZiVpEsuYW5nSv
	 qlY39eFxwMuVLLod7RvxO11aCEl/iSSiaGuEbHxMQ1AtVfS1eusW7vXwHmK2U6oEc6
	 08q6xBl4IRy/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED93CA9ED0;
	Tue, 13 Oct 2026 03:46:06 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 13 Oct 2026 06:46:13 +0300
Subject: [PATCH v5 10/10] MAINTAINERS: Add entry for Cortina Systems CS75xx
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-cs75xx-v5-10-4e72aa383d39@gmail.com>
References: <20261013-b4-cs75xx-v5-0-4e72aa383d39@gmail.com>
In-Reply-To: <20261013-b4-cs75xx-v5-0-4e72aa383d39@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791863163; l=1124;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=NwAetqwg8dZTsEYKE0lK90ntL9PQOHqCts3OMdvEgqE=;
 b=kuTZGug7QFTX/x62KXuJkHavYJGAEIxDexIMvErExiczms8M/bXgKEJ18ogg7JpKLUaQxGMpt
 eBFppF9K5NLC5NPAjJhQSPTtDEi0CTAVmKmPg7EToGTiIt7S9TDHfWA
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


