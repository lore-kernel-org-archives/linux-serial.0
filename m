From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: tcflow(TCOON/TCOOFF) vs. received XON/XOFF characters
Date: Wed, 16 Jul 2014 17:20:58 +0000 (UTC)
Message-ID: <lq6c9q$isi$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57219 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933237AbaGPRVO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jul 2014 13:21:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1X7StE-0005n8-Mx
	for linux-serial@vger.kernel.org; Wed, 16 Jul 2014 19:21:12 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 16 Jul 2014 19:21:12 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 16 Jul 2014 19:21:12 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I'm working on the regression test appliction I use to test the serial
drivers I maintain, and I've run into a problem with interaction
between tcflow(TCOON/TCOOFF) and XON/XOFF using bog-standard 16x50
UARTs and the normal in-kernel driver.

When I call tcflow(TCOOFF) on a tty device and then write data to that
tty device, the data isn't sent. That's what I expect. But, when an
XON is then received by that port, it does not start the tx data.

Conversly, when a serial port receives an XOFF, it stops sending
data as it should, but a subsequent call to tcflow(TCOON) does not
casue it to start sending data.

Am I misunderstanding how tcflow(TCOxxx) is supposed to interact with
XON/XOFF flow control?

Or is something broken in the tty layer or uart driver?

-- 
Grant Edwards               grant.b.edwards        Yow! This is a NO-FRILLS
                                  at               flight -- hold th' CANADIAN
                              gmail.com            BACON!!

