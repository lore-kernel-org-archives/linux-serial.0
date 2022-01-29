Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3C5C433F5
	for <linux-serial@archiver.kernel.org>; Sat, 29 Jan 2022 17:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352782AbiA2Rxi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 29 Jan 2022 12:53:38 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:58756
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346187AbiA2Rxh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 29 Jan 2022 12:53:37 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D2C883F4B6
        for <linux-serial@vger.kernel.org>; Sat, 29 Jan 2022 17:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643478816;
        bh=bgWRA4jagXRIZ+87s8E1TzK9o6vneJUF41jOIzkhmn8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=lA6FH8l1TyoTfuqt+fHS8HybtRsbmJAsNL33g8YwHcL1sTzIBZV+lEUGFk9RggAaX
         0zWbTMSRtHDxir/pDR42dq//amV4NIDWkED2uFerSZ0JfAcACRI12OnvvbrIvKnpbz
         JsaUgoN6p5Tm7pbAVU8dHrCp9V9W3r5VU1qtaHSGwTT5tcV39dk09oOqVSGZDj43KH
         ffyOWeZwBWB2I1fLOTD07/e9+IXkVIb0l9wKGGamMhsbZlNo7iQ/NdRjKC7dLkCxup
         lvR+KCqkcXn/glDkrYFbkAWRySTAhHrMy74RpOqd4RcWQHlTm+XdMhUG57KLmGuIO3
         l1zZGAJxA+t0A==
Received: by mail-ed1-f71.google.com with SMTP id v15-20020a50a44f000000b004094f4a8f3bso4719839edb.0
        for <linux-serial@vger.kernel.org>; Sat, 29 Jan 2022 09:53:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bgWRA4jagXRIZ+87s8E1TzK9o6vneJUF41jOIzkhmn8=;
        b=GIFqfvjrYIujxzc5+SKrZW7Ksm0m+61mpClKTN8S8yRYJ3vHZfG+D9kT/47tenDPuK
         U27djzAeMLNdg0T4Sx1QaJTYLsdT9F69yJlA2POj/Lk5v3szh/Si7TxSxrC7cj+JJRGW
         x4PgITWhO4jy6yERba+QOiN+BUZasWxpZUQVWFDQjnhqcBv8AN87Bnaz3jvpGHnwYtB/
         0QHlyyiUE+La607Id2TI1B7Ai4vsGAvcKnC6sB8lAbmXk5IyVMAD9Q7VlhMWx2rukgH9
         PIErKRaob6OzUblOvGr8THapd0rEmzi3C4jocS2I+6WxB9qF3nTxajY6ZcvbKJKn7SdD
         1YPw==
X-Gm-Message-State: AOAM530c6jAxBF4lV8Po1Lq+YgZaG/Is+fsDbgtZpU9UPDKJGh5VEDz/
        JJ+QLHzn1FyD1uWl5IZhpn7N+p24S+/OmIwTvJ5PGrRLKSPnzuXf+qot0WlETCt7OvpbvIpHUp8
        jrmWhX+LwbtkrluWV9lTtkvRR/+2xgDJyBmHPIftXUA==
X-Received: by 2002:a17:907:9726:: with SMTP id jg38mr3651950ejc.384.1643478816580;
        Sat, 29 Jan 2022 09:53:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwaBAqEWxBwVQz5SVpuSS2UhkhrR1UFQZFLootOZ1zlNqZ0WYYIUdusgJTZcK3C6ZgqYdhF9A==
X-Received: by 2002:a17:907:9726:: with SMTP id jg38mr3651939ejc.384.1643478816415;
        Sat, 29 Jan 2022 09:53:36 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id s12sm11236266ejx.184.2022.01.29.09.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 09:53:35 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 2/5] arm64: dts: exynos: drop unneeded syscon phandle in Exynos5433 LPASS
Date:   Sat, 29 Jan 2022 18:53:29 +0100
Message-Id: <20220129175332.298666-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
References: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Exynos5433 LPASS audio node does not use syscon phandle since commit
addebf1588ab ("mfd: exynos-lpass: Remove pad retention control").  It
was also dropped from bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index b4cde77e02d3..661567d2dd7a 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1885,7 +1885,6 @@ audio-subsystem@11400000 {
 			reg = <0x11400000 0x100>, <0x11500000 0x08>;
 			clocks = <&cmu_aud CLK_PCLK_SFR0_CTRL>;
 			clock-names = "sfr0_ctrl";
-			samsung,pmu-syscon = <&pmu_system_controller>;
 			power-domains = <&pd_aud>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.32.0

