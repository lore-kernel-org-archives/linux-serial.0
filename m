Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E648DC61DA4
	for <linux-serial@archiver.kernel.org>; Mon,  6 Feb 2023 09:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjBFJ1M (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Feb 2023 04:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjBFJ1C (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Feb 2023 04:27:02 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4338012062
        for <linux-serial@vger.kernel.org>; Mon,  6 Feb 2023 01:26:39 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso8218059wms.3
        for <linux-serial@vger.kernel.org>; Mon, 06 Feb 2023 01:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gv8S5H3Ovr1YQgdvQexv/ddLSC0cqfieNvtl/a724Uc=;
        b=gA3qKsbNqpXbyWk0xcX3LHDibx+UXkCv3awjvieOBKO+9dHKPjk18MrnJztoFM3EQx
         ydnUV3vJhR4ggozL2Ywu5Y2EICUYpBYSV9fiZXE6b9JPkOM6R01xHQmjpWjCl5PjmFmT
         2flTXc8VMk9DFkUoxmHLVS6zAJBZC1aPX/dGqQ95C3Jj95U1Fu6tID2NGwJH9QJoQ/CR
         YjDmzFEFS1qpthRElBoPGHG0X1Q3uELpWGIX0hC0O9sMJ2GVnYPswkixMJnIlrFymE1k
         rYsDuRHL8+JtHq1vzV/qsGUG6AgiY9NRNpGZjOJnlMXzuY80XRAQkZeNnW5jc/4C+Sks
         Nkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gv8S5H3Ovr1YQgdvQexv/ddLSC0cqfieNvtl/a724Uc=;
        b=mQFw5g+ceLA+rVbilLh60JflbVp/OS0JWHT5sjQOSfd33ezVcXZKL3oZpDN05gS1Yj
         T2BNIlL2Glsvhe73l21qeVTALs5zSYlPEAXkGBnPvVD34jUBLBMoZ4l3Y41uir+AkHmn
         vYqA2bbfnxFVAy32Iq/2/MraAsWwN0hBV+6srUOW/XebBFjouX8NdNucJPq0znIZLYQr
         QCsmqp6bOQiT3LlMIciQuzyFFFs1iQIMmvMSw3hU0m/OQX9FLDghxg3QgY7+8xtjxPtx
         HN8bEhC84bqvGzAUwPkMQbvMi3qxow4wzr+Ttdur5pJGnce81UdJFzUZoy8saZouFI4w
         Bxow==
X-Gm-Message-State: AO0yUKWIXXi3CPyQyTGF6/lxSEsy/UobIWWhKjiyRIsu0iJRFYB39+FW
        el+IO+GJS9Tdu7Ani8CJ1ZvRIQ==
X-Google-Smtp-Source: AK7set/g9k2tas0Z2ue87Vyd49Xy03J9aJSThb8Zynjak5G+lcGDdlvSuI1KRVpV7uE3LkhqUowWjQ==
X-Received: by 2002:a05:600c:4f06:b0:3da:b40f:7a55 with SMTP id l6-20020a05600c4f0600b003dab40f7a55mr10603447wmq.6.1675675597722;
        Mon, 06 Feb 2023 01:26:37 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m5-20020a7bcb85000000b003de8a1b06c0sm15722568wmi.7.2023.02.06.01.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 01:26:37 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Vasut <marex@denx.de>, Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 3/3] dt-bindings: serial: restrict possible child node names
Date:   Mon,  6 Feb 2023 10:26:24 +0100
Message-Id: <20230206092624.22922-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230206092624.22922-1-krzysztof.kozlowski@linaro.org>
References: <20230206092624.22922-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The re-usable serial.yaml schema matches every property with ".*"
pattern, thus any other schema referencing it will not report unknown
(unevaluated) properties.  This hides several wrong properties.  It is
a limitation of dtschema, thus provide a simple workaround: expect
children to be only of few names matching upstream usage (Bluetooth,
GNSS, GPS and MCU).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/serial/serial.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index e05ad3ac2abc..c9231e501f1f 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -96,7 +96,7 @@ then:
     rts-gpios: false
 
 patternProperties:
-  ".*":
+  "^bluetooth|gnss|gps|mcu$":
     if:
       type: object
     then:
-- 
2.34.1

