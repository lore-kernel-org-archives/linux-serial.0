From: "Deepak Gupta" <deepak@cse.iitk.ac.in>
Subject: RE: serial communication problems
Date: Thu, 30 May 2002 12:10:47 +0530
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <NGBBLCPHOLHALDOMDOMNEEEHCAAA.deepak@cse.iitk.ac.in>
References: <Pine.LNX.4.33.0205300846120.17925-100000@emig4.heisch.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0205300846120.17925-100000@emig4.heisch.inka.de>
List-Id: linux-serial@vger.kernel.org
To: Gerald Emig <gme@heisch.inka.de>
Cc: linux-serial@vger.kernel.org

Thanks for the response.  I tried lowering RTS after
sending the data and raising it again before the next
try (using calls ioctl(fd, TIOCMBIC/TIOCMBIS, ...)).
But no luck.  When I debugged the program, and looked
at /proc/tty/driver/serial at breakpoints, I observed
(as expected) that RTS is high when sending and low
after sending.

I'm feeling desperate, please help .....

Deepak

-----Original Message-----
=46rom: Gerald Emig [mailto:gme@heisch.inka.de]
Sent: Thursday, May 30, 2002 12:21 PM
To: Deepak Gupta
Subject: RE: serial communication problems



If it is such a converter box as you wrote, RTS probably only may activ=
e
if your program is sending. If it stays active after that, you can not
receive any data, because RTS switches between receive and transmit of =
the
box.

On Thu, 30 May 2002, Deepak Gupta wrote:

> RTS is active as reported by /proc/tty/driver/serial.
> In fact all three of RTS, CTS, and DTR are shown active.
>
> What else could be wrong?
>
> Deepak
>
> -----Original Message-----
> From: Gerald Emig [mailto:gme@heisch.inka.de]
> Sent: Wednesday, May 29, 2002 7:37 PM
> To: Deepak Gupta
> Cc: linux-serial@vger.kernel.org
> Subject: Re: serial communication problems
>
>
> On Wed, 29 May 2002, Deepak Gupta wrote:
>
> > Hi,
> >
> > I have a strange problem with the serial line communication in Linu=
x
> > (RH 7.2, kernel 2.4.7-10).  We have some electronic locks that are
> > controlled by a PC.  The locks are connected by a RS485 twisted pai=
r
> > (multidrop) and this line terminates in a 485-232 converter box whi=
ch
> > is connected via the serial line to a PC.  The lock vendor has supp=
lied
> > a Windows software to program the locks which works fine on this PC=
=2E
> > He has also given me the protocol that is followed between the PCs =
and
> > the locks.  I am trying to write my own Linux based software for
> > programming the locks.
> >
> > The problem is that when the vendor software sends a command to a l=
ock
> > it replies obediently but when my program writes exactly the same
sequence
> > of bytes to the serial line, I don't get a response (the protocol
> > says that the lock will not respond unless it gets a valid command)=
=2E
> > I know the locks use 9600 baud, 8 bits, no parity, 1 stop bit and I
> > am using the same.  I also tried with and without hardware flow con=
trol
> > (RTS/CTS) but no luck.  I know that the command I send is right sin=
ce
> > I used another PC to listen to what the vendor software writes on t=
he
> > serial line and it matches the protocol description that I have.
> >
> > Incidentally I opened up the 232-485 converter box and saw that it
> > uses only the TX, RX, SG, RTS and CTS lines on the RS232 side.  So
> > it cannot be a matter of DTR or some other signal.
> >
>
> I had a similar problem a few days ago.
> Old software worked, new one did not.
> So I also used a third PC to look what the others talk.
> I noticed the same as you.
>
> Solution was that RTS had to be set active.
>
>
> > Please help.
> >
> > Deepak Gupta
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-ser=
ial"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>
>
> Gerald Emig
>
> --
> EMIG Software		Tel. 06858-6197, Mobil: 0163-4751706
> Engelstr. 17		Fax. 0721-151-348672
> 66564 Ottweiler-F=FCrth	http://sites.inka.de/heisch
> Germany			e-mail: gme@heisch.inka.de
>
>
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
