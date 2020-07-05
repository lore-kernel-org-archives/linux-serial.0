Return-Path: <SRS0=pW61=AQ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB91C433E0
	for <linux-serial@archiver.kernel.org>; Sun,  5 Jul 2020 09:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9ABF20771
	for <linux-serial@archiver.kernel.org>; Sun,  5 Jul 2020 09:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593941275;
	bh=cwT/z4X9FKhRShGYr7Xo1xaeCkNEqrqHebtQK3v592g=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=TBcgEV8aA423C++bFUjNMlxZ30BNGxu/1x2ZaAOcXqLnyCzYUE6ItmTgL0BMYAFkg
	 c39rWxkcRfR3JmltL8qIsIPlev1eLwWpWKG/E/88ou4ZkvjRXm1+nVV5XnGO+fK6sQ
	 hzDH6h1Sp/2UpPywyhXjrv/XzbGGGSu6LG09mxf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgGEJ1z (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 5 Jul 2020 05:27:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgGEJ1z (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 5 Jul 2020 05:27:55 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4055B2075B;
        Sun,  5 Jul 2020 09:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593941274;
        bh=cwT/z4X9FKhRShGYr7Xo1xaeCkNEqrqHebtQK3v592g=;
        h=From:To:Cc:Subject:Date:From;
        b=UvSZGSBtbceq5CP+GEMr6b3VXwaWm6XG5Nouf8q5iFEcisyaEgjfwgNjfLO3tt+rB
         PLl/F1qFrEsEaHM1Kc8ns6pRS3IfQEphXEVuhRit8vpCNfU7cKgQrkWOFY5IgnnwUg
         HpKRQa5TayPt1iDyzVY71YAclQd/EHai1FeQobFo=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1js0wC-0099WP-Dx; Sun, 05 Jul 2020 10:27:52 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     khilman@baylibre.com, linux-serial@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] tty: serial: meson_uart: Init port lock early
Date:   Sun,  5 Jul 2020 10:27:36 +0100
Message-Id: <20200705092736.1030598-1-maz@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, khilman@baylibre.com, linux-serial@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com, andriy.shevchenko@linux.intel.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The meson UART driver triggers a lockdep splat at boot time, due
to the new expectation that the driver has to initialize the
per-port spinlock itself.

It remains unclear why a double initialization of the port
spinlock is a desirable outcome, but in the meantime let's
fix the splat.

Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/tty/serial/meson_uart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index d2c08b760f83..386e39c90628 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -759,6 +759,9 @@ static int meson_uart_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Init the spinlock early in case this is the console */
+	spin_lock_init(&port->lock);
+
 	port->iotype = UPIO_MEM;
 	port->mapbase = res_mem->start;
 	port->mapsize = resource_size(res_mem);
-- 
2.26.2

