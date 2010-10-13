From: Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: [PATCH] Serial: BUGFIX: uart_resume_port has an omitted
 condition.
Date: Wed, 13 Oct 2010 13:26:45 +0200
Message-ID: <1286969205.6082.700.camel@hammer.site>
References: <1286949486-2446-1-git-send-email-myungjoo.ham@samsung.com>
	 <20101013062605.GB4393@suse.de>
	 <AANLkTimc-ETu4zrny=kmVRq8jnh2CDiVSqE-EXde4ioS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:38912 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753821Ab0JML0t (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Oct 2010 07:26:49 -0400
In-Reply-To: <AANLkTimc-ETu4zrny=kmVRq8jnh2CDiVSqE-EXde4ioS@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, Alan Cox <alan@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Andr Goddard Rosa <andre.goddard@gmail.com>, Jason Wang <jason77.wang@gmail.com>, linux-serial@vger.kernel.org

On Wed, 13 Oct 2010 15:38:13 +0900, MyungJoo Ham wrote:
> On Wed, Oct 13, 2010 at 3:26 PM, Greg KH <gregkh@suse.de> wrote:
> > On Wed, Oct 13, 2010 at 02:58:06PM +0900, MyungJoo Ham wrote:

> > Is this a regression?  If so, from what working kernel?  Or has thi=
s
> > always been this way?
>=20
> I don't think this is a regression to the previous version. Logically=
,
> it's matching the console_stop()-console_start() pair.

This disparity appeared deliberately in 4547be78. If you need
no_console_suspend and the hardware lets the device in an undefined
state after resume (i. e. PXA270), you need to call subset of the
resume, even if the suspend counterpart was not called. Yes, I can
imagine that it may be a source of problems.

Did you try the latest patches from Jason Wang from linux-serial list?

> Such hang in serial and its mitigation is observed in 2.6.36 at
> arch/arm/mach-s5pv310 machines. In these machines, it hanged with
> console_suspend_enabled =3D=3D 0 every time.

It seems that support for no_console_suspend for all devices is becomin=
g
more complicated. I guess that a new driver calls (maybe "save_state"
and "resume_state") or support for no_console_suspend directly in
drivers may be useful.

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
