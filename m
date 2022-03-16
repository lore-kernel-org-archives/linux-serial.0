Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF40C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 16 Mar 2022 14:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345330AbiCPOjI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Mar 2022 10:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345781AbiCPOjD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Mar 2022 10:39:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFCA654BE6
        for <linux-serial@vger.kernel.org>; Wed, 16 Mar 2022 07:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647441464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+puTaoBs7ERRB7dXkYfJVCLixA5oMPMatpnqwUqkD1c=;
        b=Kr3l8m6MTwAxIts58nvJHPKgKfNQm6Iu5EZRKbhqvcouYhBHE41wr+aPAtl7VmtfsoQZxU
        aORghj6upIFfw5/u+Jqv76CHeikpcW8sjh9xidf3G82A5HXMfWt4z9zg6iMc3PHGntsxnS
        K6eGReSj9gdLe0BuKuy7OfFqaUHrZXM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-MY4Rzgv_OJayCNmBJHCkRg-1; Wed, 16 Mar 2022 10:37:41 -0400
X-MC-Unique: MY4Rzgv_OJayCNmBJHCkRg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68FE8811E83;
        Wed, 16 Mar 2022 14:37:40 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.19.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B97B400F73E;
        Wed, 16 Mar 2022 14:37:37 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     rostedt@goodmis.org, senozhatsky@chromium.org,
        andre.goddard@gmail.com, sudipm.mukherjee@gmail.com,
        andy.shevchenko@gmail.com, David.Laight@aculab.com,
        jonathanh@nvidia.com, phil@raspberrypi.com
Subject: [PATCH v4 3/5] serial/8250: Use tx_loadsz as the transmitter fifo size
Date:   Wed, 16 Mar 2022 11:36:42 -0300
Message-Id: <20220316143646.13301-4-wander@redhat.com>
In-Reply-To: <20220316143646.13301-1-wander@redhat.com>
References: <20220316143646.13301-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Using port_fifosize as the fifo size to transmit data to the serial
console causes data loss in some controllers. Use the correct tx_loadsz
field.

Thanks to Jon Hunter for reporting the issue.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 5021d709b31b ("tty: serial: Use fifo in 8250 console driver")
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 drivers/tty/serial/8250/8250_port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 9f3fa9fe2a4e..d3a93e5d55f7 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3343,7 +3343,7 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 {
 	int i;
 	const char *end = s + count;
-	unsigned int fifosize = up->port.fifosize;
+	unsigned int fifosize = up->tx_loadsz;
 	bool cr_sent = false;
 
 	while (s != end) {
@@ -3409,7 +3409,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	}
 
 	use_fifo = (up->capabilities & UART_CAP_FIFO) &&
-		port->fifosize > 1 &&
+		up->tx_loadsz > 1 &&
 		(up->fcr & UART_FCR_ENABLE_FIFO) &&
 		/*
 		 * After we put a data in the fifo, the controller will send
-- 
2.35.1

