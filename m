Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F16251C052
	for <linux-serial@vger.kernel.org>; Fri, 18 Sep 2026 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752880; cv=none; b=kcBO8S4a0GVQytwuNIwoel52rQqKRNNYw/eBWVw+7ZQucNqNttlYK27/sR2YUCBto5T4kVf6VTClhqfDjxHMnCLZ9rk53NvQjDIBUHdOJM9x/a9ZAoWrF4aj0TkokPxL4Lw39KLlympkiN0xY9AjWl/dK/tLwr0l6hmZ8JzZG9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752880; c=relaxed/simple;
	bh=TkeK6vGmZcwODlJlEq5gVtqOmy+dm0WEcZnbleLPAiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGxy50JklSOBjXvxV3mD/fX+5ID/PUuyTXz9ZDNu+qotxO+5jElJhSeWb/3b35kYob3SDDuftCqCEnrmIauO4m3RhwqDYMJo0uU2NR/87rIhSPzbOIO4Qydg+227YxHrUK24rDhqJIn8r+ldc0kopcEJl/FpsQ/f4f2CqeccscE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Paa4fCT8; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Paa4fCT8"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a59bc470d6so9304021fa.0
        for <linux-serial@vger.kernel.org>; Fri, 18 Sep 2026 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789752867; x=1790357667; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q3e71ONX+G/tBeD/v6Wra0d6veIuI4yfjRsJjDPREyI=;
        b=Paa4fCT8r/z8N7Ptul31rBHBZt9JzJi2hl72TWQosGg7YEhDCVXfa6VosXpvS1WYNU
         l/FmmpOREqPDHjni2c9aLgH+UwmnnbJwr4Si9ALnt0eAaHEInRoLP1dib7EnANcd5AW7
         TArlcPosB+ZNPPsd528e0wggtWbl2C9NXiQYomE9BhAJVl4bJehebpCixA4MXRyIOmZ2
         48mM4Yg4WRnbS09mXiFA4RyrF0XXpnQxd3m8he5ThQTyqeTWuUVrFz5u9zdumWYhrJz7
         pm2bMacCtWwOPekP0Zk+r7K0zR3R4LPvcdjg5VV87aNAOspdPBHoS2zeKpIjOU/NMu82
         jp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789752867; x=1790357667;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q3e71ONX+G/tBeD/v6Wra0d6veIuI4yfjRsJjDPREyI=;
        b=ln6sAaUlEICgWhPIY4TC+zHeFulYdCGqdhFWKBwevwE+si2wPUZ8zqiwVSQxizoaz6
         2L7Bb9WsM97em9g7EU45z+s8mtFNqxNAvN/MxVZOBzR1NMIvxZwhLXOxFMkOiX6XXVjG
         vFHIpuzfA1kAv1PQbhDsGVrCbgyG06mR5J2IZKJLmh97IjehPAYxnO6zv3RHa9PSzrzg
         55T8eMU9lcVRbh71mT/XE20zJpLGpHqgCupSwKY+JnlDiQnPronUD/qFcz+y65ID/CW4
         y0lN6NmFR+2RnwGQm7zAyRdT6LB2Gmr/oUoD3LiqYITIfWUp8ldB1PDx7Vr/NHZqxD0P
         e6Qw==
X-Forwarded-Encrypted: i=1; AKwUvBxWYNkfgMXKaKlr2WBtxz/+hbWrZ+zdKdULj9/Rs6xByZMSThVTmA1zaK5pidjEeIkf1FBESEz/86H/o+E=@vger.kernel.org
X-Gm-Message-State: AFuF++mebVxb1u6KSKK3EIn80y2qXVE9dysVFsCRxRE3WQ7GG0VVQ0Va
	WiqstpgdhdSJZOKGSOOgbbrAiQYEm19Xg8PGi55LqnBaGNsORa62GJ11gsvIkTPRbowRn07PXaV
	S21xkn8g=
X-Gm-Gg: AYBFou0uQEU8qWZSdyELLi9gYNiJtO+IVKdxWd7qwyroojggf+hJS0NFotwK88imw1Z
	qIWbidjgYXGA80+lDbDeYagvCBQiynDnYJiycQBnR/lwQWG/eGIOVnyUewaBihTkf7YLpVx/TL8
	GPNi+j+UGO8RwyOcSDGUVRv58YzHZSCSyrH/vZQ2gIu4b4ioDcrP6hqobrEFxNKYv7MEDyTU5tR
	rsfbDlPCufpFDSwyIMJdskJlZ2kDEw8reaDpSYf5vO3kIDhCqG9LhDYgoiZ7LY1r6jJydgRC0kt
	y5zRrAlmlwqxY1pPDVDrygMASCHhhFIh1FMOFfflGJJLwvsPFWJ1BiupwQ+BIZPUWmgFCcANu/k
	nHbphg8yEsEJhY+5v7HwWrZgm1P7OzUee2GqrUvSaX69aduvQwAJ1433CLoChuyqJD6+a2KOiIp
	Udktdax+SKWf1Ao502KT0LqR7aVLQDN6lHf5tDMUbbSc8i4MR6J/ymRRMbXHCH4FnTw8o5zC9Y0
	DaNEn6aTtf7YdpTX3k5GILjUaQd3LyX+Z6+6zYKa7TO+fAP1zYFkLtxpYvpgRU0Qg==
X-Received: by 2002:a17:907:971e:b0:c25:fdbc:52df with SMTP id a640c23a62f3a-c2a15699d4cmr283478866b.10.1789752410253;
        Fri, 18 Sep 2026 10:26:50 -0700 (PDT)
