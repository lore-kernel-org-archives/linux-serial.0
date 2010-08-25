From: Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: [PATCH RESEND 0/2] two serial_core suspend/resume fixes
Date: Wed, 25 Aug 2010 12:51:29 +0200
Message-ID: <1282733489.5085.35.camel@utx.lan>
References: <1282374882-6651-1-git-send-email-jason77.wang@gmail.com>
	 <1282593975.3526.9.camel@utx.lan>
	 <AANLkTikZgAMvODoFB9O9Mrb98f_xMatQfkb+2dgcrGJn@mail.gmail.com>
	 <1282640491.4910.35.camel@utx.lan>  <4C748E0E.8040308@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58762 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654Ab0HYKvd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Aug 2010 06:51:33 -0400
In-Reply-To: <4C748E0E.8040308@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: wanghui <Hui.Wang@windriver.com>
Cc: jason wang <jason77.wang@gmail.com>, gregkh@suse.de, alan@linux.intel.com, arnd@arndb.de, linux-serial@vger.kernel.org

wanghui wrote:  =20
> For this situation, i guess you use a single serial port both as a
> printk console and as a login tty.

Yes, I did exactly that.

>  If you use that serial port only
> as a printk console, and use another serial port or (keyboard + lcd)
> as login tty, you will see the the printk console serial port can't
> work after resume.

Well, I never tried this with my old patch, and I even forgot to think
about this situation. It complicates the suspend logic even more and I
understand that 4547be7 breaks it.

> as a result, in the uart_resume_port()
>     if (port->flags & ASYNC_SUSPENDED) {
>   ...
>     }
> will not be executed.
>=20
> In the resume process, the only serial driver relating sub-callings i=
s
> uport->ops->set_termios(), but the parameter passed in is not initial=
ized,
> we can imagine this serial port will not work anymore after this resu=
me.

Well, if you look at 4547be7 deleted chunk "/* no need to resume serial
console, it wasn't suspended */", then it may contain relevant code.
It was called with no_console_suspend before and returned. But "it
wasn't suspended" is not true: The hardware went to sleep and now is in
undefined state and this chunk failed to re-initialize it. That is why =
I
decided to never enter here and carefully pick parts of the whole resum=
e
process that need to be executed. I forgot to think about "just debug
console, not a tty".

> My 2rd patch is for this issue.
> > - with no_console_suspend: does not work both with and without your
> >   patches

> In this situation, the uart_suspend_port() will not call any serial d=
river
> relating sub-callings except ops->tx_empty().

And setting "uport->suspended =3D 1". It was my intention - the console
should stay alive as long as possible.

> In the resume process, if apply my 1st patch, the uart_resume_port()
> will not call any serial driver relating sub-callings just like the s=
uspend
> process does, i don't know why your serial can't work.

Me too, but the spitz hardware required setup, otherwise it remains in
undefined state after the resume. It worked in time of 4547be7, but not
now. Reviewing patches that affect serial_core, I don't see anything
obvious.

> If without my 1st patch, the uart_resume_port() will call=20
> uport->ops->set_termios(),
> but the parameter passed in is not initialized, moreover, it will cal=
l=20
> console_start(),
> this calling is not balance with suspend process because we don't cal=
l=20
> console_stop()
> in the suspend process.

Does it mean any problem? If I remember correctly, there were two lines
in suspend that stopped late pre-suspend console messages. I tried to
skip them, but still wanted to call their resume counterpart (without
them, the hardware was not re-initialized correctly). Maybe there is a
better way to do it.

> > So your patches surely don't mean a regression here.
> Not a 100% regression.

No regression at all on spitz and fix on your omap.

Well, thinking about correct implementation, we need:

suspend:
- save hardware state
- but not physically stop it
- tell kernel that the port is suspended
- but prevent postponing of late pre-suspend messages

resume:
- If the port is in any use (console, login or communication) then neve=
r
  skip the hardware resume
- tell kernel that the port is in fully working state

--=20
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarsk=E1 1060/12                            tel: +420 284 028 966
190 00 Praha 9                                fax: +420 284 028 951
Czech Republic                                http://www.suse.cz/

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
