From: Gerald Emig <gme@emig-software.de>
Subject: Re: Connect with various serial devices
Date: Thu, 11 Dec 2003 15:47:21 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20031211154721.40e81695.gme@emig-software.de>
References: <33348.192.168.192.123.1071088389.squirrel@www.clientes.sedifa.com>
	<20031210.203940.8.0.whitnl73@juno.com>
	<33369.192.168.192.123.1071130475.squirrel@www.clientes.sedifa.com>
	<20031211103352.G12637@microdata-pos.de>
	<32780.192.168.192.123.1071144774.squirrel@www.clientes.sedifa.com>
	<20031211132914.I12637@microdata-pos.de>
	<32779.192.168.192.123.1071148124.squirrel@www.clientes.sedifa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.184]:65535 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264971AbTLKOrd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Dec 2003 09:47:33 -0500
In-Reply-To: <32779.192.168.192.123.1071148124.squirrel@www.clientes.sedifa.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Albert Cervera Areny <informatic@sedifa.com>


Hi Albert,

Perhaps you should check your cabling first (or once again). Is it wire=
d
according to the card reader's docu ? Is it short enough ? Are you even
working in industial environment ?=20

Automatic baudrate detection is rather fool. It can easily hang if
you send the wrong character in the phase of "detection".
BTW: many modems use this detection, but they are always looking for 'A=
'
or 'a'...

You should try to find out what the reader's default baudrate is, or
which character it expects first.

Also try whether the Win-Software that came with the reader works.



Best regards,

Gerald Emig


On Thu, 11 Dec 2003 14:08:44 +0100 (CET)
"Albert Cervera Areny" <informatic@sedifa.com> wrote:

>=20
> > Hello,
> > On Thu, Dec 11, 2003 at 01:12:54PM +0100, Albert Cervera Areny
> > wrote:
> >> Thanks for your suggestion, in fact now we can receive data from
> >the> note
> >> dispenser and see the 'Ok' response. We keep on beeing unable to
> >use the> other devices though. It seems that for some strange (to us=
)
> >reason,> devices are not receiving data correctly (as they would do
> >the> appropiate
> >> thing even if we didn't receive any response). Do you have any
> >ideas on> why the sent data shouldn't be received correctly by the
> >device? I've> looked at the speed, parity, CS and Bstop parameters
> >but they are right.> Could there be any other reason for that strang=
e
> >behaviour in some of> the
> >> devices?
> > I think the Card-Reader need 9600/8bit/None Parity and CRTSCTS
>=20
> According to the Card-Reader documentation, the parameters are: 8 bit=
,
> 1 bit stop, even parity ant the speed is automaticalli recognized, an=
d
> I've tried 9600 (and others too). Trying with the CRTSCTS doesn't wor=
k
> either.
>=20
> Many thanks for your help.
>=20
> PS: ioctl(TIOCOUTQ) returns 0 in bytes; So it seems everything is
> sent, isn't it?
>=20
> >
> > t.c_cflag 		=3D baud|parity|bits|stop ;
> > t.c_cflag 		|=3D CRTSCTS;
> >
> > Use tcdrain with caution, tcdrain blocks forever without a device !
> > better use in a timed loop;
> >
> > ioctl(fd, TIOCOUTQ, &bytes)  bytes =3D bytes in outqueue
> >
> > Michael
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-serial" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
>=20
>=20
> Albert Cervera Areny
> Dept. Inform=E0tica Sedifa, S.L.
>=20
> Av. Can Bordoll, 149
> 08202 - Sabadell (Barcelona)
> Tel. 93 715 51 11
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-serial" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



Gerald Emig

--
EMIG Software, Engelstr. 17, D-66564 Ottweiler, Germany
Tel.+49(0)6858-699567, Fax.699568, gme@emig-software.de
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
