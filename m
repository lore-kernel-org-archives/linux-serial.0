From: ian <spyro@f2s.com>
Subject: Line disciplines.
Date: Tue, 15 Jul 2008 21:10:25 +0100
Message-ID: <1216152625.11481.38.camel@wirenth>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mk-outboundfilter-5.mail.uk.tiscali.com ([212.74.114.1]:59336
	"EHLO mk-outboundfilter-5.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753355AbYGOUV6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Jul 2008 16:21:58 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi!

Im trying to use a line discipline as a way to hook my kernel module up
to a serial port.

I've implemented methods for open, close, and receive_buf, and
registered the line discipline (Im using N_MOUSE as my number for now)

I've tried using stty line 2 < /dev/ttyS1 to attach my line discipline
to a serial port (and tried this on an already open port too (using cat
to open the port) and my methods never get called.

I've even written a little userspace program that opens  ttyS1 and uses
tcsetattr() to select c_line=N_MOUSE.

It looks like the ldisc is being set because after this stty reports
ttyS1 to be using '2' which is correct, however my methods are still
never called.

What am I missing?

TIA,

-Ian

