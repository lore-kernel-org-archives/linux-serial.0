Return-Path: <SRS0=EpC2=5K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD6CC2D0E9
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 23:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AD320775
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 23:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgCYXOp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:14:45 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40192 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbgCYXOn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 19:14:43 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jHFEH-0007ug-1O; Thu, 26 Mar 2020 00:14:33 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko@sntech.de, lukas@wunner.de,
        christoph.muellner@theobroma-systems.com,
        giulio.benetti@micronovasrl.com
Subject: [PATCH RFC v2 0/7] serial: 8250: Add rs485 emulation to 8250_dw
Date:   Thu, 26 Mar 2020 00:14:15 +0100
Message-Id: <20200325231422.1502366-1-heiko@sntech.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series tries to revive the work of Giulio Benetti from 2018 [0]
which seemed to have stalled at that time.

The board I needed that on also had the additional caveat that it
uses non-standard pins for DE/RE so needed gpio mctrl layer as well
and even more special needed to control the RE pin manually not as
part of it being connected to the DE signal as seems to be the standard.

The first 3 patches are taken from Lukas Wunner's repository
with work he wants to submit after 5.7-rc1.
Patches needed adaptions from their 4.19 base of course,
so no guarantes I did that correctly ;-) .
I just need the change in the rs485_mode handling as base.

So as suggested by Andy this series is meant as a base for discussions
to show how my 8250_dw rs485 support fits onto the more recent codebase
and find more issues earlier.


Changes in v2:
- move to recent rs485 improvements in tty-next
- added a capability for TEMT interrupt presence
- external gpio for optional receiver-enable handling
- timeout polling via the generic readx_poll_timeout

Changes from the 2018 submission include:
- add timeout when waiting for fifos to clear using a new helper
- move on-boot enablement of the rs485 mode to after registering
  the port. This saves having to copy the em485 struct as done
  originally, which also ran into spinlock-debug warnings when testing
  and also makes it actually possible to use the mctrl gpio layer
  for non-standard gpios.


*** BLURB HERE ***

Giulio Benetti (2):
  serial: 8250: Handle implementations not having TEMT interrupt using
    em485
  serial: 8250_dw: add em485 support

Heiko Stuebner (2):
  dt-bindings: serial: Add binding for rs485 receiver enable GPIO
  serial: 8250: Support separate rs485 rx-enable GPIO

Lukas Wunner (3):
  serial: Allow uart_get_rs485_mode() to return errno
  dt-bindings: serial: Add binding for rs485 bus termination GPIO
  serial: 8250: Support rs485 bus termination GPIO

 .../devicetree/bindings/serial/rs485.yaml     |  8 ++++
 drivers/tty/serial/8250/8250.h                |  1 +
 drivers/tty/serial/8250/8250_bcm2835aux.c     |  2 +-
 drivers/tty/serial/8250/8250_core.c           |  4 +-
 drivers/tty/serial/8250/8250_dw.c             |  3 ++
 drivers/tty/serial/8250/8250_of.c             |  2 +
 drivers/tty/serial/8250/8250_omap.c           |  2 +-
 drivers/tty/serial/8250/8250_port.c           | 41 +++++++++++++++---
 drivers/tty/serial/ar933x_uart.c              |  6 ++-
 drivers/tty/serial/atmel_serial.c             |  6 ++-
 drivers/tty/serial/fsl_lpuart.c               |  5 ++-
 drivers/tty/serial/imx.c                      |  6 ++-
 drivers/tty/serial/omap-serial.c              |  4 +-
 drivers/tty/serial/serial_core.c              | 43 ++++++++++++++++++-
 drivers/tty/serial/stm32-usart.c              |  8 ++--
 include/linux/serial_core.h                   |  4 +-
 16 files changed, 124 insertions(+), 21 deletions(-)

-- 
2.24.1

