From: "Deepak Gupta" <deepak@cse.iitk.ac.in>
Subject: serial communication problems
Date: Wed, 29 May 2002 16:35:11 +0530
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <NGBBLCPHOLHALDOMDOMNIEEFCAAA.deepak@cse.iitk.ac.in>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailhost.cse.iitk.ac.in (mailhost.cse.iitk.ac.in [172.31.16.2])
	by mail.cse.iitk.ac.in (8.11.6/8.11.2) with ESMTP id g4TAqnp13399
	for <linux-serial@vger.kernel.org>; Wed, 29 May 2002 16:22:49 +0530
Received: from dg (dg.cse.iitk.ac.in [172.31.16.73])
	by mailhost.cse.iitk.ac.in (8.10.1/8.10.1) with SMTP id g4TB5An16854
	for <linux-serial@vger.kernel.org>; Wed, 29 May 2002 16:35:10 +0530 (IST)
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I have a strange problem with the serial line communication in Linux
(RH 7.2, kernel 2.4.7-10).  We have some electronic locks that are
controlled by a PC.  The locks are connected by a RS485 twisted pair
(multidrop) and this line terminates in a 485-232 converter box which
is connected via the serial line to a PC.  The lock vendor has supplied
a Windows software to program the locks which works fine on this PC.
He has also given me the protocol that is followed between the PCs and
the locks.  I am trying to write my own Linux based software for
programming the locks.

The problem is that when the vendor software sends a command to a lock
it replies obediently but when my program writes exactly the same sequence
of bytes to the serial line, I don't get a response (the protocol
says that the lock will not respond unless it gets a valid command).
I know the locks use 9600 baud, 8 bits, no parity, 1 stop bit and I
am using the same.  I also tried with and without hardware flow control
(RTS/CTS) but no luck.  I know that the command I send is right since
I used another PC to listen to what the vendor software writes on the
serial line and it matches the protocol description that I have.

Incidentally I opened up the 232-485 converter box and saw that it
uses only the TX, RX, SG, RTS and CTS lines on the RS232 side.  So 
it cannot be a matter of DTR or some other signal.

Please help.

Deepak Gupta
