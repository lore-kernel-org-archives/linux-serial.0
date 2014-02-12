From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Is tty->receive_room no longer usable w/ SMP?
Date: Wed, 12 Feb 2014 22:43:18 +0000 (UTC)
Message-ID: <ldgte5$kp1$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38961 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754155AbaBLWno (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Feb 2014 17:43:44 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1WDiWs-0005U5-1T
	for linux-serial@vger.kernel.org; Wed, 12 Feb 2014 23:43:42 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 12 Feb 2014 23:43:42 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 12 Feb 2014 23:43:42 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

A couple serial drivers I maintain check the value of tty->receive_room
to decide the max number of bytes to pull out of the UART's receive
FIFO and shove into a flip buffer.

After checking tty->receive room to decide how many bytes to read, one
of the drivers uses this sequence:

 tty_prepare_flip_string_flags(...)
 <fill up char buffer and flag buffer>
 tty_flip_buffer_push(...)

The other uses

 for (i=0; i<count; ++i)
   uart_insert_char(...);
 tty_flip_buffer_push(...);   
 
But, starting with kernel 3.12.0, whenSMP is enabled, tty->receive_room
is always 0 and never changes.  With SMP disabled, it seems to work the
way it always has.

Is use of tty->receive room no longer supported for SMP kernels?

How _should_ a serial driver decide how many rx characters there are
room for?

-- 
Grant Edwards               grant.b.edwards        Yow! What I need is a
                                  at               MATURE RELATIONSHIP with a
                              gmail.com            FLOPPY DISK ...

