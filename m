From: Guillaume JUAN <guillaume.juan@sagemcom.com>
Subject: =?ISO-8859-1?Q?R=E9f=2E_=3A_Re=3A_n=5Fgsm_issues?=
Date: Thu, 2 Aug 2012 14:37:40 +0200
Message-ID: <18908_1343911065_501A7498_18908_1370_1_OFCB0326AC.108F61B0-ONC1257A4E.002F0361-C1257A4E.00455DD9@sagemcom.com>
References: <440_1343835403_50194D0B_440_1588_1_OF108ABE84.7A08D19F-ONC1257A4D.00556998-C1257A4D.0055C11D@sagemcom.com> <20120801222322.345d0bc2@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp2.smmp-rueil.gmessaging.net ([81.80.3.135]:44346 "EHLO
	smtp2.smmp-rueil.gmessaging.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753683Ab2HBMhs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 2 Aug 2012 08:37:48 -0400
In-Reply-To: <20120801222322.345d0bc2@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

Hi Alan,

Thanks for your quick reply.

> > - The CLD command encoding is not strictly compliant with 3GPP 27.0=
10
> > The TLV built does not have any L byte, whereas it should have one
> > indicating a zero length for the value field.
> > The modem I use accept this variant but some may not.
>
> What kernel verison is this ?

I'm using a 2.6.35 kernel, but I have upgraded specifically n_gsm.c to =
the
latest version I found in
      git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
('git describe' tells me it is v3.5-8833-g2d53492)
I also checked that I had all the n_gsm changes from
      git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
Is there anything newer ?

About CLD command I referred to the following line of code:
      gc =3D gsm_control_send(gsm, CMD_CLD, NULL, 0);
Passing NULL makes the function not put any L byte in the TLV.
The 3GPP 27.007 chapter 5.4.6.1 states
"
All [control] messages sent between the multiplexers conform to the
following type, length, value format:
      Type  Length      Value 1     Value2      =E2=80=A6     Value n
Each box in the diagram represents a field of minimum size one octet.
"
=46rom which I understand length should be present even if 0.
Of course the receiver can still infer the length from the Type or the
wrapping UIH framing but this is somewhat a layering violation.
So the source code could be replaced by:
      u8 len =3D 0 << 1 | EA;
      gc =3D gsm_control_send(gsm, CMD_CLD, &len, 1);
This is how gsmMuxd formats CLD command.


> > gsmtty_close does not wait for event DLCI_CLOSED after
> > calling gsm_dlci_begin_close.
>
> That one is intentional.

Oh. I thought it was safer for close to be synchronous.
Is it intentional in gsmtty_hangup too ?
I am not very familiar with the concept of tty hangup but I believed it
imposed to cease I/O on the tty after the function returns.
Moreover the call to tty_vhangup() from gsm_cleanup_mux() will lead to =
arm
the T1 timer and if left asynchronous, to try to send stuff after
gsmld_detach_gsm has set gsm->tty NULL.


> Probably we need to split 'ldisc close' and 'ending a mux'
> (eg have an ioctl for 'mux shutdown')

That would sure give better control to user-space on when the mux is
closed, but on the other hand:
- that would add some new states to manage, where the ld is attached bu=
t
not muxing
- I liked the idea to (try to) close the mux when all files descriptor =
on
the physical tty are closed.
When eg the user space application is killed and has not the opportunit=
y to
call the ioctl, it would be cleaner if the modem was not left in mux mo=
de
(all the more that the tty layer force reset to N_TTY line discipline a=
nd
thus you have no clue left that the peer is still muxing)

I was half-hoping you would identify other line discipline callbacks th=
at
could be useful for this purpose, or ways for the ld to tell the tty la=
yer
it needs to access the tty at closing time.
Just for a try, on my side I
- commented the code disabling reception in tty_set_ldisc
- moved the 'mux shutdown' code in gsmld_flush_buffer and in uart_close=
 I
moved the call to tty_ldisc_flush() a few lines upwards, before
uart_shutdown(), right after 'tty->closing =3D 1'

It worked fined for the use I make of n_gsm, but of course this is not
clean as
- I don't know the impact it could have on other line disciplines
- I guess I am diverting callback tty_ldisc_ops.flush_buffer from its
intended use
BTW what is the meaning of "flush" here ? Is it "push the last bytes to=
 the
tty" or "discard the bytes you have in store" ?
If the latter meaning, isn't there a lack for a callback that would giv=
e a
last opportunity for the line discipline to send bytes ? Is n_gsm the o=
nly
to have this need ?


BRs
Guillaume
#
" Ce courriel et les documents qui lui sont joints peuvent contenir des
informations confidentielles ou ayant un caract=E8re priv=E9. S'ils ne =
vous sont
pas destin=E9s, nous vous signalons qu'il est strictement interdit de l=
es
divulguer, de les reproduire ou d'en utiliser de quelque mani=E8re que =
ce
soit le contenu. Si ce message vous a =E9t=E9 transmis par erreur, merc=
i d'en
informer l'exp=E9diteur et de supprimer imm=E9diatement de votre syst=E8=
me
informatique ce courriel ainsi que tous les documents qui y sont attach=
=E9s."


                               ******

" This e-mail and any attached documents may contain confidential or
proprietary information. If you are not the intended recipient, you are
notified that any dissemination, copying of this e-mail and any attachm=
ents
thereto or use of their contents by any means whatsoever is strictly
prohibited. If you have received this e-mail in error, please advise th=
e
sender immediately and delete this e-mail and all attached documents
from your computer system."
#

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
