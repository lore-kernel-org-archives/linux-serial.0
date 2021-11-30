Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A80C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 30 Nov 2021 11:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbhK3LQt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 Nov 2021 06:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237394AbhK3LQs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Nov 2021 06:16:48 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2519FC061748
        for <linux-serial@vger.kernel.org>; Tue, 30 Nov 2021 03:13:29 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id r26so52777378lfn.8
        for <linux-serial@vger.kernel.org>; Tue, 30 Nov 2021 03:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=skodrfetI6sQYeMS84TqmzdXMiAWMy4xHtCAByWVHFI=;
        b=NN1gLQ6ZhDhSiyAh6hHxZjFFbU+o0aZMHv0WdzvXxzujKnmjbroGcnNEYvup4NVhvO
         zyHF49SMxTWzu+MDfYNdIqoMonEtgXLYfHmm/Hmo6038EqrL2w6wlfQVsWfEkX6fAN+I
         vuJpKn4n5vq22jHEIQezZN65K81Gqq/qNONPAUd7hOQ6Dz+Yoj23cNh3H00kv789YBm9
         RqU3EuEn/NdRjgukedVz/yjXwHU/4+AvMUnwsDKJIvBqjWmiUHVjfYu05qxwiJh8dxeh
         I/bbgVvF1S+LlGpb0M11cwgYLBcVFBlATV8hSV8l77FTGw3wm7UlMfni/nm8GDRTno+2
         6BPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=skodrfetI6sQYeMS84TqmzdXMiAWMy4xHtCAByWVHFI=;
        b=JhdV3zrlX0fytl/J2BtwJWoWu3/zfTnmYnNfoxsTwzQxjpKYKllQqZKLsFsGUuYN7W
         Ph4h/znjroc8HtdYJLQLUDkNzdWIuWRG0JZ32m13Zo35vIIFBwUkAScyg+BGS0WPBlbz
         brPNDNL/K4gdPqo+/7G1byccUn/G3v7qlC0tXOc6/hS2+dlFniH8HAtT4hznfl8kf4mR
         4ZmGaD3j0x082d4kkCMwO7y/m6qDl5mSYBDFO+5I0Du4W6AktRBEOpKPmXofkTJUcu41
         DlQxcPOgIBRoZj/PO3DrdqIj/2yVCFV7RGoTMldGOES5E7kHHjn6Y4kj91Izjrik4Cu7
         Rq9g==
X-Gm-Message-State: AOAM530EfSU2FKxFPwR4smprn3ld7rodbm8c2qASLXj495NkZ0TLzeMW
        vGbN+FjYjwIu21Gt8vqSusKG7g==
X-Google-Smtp-Source: ABdhPJxi5miZzbt8q+GI/aVfntdWzDkTcjLze8k3gHSi7jFuDn7DNzNHUChiiCmEdpxUddEvmIHGrA==
X-Received: by 2002:a05:6512:1094:: with SMTP id j20mr51460255lfg.237.1638270807395;
        Tue, 30 Nov 2021 03:13:27 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id b13sm1903706lfv.200.2021.11.30.03.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:13:26 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 RESEND 0/5] soc: samsung: Add USI driver
Date:   Tue, 30 Nov 2021 13:13:20 +0200
Message-Id: <20211130111325.29328-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

USIv2 IP-core provides selectable serial protocol (UART, SPI or
High-Speed I2C); only one can be chosen at a time. This series
implements USIv2 driver, which allows one to select particular USI
function in device tree, and also performs USI block initialization.

With that driver implemented, it's not needed to do USI initialization
in protocol drivers anymore, so that code is removed from the serial
driver.

Because USI driver is tristate (can be built as a module), serial driver
was reworked so it's possible to use its console part as a module too.
This way we can load serial driver module from user space and still have
serial console functional.

Make it impossible to build UART/SPI/I2C driver as a built-in when USIv2
driver built as a module: USIv2 configuration must be always done before
tinkering with particular protocol it implements.

Design features:
  - "reg" property contains USI registers start address (0xc0 offset);
    it's used in the driver to access USI_CON and USI_OPTION registers.
    This way all USI initialization (reset, HWACG, etc) can be done in
    USIv2 driver separately, rather than duplicating that code over
    UART/SPI/I2C drivers
  - System Register (system controller node) and its SW_CONF register
    offset are provided in "samsung,sysreg" property; it's used to
    select USI function (protocol to be used)
  - USI function is specified in "samsung,mode" property; integer value
    is used to simplify parsing
  - there is "samsung,clkreq-on" bool property, which makes driver
    disable HWACG control (needed for UART to work properly)
  - PCLK and IPCLK clocks are both provided to USI node; apparently both
    need to be enabled to access USI registers
  - protocol nodes are embedded (as a child nodes) in USI node; it
    allows correct init order, and reflects HW properly
  - USIv2 driver is a tristate: can be also useful from Android GKI
    requirements point of view
  - driver functions are implemented with further development in mind:
    we might want to add some SysFS interface later for example, or
    provide some functions to serial drivers with EXPORT_SYMBOL(), etc;
    also another USI revisions could be added (like USIv1)

Changes in v2:
  - Renamed all 'usi_v2' wording to just 'usi' everywhere
  - Removed patches adding dependency on EXYNOS_USI for UART/I2C/SPI
    drivers
  - Added patch: "tty: serial: samsung: Fix console registration from
    module"
  - Combined dt-bindings doc and dt-bindings header patches
  - Reworked USI driver to be ready for USIv1 addition
  - Improved dt-bindings
  - Added USI_V2_NONE mode value

Sam Protsenko (5):
  dt-bindings: soc: samsung: Add Exynos USI bindings
  soc: samsung: Add USI driver
  tty: serial: samsung: Remove USI initialization
  tty: serial: samsung: Enable console as module
  tty: serial: samsung: Fix console registration from module

 .../bindings/soc/samsung/exynos-usi.yaml      | 135 +++++++++
 drivers/soc/samsung/Kconfig                   |  14 +
 drivers/soc/samsung/Makefile                  |   2 +
 drivers/soc/samsung/exynos-usi.c              | 274 ++++++++++++++++++
 drivers/tty/serial/Kconfig                    |   2 +-
 drivers/tty/serial/samsung_tty.c              |  78 ++---
 include/dt-bindings/soc/samsung,exynos-usi.h  |  17 ++
 include/linux/serial_s3c.h                    |   9 -
 8 files changed, 483 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
 create mode 100644 drivers/soc/samsung/exynos-usi.c
 create mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h

-- 
2.30.2

