Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA05CDB486
	for <linux-serial@archiver.kernel.org>; Wed, 11 Oct 2023 18:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376285AbjJKSu0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Oct 2023 14:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345779AbjJKStp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Oct 2023 14:49:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA4D94
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 11:49:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3247cefa13aso151890f8f.1
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 11:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697050180; x=1697654980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPOqcX4Ej3m/0HUVtDwdhQHY2aoTOsl6XS4JtvFqWa4=;
        b=HCp+NejKIXCPnaGIrL0A98TSdqAPmxmjME+co5hUbjCFh/oE+kOquYpmwfxIVBS5SK
         gWP5pPdHXfiAr93jpqc/NnimXuGSHkpwZ2w0pYe2XzfBw2qmIaATgTLuBmfC5g+lTwSI
         gj9uAH+PAyIoU+aVTQuYULroDuiyXs/h6pkYEZNyDBz2uMTMz6Zzzt9om2/FaY4sC+4o
         hT/PYTvbNr/2tEZ3qfDEUkejBQIX7pkBYJQinPWokRELAoFviF1ByOEd8U8tCm4mNDRW
         1g6PI2ABJii8QRFdbRJkDucLpmofVWHsVDy5IMk7d+6AXUqyjp3Ba+LY2Im426DNayPh
         qo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050180; x=1697654980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPOqcX4Ej3m/0HUVtDwdhQHY2aoTOsl6XS4JtvFqWa4=;
        b=uJfyeeYN5tMmVo3FoFS3+o3sl27plInwpHfcQ+kBzDl39DNfe/ykcOUt8vSpWpdJhz
         PGxUWwMENmI5MRNzu3r5DtJ6qC1sfahnuK5Syf5QXfhKL2lXWZtMnuJLetVDcN++tesK
         sNc3u64V7KXScSaCe+lWPpTqxpVVq6cHUVI0hJjcZzaIA7Jj4WIh71ju+SG8Ndv5xrZp
         byxVv+FO1vkNGMACE2z8b3AhpC2fm7EtaJ36p0JYDTpO4CgEWVGWUlSxJjcdOJND2g80
         u3KiHuOSAm4l+GMJufof61Xfy30V/xAHdpd7QYIWX7goDB8Dbhv00wqXSXhGPGvaTFZs
         g2vg==
X-Gm-Message-State: AOJu0Ywfjc4T9STepnsOZ6AtAGHXRahvxwGpuXcI3yTjgj+OvM1Uj+wg
        BJ8LHV3bk0iWQTZQ54wGUsliPQ==
X-Google-Smtp-Source: AGHT+IHMpRgHoDBgn+LyjOsF0XISdxPj15/7N1fcJz0HY1O6F/N9a70SS/9n712bMEfg3/3wUNNJCg==
X-Received: by 2002:adf:e189:0:b0:32d:87b6:14d2 with SMTP id az9-20020adfe189000000b0032d87b614d2mr2360731wrb.31.1697050180253;
        Wed, 11 Oct 2023 11:49:40 -0700 (PDT)
Received: from gpeter-l.lan (host-92-12-225-146.as13285.net. [92.12.225.146])
        by smtp.gmail.com with ESMTPSA id v6-20020adff686000000b0031980294e9fsm16003875wrp.116.2023.10.11.11.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:49:39 -0700 (PDT)
From:   Peter Griffin <peter.griffin@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org,
        tomasz.figa@gmail.com, s.nawrocki@samsung.com,
        linus.walleij@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, olof@lixom.net, gregkh@linuxfoundation.org,
        cw00.choi@samsung.com
Cc:     peter.griffin@linaro.org, tudor.ambarus@linaro.org,
        andre.draszik@linaro.org, semen.protsenko@linaro.org,
        saravanak@google.com, willmcvicker@google.com, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel-team@android.com, linux-serial@vger.kernel.org
Subject: [PATCH v3 19/20] arm64: defconfig: Enable Google Tensor SoC
Date:   Wed, 11 Oct 2023 19:48:22 +0100
Message-ID: <20231011184823.443959-20-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231011184823.443959-1-peter.griffin@linaro.org>
References: <20231011184823.443959-1-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add the Google Tensor SoC to the arm64 defconfig

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5315789f4868..8a34603b1822 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -41,6 +41,7 @@ CONFIG_ARCH_BCMBCA=y
 CONFIG_ARCH_BRCMSTB=y
 CONFIG_ARCH_BERLIN=y
 CONFIG_ARCH_EXYNOS=y
+CONFIG_ARCH_GOOGLE_TENSOR=y
 CONFIG_ARCH_SPARX5=y
 CONFIG_ARCH_K3=y
 CONFIG_ARCH_LG1K=y
-- 
2.42.0.655.g421f12c284-goog

