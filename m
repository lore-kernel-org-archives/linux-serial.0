From: Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: [PATCH RESEND 0/2] two serial_core suspend/resume fixes
Date: Thu, 26 Aug 2010 12:55:39 +0200
Message-ID: <1282820139.7900.178.camel@hammer.site>
References: <1282374882-6651-1-git-send-email-jason77.wang@gmail.com>
	 <1282593975.3526.9.camel@utx.lan>
	 <AANLkTikZgAMvODoFB9O9Mrb98f_xMatQfkb+2dgcrGJn@mail.gmail.com>
	 <1282640491.4910.35.camel@utx.lan>  <4C748E0E.8040308@windriver.com>
	 <1282733489.5085.35.camel@utx.lan>  <4C76278F.4090000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45329 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092Ab0HZKzm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Aug 2010 06:55:42 -0400
In-Reply-To: <4C76278F.4090000@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jason Wang <jason77.wang@gmail.com>
Cc: gregkh@suse.de, alan@linux.intel.com, arnd@arndb.de, linux-serial@vger.kernel.org

Jason Wang wrote:

> > suspend:
> > - save hardware state
> >  =20
> How about move this part to driver specific level(i.e. pxa.c)
> > - but not physically stop it

Yes, I was thinking about it as well. It would be far the cleanest
solution that would prevent all ugly hacks in serial_core.c.

In addition to the standard suspend and resume there could be save_stat=
e
(and keep running) and resume_state (from save_state mode).

> Maybe stop it can save power on some platforms, moreover,
> it can prevent some unreadable chars

No, no_console_suspend is a special mode, required for suspend debuggin=
g
and not intended for production kernels. If you are debugging a kernel
that does not resume at all, you have no other way to collect debug
messages than keeping console in running state as long as possible.

This behavior of no_console_suspend should be kept even at cost of
higher power consumption during suspend in this mode, otherwise some
suspend failures may become undebugable.

I see just another "by design" problem: no_console_suspend keeps consol=
e
in running state. After the resume, kernel still thinks, that the
console is not suspended and it is possible to write to the console.
That is why early resume messages may be lost.

--=20
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarsk=E1 1060/12           tel: +420 284 028 966, +49 911 740538747
190 00 Praha 9                                  fax: +420 284 028 951
Czech Republic                                    http://www.suse.cz/

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
