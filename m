Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042E0C77B73
	for <linux-serial@archiver.kernel.org>; Wed, 24 May 2023 12:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjEXM2O (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 May 2023 08:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjEXM2N (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 May 2023 08:28:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A083B135
        for <linux-serial@vger.kernel.org>; Wed, 24 May 2023 05:28:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1nb1-00066i-N3; Wed, 24 May 2023 14:28:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1nb0-002TyP-Hw; Wed, 24 May 2023 14:28:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q1naz-007YdZ-NS; Wed, 24 May 2023 14:28:01 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 0/3] serial: 8250-fsl: Two fixes
Date:   Wed, 24 May 2023 14:27:51 +0200
Message-Id: <20230524122754.481816-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=709; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Mx81TvBYOUEZfOgpgIfthaKUja2KuPktQETYWjtaqDk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkbgLDJZKE5ZHCvmAcdGzxchK8ZcBt0u2BujYV3 3aR2tvGQu6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZG4CwwAKCRCPgPtYfRL+ Tn4yB/9yQP+5+zBMI3IPseLcRww7Q0Pxoqi9yWkFKM5S5ELokC6aoWnHpEHo+gk0caFxjVTmvlF o1430qky+k1w+D3obuQAEFPhJVQLGULgC4118roN87flEYGywwIhkzaA0Vfkvisy6Uw7/47SCcK ibPMl5pxm4geTsOOxCvMnyQ7TFJj7XyTXPulAoI3+LZuMPseqJOyKC3+gWPmrTz+j9DWwOl/Ge2 MPs0gVpPAtFD90eG3MmMf4XEAgwpuYYTu44cANAtrFt6sgdxdeZ4z+4+rzSL8RHyz9Wdat1escJ F8JlCPFOHsmSWdOse40RLz2fQ8NwubWgsdlOPHBRIPr13Csw
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

after better describing the problem in FSL's 8250 variant, here come two
fixes needed to reliably use RS485 on this type of UART.

The patches were originally developed and tested on top of 5.15.y.

Best regards
Uwe

Uwe Kleine-König (3):
  serial: 8250-fsl: Expand description of the MPC83xx UART's
    misbehaviour
  serial: 8250: Clear IIR.RDI in serial8250_clear_fifos()
  serial: 8250-fsl: Only do the break workaround if IIR signals RLSI

 drivers/tty/serial/8250/8250_fsl.c  | 17 +++++++++++++++--
 drivers/tty/serial/8250/8250_port.c | 12 ++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

