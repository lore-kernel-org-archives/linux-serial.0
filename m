Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40816C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 27 Dec 2021 08:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhL0Ime (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Dec 2021 03:42:34 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:9000 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbhL0Ime (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Dec 2021 03:42:34 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Dec 2021 03:42:34 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1640594185;
    s=strato-dkim-0002; d=mades.net;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=hIwli2pJET0l1AzalZASC/YnD8TyUQSWQLAQMVyR5dU=;
    b=aFbhcGF//3hm1rSY0ZNUmBZ2YpHnBLMReOcGCZ7qK1VhuLH7QyUDqV+hhnBA9/nfzg
    UIKWibPSePcxBKDJsnsyYhM2xlA3ragE8OIzVZo7fE9fZpNvzpXvFnevq/ICyjd/ra8u
    lf4G0Lac6bIvREKyuCSLShPo91BxKkQjvgPz+XH83Oav1XZVykHADBo9+uHBhSwuhiLr
    nouOqwT5bp0lmnZnwP8T48FSLgGY2BC6F4SaQUM3EkgTVld4aNRTMH9wGUGSlm3C8IPS
    OSKG0zgaUweL1zZAsvDAjpgwcFxllSAg8FvEhBMqwYJcV0s/tZS5HZ63vFYweiP4dbr2
    qmMA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JmMHfUWmW/JCZ5q3rSbjoqaGiJoG2nOuw/BEppjnAC9QlFFS7UbO3fgzapMAIqNr"
X-RZG-CLASS-ID: mo00
Received: from oxapp02-03.back.ox.d0m.de
    by smtp-ox.front (RZmta 47.35.3 AUTH)
    with ESMTPSA id 402723xBR8aPsUF
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Mon, 27 Dec 2021 09:36:25 +0100 (CET)
Date:   Mon, 27 Dec 2021 09:36:25 +0100 (CET)
From:   Jochen Mades <jochen@mades.net>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <572288095.547800.1640594185677@webmail.strato.com>
Subject: amba-pl011 driver: bug in RS485 mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.5-Rev33
X-Originating-Client: open-xchange-appsuite
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

I tested the amba-pl011 driver from the current branch rpi-5.16.y in RS485 mode and found a bug.

The current driver pulls-up RTS in function pl011_set_mctrl independent from the rs485-flags SER_RS485_RTS_AFTER_SEND.
This leads to problems if the driver is used as RS485 slave.

In my opinion the patch should look like that (and was tested successfully by myself):

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 537f37ac4..3b45beae8 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1647,7 +1647,12 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
        unsigned int cr;

        if (port->rs485.flags & SER_RS485_ENABLED)
-               mctrl &= ~TIOCM_RTS;
+       {
+               if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+                       mctrl &= ~TIOCM_RTS;
+               else
+                       mctrl |= TIOCM_RTS;
+       }

        cr = pl011_read(uap, REG_CR);


Please let me know, if I'm allowed to commit this change and let me know how to do that or if someone of you guys will do that better.

Bests
Jochen
