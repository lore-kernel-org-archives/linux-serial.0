Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175A1C61DA4
	for <linux-serial@archiver.kernel.org>; Thu,  9 Mar 2023 21:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjCIVfI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Mar 2023 16:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCIVfI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Mar 2023 16:35:08 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CC2DB48A
        for <linux-serial@vger.kernel.org>; Thu,  9 Mar 2023 13:35:04 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o12so12643015edb.9
        for <linux-serial@vger.kernel.org>; Thu, 09 Mar 2023 13:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678397703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KK2kVS/pDWxq/x5pUQs4W8hA5sU/CpHNUPW7RfmKdu0=;
        b=oBBXq4iAeXbCsT2PF/6pqeDn93WEhifSbV1qlFa/7iop2+zWVFoeABEAekMO3CFjo8
         XXFd5i2aeyKAoNCdnQEt/4uAjlOK6cjFdPbuGtqF/txObVlNkQwgyPHFXVzDNoHgTnRR
         rbpW2nXtXY4BLA0DPrDKkKgmfaZVSLLq/BXxs6eYSYcWD5MNVmyFED/xQHLX4yhhxcWL
         ru/lfliBr65TCIfvp6fTHZN9Jly/jxxB/fjLOL7OSb4u5/2I7a5UAAuTw/9EWTwf+GNM
         1b+Xfi3rSFDIlGp/PJtFNMlsbCYUyB6GNpBEmGc55AAsMCj/rbV0o/F1u1pzCU6CFKQe
         E7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678397703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KK2kVS/pDWxq/x5pUQs4W8hA5sU/CpHNUPW7RfmKdu0=;
        b=JdOGRyX++yNDUlPuq/R05HJj6ZnoL9jzp+dvixBQSgdKcqX98R++b6zsGTnXp7PDzu
         QPSWu2PrrzCsHTc99xEaO1euL2WoNNou1amtAeRuyTRjR26JCCn+elv/Rn+ha5PeNh8h
         NWB2qw0mAvNcGPSRn9vWpH9XYUSgeGkjiZhljcAd2cqOFUHlqElzvZ2dyQufkxPwexRm
         LYD7MMoHV6qf8hKC0q87vNuCZa9Q9G1kVCLM4vNPPle90Z9JWcrzngqUANj2y4fAyIoG
         WgivmHhJMqMyerCSd8cgXE17I0Zlyb0/VXzfKrrFF2pdv2plpCSRJ5lYjN0h2fBlQyIi
         iReQ==
X-Gm-Message-State: AO0yUKX7mfH+c3cr9g6LvNzdctzoMgcysiouzwtIFmU0c3qpXjTX/e0n
        4MltWN+zRhqarsmf/ZAKlHVwig==
X-Google-Smtp-Source: AK7set/lpUBZ9Bne9GGWFN6gWynBHiCiKi1zXGKsV102g3fb0dLfD4PR0FwBl6fJxgTrdcDKS96V+A==
X-Received: by 2002:aa7:d7c8:0:b0:4ac:c85c:fb8d with SMTP id e8-20020aa7d7c8000000b004acc85cfb8dmr24734520eds.10.1678397703225;
        Thu, 09 Mar 2023 13:35:03 -0800 (PST)
Received: from ryzen9.fritz.box ([81.221.122.240])
        by smtp.gmail.com with ESMTPSA id 8-20020a508748000000b004af7191fe35sm211486edv.22.2023.03.09.13.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 13:35:02 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, maz@kernel.org, tglx@linutronix.de
Subject: [PATCH v11 0/3] Add minimal MT8365 and MT8365-EVK support
Date:   Thu,  9 Mar 2023 22:34:58 +0100
Message-Id: <20230309213501.794764-1-bero@baylibre.com>
X-Mailer: git-send-email 2.40.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

v11:
  - Fix typo in systimer (Thanks Angelo)

v10:
  - Fix systimer properties (Thanks Amjad)
  - Drop components of the patchset that have already been merged

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


Bernhard Rosenkränzer (2):
  dt-bindings: irq: mtk, sysirq: add support for mt8365
  dt-bindings: serial: mediatek,uart: add MT8365

Fabien Parent (1):
  arm64: dts: mediatek: Initial mt8365-evk support

 .../interrupt-controller/mediatek,sysirq.txt  |   1 +
 .../bindings/serial/mediatek,uart.yaml        |   1 +
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts   | 168 ++++++++
 arch/arm64/boot/dts/mediatek/mt8365.dtsi      | 377 ++++++++++++++++++
 5 files changed, 548 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-evk.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8365.dtsi

-- 
2.40.0.rc2

