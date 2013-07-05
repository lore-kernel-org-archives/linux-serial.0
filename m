From: gianluca <gianluca@sottospazio.it>
Subject: question about tty_port.c
Date: Fri, 5 Jul 2013 08:58:34 +0200
Message-ID: <20130705065834.GA3548@debian.seek.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:53481 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534Ab3GEG6j (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Jul 2013 02:58:39 -0400
Received: from mail.seek.priv (87.4.110.188) by smtp209.alice.it (8.6.060.15)
        id 51CD43980183731D for linux-serial@vger.kernel.org; Fri, 5 Jul 2013 08:58:35 +0200
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I was getting kernel panics using an rfcomm bluetooth serial port with the
kernel 3.10 and searching the web I stumbled upon the following issue, which
seems to be exactly the problem I have:

http://marc.info/?t=136868685500006&r=1&w=2

So I went to look tty_port.c to understand the lifetime of the tty_port objects
and fix rfcomm/tty.c

This is unrelated to the issue I have but it seems to me that in
tty_port_tty_hangup we could leak a tty object:

        if (tty && (!check_clocal || !C_CLOCAL(tty))) {
                tty_hangup(tty);
                tty_kref_put(tty);
        }

If the first condition is true (tty != NULL) and the second is false we never
call tty_kref_put.

However I could be wrong and in this case I apologize.

I don't understand the inner working of this code, I was just trying to fix
the oops I get, without luck unfortunately.

Ciao,

Gianluca
