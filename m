From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Are calls to open()/close() serialized by tty layer?
Date: Wed, 16 Jan 2013 20:07:49 +0000 (UTC)
Message-ID: <kd71al$c78$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35360 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064Ab3APUIK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 15:08:10 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1TvZHc-0006nl-FV
	for linux-serial@vger.kernel.org; Wed, 16 Jan 2013 21:08:24 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 16 Jan 2013 21:08:24 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 16 Jan 2013 21:08:24 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Are calls to a tty driver's open()/close() methods serialized by the
tty layer?  If so, has this always been the case?

I'm working on converting an old tty driver over to using the "new"
tty_port_* functions and the standard "struct tty_port" port data
structure.

[I thought about converting it to a uart driver for serial_core, but
AFAICT, that API doesn't provide any way to return errors for
userspace open() and write() calls and would therefore break my
user-land API.]

>From looking at example tty drivers in the 3.7.2 source tree, it
appears that they assume calls to open()/close() are serialized.

The old driver I'm working on had its own internal locking to protect
race conditiions when incrementing and decrementing of a port's open
count.  That counter is being prelaced by tty->port->count, and in
existing in-kernel tty drivers it doesn't look like there is any
locking when that count is incremented during an open().

For example, from rocket.c:

   891	static int rp_open(struct tty_struct *tty, struct file *filp)
   892	{
[...]   
   924	        tty->driver_data = info;
   925	        tty_port_tty_set(port, tty);
   926	
   927	        if (port->count++ == 0) {
   928	                atomic_inc(&rp_num_ports_open);
   929	
   930	#ifdef ROCKET_DEBUG_OPEN
   931	                printk(KERN_INFO "rocket mod++ = %d...\n",
   932	                                atomic_read(&rp_num_ports_open));
   933	#endif
   934	        }

If calls to open()/close() aren't serialized, then line 927 would
cause a race condition...

-- 
Grant Edwards               grant.b.edwards        Yow! Everybody gets free
                                  at               BORSCHT!
                              gmail.com            

