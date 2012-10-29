From: Guillaume Juan <guillaume.juan@sagemcom.com>
Subject: Re: [PATCH] n_gsm: prevent crash due to dereferencing NULL gsm->tty
Date: Mon, 29 Oct 2012 19:16:17 +0100
Message-ID: <29600_1351534580_508EC7F3_29600_2345_1_508EC7F1.9030102@sagemcom.com>
References: <26026_1351239109_508A45C4_26026_63_1_508A45C1.3010407@sagemcom.com> <20121029162947.6270b4da@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.smmp-rueil.gmessaging.net ([81.80.3.134]:48475 "EHLO
	smtp1.smmp-rueil.gmessaging.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932181Ab2J2SQW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 29 Oct 2012 14:16:22 -0400
In-Reply-To: <20121029162947.6270b4da@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Le 29/10/2012 17:29, Alan Cox a =E9crit :

>=20
> More important is fixing the bug completely. I agree there is a bug I
> don't think your fix is sufficient however.
>

It may not fix all cases but I think it improves things both from a
practical and theoretical point of view.
In particular the part in gsmtty_hangup: the crash was systematic if th=
e
user space released the virtual ttys fds only after the N_GSM line
discipline was removed (with ioctl).
I explained all the crashes I had, and did not reproduced crashes after
my patch. Note that I don't have use-cases where the DCE itself opens
some DLCIs, which certainly can cause a lot more trouble.


>=20
> You no longer set dlci->dead before doing the dlci release

Yes I do, see line 2036:
+	if (dlci)
+		dlci->dead =3D 1;
I do it only for DLCI#0 but this is the same as what the previous code
was doing (I don't understand why but I thought that was another topic)=
=2E
I was not sure that this dlci->dead was really efficient, but I decided
to keep it because addressing the relevance of dlci->dead was not the
purpose of my patch.

> Also moving the gsm_dlci_release seems to have no value at all becaus=
e
> there is no locking in the code concerned so viewed from any other th=
read
> you've changed nothing but timings. Yes its probably way harder to hi=
t.
>=20

I don't really see your point, or I think you may be speaking of a
different matter. Once gsm_dlci_release has done its job, the T2 timer
should no longer be rearmed by anything the user-space could do, becaus=
e
the tty will be hung up (tty_vhangup is synchronous isn't it ?). At
least tty_port_close_start would not call tty_port_lower_dtr_rts
anymore. So then the comment /* Now we are sure T2 has stopped */ after
del_timer_sync will be true.
Do you see any other paths that may lead to relaunch the T2 timer
afterwards? Don't you agree that gsmtty_release should be done before
del_timer_sync?

> I can see two ways of tackling it both of which basically come down t=
o
> the same thing. In gsmld_detach_gsm after the gsm_cleanup_mux we need=
 to
>=20
> - be sure the thing cannot re-open

If you talk about reopening from the other side, I agree with you that
dlci->dead does not seem to protect enough. However I can read in the
description of gsmld_close that "the function will not be called while
other ldisc methods are in progress". If this is true, the concurrence
of gsmld_receive_buf should not be possible ?

> - wait until all the DLCIs are dead

I am not sure what you mean by this:
- gsm_cleanup_mux already waits for the answer to CLD command and to th=
e
closure of DLCI#0. As I reported previously, it will never see the
answers coming because of the line-discipline life-cycle design, but
this is yet another topic.
- or maybe you mean wait until we are sure there are no longer
references to the virtual ttys. This seems to me impossible to achieve
because the user-space closes them at its own pace.

> then do the tty_kref_put and gsm->tty =3D NULL
>=20
> Thoughts ?
>=20
> Alan


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
