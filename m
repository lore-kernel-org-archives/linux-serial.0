Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB8649C4A2;
	Tue, 15 Sep 2026 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470942; cv=none; b=NxBFsSCW/lBG0nPtFqZXdDc2NpryAuTiMNpXIccpUen0KWbBE9rGkSNb0DY4gJIt9lhL5wUDqVP1kQhFU0PhX9zxQfSd55adFBbhAnAWMxVb/Ik5vX3MdHrkoRv5/ina4Bgxdn2s58OuJ3EcFvnkkBGxW1fQh1X0flHpafXnXvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470942; c=relaxed/simple;
	bh=zgU3iQM72YbxnsGmykO32NltLNkwhLgTNSOphGXHrLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hoYryS5SmiBSTql8LM7YnfiXa5YpXzIFr8NxZ9naRefGpSuCO7mLkE/3a5xefRxiz1DCDUpNTWpt62ZaHaJHkjKxM0NmEa8mSQb+N2ghPtctqs93b/fxDwFXvV6SOOmflLsX/DtNJfqcdCDmyPw+36jGZmTaGpYCJnnL0GOEf6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwyp5E/1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwyp5E/1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9F50C2BCB9;
	Tue, 15 Sep 2026 11:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789470941;
	bh=zgU3iQM72YbxnsGmykO32NltLNkwhLgTNSOphGXHrLE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kwyp5E/1tV0vJR8ZyATzmjYzr7E3YkKHLTldy+svnlCeN4Kah2fEhya/2NNfxg0DW
	 m8ofnfp5IUdrNORCIQF30AGWP5DiQn45rXFlTAlZV2Fjsiuh9Tiz7vBXC6KThGV8fh
	 9RnQS+8NCYrqPJHtSrJXvaZqIYvBE/6QHCPCq9L3s3T3E528MOmSlAbW6s7F6ON942
	 be9VWWO/2Lng/C67wV5yT97iROdLC/MMEe/SM9umCHcH0AT1rHbWdJ991CoTQ0Wgx/
	 CF+NQqDLAyw/BGnK6aYglW+7RF+D1AQoKs2EpHLzUtLzBkpxWA0uyKC9Em/Ovi7Mp0
	 WUASCjRxhXtyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C772BC88E7B;
	Tue, 15 Sep 2026 11:15:41 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Tue, 15 Sep 2026 19:15:45 +0800
Subject: [PATCH v7 15/15] MAINTAINERS: add ARM/AMBARELLA SoC support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-cv75-v5-v7-15-3297d3fbc9c0@ambarella.com>
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
In-Reply-To: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Long Zhao <longzhao@ambarella.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Long Zhao <zl020895@163.com>, Lee Jones <lee@kernel.org>, 
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789470938; l=1241;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=66/FpPmSuU75AtQewU8cj7mu+Qa/5qamx4Km8ySoeYo=;
 b=OABiYP5OVIHY/EnXOBYLDqoHi4ijJkvTIZ6oUdxyiEXJxO56vuV56K1AYGqzl7OyjTAswjdVm
 HgqEQV0fcG3B+reNEpD0Kp7V3K6NLV5Oh3ov0ragz652BzmxlAUpBpa
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Add a maintainer entry covering Ambarella CV75 bindings, DTS and
related drivers.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 803b60ad628f..59e5b32d7a02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2502,6 +2502,20 @@ F:	drivers/clocksource/asm9260_timer.c
 F:	drivers/rtc/rtc-asm9260.c
 F:	drivers/watchdog/asm9260_wdt.c
 
+ARM/AMBARELLA SOC SUPPORT
+M:	Long Zhao <longzhao@ambarella.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	devicetree@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/ambarella.yaml
+F:	Documentation/devicetree/bindings/clock/ambarella,cv75-rct.yaml
+F:	Documentation/devicetree/bindings/pinctrl/ambarella,cv75-pinctrl.yaml
+F:	arch/arm64/boot/dts/ambarella/
+F:	drivers/clk/ambarella/
+F:	drivers/pinctrl/pinctrl-ambarella*
+F:	include/dt-bindings/clock/ambarella,cv75-rct.h
+N:	ambarella
+
 ARM/AMD PENSANDO ARM64 ARCHITECTURE
 M:	Brad Larson <blarson@amd.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

-- 
2.34.1


