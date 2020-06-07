Return-Path: <SRS0=JLb2=7U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D616EC433DF
	for <linux-serial@archiver.kernel.org>; Sun,  7 Jun 2020 13:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC18B20723
	for <linux-serial@archiver.kernel.org>; Sun,  7 Jun 2020 13:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591536450;
	bh=35L2ZMO3lOBbjfh/kiATRAZjy0NoIIUfJKgxb9U/9Mg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=XqfoH2b2oZmox2WKQbDHbkuwYO/m/L4IUuJvq9CriQhwTKjLHo2rcFNB9MSMRwB0l
	 +8TrSahlQATC0e4j+Yf4NVFiMciOOxV7M2Rvl2QricGy7xCsJE4a/VQ/98MdiI3lNi
	 htZxlv2DK/q3VQRRC8WsnB6iNdlIAXxfK6sdJ5wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgFGN10 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 7 Jun 2020 09:27:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgFGN10 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 7 Jun 2020 09:27:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 390E020723;
        Sun,  7 Jun 2020 13:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591536445;
        bh=35L2ZMO3lOBbjfh/kiATRAZjy0NoIIUfJKgxb9U/9Mg=;
        h=Date:From:To:Cc:Subject:From;
        b=nceG17G+QySMiWCSdtTz+XX1BLnT92LEAltw5Cc+PuOomCPJY7kvOTYSwLyCBudST
         lkp0pWuBk0mwy9ByBPk3Z7iiYH5zhzwuMWh9zJMki9JEAoCkd/wTNbOyi0cCzVPIDQ
         zRU88gRflbStAi6dug6JffCNKKvOj4kTvm3vkQwI=
Date:   Sun, 7 Jun 2020 15:27:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver patches for 5.8-rc1
Message-ID: <20200607132723.GA168173@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.8-rc1

for you to fetch changes up to a1b44ea340b21c99b34c93acad233da727cb88ba:

  tty: serial: qcom_geni_serial: Add 51.2MHz frequency support (2020-05-29 13:49:02 +0200)

----------------------------------------------------------------
TTY/Serial driver updates for 5.8-rc1

Here is the tty and serial driver updates for 5.8-rc1

Nothing huge at all, just a lot of little serial driver fixes, updates
for new devices and features, and other small things.  Full details are
in the shortlog.

Note, you will get a conflict merging with your tree in the
Documentation/devicetree/bindings/serial/rs485.yaml file, but it should
be pretty obvious what to do.  If not, I'm sure Rob will clean it all up
afterwards :)

All of these have been in linux-next with no issues for a while.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (2):
      serial: 8250_exar: Make use of PCI_DEVICE_DATA() macro
      serial: imx: Initialize lock for non-registered console

Anson Huang (2):
      tty: serial: imx: Add return value check for platform_get_irq()
      tty: serial: fsl_lpuart: Use __maybe_unused instead of #if CONFIG_PM_SLEEP

Colin Ian King (1):
      drivers/tty: remove redundant assignment to variable i and rename it to ret

Daniel Mack (4):
      sc16is7xx: Always use falling edge IRQ
      sc16is7xx: Use threaded IRQ
      sc16is7xx: Allow sharing the IRQ line
      sc16is7xx: Read the LSR register for basic device presence check

Dmitry Torokhov (1):
      vt: keyboard: avoid signed integer overflow in k_ascii

Emil Velikov (11):
      tty/sysrq: alpha: export and use __sysrq_get_key_op()
      tty/sysrq: constify the sysrq API
      tty/sysrq: constify the the sysrq_key_op(s)
      alpha: constify sysrq_key_op
      MIPS: constify sysrq_key_op
      powerpc/xmon: constify sysrq_key_op
      sparc64: constify sysrq_key_op
      drm: constify sysrq_key_op
      kdb: constify sysrq_key_op
      kernel/power: constify sysrq_key_op
      rcu: constify sysrq_key_op

Erwan Le Ray (1):
      serial: stm32: add no_console_suspend support

Fabio Estevam (1):
      serial: fsl_lpuart: Change DMA failure messages to debug level

Greg Kroah-Hartman (5):
      Merge 5.7-rc3 into tty-next
      Revert "tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state"
      Merge 5.7-rc5 into tty-next
      Revert "tty: hvc: Fix data abort due to race in hvc_open"
      Merge 5.7-rc7 into tty-next

Gregory CLEMENT (5):
      tty: n_gsm: Improve debug output
      tty: n_gsm: Fix SOF skipping
      tty: n_gsm: Fix waking up upper tty layer when room available
      tty: n_gsm: Remove unnecessary test in gsm_print_packet()
      tty: n_gsm: Fix bogus i++ in gsm_data_kick

Heiko Stuebner (1):
      serial: 8520_port: Fix function param documentation

Hyunki Koo (3):
      serial: samsung: Replace rd_regb/wr_regb with rd_reg/wr_reg
      serial: samsung: dt-bindings: Add reg-io-width compatible
      serial: samsung: 32-bit access for TX/RX hold registers

Jason Yan (2):
      tty: hvc: remove hvcs_driver_string
      tty: mxser: make mxser_change_speed() return void

Ji-Ze Hong (Peter Hong) (1):
      serial: 8250_fintek: Add F81966 Support

Jiri Slaby (4):
      vt: selection, split __set_selection_kernel
      vt: extract selection chars storing from vc_do_selection
      tty: rocket, remove unneeded variable
      tty: hvc_console, fix crashes on parallel open/close

