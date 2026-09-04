Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC17E424D65;
	Fri,  4 Sep 2026 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503955; cv=none; b=KUd9HB7KG+6DIOPPyjGv9WzMGsGndDis+tBgEDaZ7Fo/pdwyGUW6vyL5RG08BmCgh+8bwR4QwngbbQh1POJ25Tw8Ra8ye6VWeVz0ZboUgv8vFJWa7LoHp3104UeHzCjU6ac2jchucIdnybzI2BGy98WyGYWq9xzMqsEWS3drT5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503955; c=relaxed/simple;
	bh=u1O2yyg4IFgXvWdBWEfBf7DSbFAtEAmAyY6MwVpsw88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EiDPc3P0q3Zre3YfTPIVPevOUJ1YroTl1A/rUSMQryp1tymSQ/eqKJNFQglqrOoJ4sOw3Bj/9Go9nx1BJNko1O+e3Tn1Vu5WXOERq/4mPPbL6MS7L6qgoJ5YOPLXNjBMsT96uECO3otd5LjLQ1fWKOGU1g28DeDEq8OqekV/j/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6x4XMEQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6x4XMEQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0313C2BCFB;
	Fri,  4 Sep 2026 06:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788503954;
	bh=u1O2yyg4IFgXvWdBWEfBf7DSbFAtEAmAyY6MwVpsw88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=J6x4XMEQrbSig3dyY7G2WKP5LuW7mNQWZ6oFtmcWY5zHfTJ9omOcBnQPrvssoNKyu
	 u4sx4PLmyPshXjxkD+HNXF8P3z2wAjfyzkfngefe1J6PxlALJe38Tq1/NKu3N9pzvY
	 J1oIauK5BRpeFh1y4ori1dMlhwxGXX6p5j1KYVz0asbB3YArhQL0aV42ts7m7xbdG9
	 uOBWDWatJZjjxtvAPH4Ug+ebL6u7tF5n8bV/pupj4+ijnfCsOTkIgoIWxotI5wGcRo
	 b4UkjM8EkCADfnIVBG8FFFPAX/67mauX0CnHeBqy9SXKkR/cFgKx4WZF5CHCRhnsbZ
	 y441fpKfnjYzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA5EC79F82;
	Fri,  4 Sep 2026 06:39:14 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Fri, 04 Sep 2026 14:38:20 +0800
Subject: [PATCH v6 13/13] MAINTAINERS: add ARM/AMBARELLA SoC support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-cv75-v5-v6-13-e918514cb3b1@ambarella.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
In-Reply-To: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Long Zhao <longzhao@ambarella.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788503951; l=1193;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=FMdxZub31R7avQT3Ojw4RWRGTKHK7OVLHXgrDSDBBvo=;
 b=J20AxAQaqy7Qb3wZitsadbnYGTVQMan5SDPyQ+DqSnV+k1kaVX6z5mKQ4xl+txmE+cBAzqFwj
 r//YYyCQx1pARbXn3QbLcQ8xktjp5ktrUbMtqy+KG1o+7+u+jYSNZBp
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Add a maintainer entry covering Ambarella CV75 bindings, DTS and
related drivers.

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


