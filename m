Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B25FC4332F
	for <linux-serial@archiver.kernel.org>; Sun, 20 Nov 2022 08:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKTIbJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 20 Nov 2022 03:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKTIbI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 20 Nov 2022 03:31:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E8B1B1DC;
        Sun, 20 Nov 2022 00:31:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3CB7B8094C;
        Sun, 20 Nov 2022 08:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92241C433D6;
        Sun, 20 Nov 2022 08:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668933064;
        bh=d1nQsTvqVNRfsr2uUYzaSLywza3QLKAC/5j5ALiH8bQ=;
        h=From:To:Cc:Subject:Date:From;
        b=cLw5+DQ+9ToprmmNHwUhprUPQ1qDgUgRmOQ/XwBXlinXnERWlkwGkbo6Nf3wiUID2
         j99nQXmhf/Sw6QQf6fDa2s4rm/PtikR3EuxyMrEbhB0o12QGIjXLy7SkGFZzvIt+kf
         zk6q3HF61/TVa99KZms1DW3PQbD5eVF9Y1Gx/tOmOV/McxM4qNn1XQ7yIMwZtzdPqg
         nKREtt+C/pjNbbEhWw3bk1a9GgOqTamGjBXxV6Q4gWTPY7BbD5xuhkbKGP/RwnN5z8
         wwOC3KBxCRt71Y8CLvA+ELcIroIjnz5IrKl5oJozbvWDwKroTVHbgPubhZppmweIrt
         fmjgylK19oghQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 0/7] riscv: add Bouffalolab bl808 support
Date:   Sun, 20 Nov 2022 16:21:07 +0800
Message-Id: <20221120082114.3030-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series adds Bouffalolab uart driver and basic devicetrees for
Bouffalolab bl808 SoC and Sipeed M1S dock board.

It's too late for v6.2-rc1, but I hope I can catch up the v6.3-rc1
window.

Jisheng Zhang (7):
  dt-bindings: serial: add bindings doc for Bouffalolab
  serial: bflb_uart: add Bouffalolab UART Driver
  MAINTAINERS: add myself as a reviewer for Bouffalolab uart driver
  riscv: add the Bouffalolab SoC family Kconfig option
  riscv: dts: bouffalolab: add the bl808 SoC base device tree
  riscv: dts: bouffalolab: add Sipeed M1S dock devicetree
  MAINTAINERS: add myself as Bouffalolab SoC entry maintainer

 .../bindings/serial/bouffalolab,uart.yaml     |  50 ++
 MAINTAINERS                                   |  12 +
 arch/riscv/Kconfig.socs                       |   6 +
 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/bouffalolab/Makefile      |   2 +
 .../boot/dts/bouffalolab/bl808-sipeed-m1s.dts |  30 +
 arch/riscv/boot/dts/bouffalolab/bl808.dtsi    |  74 ++
 drivers/tty/serial/Kconfig                    |  18 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/bflb_uart.c                | 659 ++++++++++++++++++
 include/uapi/linux/serial_core.h              |   3 +
 11 files changed, 856 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/bouffalolab,uart.yaml
 create mode 100644 arch/riscv/boot/dts/bouffalolab/Makefile
 create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dts
 create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808.dtsi
 create mode 100644 drivers/tty/serial/bflb_uart.c

-- 
2.37.2

