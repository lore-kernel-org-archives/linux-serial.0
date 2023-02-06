Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2703C636D4
	for <linux-serial@archiver.kernel.org>; Mon,  6 Feb 2023 09:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjBFJ0n (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Feb 2023 04:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBFJ0k (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Feb 2023 04:26:40 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD40413DC8
        for <linux-serial@vger.kernel.org>; Mon,  6 Feb 2023 01:26:31 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so2943861wmb.2
        for <linux-serial@vger.kernel.org>; Mon, 06 Feb 2023 01:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zGhCvFoTy0X36TbIluhE7gVD7vDKBMWtC9eNAwAf9ZU=;
        b=s82aRZY6NB5/PGChQ03T+YvIWJIDRXw7Y5GR5ixDk0TMQ7AKnUFAnfwDg9LGTHgd8y
         W5vxxg5JQk54PkyijgAfnXNwZBje8UCXhcJeUfFvEAsCfJjGgEK+SUmc0VzDXANs4Uej
         zpnZg/5INLkmCT/PPW8W1rXdAsAKB1Bj5B8u3ROpc3aH6401vBaXGrvs3xMEChoPIoYg
         7uoLhSSnQTv2gxfEGDo7Cg6LhNsTrdRYqlhaHJYdAn/ebvB7+uvfZzYEkH/Q+hFKThh+
         NqIBE+2XZ6u+bsVORZ9zgSWxGwFPPgpk2Po3U+lo1nGgKwWrXtPsFfmy5o+WI41Tflk4
         ApgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGhCvFoTy0X36TbIluhE7gVD7vDKBMWtC9eNAwAf9ZU=;
        b=XAtxHPn3P2zwERGL3nwQ+cEL3ibvVazhU7WaVIHiY0UgMFx9V3Oxyf3+uZZU6YeIFW
         qTRVVBpuEG+hKiwEJhlQean1QS3wHERdQ9buo94S7giI0l4PXpkdiUMYudM7jIuEA8ul
         E7uEq4ELzm50TWbO3it9a0hmBKzwXm7cXa8EGsbERNdCs+ugY15GXQbzR0P8Kj5l8h76
         fCRW2LocqROkskxhzaChdg0E3nWVH1nSf0wFMM+6N+7GWHOOol/ATczGug9i8skoHSpN
         AzHGyNNF94NV59N1Kj+p5w32iqUbjQTGJ4ELaMjEGFyesTeNJh2Oiv2L4t4GLfyYGFS3
         5Vdg==
X-Gm-Message-State: AO0yUKWV1zxv4e1/j29MumQN68E1w04BsmHiFx62spAUY1OAkiFGi0r/
        jVA82BbYDh2n7f9yiKwbS+BVxw==
X-Google-Smtp-Source: AK7set+37JMLJnS4PPNFcpsshhqiHoi7Y6DOKHumWXTgNxkbG6T5RGuIwyDWGe2QTnGqcm8d7QeoEA==
X-Received: by 2002:a05:600c:1d05:b0:3e0:185:e935 with SMTP id l5-20020a05600c1d0500b003e00185e935mr2358414wms.36.1675675589656;
        Mon, 06 Feb 2023 01:26:29 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m5-20020a7bcb85000000b003de8a1b06c0sm15722568wmi.7.2023.02.06.01.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 01:26:29 -0800 (PST)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 0/3] dt-bindings: serial/mtd/mc/ata: use MC peripheral props
Date:   Mon,  6 Feb 2023 10:26:21 +0100
Message-Id: <20230206092624.22922-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

Dependencies
============
I think entire patchset should go via one tree (Rob's). Patch #2 depends on
patch #1.  Patch #3 could go separate tree as long as others are in the
linux-next.  However for simplicity let's push everything through Rob's DT
tree?

Changelog
=========
Changes since v2:
1. Add tags.
2. Move intel,ixp4xx-expansion-bus-controller.yaml to memory-controllers (Rob).
3. Drop | in intel,ixp4xx-expansion-peripheral-props.yaml (Rob).

Changes since v1:
1. Add patches 1 and 2 to fix dt_binding_check and few dtbs_check warnings
v1: https://lore.kernel.org/linux-devicetree/20230123151302.368277-11-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  dt-bindings: intel,ixp4xx-expansion-bus: split out peripheral
    properties
  dt-bindings: reference MC peripheral properties in relevant devices
  dt-bindings: serial: restrict possible child node names

 .../ata/intel,ixp4xx-compact-flash.yaml       |  1 +
 ...intel,ixp4xx-expansion-bus-controller.yaml | 66 +--------------
 ...tel,ixp4xx-expansion-peripheral-props.yaml | 80 +++++++++++++++++++
 .../mc-peripheral-props.yaml                  |  1 +
 .../devicetree/bindings/mtd/mtd-physmap.yaml  |  1 +
 .../devicetree/bindings/serial/8250.yaml      |  1 +
 .../devicetree/bindings/serial/serial.yaml    |  2 +-
 .../bindings/watchdog/maxim,max63xx.yaml      |  1 +
 MAINTAINERS                                   |  2 +-
 9 files changed, 89 insertions(+), 66 deletions(-)
 rename Documentation/devicetree/bindings/{bus => memory-controllers}/intel,ixp4xx-expansion-bus-controller.yaml (57%)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/intel,ixp4xx-expansion-peripheral-props.yaml

-- 
2.34.1

