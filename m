From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: tty_reopen() returning -EIO because port is closing
Date: Fri, 18 Jan 2013 21:23:10 +0000 (UTC)
Message-ID: <kdcefu$dbc$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34853 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753930Ab3ARVX0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Jan 2013 16:23:26 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1TwJPY-0005k3-Ah
	for linux-serial@vger.kernel.org; Fri, 18 Jan 2013 22:23:40 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 18 Jan 2013 22:23:40 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 18 Jan 2013 22:23:40 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

During testing of a tty driver that's just been updated to use the
tty_port_ helper functions, I'm seeing a test failure in user-space
when open() returns -EIO.

The failure occurs sporadically (maybe 1 failure per 100 opens) when
running a test that has multiple threads all opening and closing the
same serial port (more or less at random).

It's worth noting that my port activate and shutdown functions sleep.

Typically, they sleep for a few ms [this is the case during the tests
I've been running].  But, there are use cases where they could sleep
for hundreds of ms.

I've tracked the failure to tty_reopen() in tty_io.c [3.8-rc3]:

  1331	static int tty_reopen(struct tty_struct *tty)
  1332	{
  1333	        struct tty_driver *driver = tty->driver;
  1334	
  1335	        if (test_bit(TTY_CLOSING, &tty->flags) ||
  1336	                        test_bit(TTY_HUPPING, &tty->flags) ||
  1337	                        test_bit(TTY_LDISC_CHANGING, &tty->flags))
  1338	                return -EIO;

Line 1338 is returning -EIO because test_bit(TTY_CLOSING, &tty->flags)
is true.

Can this be caused by a bug in my driver?

If not, is it a bug in the tty layer?

Does Posix say than an open() may fail if it's called while another
process is calling close()?  IOW, is user-space code expected to retry
an open() call that returns EIO?  [I've never seen user-space code
that did that...]

-- 
Grant Edwards               grant.b.edwards        Yow! I'm having a RELIGIOUS
                                  at               EXPERIENCE ... and I don't
                              gmail.com            take any DRUGS

