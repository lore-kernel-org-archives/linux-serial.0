Return-Path: <SRS0=Hdmd=67=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AD3C433DF
	for <linux-serial@archiver.kernel.org>; Sun, 17 May 2020 21:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D6920823
	for <linux-serial@archiver.kernel.org>; Sun, 17 May 2020 21:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgEQV4e (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 17 May 2020 17:56:34 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45120 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgEQV4e (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 17 May 2020 17:56:34 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jaRGd-0002am-T0; Sun, 17 May 2020 23:56:19 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de
Subject: [PATCH v3 0/5] serial: 8250: Add rs485 emulation to 8250_dw
Date:   Sun, 17 May 2020 23:56:05 +0200
Message-Id: <20200517215610.2131618-1-heiko@sntech.de>
X-Mailer: git-send-email 2.25.1
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

Depends on Lukas Wunner's series adding the rs485 bus term gpio:
https://lore.kernel.org/r/cover.1588505407.git.lukas@wunner.de

changes in v3:
- wording fixes for dt-binding (Andy)
- maxItems 1 in dt-binding (Lukas)
- use devm_gpiod_get_optional (Andy)
- remove unneeded gpio checks (Andy)
- use GPIOD_OUT_HIGH for initial value (Lukas)
- split loop-reading into the existing timer infrastructure

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


Giulio Benetti (2):
  serial: 8250: Handle implementations not having TEMT interrupt using
    em485
  serial: 8250_dw: add em485 support

Heiko Stuebner (3):
  serial: 8520_port: Fix function param documentation
  dt-bindings: serial: Add binding for rs485 receiver enable GPIO
  serial: 8250: Support separate rs485 rx-enable GPIO

 .../devicetree/bindings/serial/rs485.yaml     |  4 ++
 drivers/tty/serial/8250/8250.h                |  1 +
 drivers/tty/serial/8250/8250_bcm2835aux.c     |  2 +-
 drivers/tty/serial/8250/8250_dw.c             |  3 +
 drivers/tty/serial/8250/8250_of.c             |  2 +
 drivers/tty/serial/8250/8250_omap.c           |  2 +-
 drivers/tty/serial/8250/8250_port.c           | 60 ++++++++++++++++---
 drivers/tty/serial/serial_core.c              | 10 ++++
 include/linux/serial_core.h                   |  1 +
 9 files changed, 76 insertions(+), 9 deletions(-)

-- 
2.25.1

