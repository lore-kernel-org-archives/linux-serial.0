From: Dalibor Kranjcic <dalibor.kranjcic@ultra.si>
Subject: modem multiplexing mode?
Date: 19 Aug 2003 11:51:32 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <1061286695.1312.172.camel@dalibork.ultra.si>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from naomi.triera.net ([213.161.0.25]:20144 "EHLO naomi.triera.net")
	by vger.kernel.org with ESMTP id S269639AbTHSJvg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Aug 2003 05:51:36 -0400
Received: from dalibork.ultra.si (cpe1-7-75.cable.triera.net [213.161.7.75])
	by naomi.triera.net (Postfix) with ESMTP id D156C177A4
	for <linux-serial@vger.kernel.org>; Tue, 19 Aug 2003 11:52:42 +0200 (CEST)
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,


Is there any way to send addtional traffic (AT commands) to serial port 
(/dev/ttyS1 (COM2) in my example) when ppp is atached to it, thus
providing something as a modem 
multiplexing mode/protocol (Wavecom GPRS modem), since /dev/ttyS1 is
locked by pppd and used by ppp modules. 

I tried to use /dev/ttyS12 as virtual port for COM2, which would
allow sending of additional data flow to COM2 independently from the
data flow which is already sent trough /dev/ttyS1 (ppp traffic).

So, I expect write to /dev/ttyS12 to activate rs_interrupt_single method
which does the actual write in serial driver. 
Once I'm in rs_interrupt_single method I
would redirect the incoming user space data to TX lines for COM2.

The write to /dev/ttyS12 fails with EIO Input/Output error, I suppose
because there is no UART defined for this device and some initialization
stuff doesn't go trough.

Is there any way to have more (virtual) tty device files for the same
COM 
thus allowing AT commands to be sent despite present ppp traffic.
Is it possible to send AT commands when ppp traffic is running on serial
port?  


Thanks for any advice...


Dalibor Kranjcic.




