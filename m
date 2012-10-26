From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] n_gsm: prevent crash due to dereferencing NULL gsm->tty
Date: Fri, 26 Oct 2012 09:47:52 -0700
Message-ID: <20121026164752.GA26968@kroah.com>
References: <26026_1351239109_508A45C4_26026_63_1_508A45C1.3010407@sagemcom.com>
 <20121026152052.GA15840@kroah.com>
 <3252_1351269266_508ABB91_3252_975_1_508ABB8F.5040906@sagemcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3252_1351269266_508ABB91_3252_975_1_508ABB8F.5040906@sagemcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guillaume Juan <guillaume.juan@sagemcom.com>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 26, 2012 at 06:34:23PM +0200, Guillaume Juan wrote:
> Le 26/10/2012 17:20, Greg Kroah-Hartman a =E9crit :
>=20
> > On Fri, Oct 26, 2012 at 10:11:45AM +0200, Guillaume Juan wrote:
> >> From: Guillaume Juan <guillaume.juan@sagemcom.com>
> >>
> >> If gsm->tty happens to be NULL in gsmld_output, avoid crashing the=
 kernel (the crash is replaced by a warning dump).
> >=20
> > How can ->tty be NULL here?
> >=20
>=20
> I had some crashes and identified 2 causes: this is what I tried to e=
xplain in the 2nd part of the changelog ("Prevent at earlier level such=
 situation: [...]"). Basically it is because the T1 and T2 timers may b=
e rearmed while gsm_cleanup_mux executes (T1 is rearmed by gsmtty_hangu=
p called by gsm_cleanup_mux itself via gsm_dlci_release, whereas T2 may=
 be rearmed by a concurrent call to gsmtty_close).
>=20
> My patch is intended to remove theses causes, but I thought safer to =
avoid the crash in gsmld_output if ever there are other causes remainin=
g. Do you mean I should let the crash happen for these unproven cases?

If you leave it, and it happens, then you know you didn't really fix th=
e
real problem :)

> >> " This e-mail and any attached documents may contain confidential =
or
> >> proprietary information. If you are not the intended recipient, yo=
u are
> >> notified that any dissemination, copying of this e-mail and any at=
tachments
> >> thereto or use of their contents by any means whatsoever is strict=
ly
> >> prohibited. If you have received this e-mail in error, please advi=
se the
> >> sender immediately and delete this e-mail and all attached documen=
ts
> >> from your computer system."
> >> #
> >=20
> > Because of that footer, I am not allowed to accept this patch at al=
l.
> > Please remove it and resend.
>=20
> Argh. I'm afraid I don't know how to remove it, since it seems added =
automatically by my company mail server. I probably will have to strugg=
le with the admins. But since you ARE the "intended recipient" and the =
content is NOT "confidential or proprietary", does it really forbid you=
 to use the patch?

Yes it does, it goes against the "Signed-off-by:" line in the patch, an=
d
because of that, I am not allowed to accept it.  If you wish to do
kernel development, either get your email admins to fix it, or use an
external email account (sadly the only solution for a lot of people.)
If you use an external account, be sure you properly set the "From:"
line in the patch to your properly account, see the file,
Documentation/SubmittingPatches for details.

thanks,

greg k-h
