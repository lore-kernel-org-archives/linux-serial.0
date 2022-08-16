Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728B4C28B2B
	for <linux-serial@archiver.kernel.org>; Tue, 16 Aug 2022 12:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiHPMIJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Aug 2022 08:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiHPMHg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Aug 2022 08:07:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D87B7B
        for <linux-serial@vger.kernel.org>; Tue, 16 Aug 2022 04:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660651071; x=1692187071;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Rb50xlrHfjIjTbxhYjK408M6LPffWtEWNgnDdAIE97Y=;
  b=dMxOCB8qXOf4KK/g14rY5PxJBMx2E2ZDrsCFEeudUS4OEUZwKmj1SuWb
   zlU0HhLrVLZg9ajQ4gpwQh4ghusi5iuKQnfFcxoa6puo3Wqz50f5dp3ON
   hCcSpxvqIqj4CrgtsAL6Fdki/rDQY/taKNfHPOOTyZobEFyCfDslkyFLi
   BbzZcOJnvV1454GNctmc8IUlGq+qaGoZi6XHHU5k+wqtGIBwrSqyghUet
   3OVznfVkZamJq0f80LJKeA20LgaaIWca8/9xpdCX9HA0Dq6ZyQDjYGHvZ
   wzsXALKMHcR2TSo2usIw1j3ExLO5+DZycZq5ZcAreIamo5cy8eBAG9omv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="356199297"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="356199297"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 04:57:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="667080772"
Received: from tturcu-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.51.153])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 04:57:46 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/8] tty/serial: Convert ->set_termios() related callchains to const old ktermios
Date:   Tue, 16 Aug 2022 14:57:31 +0300
Message-Id: <20220816115739.10928-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

->set_termios() callchains input old ktermios (mainly used as fallback
and feature compares). It is discarded right after returning from the
calls and should therefore not be modified by drivers because any such
change will get lost (instead, the changes must be applied to the new
ktermios). While doing this patchset, I found a few such issues that
were fixed earlier.

Now enforce old ktermios constness. Another goodie is that "get" named
functions in tty_baudrate.c that previously mucked with the old
ktermios can no longer have such side-effects. I found out that the
ktermios adjustments made were dead-code for all in-tree archs anyway.

