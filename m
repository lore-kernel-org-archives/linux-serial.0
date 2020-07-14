Return-Path: <SRS0=SZDA=AZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBB1C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 09:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF112075F
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 09:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgGNJaS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgGNJaS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jul 2020 05:30:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B21C061755
        for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2020 02:30:17 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jvHGQ-0002gd-Ri; Tue, 14 Jul 2020 11:30:14 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jvHGQ-0004KJ-3V; Tue, 14 Jul 2020 11:30:14 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, Rafael Gago Castano <rgc@hms.se>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 0/2] serial: imx: add support for rs485 delays
Date:   Tue, 14 Jul 2020 11:30:10 +0200
Message-Id: <20200714093012.21621-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Hello,

this is a set of two patches that is used for quite some time now at
several customers.

The first patch is older and in our imx-uart topic branch since 2015,
the second is newer and accounts for higher precision.

While conceptual the change might well be made in a single patch it
shows history correctly to keep it as two patches and also allows to
credit the authors correctly. So I decided to not squash the patches.

Best regards
Uwe

Ahmad Fatoum (1):
  serial: imx: use hrtimers for rs485 delays

Uwe Kleine-König (1):
  serial: imx: implement rts delaying for rs485

 drivers/tty/serial/imx.c | 167 ++++++++++++++++++++++++++++++---------
 1 file changed, 131 insertions(+), 36 deletions(-)

-- 
2.27.0

