Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32644C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 07:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C3C560E8E
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 07:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhGWHCp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 03:02:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55362 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhGWHCo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 03:02:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D253C225F9;
        Fri, 23 Jul 2021 07:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627026197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=GrONBBxOFl8xDimt+FsB8lhbYxtf9ATz8q2XpqkvTM8=;
        b=Kwed4iF8DmjhfHHMgDseKkOnloLoUvvLjs8aH6VoSKkcAlmx3xal116zX7htX/HqDb4NVw
        jt8kHgmoLn+tn05kiuHM1uU8ZikTe7VyXbEPPOv8m8KPDY9mtXt1nzRXbJ1Qz3WDsppQhH
        c1g67QsKv18rrjAM2/SX70Wg3tkGJBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627026197;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=GrONBBxOFl8xDimt+FsB8lhbYxtf9ATz8q2XpqkvTM8=;
        b=WYSZu2/qmP1Iqi8eCcWEw/U5aN+s0mf8dkM14sqW/4gDfI38FfPd6/4+78kiaZXhHyYooe
        ad0zNBHhPglXQCCA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B644EA3B90;
        Fri, 23 Jul 2021 07:43:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 0/8] Get rid of old tty_driver functions
Date:   Fri, 23 Jul 2021 09:43:09 +0200
Message-Id: <20210723074317.32690-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series converts the rest of the drivers to use:
* tty_alloc_driver instead of alloc_tty_driver, and
* tty_driver_kref_put instead of put_tty_driver.

They were more of less interchangeable, alloc_tty_driver() and
put_tty_driver() are older interfaces which weren't eliminated until
now.

There are few fix and cleanup patches around tty_driver too.

Jiri Slaby (8):
  xtensa: ISS: don't panic in rs_init
  hvsi: don't panic on tty_register_driver failure
  tty: don't store semi-state into tty drivers
  tty: stop using alloc_tty_driver
  tty: drop alloc_tty_driver
  tty: make tty_set_operations an inline
  tty: drop put_tty_driver
  tty: pdc_cons, free tty_driver upon failure

 arch/alpha/kernel/srmcons.c            |  8 ++--
 arch/m68k/emu/nfcon.c                  | 30 +++++++-------
 arch/parisc/kernel/pdc_cons.c          | 34 ++++++++--------
 arch/um/drivers/line.c                 | 13 +++---
 arch/xtensa/platforms/iss/console.c    | 45 +++++++++++++--------
 drivers/char/pcmcia/synclink_cs.c      |  4 +-
 drivers/char/ttyprintk.c               |  4 +-
 drivers/ipack/devices/ipoctal.c        | 13 +++---
 drivers/isdn/capi/capi.c               | 14 +++----
 drivers/misc/bcm-vk/bcm_vk_tty.c       |  8 ++--
 drivers/mmc/core/sdio_uart.c           | 12 +++---
 drivers/net/usb/hso.c                  | 12 +++---
 drivers/s390/char/con3215.c            | 11 +++---
 drivers/s390/char/sclp_tty.c           | 15 ++++---
 drivers/s390/char/sclp_vt220.c         |  9 ++---
 drivers/s390/char/tty3270.c            |  4 +-
 drivers/staging/fwserial/fwserial.c    |  8 ++--
 drivers/staging/gdm724x/gdm_tty.c      | 13 +++---
 drivers/staging/greybus/uart.c         |  4 +-
 drivers/tty/amiserial.c                | 42 ++++++++++----------
 drivers/tty/ehv_bytechan.c             | 34 +++++++++-------
 drivers/tty/goldfish.c                 | 18 ++++-----
 drivers/tty/hvc/hvc_console.c          | 10 ++---
 drivers/tty/hvc/hvcs.c                 | 12 +++---
 drivers/tty/hvc/hvsi.c                 | 55 ++++++++++++++++----------
 drivers/tty/ipwireless/tty.c           | 12 +++---
 drivers/tty/mips_ejtag_fdc.c           |  2 +-
 drivers/tty/moxa.c                     |  4 +-
 drivers/tty/mxser.c                    | 12 +++---
 drivers/tty/n_gsm.c                    | 13 +++---
 drivers/tty/nozomi.c                   | 12 +++---
 drivers/tty/serial/kgdb_nmi.c          | 11 +++---
 drivers/tty/serial/serial_core.c       | 12 +++---
 drivers/tty/synclink_gt.c              | 12 +++---
 drivers/tty/tty_io.c                   | 13 ------
 drivers/tty/ttynull.c                  |  4 +-
 drivers/tty/vcc.c                      |  4 +-
 drivers/tty/vt/vt.c                    |  6 +--
 drivers/usb/class/cdc-acm.c            | 14 +++----
 drivers/usb/gadget/function/u_serial.c | 36 +++++++++--------
 drivers/usb/host/xhci-dbgtty.c         |  4 +-
 drivers/usb/serial/usb-serial.c        | 13 +++---
 include/linux/tty_driver.h             | 21 +++-------
 net/bluetooth/rfcomm/tty.c             | 12 +++---
 44 files changed, 330 insertions(+), 319 deletions(-)

-- 
2.32.0

