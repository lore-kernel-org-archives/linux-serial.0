From: Gerald Emig <gme@heisch.inka.de>
Subject: Re: serial communication problems
Date: Wed, 29 May 2002 16:07:17 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0205291602120.17925-100000@emig4.heisch.inka.de>
References: <NGBBLCPHOLHALDOMDOMNIEEFCAAA.deepak@cse.iitk.ac.in>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <NGBBLCPHOLHALDOMDOMNIEEFCAAA.deepak@cse.iitk.ac.in>
List-Id: linux-serial@vger.kernel.org
To: Deepak Gupta <deepak@cse.iitk.ac.in>
Cc: linux-serial@vger.kernel.org

On Wed, 29 May 2002, Deepak Gupta wrote:

> Hi,
>
> I have a strange problem with the serial line communication in Linux
> (RH 7.2, kernel 2.4.7-10).  We have some electronic locks that are
> controlled by a PC.  The locks are connected by a RS485 twisted pair
> (multidrop) and this line terminates in a 485-232 converter box which
> is connected via the serial line to a PC.  The lock vendor has suppli=
ed
> a Windows software to program the locks which works fine on this PC.
> He has also given me the protocol that is followed between the PCs an=
d
> the locks.  I am trying to write my own Linux based software for
> programming the locks.
>
> The problem is that when the vendor software sends a command to a loc=
k
> it replies obediently but when my program writes exactly the same seq=
uence
> of bytes to the serial line, I don't get a response (the protocol
> says that the lock will not respond unless it gets a valid command).
> I know the locks use 9600 baud, 8 bits, no parity, 1 stop bit and I
> am using the same.  I also tried with and without hardware flow contr=
ol
> (RTS/CTS) but no luck.  I know that the command I send is right since
> I used another PC to listen to what the vendor software writes on the
> serial line and it matches the protocol description that I have.
>
> Incidentally I opened up the 232-485 converter box and saw that it
> uses only the TX, RX, SG, RTS and CTS lines on the RS232 side.  So
> it cannot be a matter of DTR or some other signal.
>

I had a similar problem a few days ago.
Old software worked, new one did not.
So I also used a third PC to look what the others talk.
I noticed the same as you.

Solution was that RTS had to be set active.


> Please help.
>
> Deepak Gupta
> -
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


Gerald Emig

--
EMIG Software		Tel. 06858-6197, Mobil: 0163-4751706
Engelstr. 17		Fax. 0721-151-348672
66564 Ottweiler-F=FCrth	http://sites.inka.de/heisch
Germany			e-mail: gme@heisch.inka.de


-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
