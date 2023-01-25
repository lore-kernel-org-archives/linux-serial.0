Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF945C54EAA
	for <linux-serial@archiver.kernel.org>; Wed, 25 Jan 2023 14:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjAYOff (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Jan 2023 09:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbjAYOfe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Jan 2023 09:35:34 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D44E59B63
        for <linux-serial@vger.kernel.org>; Wed, 25 Jan 2023 06:35:07 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id kt14so48211998ejc.3
        for <linux-serial@vger.kernel.org>; Wed, 25 Jan 2023 06:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PdB/SfQ0SWBNWh08eH3SW1QsUqwi/lP4LXtXf+kq5IA=;
        b=Dd+et0jm0/0xlucO8IFpitLrtrMSv/ALQqB/ABHM6GgO6GnUzbRaEoTk9f90z5SHOH
         9895maVzDl98Arm+NjPKIpdjElFiPZ9Jeo3LnXvbd4H05ZCFdnrJZi99XjV9DuJIyOuk
         hXLfIXmUZKYnIFIDh41CJkrMdT4MIPZV0C/TCRbZvgVNOnT6O1KVuJs617S0kWw2mpSQ
         uZdVaCSLaejaA7nV+bDUgxTpJXKRrsO9QkaYrxMBLf3VRY+v1eKc6Mv7GoRJIYGKTsQM
         cWQ4yjrV9wrx0iL3inejwa5YjLJHK4dEDve3GY1NPGCTVeDN74focNhN5QW8lINjPCTf
         02Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdB/SfQ0SWBNWh08eH3SW1QsUqwi/lP4LXtXf+kq5IA=;
        b=WNaLdhJPMZSrnll0fvIlyH8rnAjKgTPSY8o3tA1FqVW/fS9aDS7FaFm9pFslgB+zQ0
         0/Q6s+SMoGmsY5pYSfmTJrfWBBlm2bcWqlIc1u1siwI+JiIgz3Mljt3Bfj9YmjbmsO9g
         ROflifJJiiSPS7njOLL1ddLzjqTUhtVykob2PTT3QtGweaDE59bOJR66XUaejtq1biuK
         kUfal5q2bhkylOTkRi+vUF78aMnuVRwKAV/rTdEa+JB5Cl+cvNoHE3kclLmfR3kcxfSY
         h7q9XYC7T6alFoMi8qVZTVZ3Sd72JvqcHvbR2lAxIgpRJRJfLSrA0IqUzzDxFRiYeaNL
         v1Aw==
X-Gm-Message-State: AFqh2kq0mojsC49EbUURW147Y6ie1Z92GUOCgWNhYgkDNQ+u6MTCbCJH
        wdSGD1IIe5jj7ejRHND6fOZuEA==
X-Google-Smtp-Source: AMrXdXvIoSQXuacQCMREvujIPcbrM3wN6HpuxYCIHNdefXOQtvM5NR0Td/Q1ffeOepulflZ21gnbaA==
X-Received: by 2002:a17:906:6b13:b0:872:cc12:f712 with SMTP id q19-20020a1709066b1300b00872cc12f712mr30129839ejr.43.1674657305792;
        Wed, 25 Jan 2023 06:35:05 -0800 (PST)
Received: from c64.fritz.box ([81.221.122.240])
        by smtp.gmail.com with ESMTPSA id gx2-20020a1709068a4200b0082000f8d871sm2437789ejc.152.2023.01.25.06.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 06:35:05 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de,
        maz@kernel.org, lee@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, gregkh@linuxfoundation.org,
        daniel.lezcano@linaro.org, chunfeng.yun@mediatek.com,
        angelogioacchino.delregno@collabora.com, nfraprado@collabora.com,
        allen-kh.cheng@mediatek.com, sean.wang@mediatek.com,
        zhiyong.tao@mediatek.com
Subject: [PATCH v9 0/9] Add minimal MT8365 and MT8365-EVK support
Date:   Wed, 25 Jan 2023 15:34:54 +0100
Message-Id: <20230125143503.1015424-1-bero@baylibre.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

v9:
  - Fix a regression in v8 that broke the USB port
  - Remove superfluous include in mt8365.dtsi
  - Fix some naming issues pointed out by dtbs_check

v8:
  - Add binding descriptions for mediatek,mt8365-systimer and
    mediatek,mt8365-uart
  - Specify ranges with parameters for u3phy

Tested-by: Kevin Hilman <khilman@baylibre.com>

v7:
  - Update GIC information in mt8365.dtsi (thanks to Marc Zyngier for
    pointing out the problem)
  - Adjust the timer to match the updated GIC information

v6:
  - Add systimer in mt8365.dtsi
  - Add I/D caches and L2 cache details in mt8365.dtsi
  - Move bl31_secmon_reserved from mt8365.dtsi to mt8365-evk.dts
  - Fix inconsistent indentation in mt8365-pinctrl example
  - Further mt8365.dtsi cleanups
  - Submit to additional maintainers spotted by get_maintainer.pl

v5:
  - Reorder top-level entries in mediatek,mt8365-pinctrl.yaml to match
    example-schema
  - Use consistent quotes

v4:
  - Remove pins-are-numbered references that have been holding things up
    now that the patches removing it from dt-bindings have landed in linux-next

v3:
  - Remove a number of components that are not yet supported (they will
    come back alongside the corresponding drivers)
  - Address issues found by dt_binding_check (mostly fixing pinctrl
    bindings)
  - Address issues pointed out in comments
  - Reorder patches

v2:
  - Add missing dt-bindings documentation
  - Small cleanups addressing issues in v1 pointed out by Krzysztof Kozlowski


Bernhard Rosenkränzer (6):
  dt-bindings: arm64: dts: mediatek: Add mt8365-evk board
  dt-bindings: irq: mtk, sysirq: add support for mt8365
  dt-bindings: mfd: syscon: Add mt8365-syscfg
  dt-bindings: pinctrl: add bindings for Mediatek MT8365 SoC
  dt-bindings: timer: mediatek,mtk-timer: add MT8365
  dt-bindings: serial: mediatek,uart: add MT8365

Fabien Parent (3):
  dt-bindings: usb: mediatek,mtu3: add MT8365 SoC bindings
  dt-bindings: usb: mediatek,mtk-xhci: add MT8365 SoC bindings
  arm64: dts: mediatek: Initial mt8365-evk support

 .../devicetree/bindings/arm/mediatek.yaml     |   4 +
 .../interrupt-controller/mediatek,sysirq.txt  |   1 +
 .../devicetree/bindings/mfd/syscon.yaml       |   1 +
 .../pinctrl/mediatek,mt8365-pinctrl.yaml      | 197 +++++++++
 .../bindings/serial/mediatek,uart.yaml        |   1 +
 .../bindings/timer/mediatek,mtk-timer.txt     |   1 +
 .../bindings/usb/mediatek,mtk-xhci.yaml       |   1 +
 .../bindings/usb/mediatek,mtu3.yaml           |   1 +
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts   | 168 ++++++++
 arch/arm64/boot/dts/mediatek/mt8365.dtsi      | 377 ++++++++++++++++++
 11 files changed, 753 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-evk.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8365.dtsi

-- 
2.39.1

