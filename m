Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CCDC4332F
	for <linux-serial@archiver.kernel.org>; Sun,  5 Nov 2023 21:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjKEVog (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 5 Nov 2023 16:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKEVof (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 5 Nov 2023 16:44:35 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12FEBF
        for <linux-serial@vger.kernel.org>; Sun,  5 Nov 2023 13:44:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzkun-0005cC-Oi; Sun, 05 Nov 2023 22:44:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzkul-006sXL-OP; Sun, 05 Nov 2023 22:44:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzkul-00DHxV-Es; Sun, 05 Nov 2023 22:44:15 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 0/2] tty: hvc: Convert to platform remove callback returning void
Date:   Sun,  5 Nov 2023 22:44:07 +0100
Message-ID: <20231105214406.3765906-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=2G89HgbYBqf0Lwg13SXDRVWuf/UVadm57eZl7j7tSLs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlSAynd3H0mMld8K/mCAxD8Ftf264W7AoOj2MGQ YI68GhmeDyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUgMpwAKCRCPgPtYfRL+ Ts9aB/9xWS/XexOtt4MrBteSIpKz45O4fgJ05w2EZFjyMcCQR+x6P5kmzIV7vMkeXc9a7yMh+0c 0B340N8ctuaQGvTEAPJdhYiOQoYLS+06FN1MP1M0a+N4MACHtomPKpvL5tarZHT1pqyfm/yBUfU cWO4pQ+73IoGd/casIVxeo6To/P460wir5nn9X1ad6o9VzfvSDvhvouTvzR9YYaOv05i4fbCj1Y pZ5XKnoHoJS2tcrM9XtTPpckwFQrdaNMSmPgyyQDHZZwulxBvUylPk+wT1UkEXZTs0/wgtApPmB maVVnEh4K0s3SiLOJuXeDrYmrsEolHgrfFVYKt0kWBUUL3w7
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

The hvc_opal driver had an error path in its remove function resulting
in returning a non-zero value. This is a bad thing because the core
doesn't do error handling and effectively ignores the return value.

In this case it's not as bad as it sounds though, as this error path is
never taken.

After the first patch changes hvc_remove() to return void the remove
function obviously always returns zero. Then it can be trivially
converted to .remove_new(). See commit 5c5a7680e67b ("platform: Provide
a remove callback that returns no value") for an extended explanation
and the eventual goal of this conversion.

Uwe Kleine-König (2):
  tty: hvc: Make hvc_remove() return no value
  tty: hvc: hvc_opal: Convert to platform remove callback returning void

 drivers/tty/hvc/hvc_console.c |  3 +--
 drivers/tty/hvc/hvc_console.h |  2 +-
 drivers/tty/hvc/hvc_opal.c    | 17 +++++++----------
 3 files changed, 9 insertions(+), 13 deletions(-)

base-commit: e27090b1413ff236ca1aec26d6b022149115de2c
-- 
2.42.0

