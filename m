From: Dalibor Kranjcic <dalibor.kranjcic@ultra.si>
Subject: [Fwd: modem multiplexing mode?]
Date: 20 Aug 2003 12:16:32 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <1061374592.1363.40.camel@dalibork.ultra.si>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Nd2XaPKj4oklzPPnbsU3"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from naomi.triera.net ([213.161.0.25]:54449 "EHLO naomi.triera.net")
	by vger.kernel.org with ESMTP id S261854AbTHTKQa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Aug 2003 06:16:30 -0400
Received: from dalibork.ultra.si (cpe1-7-75.cable.triera.net [213.161.7.75])
	by naomi.triera.net (Postfix) with ESMTP id BFD7017749
	for <linux-serial@vger.kernel.org>; Wed, 20 Aug 2003 12:17:36 +0200 (CEST)
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--=-Nd2XaPKj4oklzPPnbsU3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit




--=-Nd2XaPKj4oklzPPnbsU3
Content-Disposition: inline
Content-Description: Forwarded message - modem multiplexing mode?
Content-Type: message/rfc822

Subject: modem multiplexing mode?
From: Dalibor Kranjcic <dalibor.kranjcic@ultra.si>
To: linux-ppp@vger.kernel.org
Cc: tytso@mit.edu, james.cameron@hp.com, paulus@samba.org,  stuartm@connecttech.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 20 Aug 2003 12:12:24 +0200
Message-Id: <1061374345.1363.35.camel@dalibork.ultra.si>
Mime-Version: 1.0


Thank you all for your answers,
Let me describe a little more the subject I'm working on:

The Wavecom GPRS modem allows double session: one for AT commands and
one for DATA communication.
Sending of AT command AT+WMUX=1 activates the Multiplexing Mode. With
this mode, AT commands and DATA are encapsulated into packets. The
header of these packets allows to recognize whether it is a DATA packet
or an AT command packet.
AT+WMUX=0 deactivates the Multiplexing Mode and gets modem back to the
default mode.

AT command packet in multiplexing mode:
---------------------------------------
Start pattern 0xAA
AT command length LSB
AT command pattern 0x1D
AT command length MSB
AT command
checksum


DATA packet in multiplexing mode:
---------------------------------
Start pattern 0xDD
Data packet  length LSB
Data packet type
Data packet length MSB
Data bytes
Checksum

Sending AT command in multiplexing mode is not just matter of sending
+++ escape, but actually there is a new type of packets which have to be
sent trough line. So, I guess, some changes must be done in serial
driver also in order to demultiplex/multiplex incoming/outgoing packets.

Paul, your solution seems interesting. Did you mean of adding a new
ioctl command to the ppp_asynctty_ioctl line discipline function or
adding a completly new ioctl function (new additional line discipline)?

I have once added my own ioctl commands in the serial driver, but ppp
blocked anything sent from this ioctl while ppp was active.

If I demultiplex received multiplexed packets in the serial driver and
send them trough the serial driver normally as any other packet I expect
to see this packets in the ppp_asynctty_receive method in ppp_async.c,
if I'm right. How to proceed this packets (AT) back to /dev/ttyS0? Would
blocking of net device be enough to allow usual reading of /dev/ttyS0
from the user space?
One possible solution would be to send incoming packets to some fifo.

I have managed to modify serial driver in order to send AT commands and
PPP traffic separately with use of external fifo:

When traffic comes to the serial driver I check if it is AT or DATA. If
DATA (PPP) traffic comes to serial I proceed it normally, if AT traffic
comes I write it to the external fifo (let's say /dev/ATtraffic).

Sending traffic to serial driver is a little bit tricky. After writing
to fifo I need an entry point to the driver. 
Driver must know that something was written to fifo. So I open an
'dummy' device for example /dev/ttyS12. This allows me to jump into
driver's rs_open method. From there I can read AT commands written to
fifo previously and proceed them to the TX line. Of course this traffic
must be multiplexed before coming to TX lines and I also have to watch
out not to break ppp packets in the middle. 

This works well and I'm really able to send/receive AT packets while ppp
is up, but maybe there is better way to do it?

What do you think about this solution?

So at the end, my goal would be to have to separate devices let's say
/dev/ATtraffic and /dev/PPPtraffic.
I was not working with line disciplines, so I have just basic idea of
what should be done.

I would be grateful for all advices that you can send me.


Dalibor.




 





--=-Nd2XaPKj4oklzPPnbsU3--

