From: "Albert Cervera Areny" <informatic@sedifa.com>
Subject: Re: Connect with various serial devices
Date: Thu, 11 Dec 2003 13:12:54 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <32780.192.168.192.123.1071144774.squirrel@www.clientes.sedifa.com>
References: <33348.192.168.192.123.1071088389.squirrel@www.clientes.sedifa.com>
    <20031210.203940.8.0.whitnl73@juno.com>
    <33369.192.168.192.123.1071130475.squirrel@www.clientes.sedifa.com>
    <20031211103352.G12637@microdata-pos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 199.Red-80-26-113.pooles.rima-tde.net ([80.26.113.199]:61059
	"HELO localhost") by vger.kernel.org with SMTP id S264903AbTLKMM4
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Dec 2003 07:12:56 -0500
In-Reply-To: <20031211103352.G12637@microdata-pos.de>
List-Id: linux-serial@vger.kernel.org
To: Michael Westermann <mw@microdata-pos.de>
Cc: linux-serial@vger.kernel.org

Hi!
Thanks for your suggestion, in fact now we can receive data from the no=
te
dispenser and see the 'Ok' response. We keep on beeing unable to use th=
e
other devices though. It seems that for some strange (to us) reason,
devices are not receiving data correctly (as they would do the appropia=
te
thing even if we didn't receive any response). Do you have any ideas on
why the sent data shouldn't be received correctly by the device? I've
looked at the speed, parity, CS and Bstop parameters but they are right=
=2E
Could there be any other reason for that strange behaviour in some of t=
he
devices?

> Hello,
>
> On Thu, Dec 11, 2003 at 09:14:35AM +0100, Albert Cervera Areny wrote:
>
>
>> Thanks for your suggestion, but it doesn't work either. If I set
>> O_NONBLOCK it doesn't block in the read statement but it never recei=
ves
>> anything. The problem must be that data isn't sent correctly either =
as
>> the
>> device would do something if it received it correctly (though I migh=
t
>> not
>> receive a response).
> I think you you will read raw from the device, please set
>
> 	t.c_iflag		=3D 0;
> 	t.c_oflag		=3D 0;
> 	t.c_cflag 		=3D B4800 | CS7 | CLOCAL | CREAD | PARENB;
> 	t.c_cc[VMIN]		=3D count;
> 	t.c_cc[VTIME]		=3D time;
> 	t.c_cc[VSTOP]		=3D 0;
> 	t.c_cc[VSTART]		=3D 0;
> 	t.c_lflag		=3D 0;
> 	t.c_oflag		=3D 0;
>
> VMIN and VTIM are most probably described in a serial HOWTO
>
>> Any other ideas?
>
> Particulary, I think ICANON is wrong in this context.
> Use select(2)  ;-)
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
