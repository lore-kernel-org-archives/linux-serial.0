From: Joe Millenbach <jmillenbach@gmail.com>
Subject: Re: [PATCHv2] tty: Added a CONFIG_TTY option to allow removal of TTY
Date: Mon, 3 Sep 2012 14:24:21 -0700
Message-ID: <CADwDc1DXb3o0i-7NGZKFGwKU6Ybj703OHhUWgh0he9TcCFpW4g@mail.gmail.com>
References: <1346633072-29361-1-git-send-email-jmillenbach@gmail.com>
	<50451E0E.1050605@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37789 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578Ab2ICVYV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Sep 2012 17:24:21 -0400
In-Reply-To: <50451E0E.1050605@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "jirisl >> Jiri Slaby" <jirislaby@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>, team-fjord@googlegroups.com

On Mon, Sep 3, 2012 at 2:15 PM, Jiri Slaby <jslaby@suse.cz> wrote:
>
> On 09/03/2012 02:44 AM, Joe Millenbach wrote:
> > The option allows you to remove TTY and compile without errors. This
> > saves space on systems that won't support TTY interfaces anyway.
> > bloat-o-meter output is below.
> ...
> > --- a/drivers/tty/Kconfig
> > +++ b/drivers/tty/Kconfig
> > @@ -1,3 +1,14 @@
> > +config TTY
> > +     bool "Enable TTY" if EXPERT
> > +     default y
> > +     ---help---
> > +       Allows you to remove TTY support which can save space, and
> > +       blocks features that require TTY from inclusion in the kernel.
> > +       TTY is required for any text terminals or serial port
> > +       communication. Most users should leave this enabled.
> > +
> > +if TTY
> > +
> >  config VT
> >       bool "Virtual terminal" if EXPERT
> >       depends on !S390 && !UML
> > @@ -355,6 +366,8 @@ config TRACE_SINK
> >         If you select this option, you need to select
> >         "Trace data router for MIPI P1149.7 cJTAG standard".
> >
> > +endif # TTY
> > +
> >  config PPC_EPAPR_HV_BYTECHAN
> >       tristate "ePAPR hypervisor byte channel driver"
> >       depends on PPC
>
> Hmm, I wonder why do not you include EHV in the depends-on-tty list?
>
> thanks,
> --
> js
> suse labs

I do not have a Power PC system to test on, so during my testing I did
not notice that option would need TTY also.  Thanks for pointing that
out.  Before I spin a new patch is there anything else I should add?
I do not know of a way for me to easily test all the different CPU
specific configurations on my x86 based machines.

Joe
