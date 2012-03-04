From: matthieu castet <castet.matthieu@free.fr>
Subject: [PATCH 0/9] [RFC] tty : make receive_room internal to N_TTY line
 discipline
Date: Sun, 4 Mar 2012 19:05:13 +0100
Message-ID: <20120304190513.0b7a881b@mat-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:51023 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754476Ab2CDSFW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 4 Mar 2012 13:05:22 -0500
Received: from mat-laptop (unknown [81.57.151.96])
	by smtp6-g21.free.fr (Postfix) with ESMTP id BBB6F8237C
	for <linux-serial@vger.kernel.org>; Sun,  4 Mar 2012 19:05:15 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Toby Gray <toby.gray@realvnc.com>, Stefan Bigler <stefan.bigler@keymile.com>

These patches try to solve issue exposed on
https://lkml.org/lkml/2011/6/7/700

On Tue, Jun 07, 2011 at 07:44:48PM -0700, Linus Torvalds wrote
> I'd love to get rid of receive_room entirely - and just letting the
> tty line discipline handler say how much it actually received. in
> other words, having receive_buf() just tell us how much it used, and
> not looking at receive_room in the caller is absolutely the right
> thing.

GIT: [PATCH 1/9] tty: make receive_buf() return the amout of bytes
GIT: [PATCH 2/9] tty : make n_tty_receive_buf return bytes received in
GIT: [PATCH 3/9] tty: make hci_uart_tty_receive return bytes received
GIT: [PATCH 4/9] tty : kill receive_room usage in vt
GIT: [PATCH 5/9] tty : kill receive_room usage in speakup
GIT: [PATCH 6/9] tty : don't use receive_room in tty_set_ldisc
GIT: [PATCH 7/9] tty : kill receive_room usage in tty_buffer
GIT: [PATCH 8/9] tty : kill receive_room usage in mxser
GIT: [PATCH 9/9] tty : make receive_room internal to N_TTY line
