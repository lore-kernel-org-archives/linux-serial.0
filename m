Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAE6C61DA7
	for <linux-serial@archiver.kernel.org>; Fri, 27 Jan 2023 09:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjA0Jcb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 Jan 2023 04:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjA0Jc2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Jan 2023 04:32:28 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ACD38024
        for <linux-serial@vger.kernel.org>; Fri, 27 Jan 2023 01:32:25 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l8so2996844wms.3
        for <linux-serial@vger.kernel.org>; Fri, 27 Jan 2023 01:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+nr5yhr/+t2gpLfGOs+Jk9mqx4K88IomiY/057Wk89I=;
        b=afmjeNTvz+QfUYiPvDH9aI4+T3r6PKox0Z9VZNkm/tf4SrNrWhmAcU/fV+6GKjKun0
         eo9QyIGD2KagMefssAESDksaJXXFJRmKbfo1rmLaHPLpff+IelOR/8NStIUQfsWi55uS
         qA+Vkq6u2u9jqDXXsflTi3MrPmYzdeVqSMDTaSRU+kZaMs9USDTu2cP8vy0U7WTP9hWf
         NxrdpUjYK3tZ0pqfZrABbKlgk6Jg/0+eBZF8tzTept+x41W70ysQfVEoPC9ugQNzXPuM
         s+CCp3ROSLUim+9jHenXJtiPJrg6FHgFAKQW/3155i8iK7ZkRBShMo40/I7t/oUoTRlM
         kD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nr5yhr/+t2gpLfGOs+Jk9mqx4K88IomiY/057Wk89I=;
        b=LpsFGxZtes0txPwd7li1e1cLn5t25mHSsQuHmogsv7sBBG2hUOs4zRPStM0D66f0+C
         kCnT2pWCK9F6QqCq6QOandSq5Mw+4PO5qZXn1KeSym5pgAVGx2PEUoxoldDhKdIXnJTQ
         3Nu4Iedmgt7ajz4t5w/ijuRw0W4N5ksHSYo8sNacVrs/Sw1VbZr58i3xjLFjyWrngp/Y
         PT64D4KNQnBhXickiRv/8Ks7zx3G1OuvfPcsF31T0cbwuPyOazpRWKXG+zKox2AduH9U
         foO6ih0MrYmh2XXNdAM8OXYbeoXOMNCcOddRnYU3P/5hI0BMGzoF3qnOyDidjaYh3HS0
         8R8w==
X-Gm-Message-State: AFqh2krTfdp3fJ+D3dzHdMIC/VX+7F/yakluenSE2F2m9A/c/6eqawbb
        bokuRRub6VUlOeKeIf4jIDC+/A==
X-Google-Smtp-Source: AMrXdXuMTQOCdCJ4CvxFABguPpRWFrI5npvRZDl6tCte99HXwtgK6k0OjDxljIq3pESdxDzl3Zcb6A==
X-Received: by 2002:a05:600c:1c1a:b0:3da:fbd2:a324 with SMTP id j26-20020a05600c1c1a00b003dafbd2a324mr38878286wms.36.1674811943923;
        Fri, 27 Jan 2023 01:32:23 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c439300b003cfd4e6400csm3795265wmn.19.2023.01.27.01.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 01:32:23 -0800 (PST)
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
Subject: [PATCH v2 0/3] dt-bindings: serial/mtd/mc/ata: use MC peripheral props
Date:   Fri, 27 Jan 2023 10:32:14 +0100
Message-Id: <20230127093217.60818-1-krzysztof.kozlowski@linaro.org>
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
This is a v2 of this one patch:
https://lore.kernel.org/linux-devicetree/20230123151302.368277-11-krzysztof.kozlowski@linaro.org/

Changes since v1:
1. Add patches 1 and 2 to fix dt_binding_check and few dtbs_check warnings

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  dt-bindings: intel,ixp4xx-expansion-bus: split out peripheral
    properties
  dt-bindings: reference MC peripheral properties in relevant devices
  dt-bindings: serial: restrict possible child node names

 .../ata/intel,ixp4xx-compact-flash.yaml       |  1 +
 ...intel,ixp4xx-expansion-bus-controller.yaml | 64 +--------------
 ...tel,ixp4xx-expansion-peripheral-props.yaml | 80 +++++++++++++++++++
 .../mc-peripheral-props.yaml                  |  1 +
 .../devicetree/bindings/mtd/mtd-physmap.yaml  |  1 +
 .../devicetree/bindings/serial/8250.yaml      |  1 +
 .../devicetree/bindings/serial/serial.yaml    |  2 +-
 .../bindings/watchdog/maxim,max63xx.yaml      |  1 +
 8 files changed, 87 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/intel,ixp4xx-expansion-peripheral-props.yaml

-- 
2.34.1

