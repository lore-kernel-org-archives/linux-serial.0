Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3A3C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 11:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B88896115C
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 11:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbhJOLQv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Oct 2021 07:16:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233881AbhJOLQu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Oct 2021 07:16:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5929D610D2;
        Fri, 15 Oct 2021 11:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634296484;
        bh=TyE2o8UiVtlpNgFi84DK+nkER3aZgsvsMDKRdk8epVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VZJTWLh5hZB2pc2hR9i6r9LBL0PNtUqljMFYfCUEIEjId/9V8uHcD9w4hbb2mdNrp
         nhlg17IcbFt+DQrK1HbCNk3tXnPp6aJ6vLoorHBLb6Djpxn1LnoFBpj0IYyC/u4vvj
         Siqx5auBTxyQ6mIJa60SKrgOAMfc/8BDfcEn+3uD/9Hgg3wXp+nItMwszejuFIlNv8
         IaYDalwf5aMRtVaDoSZl5b6zO7yWnrStjEMaoMSoJr558iu4+GnmBFwqZ0e1FU0oCI
         wpLU5iutdakF43y5RCY2QfiDRrIQoBkY5ojaDspEUr+UG9AWM6/Qjwdn2rWpv4kedN
         U5KAj80IqZhmA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mbLAc-0000HW-5w; Fri, 15 Oct 2021 13:14:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/3] serial: 8250: rename unlock labels
Date:   Fri, 15 Oct 2021 13:14:21 +0200
Message-Id: <20211015111422.1027-3-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211015111422.1027-1-johan@kernel.org>
References: <20211015111422.1027-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Rename a couple of oddly named labels that are used to unlock before
returning after what they do (rather than after the context they are
used in) to improve readability.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index e4dd82fd7c2a..5775cbff8f6e 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1338,7 +1338,7 @@ static void autoconfig(struct uart_8250_port *up)
 	up->tx_loadsz = uart_config[port->type].tx_loadsz;
 
 	if (port->type == PORT_UNKNOWN)
-		goto out_lock;
+		goto out_unlock;
 
 	/*
 	 * Reset the UART.
@@ -1355,7 +1355,7 @@ static void autoconfig(struct uart_8250_port *up)
 	else
 		serial_out(up, UART_IER, 0);
 
-out_lock:
+out_unlock:
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	/*
@@ -2714,12 +2714,12 @@ void serial8250_update_uartclk(struct uart_port *port, unsigned int uartclk)
 	mutex_lock(&tport->mutex);
 
 	if (port->uartclk == uartclk)
-		goto out_lock;
+		goto out_unlock;
 
 	port->uartclk = uartclk;
 
 	if (!tty_port_initialized(tport))
-		goto out_lock;
+		goto out_unlock;
 
 	termios = &tty->termios;
 
@@ -2737,7 +2737,7 @@ void serial8250_update_uartclk(struct uart_port *port, unsigned int uartclk)
 	spin_unlock_irqrestore(&port->lock, flags);
 	serial8250_rpm_put(up);
 
-out_lock:
+out_unlock:
 	mutex_unlock(&tport->mutex);
 	up_write(&tty->termios_rwsem);
 	tty_kref_put(tty);
-- 
2.32.0

