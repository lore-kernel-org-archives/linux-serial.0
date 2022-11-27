Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C527CC4332F
	for <linux-serial@archiver.kernel.org>; Sun, 27 Nov 2022 13:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiK0Neo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 27 Nov 2022 08:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiK0Neo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Nov 2022 08:34:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B34CE08;
        Sun, 27 Nov 2022 05:34:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12608B80937;
        Sun, 27 Nov 2022 13:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE47C433D6;
        Sun, 27 Nov 2022 13:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669556080;
        bh=XIThUy/xmyVPU1AnNTBmo5HzcB1h/80tTpyOzqgfD/c=;
        h=From:To:Cc:Subject:Date:From;
        b=XsPVbtbJ+9I6ZQHBQRh1m9zmrPTCZqoi4a0A++XQBEH3B/7CdZfugH8OcpCqpe5MZ
         4P4UbR9Fipck/ageQfdx/qe59VFn409E/j7x4TkgLG5XUrXBCGRgAKkaqL8e7d/a/9
         1uy7QYD3DYgqk3OkyolDkF6IXI4kNeK4a47DAETKOchYFP5E4HzTT8X2mZy7Omyya1
         o3koz4MLAX3DxgNX4NECzL4PQTPI4g9IISGW/clinwpM+o/q1sn14Y3YYGVfUjXEdy
         3a7aYyDvnycM1teq+JRjCaZlvNrZqNR3MmL5uHlIbqTSckli0L13UitdxYHV1rSKjd
         uchyoGxQHhP6w==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 0/9] riscv: add Bouffalolab bl808 support
Date:   Sun, 27 Nov 2022 21:24:39 +0800
Message-Id: <20221127132448.4034-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series adds Bouffalolab uart driver and basic devicetrees for
Bouffalolab bl808 SoC and Sipeed M1s dock board.

It's too late for v6.2-rc1, but I hope I can catch up the v6.3-rc1
window.

I think I have addressed all review comments to v1, correct me if I
missed anything.

PS: this series assumes the "thead,c906" riscv cpu binding patch is
merged(I see Conor has picked up it).

Since v1:
  - use FIELD_PREP and FIELD_GET macro
  - rewrite bflb_uart_tx_chars()
  - add vendor prefix for bouffalolab
  - add dt binding for bl808 compatibles
  - enable SOC_BOUFFALOLAB in defconfig
  - collect Reviewed-by tag
  - modify commit-msg as suggested

Jisheng Zhang (9):
  dt-bindings: serial: add documentation for Bouffalolab UART Driver
  serial: bflb_uart: add Bouffalolab UART Driver
  riscv: add the Bouffalolab SoC family Kconfig option
  dt-bindings: vendor-prefixes: add bouffalolab
  dt-bindings: riscv: Add bouffalolab bl808 board compatibles
  riscv: dts: bouffalolab: add the bl808 SoC base device tree
  riscv: dts: bouffalolab: add Sipeed M1s SoM and Dock devicetree
  MAINTAINERS: riscv: add entry for Bouffalolab SoC
  riscv: defconfig: enable BOUFFALOLAB SoC

 .../bindings/riscv/bouffalolab.yaml           |  34 +
 .../bindings/serial/bouffalolab,uart.yaml     |  47 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   9 +
 arch/riscv/Kconfig.socs                       |   6 +
 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/bouffalolab/Makefile      |   2 +
 .../dts/bouffalolab/bl808-sipeed-m1s-dock.dts |  25 +
 .../dts/bouffalolab/bl808-sipeed-m1s.dtsi     |  21 +
 arch/riscv/boot/dts/bouffalolab/bl808.dtsi    |  74 +++
 arch/riscv/configs/defconfig                  |   1 +
 drivers/tty/serial/Kconfig                    |  18 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/bflb_uart.c                | 610 ++++++++++++++++++
 include/uapi/linux/serial_core.h              |   3 +
 15 files changed, 854 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/bouffalolab.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/bouffalolab,uart.yaml
 create mode 100644 arch/riscv/boot/dts/bouffalolab/Makefile
 create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s-dock.dts
 create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi
 create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808.dtsi
 create mode 100644 drivers/tty/serial/bflb_uart.c

-- 
2.38.1

