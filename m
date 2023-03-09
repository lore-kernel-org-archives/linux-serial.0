Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF741C6FD19
	for <linux-serial@archiver.kernel.org>; Thu,  9 Mar 2023 21:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCIVuI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Mar 2023 16:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjCIVuH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Mar 2023 16:50:07 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999D0E9817
        for <linux-serial@vger.kernel.org>; Thu,  9 Mar 2023 13:50:04 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a25so12997904edb.0
        for <linux-serial@vger.kernel.org>; Thu, 09 Mar 2023 13:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678398603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KK2kVS/pDWxq/x5pUQs4W8hA5sU/CpHNUPW7RfmKdu0=;
        b=Wbg1jSF872bITS/MV4oiOvXaEN6BjZnu2OMHT+QhKMUR+1d9M4iS55uzTP4Z0+LwZd
         a18IH5Z/RxxE9sYRJ/XYdhWNNtiAwOP+OjjfeXsFAq/RsyuN+k3xFa/neoOzGGYsSwxc
         1YM+bbd1fAkHbDvTHRhEhTyxvd5cRqDcFJ0EZUK+9+px0dwMKlFXzlA6FYjgrnBP4nF+
         AEysNe5rnnOmTeSsAt1OXl50AoMYR6tlvKKoOt+aPEQoEJxOr2aDPp9MiNd1BL86+PPw
         nTs6/RAyvgGuRCYrNmDPmah6/ySoAqfZ1cpBd9fXAk6qMFjNM5EpxPfQ3yUyGtup2iXj
         2CZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678398603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KK2kVS/pDWxq/x5pUQs4W8hA5sU/CpHNUPW7RfmKdu0=;
        b=rBtb6tHjjXC/JWZPVQ46n2dzS6fKSPvX+Q2fxDlNCFIuGglxUegVcGo1qII7LxoY80
         t+O1GXWaVnNnKnyukPn3VHNw4/bIam1e6/zUia1nA9Qqx+kwcBU5HarQ6nwEqLFxesSo
         VghHukVSa611VjmmOFth9FpHEOiGrWbDOawpLa/msJBSruOW0LEwkToY0ie1cYqhiY3D
         dr4V8KwQvCSBf8BDTj1CpIyZ+28U5FrYDZuzr28P9KmeE/3dy6lV7fdKaejvgZqdZl1Q
         aZfm/zOOlpocQ/Bfn3cIdY8sp9WoIlNNZEL8IWXfVOJYIVwHCq1ID0u7ZmEBK9zejAuK
         +Ygg==
X-Gm-Message-State: AO0yUKWC6CGQPPV9dBzotK5Kbn4fu9LvoUjCAg+wwUrpm/o8RrIBvZS5
        jU+ppxhNs6VqMIAJT+3xfwI+OA==
X-Google-Smtp-Source: AK7set+5QCYisQjzh6bsce1zFynUkiZ/RTqVYScw9ZFdEDXjWr+TVTj/rn3OhSNxi4BNNZDQlfhwpQ==
X-Received: by 2002:a50:ee18:0:b0:4a0:e31a:434 with SMTP id g24-20020a50ee18000000b004a0e31a0434mr20831551eds.27.1678398603119;
        Thu, 09 Mar 2023 13:50:03 -0800 (PST)
Received: from ryzen9.fritz.box ([81.221.122.240])
        by smtp.gmail.com with ESMTPSA id r20-20020a50c014000000b004bc2d1c0fadsm218206edb.32.2023.03.09.13.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 13:50:02 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, maz@kernel.org, tglx@linutronix.de
Subject: [PATCH v11 0/3] Add minimal MT8365 and MT8365-EVK support
Date:   Thu,  9 Mar 2023 22:50:01 +0100
Message-Id: <20230309215001.881646-1-bero@baylibre.com>
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

