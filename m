Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B93C4321E
	for <linux-serial@archiver.kernel.org>; Mon, 15 Nov 2021 22:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98BFA63215
	for <linux-serial@archiver.kernel.org>; Mon, 15 Nov 2021 22:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241165AbhKOWyL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Nov 2021 17:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353395AbhKOWfi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Nov 2021 17:35:38 -0500
Received: from mailg210.ethz.ch (mailg210.ethz.ch [IPv6:2001:67c:10ec:5606::21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E458AC04A4AF
        for <linux-serial@vger.kernel.org>; Mon, 15 Nov 2021 13:49:49 -0800 (PST)
Received: from mailm113.d.ethz.ch (2001:67c:10ec:5602::25) by mailg210.ethz.ch
 (2001:67c:10ec:5606::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.12; Mon, 15 Nov
 2021 22:49:34 +0100
Received: from dtkw (213.55.225.240) by mailm113.d.ethz.ch
 (2001:67c:10ec:5602::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 15 Nov
 2021 22:49:45 +0100
Date:   Mon, 15 Nov 2021 22:49:44 +0100
From:   Ilia Sergachev <silia@ethz.ch>
To:     <linux-serial@vger.kernel.org>
CC:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Ilia Sergachev <silia@ethz.ch>, Johan Hovold <johan@kernel.org>
Subject: [PATCH v3] serial: liteuart: Fix NULL pointer dereference in
 ->remove()
Message-ID: <20211115224944.23f8c12b@dtkw>
Organization: ETH Zurich
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [213.55.225.240]
X-ClientProxiedBy: mailm210.d.ethz.ch (2001:67c:10ec:5603::24) To
 mailm113.d.ethz.ch (2001:67c:10ec:5602::25)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

drvdata has to be set in _probe() - otherwise platform_get_drvdata()
causes null pointer dereference BUG in _remove().

Fixes: 1da81e5562fa ("drivers/tty/serial: add LiteUART driver")
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ilia Sergachev <silia@ethz.ch>
---
v2 -> v3: update subject and description
v1 -> v2: add Fixes:

 drivers/tty/serial/liteuart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index dbc0559a9157..f075f4ff5fcf 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -285,6 +285,8 @@ static int liteuart_probe(struct platform_device *pdev)
 	port->line = dev_id;
 	spin_lock_init(&port->lock);
 
+	platform_set_drvdata(pdev, port);
+
 	return uart_add_one_port(&liteuart_driver, &uart->port);
 }
 
-- 
2.25.1
