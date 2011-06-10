From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: uart : lost characters when system is busy
Date: Fri, 10 Jun 2011 10:58:17 +0200
Message-ID: <4DF1DCA9.9060604@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:41719 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753537Ab1FJI6y (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Jun 2011 04:58:54 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hi,

the linux uart layer can loose some characters if the system is busy.

uart_throttle/uart_unthrottle is called from a workqueue.
If the system is busy, and the uart receive lot's of data, we fill the tty
buffer, but the workqueue doesn't run and we never have a chance to call
uart_throttle. So the uart is never slow down.

And because most uart driver call uart_insert_char (that doesn't return if
tty_insert_flip_char manage to push the character), we never detect that there
are some lost characters.


A workaround could be to check the buffer threshold in tty_flip_buffer_push and
call throttle callback if needed.


Matthieu
