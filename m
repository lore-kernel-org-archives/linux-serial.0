From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Curious about tty_port_operations drop() callback.
Date: Tue, 22 Jan 2013 16:38:54 +0000 (UTC)
Message-ID: <kdmfat$dt9$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38528 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754319Ab3AVQjJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Jan 2013 11:39:09 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1Txgsd-0007JA-Tu
	for linux-serial@vger.kernel.org; Tue, 22 Jan 2013 17:39:23 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 22 Jan 2013 17:39:23 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 22 Jan 2013 17:39:23 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

While testing/debugging the tty driver I've changed to use the
tty_port_* helper functions, I noticed there are two
tty_port_operation fields that I'm not providing: destruct() and
drop(). There's an example of destruct() usage in the hvc driver and a
comment in tty.h explaining when it's called, so that's fairly
obvious.

I haven't been able to figure out the purpose of the drop() callback.
It's not used anywhere and there is no comment in tty.h hinting at its
purpose.

Looking at tty_port_close() shows that drop() is called during close()
of port with a reference count > 1.  IOW, close() calls drop() in the
cases where it isn't going to call shutdown().

There doesn't seem to be a corresponding "raise" callback during
open() when activate() isn't going to be called, and I can't think of
any use for either drop or raise...

-- 
Grant Edwards               grant.b.edwards        Yow! My mind is a potato
                                  at               field ...
                              gmail.com            

