From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 00/10] serial: sh-sci fixes - console PM, SCIFB, SMP
 lockup, etc.
Date: Thu, 15 Nov 2012 18:04:34 -0800
Message-ID: <20121116020434.GA15188@kroah.com>
References: <509A0658.1010503@renesas.com>
 <509A0B4E.1030801@renesas.com>
 <20121116010107.GA6068@kroah.com>
 <50A59B9B.2010501@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:49033 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab2KPCEw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Nov 2012 21:04:52 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so1507594pad.19
        for <linux-serial@vger.kernel.org>; Thu, 15 Nov 2012 18:04:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50A59B9B.2010501@renesas.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Cc: lethal@linux-sh.org, magnus.damm@gmail.com, rjw@sisk.pl, alan@linux.intel.com, takashi.yoshii.zj@renesas.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org

On Fri, Nov 16, 2012 at 10:49:15AM +0900, Shinya Kuribayashi wrote:
> Hi Greg,
> 
> On 11/16/2012 10:01 AM, Greg KH wrote:> On Wed, Nov 07, 2012 at 04:18:38PM +0900, Shinya Kuribayashi wrote:
> >> On 11/7/2012 3:57 PM, Shinya Kuribayashi wrote:
> >>> Hi Paul and serial forks,
> >> [...]
> >>> Takashi YOSHII (4):
> >>>       serial: sh-sci: fix condition test to set SCBRR
> >>>       serial: sh-sci: support lower baud rate
> >>>       serial: sh-sci: mask SCTFDR/RFDR according to fifosize
> >>>       serial: sh-sci: fix common SCIFB regmap definition
> >>>
> >>> Teppei Kamijou (1):
> >>>       serial: sh-sci: console runtime PM support (revisit)
> >>>
> >>>  drivers/tty/serial/sh-sci.c | 140 ++++++++++++++++++--------------------------
> >>>  1 file changed, 56 insertions(+), 84 deletions(-)
> >>
> >> Oops, I forgot to append proper From: author lines in five commits
> >> (patch 04/10 to 09/10).  Didn't mean to supersede your authoship.
> >>
> >> I'd respin the patchset later, waiting for some feedback.
> > 
> > Can you please resend this with this fixed up if you want to get this
> > into 3.8?
> 
> Thanks for your kind reminder.  Here's v2, providing From: authorship
> lines in five patches (04 to 08).  No logical change in the patches.

All now applied, thanks.

greg k-h
