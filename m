From: "Neil Everton" <neil@gemini-it.com>
Subject: [OT(ish] Duplicate Character between modems
Date: Fri, 2 Aug 2002 21:41:09 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <HMEGLNIPFGJPACKIEKLFGEJJEPAA.neil@gemini-it.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from marstons.services.quay.plus.net (marstons.services.quay.plus.net [212.159.14.223])
	by zeus.kernel.org (8.11.6/8.11.6) with SMTP id g72KeOg22832
	for <linux-serial@vger.kernel.org>; Fri, 2 Aug 2002 13:40:29 -0700
List-Id: linux-serial@vger.kernel.org
To: "Linux-Serial@Vger. Kernel. Org" <linux-serial@vger.kernel.org>

Hi,
	My apologies for sending this here, but I reckon you guys are probably the
best bet I have of finding a solution to my problem (esp. as it indirectly
relates to serial programming)

	I'm currently porting an application from DOS to Linux (RH7.2 with Cyclades
Cyclom-Y (hi henrique!!)).

	My issue is this, if I send down the modem ;
"ABCDEFGHI"
	the receiving end (very infrequently) receives
"AABCDEFGHI"
	This is caught by the check digit routine and the line is NAK'd ready for a
re-transmit. It will usually work the second or third time. This has found a
bug in the 3rd party transmitting software, but they're taking the attitude
of the existing system works, so you fix your end !!! (the bug if your
interested is after sending a NAK they drop the connection, instead of
waiting for 5 retries)

	The existing DOS system uses old modems such as Pace Linnet (1200 baud) and
an even older modem called a Compact which you cannot do anything with, no
init string, no RING or CONNECT message, just straight into getting the
data.

	The new system is using 3Com Courier V.everything modems. I can replicate
the problem on other modems as well, so it's not a courier issue. We have to
disable any error correction, compression (except MNP), and set the flow
control to hardware. As far as I can see I've disable pretty much
everything, but I still occasionally get these duplicated characters. It
used to be quite bad and then I realised that the Courier set the flow
control on both the transmit and receive stacks seperately. Once I'd set the
flow control to hardware for both stacks it made the issue a lot better, but
I still get it.

	I can normally get this issue (at home) at least every 3rd order, luckily
it's not so bad at the clients end. My home setup incidentally doesn't have
a cyclades card, but I've sniffed at the modem connection and I definatly
don't send the duplicate characters to the modem, they're adding in between
the modems.

	The modem I'm sending on is a generic 56k modem, but we're getting the
issue on 300 baud modems, with the Courier set to only connect at 300. The
connect message is simply 'CONNECT' so should be giving no error correction,
compression, etc. it should be a standard V21 connection. There might be an
issue with fast modems connecting at V21 I'm not aware of, but I'm at a
loss. My client is also concerned with the issue (understandably) and are
also in the 'it works on the existing system' mentality.

Any help/pointers/advice gratefully received
Regards
Neil Everton

