From: Nikolay Datchev <nik@varna.net>
Subject: Re: serial port forcing
Date: Mon, 1 Dec 2003 14:02:33 +0200 (EET)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0312011345470.1388-100000@ns.varna.net>
References: <20031201112239.GD1037@lug-owl.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ns.varna.net ([195.24.57.1]:36252 "EHLO ns.varna.net")
	by vger.kernel.org with ESMTP id S263014AbTLAMCn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Dec 2003 07:02:43 -0500
In-Reply-To: <20031201112239.GD1037@lug-owl.de>
List-Id: linux-serial@vger.kernel.org
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-serial@vger.kernel.org

The board is some taiwan made crap.

When it is not recognized at all, why i got totally 6 ports, 4 recogniz=
ed
+ 1 onboard must be 5?

And in the instruction manual of the board, in the Linux section, there=
 is
advice to force some unused ttyS with port and irq from lspci. That's
exaclty what i do, but i have not enough ttyS-es to reconfigure =3D]. A=
t
least one of 7 ports will be unusable in this situation.

I looked in the drivers/char/serial.c (kernel 2.4.22), and in function
line_info() (near line 3268) there is a check:

if (state->type =3D=3D PORT_UNKNOWN) {
	return 0;
}

After i remove this check, in the /proc/tty/driver/serial i got 64 port=
s,
just like in 2.4.18, but on test machine. Since the 7-port machine is i=
n
heavy production, i cannot try to change the kernel with this check
removed and force all the ports i need. I am not sure that such kind of
forcing will be successful.

-- Nikolay Datchev

On Mon, 1 Dec 2003, Jan-Benedict Glaw wrote:

> On Mon, 2003-12-01 13:18:44 +0200, Nikolay Datchev <nik@varna.net>
> wrote in message <Pine.LNX.4.33.0312011257140.11314-100000@ns.varna.n=
et>:
> > Hello list,
> >
> > Here is my problem:
> >
> > I have one linux machine with one 4xserial PCI board, another one 2=
xserial
> > PCI board, and one onboard serial port, total 7 ports. After boot-u=
p, only
>
> This all sounds like your 2-port serial PCI board isn't recognized. W=
hat
> kind of board is this *exactly*? Brand name and "lspci -vv" output co=
uld
> help...
>
> MfG, JBG
>
> --
>    Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
>    "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gege=
n Krieg
>     fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   =
im Irak!
>    ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DR=
M | TCPA));
>

-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
