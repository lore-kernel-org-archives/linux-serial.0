Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59224582C3;
	Tue, 18 Aug 2026 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049134; cv=none; b=fChP88hyykiK7WHdqPWqCN41u2qdR3O1OK/RqkphFyitLAF5ZREq1zHiYQdvRgjkRAWWOlfJ5DlKh5bjqn+RlgYzLwNny83p4t8FUWAyoe6eS88XBDWx0pjltu9KzJrURYZCmJ9+cN/4MPXU4FzNdq0RLHVBDy1Kdy7F9XeqcGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049134; c=relaxed/simple;
	bh=Bb36BfGeVG00O5acHqEedqkrcVnPEN+C2tMnqCVjfps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o4sIWGgTpVETvNTwodqQgv1LzhteZpmpWTFHgE4L8sJYB5WkwQXK7BmXXK42m0iQC8pDObG+ECLP9KcJhY5b0SCDtvdzirAxMQoIGlQ1dSu83moDMciESD59q1xCqrPB/M9jHz6ntTbhDq0F39Ur5rKzkIS4hKgBzlOzkGcC/eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxEGbg9a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxEGbg9a"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91965C2BD00;
	Tue, 18 Aug 2026 10:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787049134;
	bh=Bb36BfGeVG00O5acHqEedqkrcVnPEN+C2tMnqCVjfps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cxEGbg9akGWhslNkUnpvGOYgjYFvlG8RUICRl72778pTxnW3tnuZxyB4KoSOaeWRb
	 qiKkjCk6xyzajQt0crSTGwE7HfoNwmhCn2QF/yPf6OZcuJ0R0ry6mwGx9y9RspM+ow
	 B3lL4rZxD0Tmq/e4iqwV2QupyHpLlTQ0rghEjdVtNWPJM70+5vr9vsM9P4FhwvsmSj
	 vsaJrHHybEGw5cs5KZ1jBHj9Gf+KPe91JusBO+zRl6PcKIlKYGxX7yaHZKQlKdRvrl
	 H5XSv+eGMA6zYbMVBG7GUE1leWbYOEUcfz1YMJwKLcY5utPuFDWhx1pbB8U+5Yo1gL
	 1lQYTelHwxd3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3B0C5DF70;
	Tue, 18 Aug 2026 10:32:14 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Tue, 18 Aug 2026 18:31:26 +0800
Subject: [PATCH v5 12/12] MAINTAINERS: add ARM/AMBARELLA SoC support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-cv75-v5-v5-12-7bbb12f0360f@ambarella.com>
References: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
In-Reply-To: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>, 
 Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, 
 Long Zhao <zl020895@163.com>, Long Zhao <longzhao@ambarella.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787049131; l=1312;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=qRk4o9fqrbJ/RTe53ZqQZzJC7nitoycd8NIbTSpQATc=;
 b=22jZKHSk4JLzNo9O8aGxR1ZHXYovNN3EMRSWAxCkRINCuJDf+fH7BEi0M1am6EfDNoaT9CyzQ
 GaOtRr7cdbOCbblt/GRQZFAws6QRfB1pNBOAALqZOdSrlL4fz1xTMEJ
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
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 803b60ad628f..4352a2dc1e3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2502,6 +2502,22 @@ F:	drivers/clocksource/asm9260_timer.c
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
+F:	Documentation/devicetree/bindings/serial/ambarella,cv75-uart.yaml
+F:	arch/arm64/boot/dts/ambarella/
+F:	drivers/clk/ambarella/
+F:	drivers/pinctrl/pinctrl-ambarella*
+F:	drivers/tty/serial/8250/8250_ambarella.c
+F:	include/dt-bindings/clock/ambarella,cv75-rct.h
+N:	ambarella
+
 ARM/AMD PENSANDO ARM64 ARCHITECTURE
 M:	Brad Larson <blarson@amd.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

-- 
2.34.1


