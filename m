From: Nikolay Datchev <nik@varna.net>
Subject: Re: serial port forcing
Date: Mon, 1 Dec 2003 15:24:03 +0200 (EET)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0312011505090.13366-100000@ns.varna.net>
References: <20031201125030.GA16507@lug-owl.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ns.varna.net ([195.24.57.1]:22162 "EHLO ns.varna.net")
	by vger.kernel.org with ESMTP id S262868AbTLANYJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Dec 2003 08:24:09 -0500
Received: from localhost (nik@localhost)
	by ns.varna.net (8.12.10/8.12.9) with ESMTP id hB1DO3tB001409
	for <linux-serial@vger.kernel.org>; Mon, 1 Dec 2003 15:24:03 +0200
In-Reply-To: <20031201125030.GA16507@lug-owl.de>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Seems that i'll help myself. There is big difference between filesystem
character devices for ttyS-es and proc (driver) slots. You can have lot=
 of
filesystem /dev entries for serial ports, but if you don't have enough
/proc/tty/driver/serial slots, you're stuck with the number of serial
ports, recognized by the serial driver at boot time.

After removing the check, pointed by my previous email, i have more tha=
n
enough slots in the driver (and in the /proc), just like in the older
kernels, and i'm able to force serial ports, even with parameters of
non-existent ones. I hope that some developper is reading this maillist
and will give me good solution, since just removing this check is too
'quick and dirty'. When i have enough time (this week), i'll try to mer=
ge
2.4.18 checks for PORT_UNKNOWN with newer kernel to get enough serial
driver slots.

-- Nikolay Datchev

On Mon, 1 Dec 2003, Jan-Benedict Glaw wrote:

> On Mon, 2003-12-01 14:02:33 +0200, Nikolay Datchev <nik@varna.net>
> wrote in message <Pine.LNX.4.33.0312011345470.1388-100000@ns.varna.ne=
t>:
> > The board is some taiwan made crap.
> >
> > When it is not recognized at all, why i got totally 6 ports, 4 reco=
gnized
> > + 1 onboard must be 5?
> >
> > And in the instruction manual of the board, in the Linux section, t=
here is
> > advice to force some unused ttyS with port and irq from lspci. That=
's
> > exaclty what i do, but i have not enough ttyS-es to reconfigure =3D=
]. At
>
> You don't have enough nodes? So, then simply create some new! "man
> mknod"
>
> > least one of 7 ports will be unusable in this situation.
>
> NO thanks for not sending requested output. Nobody can help, then...
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
