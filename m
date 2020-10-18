Return-Path: <SRS0=dZFG=DZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ADCC43457
	for <linux-serial@archiver.kernel.org>; Sun, 18 Oct 2020 20:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F12422277
	for <linux-serial@archiver.kernel.org>; Sun, 18 Oct 2020 20:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgJRUky (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 18 Oct 2020 16:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729059AbgJRUko (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 18 Oct 2020 16:40:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21081C061755
        for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2020 13:40:44 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kUFTl-0002Z4-RC; Sun, 18 Oct 2020 22:40:33 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kUFTk-0007Ie-08; Sun, 18 Oct 2020 22:40:32 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>, linux-leds@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v9 0/3] leds: trigger: implement a tty trigger
Date:   Sun, 18 Oct 2020 22:40:19 +0200
Message-Id: <20201018204022.910815-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

this is v9 of this series. Changes compared to v8 sent with Message-Id
20201012123358.1475928-1-u.kleine-koenig@pengutronix.de on Oct 12:

 - make struct led_trigger ledtrig_tty static
 - drop write-only variable firstrun (which is a remains of the changes
   done in v8)

Both issues were found by the kernel test robot <lkp@intel.com>.

Best regards
Uwe

Uwe Kleine-König (3):
  tty: rename tty_kopen() and add new function tty_kopen_shared()
  tty: new helper function tty_get_icount()
  leds: trigger: implement a tty trigger

 .../ABI/testing/sysfs-class-led-trigger-tty   |   6 +
 drivers/accessibility/speakup/spk_ttyio.c     |   2 +-
 drivers/leds/trigger/Kconfig                  |   9 +
 drivers/leds/trigger/Makefile                 |   1 +
 drivers/leds/trigger/ledtrig-tty.c            | 184 ++++++++++++++++++
 drivers/tty/tty_io.c                          |  85 +++++---
 include/linux/tty.h                           |   7 +-
 7 files changed, 269 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-tty
 create mode 100644 drivers/leds/trigger/ledtrig-tty.c


base-commit: bbf5c979011a099af5dc76498918ed7df445635b
-- 
2.28.0

