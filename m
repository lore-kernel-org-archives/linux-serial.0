From: "Albert Cervera Areny" <informatic@sedifa.com>
Subject: Re: Connect with various serial devices
Date: Thu, 11 Dec 2003 14:08:44 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <32779.192.168.192.123.1071148124.squirrel@www.clientes.sedifa.com>
References: <33348.192.168.192.123.1071088389.squirrel@www.clientes.sedifa.com>
    <20031210.203940.8.0.whitnl73@juno.com>
    <33369.192.168.192.123.1071130475.squirrel@www.clientes.sedifa.com>
    <20031211103352.G12637@microdata-pos.de>
    <32780.192.168.192.123.1071144774.squirrel@www.clientes.sedifa.com>
    <20031211132914.I12637@microdata-pos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 199.Red-80-26-113.pooles.rima-tde.net ([80.26.113.199]:32644
	"HELO localhost") by vger.kernel.org with SMTP id S264936AbTLKNIq
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Dec 2003 08:08:46 -0500
In-Reply-To: <20031211132914.I12637@microdata-pos.de>
List-Id: linux-serial@vger.kernel.org
To: Michael Westermann <mw@microdata-pos.de>
Cc: linux-serial@vger.kernel.org


> Hello,
> On Thu, Dec 11, 2003 at 01:12:54PM +0100, Albert Cervera Areny wrote:
>> Thanks for your suggestion, in fact now we can receive data from the
>> note
>> dispenser and see the 'Ok' response. We keep on beeing unable to use=
 the
>> other devices though. It seems that for some strange (to us) reason,
>> devices are not receiving data correctly (as they would do the
>> appropiate
>> thing even if we didn't receive any response). Do you have any ideas=
 on
>> why the sent data shouldn't be received correctly by the device? I'v=
e
>> looked at the speed, parity, CS and Bstop parameters but they are ri=
ght.
>> Could there be any other reason for that strange behaviour in some o=
f
>> the
>> devices?
> I think the Card-Reader need 9600/8bit/None Parity and CRTSCTS

According to the Card-Reader documentation, the parameters are: 8 bit, =
1
bit stop, even parity ant the speed is automaticalli recognized, and I'=
ve
tried 9600 (and others too). Trying with the CRTSCTS doesn't work eithe=
r.

Many thanks for your help.

PS: ioctl(TIOCOUTQ) returns 0 in bytes; So it seems everything is sent,
isn't it?

>
> t.c_cflag 		=3D baud|parity|bits|stop ;
> t.c_cflag 		|=3D CRTSCTS;
>
> Use tcdrain with caution, tcdrain blocks forever without a device !
> better use in a timed loop;
>
> ioctl(fd, TIOCOUTQ, &bytes)  bytes =3D bytes in outqueue
>
> Michael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


Albert Cervera Areny
Dept. Inform=E0tica Sedifa, S.L.

Av. Can Bordoll, 149
08202 - Sabadell (Barcelona)
Tel. 93 715 51 11
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
