From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: close() handler of tty driver called for port that's not open?
Date: Wed, 14 Sep 2011 16:21:03 +0000 (UTC)
Message-ID: <j4qk9f$vro$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:55722 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837Ab1INQVV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Sep 2011 12:21:21 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1R3sD8-0003jZ-3h
	for linux-serial@vger.kernel.org; Wed, 14 Sep 2011 18:21:18 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 14 Sep 2011 18:21:18 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 14 Sep 2011 18:21:18 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Why does the tty layer call my tty driver's close() handler on a port
that's not open?

The scenario I've run into is that my open() handler is called for a
serial port that's not currently available, so I return -EBUSY.  The
libc open() call returns an error:

  [Errno 16] Device or resource busy: '/dev/ttySI0'

But then after the open has failed, my tty driver sees a call to
close() the device which failed to open.

Why does the tty layer try to close a device that isn't open?

Does the tty consider a device to be open even if the open() handler
returned an error?

The problem is that my driver keeps a usage count on the port so it
can clean up some internal stuff when the last user closes a port.

I only increment the usage count when an open is successful.  That
doesn't work very well when the tty layer calls close() on a device
regardless of whether or not it was able to open it first.

Does the tty layer guarantee that the number of close() calls will
match the number of open() calls regardless of whether the open()
calls succeed or not?

If so, has that always been the policy, or is calling close() on
non-open device a new feature?

-- 
Grant Edwards               grant.b.edwards        Yow! I want to mail a
                                  at               bronzed artichoke to
                              gmail.com            Nicaragua!

