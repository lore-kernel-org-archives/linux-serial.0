From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: tty_flip_buffer() from atomic context when low_latency==1
Date: Fri, 19 Aug 2011 19:43:34 +0000 (UTC)
Message-ID: <j2med6$q2r$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:58481 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756098Ab1HSTnt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Aug 2011 15:43:49 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1QuUyq-0000aZ-8s
	for linux-serial@vger.kernel.org; Fri, 19 Aug 2011 21:43:48 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 19 Aug 2011 21:43:48 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 19 Aug 2011 21:43:48 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I've been looking at various drivers to try to figure out how to
receive a block of serial data in an atomic context.  All the examples
I can find buffer the receive data with calls to
tty_insert_flip_string() or tty_insert_flip_char(), then they call
tty_flip_buffer_push().

But, many drivers appear to call tty_flip_buffer_push() from an atomic
context. If that is done with tty->low_latency==1 it turns into a call
to flush_to_ldisc(), which then calls disc->ops->receive_buf(), which
must not be called from an atomic context.

Is the low_latency flag being forced to 0 somewhere behind the scenes
when tty_flip_buffer_push() is being called from an atomic context?

-- 
Grant Edwards               grant.b.edwards        Yow! I'm receiving a coded
                                  at               message from EUBIE BLAKE!!
                              gmail.com            

