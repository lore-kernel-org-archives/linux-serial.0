Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6387AC3DA78
	for <linux-serial@archiver.kernel.org>; Tue, 17 Jan 2023 09:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbjAQJLQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Jan 2023 04:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbjAQJKx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Jan 2023 04:10:53 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DEF3A855;
        Tue, 17 Jan 2023 01:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673946283; x=1705482283;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yEfwaA1ZLZIwJAyW/Vv2oWQYDGbEZLM/Ipw3HRQM2rk=;
  b=FFLiT/G4rokiZeh1Kx/1Kr01hSebWqv6obqMOg8DJ0Ffe9uYkKDW1cTJ
   WUil6UlqZRbVyja/GKi8L+yO8Yb1YDzcn0dnIBmm+USc5eOhQMqkQoen4
   nkr6Gc8G1hfi7ENkbBsUOE1nOTZlqkv2izqqoGM9Rb8xC+g+Y1CPPNJe1
   erRgug2N7DHU4V0rl1WM0UpS8i+72AdYGKyiz0gh2i2pm1eyUwHahcfrc
   Ubgpar8mMFdfZOJ8yMfl5VGv3qW93Equ/hQSqwMbAtweLHAr9yZTEekoX
   O/vbwgg2nGsO7FYDCdQOw8ZQn0WYr7aTUZCWLevmMoV2Bymy95OrAIOUK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="324700896"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="324700896"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 01:04:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="783173965"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="783173965"
Received: from tronach-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.40.3])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 01:04:20 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 00/12] tty/serial: bool conversions and cleanups
Date:   Tue, 17 Jan 2023 11:03:46 +0200
Message-Id: <20230117090358.4796-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There are number of functions in tty/serial which have arguments or
return types that expect/behave like bool. Likely due to them existing
before bool was available, other types are used. Make conversions to
bool and cleanups.

v4:
- Removed most of the USB serial changes from this series

v3:
- moxa: Fix function signature in comment
- moxa: Rearrange comment (0: off, 1: on) removal from rename change
  to bool change (effect is internal to the series)

v2:
- Call dtr/rts parameters/variables consistently "active"
- Don't chain one return statement with ||
- Don't change function signatures to >80 chars ("while at it")
- moxa: differentiated dtr and status variables

Ilpo Järvinen (12):
  tty: Cleanup tty_port_set_initialized() bool parameter
  tty: Cleamup tty_port_set_suspended() bool parameter
  tty: Cleanup tty_port_set_active() bool parameter
  tty: moxa: Make local var storing tty_port_initialized() bool
  serial: Convert uart_{,port_}startup() init_hw param to bool
  tty: Convert ->carrier_raised() and callchains to bool
  tty: Convert ->dtr_rts() to take bool argument
  tty/serial: Make ->dcd_change()+uart_handle_dcd_change() status bool
    active
  serial: Make uart_handle_cts_change() status param bool active
  tty: Return bool from tty_termios_hw_change()
  tty: Call ->dtr_rts() parameter active consistently
  tty: moxa: Rename dtr/rts parameters/variables to active

 drivers/char/pcmcia/synclink_cs.c | 18 +++----
 drivers/ipack/devices/ipoctal.c   |  4 +-
 drivers/mmc/core/sdio_uart.c      | 13 +++--
 drivers/pps/clients/pps-ldisc.c   |  6 +--
 drivers/s390/char/con3215.c       |  4 +-
 drivers/staging/greybus/uart.c    |  4 +-
 drivers/tty/amiserial.c           | 12 ++---
 drivers/tty/hvc/hvc_console.c     |  4 +-
 drivers/tty/hvc/hvc_console.h     |  2 +-
 drivers/tty/hvc/hvc_iucv.c        |  6 +--
 drivers/tty/moxa.c                | 82 ++++++++++++++++---------------
 drivers/tty/mxser.c               | 11 +++--
 drivers/tty/n_gsm.c               | 16 +++---
 drivers/tty/serial/imx.c          |  2 +-
 drivers/tty/serial/max3100.c      |  2 +-
 drivers/tty/serial/max310x.c      |  3 +-
 drivers/tty/serial/serial_core.c  | 65 ++++++++++++------------
 drivers/tty/serial/sunhv.c        |  8 +--
 drivers/tty/synclink_gt.c         | 21 ++++----
 drivers/tty/tty_ioctl.c           |  8 +--
 drivers/tty/tty_port.c            | 22 ++++-----
 drivers/usb/class/cdc-acm.c       |  4 +-
 drivers/usb/serial/console.c      |  2 +-
 drivers/usb/serial/usb-serial.c   |  6 +--
 include/linux/serial_core.h       |  6 +--
 include/linux/tty.h               |  2 +-
 include/linux/tty_ldisc.h         |  4 +-
 include/linux/tty_port.h          | 10 ++--
 net/bluetooth/rfcomm/tty.c        |  2 +-
 29 files changed, 173 insertions(+), 176 deletions(-)

-- 
2.30.2

