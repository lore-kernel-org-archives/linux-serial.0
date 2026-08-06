Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D50416859;
	Thu,  6 Aug 2026 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008867; cv=none; b=Rn3agx7zjk2sfFuFhxkUWJ4IgOufj6nZ48FaIIjP0XoIA+ft3G8+XXS52SadaHg0uEFFNd+vNjbB0huWD9KrXgiMb+kZ+/cJ2K+Hi/FGskWEUnVsDaSY/kY2UZc/LJhT8+SbYYQwovn2lVqN39S8LAwZeH8VeFHzuogo13Q5i0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008867; c=relaxed/simple;
	bh=Z2E9zTsEDJP0zeF+i+JgJFiaNg9dXXSm8HlaEi6y/IU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rnwl37WAANm5L2eU28iSwavzlOtI2NF4RGmMtFuPgYh3YIUDez3wl8YnY+QshaEUNwSMMMY5Egxqw2/otueDRoEuhlDsi7qVol2i72i8spyjDtkhAuh/qwdAzYOr37EhqP6lrfd0uUk6LcChWB4Yl2lLokQbCakFi9ViLHzCGH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdizhPxX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdizhPxX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 131F6C2BCF7;
	Thu,  6 Aug 2026 09:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786008867;
	bh=Z2E9zTsEDJP0zeF+i+JgJFiaNg9dXXSm8HlaEi6y/IU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pdizhPxXUuHxGuXeSg4WLxPTMGebF0ymR/rm8GvYX8qlfK1JffTAeIQaJ+igQqnfB
	 IaF/JuPBQMzqM2dldTLMPfjxo5L6Cwo2Zfqf8KJIV07vLFk3Y7nQbZ34g1z6udA67w
	 7e55vdo10X++1r21fxwabRtkis9BSqCNkiB+lbMy4VFfRYVK6mFegu98WfnmL7YKuY
	 KibHJljxl02Cf1uSoVR4RhT18IhIBiQnSLyxQjpEwaA9kMGXg07FtpMJ3McOUt6xlf
	 RmktpVeGZelocXSvVTy2+KDo7bOLf/YqQlICu26CnDQylTkqX8VTpuaJQ/B9CiVcuA
	 zdWb06iA4d67w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24CAC5AC67;
	Thu,  6 Aug 2026 09:34:26 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Thu, 06 Aug 2026 17:34:18 +0800
Subject: [PATCH v2 10/10] MAINTAINERS: add ARM/AMBARELLA SoC support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-longzhao-upstream-cv75-v2-v2-10-6b09707c5fe9@ambarella.com>
References: <20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com>
In-Reply-To: <20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
 soc@lists.linux.dev, Long Zhao <longzhao@ambarella.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786008863; l=1365;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=xx2F3xyEKnw6VoTF4kbTyKftrweRLyCy3Ck5hCpXsBs=;
 b=CYPiCCAYitDcu2nNmIqOUgU1M2v+u8yv6F5uq4RplmWynENMCpHv/8g2l3sZp2Jv6N1l+oF7H
 feJngjTBpAUDjsRTFuGGf14U9pSIDGhGLTCCQWqtln7EUtZQ8fI/oNM
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Add a maintainer entry covering Ambarella CV75 bindings, drivers
and device trees.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 MAINTAINERS | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 803b60ad628f..c06c84fab57a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2502,6 +2502,23 @@ F:	drivers/clocksource/asm9260_timer.c
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
+F:	Documentation/devicetree/bindings/soc/ambarella/
+F:	arch/arm64/boot/dts/ambarella/
+F:	drivers/clk/ambarella/
+F:	drivers/pinctrl/pinctrl-ambarella*
+F:	drivers/tty/serial/ambarella_uart.c
+F:	include/dt-bindings/clock/ambarella,cv75-clock.h
+N:	ambarella
+
 ARM/AMD PENSANDO ARM64 ARCHITECTURE
 M:	Brad Larson <blarson@amd.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

-- 
2.34.1


