From: Dalibor Kranjcic <dalibor.kranjcic@ultra.si>
Subject: more device files on same COM?
Date: 18 Aug 2003 16:03:18 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <1061215398.16386.44.camel@dalibork.ultra.si>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from naomi.triera.net ([213.161.0.25]:55768 "EHLO naomi.triera.net")
	by vger.kernel.org with ESMTP id S271703AbTHROAF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Aug 2003 10:00:05 -0400
Received: from dalibork.ultra.si (cpe1-7-75.cable.triera.net [213.161.7.75])
	by naomi.triera.net (Postfix) with ESMTP id 5DA571774F
	for <linux-serial@vger.kernel.org>; Mon, 18 Aug 2003 16:01:11 +0200 (CEST)
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I would like to use /dev/ttyS12 as virtual port for COM2, which would
allow sending of additional data flow to COM2 independently from the
data flow which is already sent trough /dev/ttyS1 (let's say ppp).

So, I expect write to /dev/ttyS12 to activate rs_interrupt_single method
which does the actual write. Once I'm in rs_interrupt_single method I
would redirect the incoming user space data to TX lines for COM2.

The write to /dev/ttyS12 fails with EIO Input/Output error, I suppose
because there is no UART defined for this device and some initialization
stuff doesn't go trough.

I'm wondering if there is any way to activate rs_interrupt_single method
in serial.c or for /dev/ttyS12 or in other words is there any way to
have more (virtual) tty device files for the same COM? 


Thanks for any advice...


Dalibor Kranjcic.

