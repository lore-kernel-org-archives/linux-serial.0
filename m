From: Fabio Estevam <festevam@gmail.com>
Subject: Incorrect set_ldisc() for mxs-auart
Date: Wed, 12 Nov 2014 15:26:05 -0200
Message-ID: <CAOMZO5BzF5t-TFBP-YLrkLO0tj0n9U-ShbdTHNkpGuxOm=DueA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:56683 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319AbaKLR0H (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 12:26:07 -0500
Received: by mail-lb0-f182.google.com with SMTP id f15so10749409lbj.13
        for <linux-serial@vger.kernel.org>; Wed, 12 Nov 2014 09:26:05 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Janusz Uzycki <j.uzycki@elproma.com.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Janusz,

Since commit 36a262782b04 ("serial: mxs-auart: enable PPS support")
the following build warning is seen:

drivers/tty/serial/mxs-auart.c:962:2: warning: initialization from
incompatible pointer type
  .set_ldisc      = mxs_auart_set_ldisc,
  ^
drivers/tty/serial/mxs-auart.c:962:2: warning: (near initialization
for 'mxs_auart_ops.set_ldisc')

The mxs_auart_set_ldisc() function should look like this:

static void mxs_auart_set_ldisc(struct uart_port *port, struct
ktermios *termios)

instead of

static void mxs_auart_set_ldisc(struct uart_port *port, int new)

Please fix it.