Received: from petegriffin.c.googlers.com (116.118.90.34.bc.googleusercontent.com. [34.90.118.116])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a35701d8bsm902966b.27.2026.09.18.10.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 10:26:49 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 18 Sep 2026 17:26:35 +0000
Subject: [PATCH v3 2/4] arm64: dts: google: Add dts directory for
 Google-designed silicon
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-contrib-pg-pixel10-initial-dts-v3-2-c94e51140509@linaro.org>
References: <20260918-contrib-pg-pixel10-initial-dts-v3-0-c94e51140509@linaro.org>
In-Reply-To: <20260918-contrib-pg-pixel10-initial-dts-v3-0-c94e51140509@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 soc@lists.linux.dev, Douglas Anderson <dianders@chromium.org>, 
 Juan Yescas <jyescas@google.com>, RD Babiera <rdbabiera@google.com>, 
 Brian Norris <briannorris@google.com>, 
 William McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-serial@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Brian Norris <briannorris@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2879;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=prHtn5W9Y5dmFFjTBpt1J6sbCTHN8IgoPCiN1ehs4ME=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBqrXRXFTEYAGEsoS7MUfIrg6CjdIOaifPmsSFmo
 QQ8leTp7q6JAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaq10VwAKCRDO6LjWAjRy
 ug/fD/9Urr6DgBP6/xSBuCZzkbqwlAfIRnR0z+L2WO+ksdtXeV/usopNI2AWlnxNecYkTWIZGJa
 nEg5M1CL0S432JJKZVtOBTqNyd3O3himpBwj8neXDBebwgX61R3vSYad2+Ux1jX1O/Klpi4qnPb
 oOqdhdPqvqxSOVUE2sk8HR53f0KERaeGyP0yrfXHq+bYR1M/KtSQoUGXuqfDH/0dIHedUIYy/dh
 X5jFUZvD4fhLsridougvieTgMWG79r/RcfaeeakcMYvEjU2eOgZWA2vxlhQpsHd/T0aBahZhRHr
 VYTEMfKs2DWxuMakwGN39vpfRy630y/vqTowyXYfAUZqFM8Iw/frDfJTm61WD6dvAB3rVU6ToZt
 pEcem4gWuKQcuROBYfK3PepyoPV2dWpA+kwsYy3tMGkw5z334AP7kqOxBt5A83YssgBip21tv9+
 Fp2Fwgi7hYNtNCTiGOEn9mqSsp6ysDQYA9mf/0b7wIehZUycnJrVRAYijVrhOH2K62bvqeMH7ZA
 8Ini+nFiLhcz+uYLVsqNuJfSY8lZ185M79jJY9EzEVarntgmQhWexSBmttBx74LR64QRnudxm1i
 f5x2MsrmsBrVPnJIml/VkouixLbIM9jrTMEqGSfCLiDTtIrDIP1Bh5z7dE3Icy1rqDk8mVlHF51
 btmyUow4Did/arA==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

From: Douglas Anderson <dianders@chromium.org>

The first four Google Tensor SoCs were offshoots of Samsung Exynos
SoCs and their device trees were organized under the "exynos/google"
directory. Starting with the Google Tensor G5 SoC in Pixel 10 phones,
Google Tensor SoCs are now of Google's own design. Add a location in
the tree to store these device tree files.

Changes by Peter Griffin
 * update config symbol help with at least 4 lines to avoid checkpatch
   warning

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Tested-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 MAINTAINERS                         | 1 +
 arch/arm64/Kconfig.platforms        | 8 ++++++++
 arch/arm64/boot/dts/Makefile        | 1 +
 arch/arm64/boot/dts/google/Makefile | 1 +
 4 files changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 06760c45c582c..bee67180e93e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11245,6 +11245,7 @@ F:	Documentation/devicetree/bindings/phy/google,lga-usb-phy.yaml
 F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu-intr-gen.yaml
 F:	Documentation/devicetree/bindings/usb/google,lga-dwc3.yaml
 F:	arch/arm64/boot/dts/exynos/google/
+F:	arch/arm64/boot/dts/google/
 F:	drivers/clk/samsung/clk-gs101.c
 F:	drivers/phy/phy-google-usb.c
 F:	drivers/soc/samsung/gs101-pmu.c
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 1489bad527d8e..c52dc955df5f0 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -154,6 +154,14 @@ config ARCH_EXYNOS
 	help
 	  This enables support for ARMv8 based Samsung Exynos SoC family.
 
+config ARCH_GOOGLE
+	bool "Google-Designed SoC family"
+	help
+	  This enables support for Google Tensor SoCs starting at the
+	  Google Tensor G5 (Laguna) found in Pixel 10 and later phones.
+	  Tensor G1 to G4 are offshoots of the Exynos family and are
+	  enabled via ARCH_EXYNOS.
+
 config ARCH_K3
 	bool "Texas Instruments Inc. K3 multicore SoC architecture"
 	select SOC_TI
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index fc726b215f125..f2d7cd6eb5695 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -19,6 +19,7 @@ subdir-y += cavium
 subdir-y += cix
 subdir-y += exynos
 subdir-y += freescale
+subdir-y += google
 subdir-y += hisilicon
 subdir-y += intel
 subdir-y += lg
diff --git a/arch/arm64/boot/dts/google/Makefile b/arch/arm64/boot/dts/google/Makefile
new file mode 100644
index 0000000000000..a6b187e2d6318
--- /dev/null
+++ b/arch/arm64/boot/dts/google/Makefile
@@ -0,0 +1 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)

-- 
2.55.0.1082.g2b9226bbc0-goog