John Stultz (1):
      serial: amba-pl011: Make sure we initialize the port.lock spinlock

Jonathan Bakker (1):
      tty: serial: samsung: Correct clock selection logic

Josh Triplett (1):
      serial: 8250: Enable 16550A variants by default on non-x86

Linus Walleij (3):
      serial: lpc32xx_hs: Drop surplus include
      serial: omap: Convert to use GPIO descriptors
      serial: sh-sci: Drop unused include

Lukas Wunner (4):
      serial: 8250: Avoid error message on reprobe
      serial: Allow uart_get_rs485_mode() to return errno
      dt-bindings: serial: Add binding for rs485 bus termination GPIO
      serial: 8250: Support rs485 bus termination GPIO

Manivannan Sadhasivam (2):
      dt-bindings: serial: Document CTS/RTS gpios in STM32 UART
      tty: serial: Add modem control gpio support for STM32 UART

Matthias Schiffer (1):
      tty: serial: imx: clear Ageing Timer Interrupt in handler

Michael Walle (1):
      tty: serial: fsl_lpuart: make coverity happy

Pascal Huerst (2):
      dt-bindings: sc16is7xx: Add flag to activate IrDA mode
      sc16is7xx: Add flag to activate IrDA mode

Raghavendra Rao Ananta (1):
      tty: hvc: Fix data abort due to race in hvc_open

Rahul Tanwar (3):
      serial: lantiq: Add x86 in Kconfig dependencies for Lantiq serial driver
      serial: lantiq: Make UART's use as console selectable
      serial: lantiq: Make driver modular

Rajendra Nayak (1):
      tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state

Raviteja Narayanam (2):
      serial: uartps: Wait for tx_empty in console setup
      serial: uartps: Use cdns_uart_tx_empty in console_write

Serge Semin (1):
      serial: 8250: Fix max baud limit in generic 8250 port

Wei Yongjun (1):
      sparc64: vcc: Fix error return code in vcc_probe()

satya priya (1):
      tty: serial: qcom_geni_serial: Add 51.2MHz frequency support

 Documentation/admin-guide/sysrq.rst                |  10 +-
 .../devicetree/bindings/serial/nxp,sc16is7xx.txt   |   4 +
 .../devicetree/bindings/serial/rs485.yaml          |   4 +
 .../devicetree/bindings/serial/samsung_uart.yaml   |   8 ++
 .../devicetree/bindings/serial/st,stm32-uart.yaml  |  14 +++
 arch/alpha/kernel/setup.c                          |  13 +-
 arch/mips/kernel/sysrq.c                           |   2 +-
 arch/powerpc/xmon/xmon.c                           |   2 +-
 arch/sparc/kernel/process_64.c                     |   4 +-
 drivers/gpu/drm/drm_fb_helper.c                    |   4 +-
 drivers/tty/hvc/hvc_console.c                      |  23 ++--
 drivers/tty/hvc/hvcs.c                             |   2 -
 drivers/tty/mxser.c                                |   7 +-
 drivers/tty/n_gsm.c                                |  39 +++---
 drivers/tty/rocket.c                               |  10 +-
 drivers/tty/serial/8250/8250_core.c                |  18 ++-
 drivers/tty/serial/8250/8250_exar.c                |  65 +++++-----
 drivers/tty/serial/8250/8250_fintek.c              |  13 +-
 drivers/tty/serial/8250/8250_port.c                |   9 +-
 drivers/tty/serial/8250/Kconfig                    |   1 +
 drivers/tty/serial/8250/serial_cs.c                |   6 +-
 drivers/tty/serial/Kconfig                         |  16 ++-
 drivers/tty/serial/amba-pl011.c                    |   1 +
 drivers/tty/serial/ar933x_uart.c                   |   6 +-
 drivers/tty/serial/atmel_serial.c                  |   6 +-
 drivers/tty/serial/fsl_lpuart.c                    |  27 ++---
 drivers/tty/serial/imx.c                           |  13 +-
 drivers/tty/serial/lantiq.c                        |  40 ++++++-
 drivers/tty/serial/lpc32xx_hs.c                    |   1 -
 drivers/tty/serial/omap-serial.c                   |  52 ++++----
 drivers/tty/serial/qcom_geni_serial.c              |   7 +-
 drivers/tty/serial/samsung_tty.c                   |  84 ++++++++++---
 drivers/tty/serial/sc16is7xx.c                     |  73 +++++++----
 drivers/tty/serial/serial_core.c                   |  22 +++-
 drivers/tty/serial/sh-sci.h                        |   1 -
 drivers/tty/serial/stm32-usart.c                   |  74 ++++++++++--
 drivers/tty/serial/stm32-usart.h                   |   1 +
 drivers/tty/serial/xilinx_uartps.c                 |  12 +-
 drivers/tty/sysrq.c                                |  68 ++++++-----
 drivers/tty/vcc.c                                  |   1 +
 drivers/tty/vt/keyboard.c                          |  26 ++--
 drivers/tty/vt/selection.c                         | 133 +++++++++++----------
 include/linux/serial_core.h                        |   4 +-
 include/linux/sysrq.h                              |  18 +--
 kernel/debug/debug_core.c                          |   2 +-
 kernel/power/poweroff.c                            |   2 +-
 kernel/rcu/tree_stall.h                            |   2 +-
 47 files changed, 619 insertions(+), 331 deletions(-)