Ilpo Järvinen (8):
  tty: Remove baudrate dead code & make ktermios params const
  tty: Fix comment style in tty_termios_input_baud_rate()
  serial: dz: Assume previous baudrate is valid
  tty: Make tty_termios_copy_hw() old ktermios const
  tty: Make ldisc ->set_termios() old ktermios const
  serial: Make ->set_termios() old ktermios const
  usb: serial: Make ->set_termios() old ktermios const
  tty: Make ->set_termios() old ktermios const

 drivers/char/pcmcia/synclink_cs.c           |  3 ++-
 drivers/ipack/devices/ipoctal.c             |  2 +-
 drivers/mmc/core/sdio_uart.c                |  4 ++--
 drivers/net/usb/hso.c                       |  3 ++-
 drivers/s390/char/tty3270.c                 |  2 +-
 drivers/staging/fwserial/fwserial.c         |  3 ++-
 drivers/staging/greybus/uart.c              |  2 +-
 drivers/tty/amiserial.c                     |  6 ++---
 drivers/tty/moxa.c                          |  9 +++----
 drivers/tty/mxser.c                         |  6 +++--
 drivers/tty/n_gsm.c                         |  3 ++-
 drivers/tty/n_tty.c                         |  2 +-
 drivers/tty/pty.c                           |  2 +-
 drivers/tty/serial/21285.c                  |  2 +-
 drivers/tty/serial/8250/8250_bcm7271.c      |  2 +-
 drivers/tty/serial/8250/8250_dw.c           |  2 +-
 drivers/tty/serial/8250/8250_dwlib.c        |  3 ++-
 drivers/tty/serial/8250/8250_dwlib.h        |  2 +-
 drivers/tty/serial/8250/8250_fintek.c       |  2 +-
 drivers/tty/serial/8250/8250_lpss.c         |  2 +-
 drivers/tty/serial/8250/8250_mid.c          |  5 ++--
 drivers/tty/serial/8250/8250_mtk.c          |  2 +-
 drivers/tty/serial/8250/8250_omap.c         |  2 +-
 drivers/tty/serial/8250/8250_port.c         |  6 ++---
 drivers/tty/serial/altera_jtaguart.c        |  4 ++--
 drivers/tty/serial/altera_uart.c            |  2 +-
 drivers/tty/serial/amba-pl010.c             |  2 +-
 drivers/tty/serial/amba-pl011.c             |  4 ++--
 drivers/tty/serial/apbuart.c                |  2 +-
 drivers/tty/serial/ar933x_uart.c            |  2 +-
 drivers/tty/serial/arc_uart.c               |  2 +-
 drivers/tty/serial/atmel_serial.c           |  5 ++--
 drivers/tty/serial/bcm63xx_uart.c           |  5 ++--
 drivers/tty/serial/clps711x.c               |  2 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |  2 +-
 drivers/tty/serial/digicolor-usart.c        |  2 +-
 drivers/tty/serial/dz.c                     | 11 +++++----
 drivers/tty/serial/fsl_linflexuart.c        |  2 +-
 drivers/tty/serial/fsl_lpuart.c             |  4 ++--
 drivers/tty/serial/icom.c                   |  5 ++--
 drivers/tty/serial/imx.c                    |  2 +-
 drivers/tty/serial/ip22zilog.c              |  2 +-
 drivers/tty/serial/jsm/jsm_tty.c            |  4 ++--
 drivers/tty/serial/lantiq.c                 |  4 ++--
 drivers/tty/serial/liteuart.c               |  2 +-
 drivers/tty/serial/lpc32xx_hs.c             |  2 +-
 drivers/tty/serial/max3100.c                |  2 +-
 drivers/tty/serial/max310x.c                |  2 +-
 drivers/tty/serial/mcf.c                    |  2 +-
 drivers/tty/serial/men_z135_uart.c          |  4 ++--
 drivers/tty/serial/meson_uart.c             |  2 +-
 drivers/tty/serial/milbeaut_usio.c          |  3 ++-
 drivers/tty/serial/mpc52xx_uart.c           | 12 +++++-----
 drivers/tty/serial/mps2-uart.c              |  2 +-
 drivers/tty/serial/msm_serial.c             |  2 +-
 drivers/tty/serial/mux.c                    |  2 +-
 drivers/tty/serial/mvebu-uart.c             |  2 +-
 drivers/tty/serial/mxs-auart.c              |  2 +-
 drivers/tty/serial/omap-serial.c            |  2 +-
 drivers/tty/serial/owl-uart.c               |  2 +-
 drivers/tty/serial/pch_uart.c               |  3 ++-
 drivers/tty/serial/pic32_uart.c             |  2 +-
 drivers/tty/serial/pmac_zilog.c             |  4 ++--
 drivers/tty/serial/pxa.c                    |  2 +-
 drivers/tty/serial/qcom_geni_serial.c       |  3 ++-
 drivers/tty/serial/rda-uart.c               |  2 +-
 drivers/tty/serial/rp2.c                    |  5 ++--
 drivers/tty/serial/sa1100.c                 |  2 +-
 drivers/tty/serial/samsung_tty.c            |  2 +-
 drivers/tty/serial/sb1250-duart.c           |  2 +-
 drivers/tty/serial/sc16is7xx.c              |  2 +-
 drivers/tty/serial/sccnxp.c                 |  3 ++-
 drivers/tty/serial/serial-tegra.c           |  3 ++-
 drivers/tty/serial/serial_core.c            |  8 +++----
 drivers/tty/serial/serial_txx9.c            |  2 +-
 drivers/tty/serial/sh-sci.c                 |  2 +-
 drivers/tty/serial/sifive.c                 |  2 +-
 drivers/tty/serial/sprd_serial.c            |  5 ++--
 drivers/tty/serial/st-asc.c                 |  2 +-
 drivers/tty/serial/stm32-usart.c            |  2 +-
 drivers/tty/serial/sunhv.c                  |  2 +-
 drivers/tty/serial/sunplus-uart.c           |  2 +-
 drivers/tty/serial/sunsab.c                 |  2 +-
 drivers/tty/serial/sunsu.c                  |  2 +-
 drivers/tty/serial/sunzilog.c               |  2 +-
 drivers/tty/serial/tegra-tcu.c              |  2 +-
 drivers/tty/serial/timbuart.c               |  4 ++--
 drivers/tty/serial/uartlite.c               |  5 ++--
 drivers/tty/serial/ucc_uart.c               |  3 ++-
 drivers/tty/serial/vt8500_serial.c          |  2 +-
 drivers/tty/serial/xilinx_uartps.c          |  3 ++-
 drivers/tty/serial/zs.c                     |  2 +-
 drivers/tty/synclink_gt.c                   |  3 ++-
 drivers/tty/tty.h                           |  2 +-
 drivers/tty/tty_baudrate.c                  | 26 +++++++--------------
 drivers/tty/tty_ioctl.c                     |  4 ++--
 drivers/usb/class/cdc-acm.c                 |  4 ++--
 drivers/usb/serial/ark3116.c                |  2 +-
 drivers/usb/serial/belkin_sa.c              |  6 +++--
 drivers/usb/serial/ch341.c                  |  5 ++--
 drivers/usb/serial/cp210x.c                 | 13 +++++++----
 drivers/usb/serial/cypress_m8.c             |  6 +++--
 drivers/usb/serial/digi_acceleport.c        |  6 +++--
 drivers/usb/serial/f81232.c                 |  3 ++-
 drivers/usb/serial/f81534.c                 |  4 ++--
 drivers/usb/serial/ftdi_sio.c               |  6 +++--
 drivers/usb/serial/io_edgeport.c            |  7 +++---
 drivers/usb/serial/io_ti.c                  |  8 ++++---
 drivers/usb/serial/ir-usb.c                 |  6 +++--
 drivers/usb/serial/iuu_phoenix.c            |  3 ++-
 drivers/usb/serial/keyspan.c                |  3 ++-
 drivers/usb/serial/keyspan_pda.c            |  3 ++-
 drivers/usb/serial/kl5kusb105.c             |  5 ++--
 drivers/usb/serial/kobil_sct.c              |  6 +++--
 drivers/usb/serial/mct_u232.c               |  5 ++--
 drivers/usb/serial/mos7720.c                |  5 ++--
 drivers/usb/serial/mos7840.c                |  5 ++--
 drivers/usb/serial/mxuport.c                |  4 ++--
 drivers/usb/serial/oti6858.c                |  6 +++--
 drivers/usb/serial/pl2303.c                 |  3 ++-
 drivers/usb/serial/quatech2.c               |  4 ++--
 drivers/usb/serial/spcp8x5.c                |  3 ++-
 drivers/usb/serial/ssu100.c                 |  4 ++--
 drivers/usb/serial/ti_usb_3410_5052.c       |  6 +++--
 drivers/usb/serial/upd78f0730.c             |  4 ++--
 drivers/usb/serial/usb-serial.c             |  3 ++-
 drivers/usb/serial/whiteheat.c              |  6 +++--
 drivers/usb/serial/xr_serial.c              | 20 +++++++++-------
 include/linux/serial_8250.h                 |  4 ++--
 include/linux/serial_core.h                 |  6 ++---
 include/linux/tty.h                         |  4 ++--
 include/linux/tty_driver.h                  |  4 ++--
 include/linux/tty_ldisc.h                   |  4 ++--
 include/linux/usb/serial.h                  |  4 ++--
 net/bluetooth/rfcomm/tty.c                  |  3 ++-
 135 files changed, 283 insertions(+), 234 deletions(-)

-- 
2.30.2

