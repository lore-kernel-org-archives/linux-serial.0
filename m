Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0958C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 30 Mar 2022 10:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245558AbiC3Kso (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 30 Mar 2022 06:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245509AbiC3Kso (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Mar 2022 06:48:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0A6269A70
        for <linux-serial@vger.kernel.org>; Wed, 30 Mar 2022 03:46:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nZVql-0002vB-V0; Wed, 30 Mar 2022 12:46:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nZVqh-003y5u-Ji; Wed, 30 Mar 2022 12:46:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nZVqj-00Clkj-Iy; Wed, 30 Mar 2022 12:46:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Tremblay <etremblay@distech-controls.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v3 0/3] Handle UART without interrupt on TEMT using em485
Date:   Wed, 30 Mar 2022 12:46:39 +0200
Message-Id: <20220330104642.229507-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=943; h=from:subject; bh=llOorWorLlD1RrCRWPKaiBFBXVBahCxRpgbDtUoJ3is=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiRDT/qkr5wGZ8XoQyXcH/kPlkuheaUms41Yy7yAWJ e9+cgyCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYkQ0/wAKCRDB/BR4rcrsCVtGB/ 4poOasW3+w8BKKV7ahXcMTXiXkaJaRoJIs4sFaweD3G3migKCpDWExvf7bWziqa7RqXMZrzp5xfTSC wrqDGYOWkbKXaWpvQdVJjQizxXDWm24rUAC6MwFXB0wmnGhh7yBYTEbgvxwK16hk8musO4ncbOdoTS KppeCaubX99xr+YDAOSwt/3LahdGNRjdOG0U+DlfCVSpjVa4QL4CAUyXN5cIEUvp1RADX2C17SbsWO qgmk2Lgz0NQPnFj2Gbk+IjxIRT1T6nKTXaKNVpYERT8CEMnn7YbC4gCXtVOnQhLSEcORiDXOe5u7II 3SAFfaI+0luXGeAyYEk27VNq+Xd6ED
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

this is a follow up to
https://lore.kernel.org/linux-serial/20210204161158.643-1-etremblay@distech-controls.com

Compared to this v3 the following happend:

 - rebased to v5.17
 - Slightly reworded commit log of patch 2 and 3 (requested by Andy)
 - Use tty_get_frame_size instead of adding another variant.

I tested this series on a Freescale MPC8313 (ARCH=powerpc).

Best regards
Uwe

Eric Tremblay (3):
  serial: 8250: Handle UART without interrupt on TEMT using em485
  serial: 8250: Add UART_CAP_NOTEMT on PORT_16550A_FSL64
  serial: 8250: add compatible for fsl,16550-FIFO64

 drivers/tty/serial/8250/8250.h      |  1 +
 drivers/tty/serial/8250/8250_of.c   |  2 +
 drivers/tty/serial/8250/8250_port.c | 78 +++++++++++++++++++++++++++--
 include/linux/serial_8250.h         |  2 +
 4 files changed, 80 insertions(+), 3 deletions(-)


base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.30.2

