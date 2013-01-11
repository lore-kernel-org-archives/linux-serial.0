From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Warning about not setting tty->port: what to set it to?
Date: Fri, 11 Jan 2013 20:34:23 +0000 (UTC)
Message-ID: <kcpt0f$ott$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53722 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755558Ab3AKUei (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Jan 2013 15:34:38 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1TtlJS-0001wr-He
	for linux-serial@vger.kernel.org; Fri, 11 Jan 2013 21:34:50 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 11 Jan 2013 21:34:50 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 11 Jan 2013 21:34:50 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I maintain a serial card driver which, starting with kernel 3.7,
produces this warning when a port is opened:

 tty_init_dev: ttyXYZ driver does not set tty->port. This will crash the kernel later. Fix the driver!

The driver still seems to work fine, but apparently I shouldn't expect
it to continue to do so.  

What am I supposed to set tty->port _to_ ?

Obviously, it's supposed to point to an instance of the type (struct tty_port).

Is there somewhere in particular I'm supposed to get that structure
instance from?

Am I supposed to allocate/clear one when the port is opened and free
it when the port is closed?  Or does the contents the structure
pointed to by tty->port need to be preserved?

Am I expected to do anything with the contents of that structure?

Or am I just providing some storage space for use by the tty layer
code?

-- 
Grant Edwards               grant.b.edwards        Yow! I'm young ... I'm
                                  at               HEALTHY ... I can HIKE
                              gmail.com            THRU CAPT GROGAN'S LUMBAR
                                                   REGIONS!

