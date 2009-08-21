From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Persistent problem with wait_until_sent timeout parameter type
 mismatch
Date: Fri, 21 Aug 2009 20:03:54 +0000 (UTC)
Message-ID: <h6muja$6ol$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:53137 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932200AbZHUUEZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Aug 2009 16:04:25 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MeaLX-00028x-RR
	for linux-serial@vger.kernel.org; Fri, 21 Aug 2009 22:04:23 +0200
Received: from mn-69-34-67-62.sta.embarqhsd.net ([69.34.67.62])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 21 Aug 2009 22:04:23 +0200
Received: from grant.b.edwards by mn-69-34-67-62.sta.embarqhsd.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 21 Aug 2009 22:04:23 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I seem to have run into a problem which people have been
pointing out for years, but never gets fixed.

In tty_driver.h, the low-level driver routine wait_until_set()
function takes an "int" as a timeout value:

   192	struct tty_operations {
   193		int  (*open)(struct tty_struct * tty, struct file * filp);
[...]
   214		void (*wait_until_sent)(struct tty_struct *tty, int timeout);
[...]
   228	};

But, in tty_ioclt.c in the tty_wait_unti_sent() function, the
timeout is a "long":

    98	void tty_wait_until_sent(struct tty_struct *tty, long timeout)
    99	{
   100	#ifdef TTY_DEBUG_WAIT_UNTIL_SENT
   101		char buf[64];
   102	
   103		printk(KERN_DEBUG "%s wait until sent...\n", tty_name(tty, buf));
   104	#endif
   105		if (!timeout)
   106			timeout = MAX_SCHEDULE_TIMEOUT;
   107		if (wait_event_interruptible_timeout(tty->write_wait,
   108				!tty_chars_in_buffer(tty), timeout) >= 0) {
   109			if (tty->ops->wait_until_sent)
   110				tty->ops->wait_until_sent(tty, timeout);
   111		}
   112	}
   113	EXPORT_SYMBOL(tty_wait_until_sent);

This is fine on 32-bit systems, where "int" and "long" are
equivalent, but it results in breakage on 64-bit systems.  At
line 106, timeout is set to MAX_SCHEDULE_TIMEOUT which is 
7fffffffffffffff.  When that value is passed to the low-level
driver routine at line 110, it gets truncated to ffffffff --
which is -1.  That means that waiting until (jiffies+timeout)
returns immediately when the caller's intent was to wait as
long as possible.

People have been pointing out that type mismatch for many years
now.  What's the justification for the low-level driver routine
parameter being "int" instead of "long"?

Since this doesn't seem to be something that's going to be
fixed, I guess a work-around for those of us who maintain
serial drivers is to treat a timeout of -1 as a special value
that means "forever"?  Is that the intent?

-- 
Grant Edwards                   grante             Yow! I feel like a wet
                                  at               parking meter on Darvon!
                               visi.com            

