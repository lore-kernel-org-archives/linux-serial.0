Return-Path: <SRS0=locQ=DV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402D5C433DF
	for <linux-serial@archiver.kernel.org>; Wed, 14 Oct 2020 17:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA11B22227
	for <linux-serial@archiver.kernel.org>; Wed, 14 Oct 2020 17:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602697674;
	bh=3PW7r+uDZ9YzCNIpR7/h7kIHXJrLZPAav/yRL5sEaf0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=gOJX4jhbN38nduy0W3XMGFXsL5kycLrkx9YgYdD3/nydmCDp6gnnhGYJGVhD5pOwt
	 HuPw2LwdhHMnQDj2fi4uFVwl5XdRYLrMq1DPL5jhPwmY8/3PeGSMPw0EYCd+oeBIFL
	 jf8nu+RjjPJrk9IK6xiCjS6j5+irQhK/yQlKSB+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgJNRry (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Oct 2020 13:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgJNRry (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Oct 2020 13:47:54 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E56F721D7F;
        Wed, 14 Oct 2020 17:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602697672;
        bh=3PW7r+uDZ9YzCNIpR7/h7kIHXJrLZPAav/yRL5sEaf0=;
        h=Date:From:To:Cc:Subject:From;
        b=lJ3CzkHEFJSFDCViHMOwkdXeyRLF5EmewpQ1RQZUuFPtqoMVhYNJxJ36DmO9yFrG/
         pwwrE7a5qyYN5nBiTTFMOmDTTJEHdtYbA/fYY/uTn85Kjd5z4TUn1++jKWCB4WJxdL
         usGksBAjyeYGOmU/v6E2q0TO0wUG/efGlVMAr5e4=
Date:   Wed, 14 Oct 2020 19:48:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver patches for 5.10-rc1
Message-ID: <20201014174826.GA3786470@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit ba4f184e126b751d1bffad5897f263108befc780:

  Linux 5.9-rc6 (2020-09-20 16:33:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.10-rc1

for you to fetch changes up to 4be87603b6dc9e49c2e07151bb51180dc0b6964a:

  serial: mcf: add sysrq capability (2020-10-05 13:32:30 +0200)

----------------------------------------------------------------
TTY/Serial patches for 5.10-rc1

Here is the big set of tty and serial driver patches for 5.10-rc1.

Lots of little things in here, including:
	- tasklet_setup api conversions
	- sysrq support for capital letters
	- vt and vc cleanups and unwinding the mess some more
	- serial driver updates and minor tweaks
	- new device ids
	- rs485 support for some drivers
	- serial binding documentation updates
	- lots of small serial driver changes for reported issues

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alex Dewar (1):
      serial: core: don't use snprintf() for formatting sysfs attrs

Allen Pais (4):
      tty: ipwireless: convert tasklets to use new tasklet_setup() API
      tty: atmel_serial: convert tasklets to use new tasklet_setup() API
      tty: ifx6x60: convert tasklets to use new tasklet_setup() API
      tty: timbuart: convert tasklets to use new tasklet_setup() API

Andrij Abyzov (1):
      serial: 8250_fsl: Fix TX interrupt handling condition

Andrzej Pietrasiewicz (1):
      tty/sysrq: Extend the sysrq_key_table to cover capital letters

Andy Shevchenko (1):
      serial: sa1100: use platform_get_resource()

Angelo Dureghello (2):
      serial: fsl_lpuart: add sysrq support when using dma
      serial: mcf: add sysrq capability

Artem Savkov (1):
      pty: do tty_flip_buffer_push without port->lock in pty_write

Christophe JAILLET (2):
      tty: serial: icom: switch from 'pci_' to 'dma_' API
      tty: synclink_gt: switch from 'pci_' to 'dma_' API

Daniel Mack (1):
      sc16is7xx: Set iobase to device index

Douglas Anderson (1):
      tty: serial: qcom_geni_serial: 115.2 is a better console default than 9600

Du Huanpeng (1):
      serial: 8250_pci: Add WCH384_8S 8 port serial device

Fabio Estevam (1):
      serial: fsl_lpuart: Fix typo in "transfer"

Greg Kroah-Hartman (3):
      Merge 5.9-rc3 into tty-next
      Merge 5.9.0-rc6 into tty-next
      Merge ba31128384dfd ("Merge tag 'libnvdimm-fixes-5.9-rc7' of git://git.kernel.org/.../nvdimm/nvdimm") into tty-next

Hsin-Yi Wang (2):
      tty: serial: print earlycon info after match->setup
      tty: serial: 8250_mtk: set regshift for mmio32

Jan Kara (1):
      dax: Fix compilation for CONFIG_DAX && !CONFIG_FS_DAX

Jason Yan (1):
      serial: ucc_uart: make qe_uart_set_mctrl() static

Jiri Slaby (25):
      vt: make vc_data pointers const in selection.h
      vt: declare xy for get/putconsxy properly
      vc: propagate "viewed as bool" from screenpos up
      vc_screen: document and cleanup vcs_vc
      vc_screen: rewrite vcs_size to accept vc, not inode
      vc_screen: sanitize types in vcs_write
      vc_screen: extract vcs_write_buf_noattr
      vc_screen: extract vcs_write_buf
      vc_screen: eliminate ifdefs from vcs_write_buf
      vc_screen: sanitize types in vcs_read
      vs_screen: kill tmp_count from vcs_read
      vc_screen: extract vcs_read_buf_uni
      vc_screen: extract vcs_read_buf_noattr
      vc_screen: extract vcs_read_buf
      vc_screen: extract vcs_read_buf_header
      vc_screen: prune macros
      tty: n_gsm, eliminate indirection for gsm->{output,error}()
      newport_con: fix no return statement in newport_show_logo
      newport_con: make module's init & exit static using module_driver
      tty: fix kernel-doc
      tty: ldiscs, fix kernel-doc
      tty: vt, fix kernel-doc
      tty: synclink, fix kernel-doc
      tty: serial, fix kernel-doc
      Revert "vc_screen: extract vcs_read_buf_header"

Julia Lawall (1):
      pch_uart: drop double zeroing

Krzysztof Kozlowski (2):
      serial: 8250: Simplify with dev_err_probe()
      serial: core: Simplify with dev_err_probe()

Lad Prabhakar (2):
      dt-bindings: serial: renesas, scif: Document r8a774e1 bindings
      dt-bindings: serial: renesas, hscif: Document r8a774e1 bindings

Linus Torvalds (1):
      Merge tag 'libnvdimm-fixes-5.9-rc7' of git://git.kernel.org/.../nvdimm/nvdimm

Marek Vasut (1):
      serial: stm32: Add RS485 RTS GPIO control again

Matthias Schiffer (1):
      tty: serial: imx: disable TXDC IRQ in imx_uart_shutdown() to avoid IRQ storm

Paras Sharma (1):
      serial: qcom_geni_serial: To correct QUP Version detection logic

Peng Fan (2):
      tty: serial: lpuart: fix lpuart32_write usage
      tty: serial: fsl_lpuart: fix lpuart32_poll_get_char

Peter Zijlstra (1):
      serial: pl011: Fix lockdep splat when handling magic-sysrq interrupt

Qinglang Miao (3):
      serial: pmac_zilog: use for_each_child_of_node() macro
      serial: mvebu-uart: simplify the return expression of mvebu_uart_probe()
      serial: mvebu-uart: fix unused variable warning

Seiya Wang (2):
      dt-bindings: serial: Add compatible for Mediatek MT8192
      dt-bindings: timer: Add compatible for Mediatek MT8192

Serge Semin (3):
      serial: 8250: Discard RTS/DTS setting from clock update method
      serial: 8250: Skip uninitialized TTY port baud rate update
      serial: 8250_dw: Fix clk-notifier/port suspend deadlock

Tetsuo Handa (4):
      newport_con: remove no-op newport_set_origin()
      sticon: remove no-op sticon_set_origin()
      vt_ioctl: make VT_RESIZEX behave like VT_RESIZE
      fbcon: remove no-op fbcon_set_origin()

Thomas Petazzoni (1):
      serial: max310x: rework RX interrupt handling

Tong Zhang (2):
      tty: serial: earlycon dependency
      tty: ipwireless: fix error handling

Tyrel Datwyler (1):
      tty: hvcs: Don't NULL tty->driver_data until hvcs_cleanup()

Viresh Kumar (1):
      tty: serial: qcom_geni_serial: Unconditionally call dev_pm_opp_of_remove_table()

Yang Yingliang (2):
      tty: hvc: fix link error with CONFIG_SERIAL_CORE_CONSOLE=n
      tty: serial: imx: fix link error with CONFIG_SERIAL_CORE_CONSOLE=n

Ye Bin (1):
      serial: imx: Delete duplicated argument to '|' in imx_uart_probe

YueHaibing (1):
      serial: 8250_pci: Remove unused function get_pci_irq()

kuldip dwivedi (1):
      serial: 8250_fsl: Add ACPI support

satya priya (1):
      tty: serial: qcom_geni_serial: Fix the UART wakeup issue

 Documentation/admin-guide/sysrq.rst                |   2 +
 .../devicetree/bindings/serial/mtk-uart.txt        |   1 +
 .../devicetree/bindings/serial/renesas,hscif.yaml  |   1 +
 .../devicetree/bindings/serial/renesas,scif.yaml   |   1 +
 .../bindings/timer/mediatek,mtk-timer.txt          |   1 +
 drivers/accessibility/speakup/main.c               |   4 +-
 drivers/gpu/drm/drm_fb_helper.c                    |   2 +-
 drivers/tty/hvc/Kconfig                            |   1 +
 drivers/tty/hvc/hvcs.c                             |  14 +-
 drivers/tty/ipwireless/hardware.c                  |   6 +-
 drivers/tty/ipwireless/network.c                   |   4 +-
 drivers/tty/ipwireless/tty.c                       |   2 +-
 drivers/tty/n_gsm.c                                |  38 +-
 drivers/tty/n_hdlc.c                               |  72 +--
 drivers/tty/n_tty.c                                |   4 +-
 drivers/tty/pty.c                                  |   4 +-
 drivers/tty/serial/8250/8250_bcm2835aux.c          |  12 +-
 drivers/tty/serial/8250/8250_dw.c                  |  54 +--
 drivers/tty/serial/8250/8250_fsl.c                 | 110 ++++-
 drivers/tty/serial/8250/8250_ingenic.c             |  20 +-
 drivers/tty/serial/8250/8250_mtk.c                 |   1 +
 drivers/tty/serial/8250/8250_pci.c                 |  64 ++-
 drivers/tty/serial/8250/8250_port.c                |   5 +-
 drivers/tty/serial/Kconfig                         |   2 +
 drivers/tty/serial/amba-pl011.c                    |  11 +-
 drivers/tty/serial/atmel_serial.c                  |  20 +-
 drivers/tty/serial/earlycon.c                      |   9 +-
 drivers/tty/serial/fsl_lpuart.c                    |  77 ++-
 drivers/tty/serial/icom.c                          |  32 +-
 drivers/tty/serial/ifx6x60.c                       |  15 +-
 drivers/tty/serial/imx.c                           |  14 +-
 drivers/tty/serial/max310x.c                       |  29 +-
 drivers/tty/serial/mcf.c                           |   1 +
 drivers/tty/serial/men_z135_uart.c                 |   8 +-
 drivers/tty/serial/mvebu-uart.c                    |   7 +-
 drivers/tty/serial/pch_uart.c                      |   2 +-
 drivers/tty/serial/pmac_zilog.c                    |   2 +-
 drivers/tty/serial/qcom_geni_serial.c              |  19 +-
 drivers/tty/serial/sa1100.c                        |  22 +-
 drivers/tty/serial/sc16is7xx.c                     |   1 +
 drivers/tty/serial/serial_core.c                   |  30 +-
 drivers/tty/serial/stm32-usart.c                   |  33 +-
 drivers/tty/serial/timbuart.c                      |   6 +-
 drivers/tty/serial/ucc_uart.c                      |   2 +-
 drivers/tty/synclink.c                             |  82 ++--
 drivers/tty/synclink_gt.c                          |  95 ++--
 drivers/tty/synclinkmp.c                           |  83 ++--
 drivers/tty/sysrq.c                                |  49 +-
 drivers/tty/tty_baudrate.c                         |   6 +-
 drivers/tty/tty_buffer.c                           |  14 +-
 drivers/tty/tty_io.c                               |  26 +-
 drivers/tty/tty_jobctrl.c                          |   4 +-
 drivers/tty/tty_ldisc.c                            |   3 +-
 drivers/tty/vt/consolemap.c                        |   4 +-
 drivers/tty/vt/selection.c                         |   2 +-
 drivers/tty/vt/vc_screen.c                         | 532 ++++++++++++---------
 drivers/tty/vt/vt.c                                |  42 +-
 drivers/tty/vt/vt_ioctl.c                          |  60 +--
 drivers/video/console/newport_con.c                |  22 +-
 drivers/video/console/sticon.c                     |   9 +-
 drivers/video/fbdev/core/fbcon.c                   |  10 +-
 include/linux/console.h                            |   2 +-
 include/linux/consolemap.h                         |   3 +-
 include/linux/dax.h                                |  17 +-
 include/linux/qcom-geni-se.h                       |   3 +
 include/linux/selection.h                          |  18 +-
 66 files changed, 1056 insertions(+), 795 deletions(-)
