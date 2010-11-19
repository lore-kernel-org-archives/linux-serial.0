From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: How to disable the transmit FIFO?
Date: Thu, 18 Nov 2010 22:31:55 -0600
Message-ID: <20101119043155.GA17198@grante>
References: <E1PJ0al-0000hs-Kb@palantir.moria.de>
 <20101118164122.GB2855@kroah.com>
 <E1PJAfx-0000gW-8e@palantir.moria.de>
 <ic40v4$ghm$1@dough.gmane.org>
 <20101119012523.GT3290@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62299 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab0KSEcE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Nov 2010 23:32:04 -0500
Received: by iwn35 with SMTP id 35so4333843iwn.19
        for <linux-serial@vger.kernel.org>; Thu, 18 Nov 2010 20:32:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101119012523.GT3290@thunk.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ted Ts'o <tytso@mit.edu>
Cc: Michael Haardt <michael@moria.de>, linux-serial@vger.kernel.org

On Thu, Nov 18, 2010 at 08:25:23PM -0500, Ted Ts'o wrote:
> On Thu, Nov 18, 2010 at 08:05:56PM +0000, Grant Edwards wrote:
> > On 2010-11-18, Michael Haardt <michael@moria.de> wrote:
> > >> > I miss a way to disable the transmit FIFO.
> > >>
> > >> From userspace or from within a kernel driver?
> > >
> > > From userspace.
> > 
> > $ man setserial
> 
> Specifically, if you use setserial to configure a serial port so that
> its UART is a 16450, it will force the transmit FIFO to be unused.

You can also leave the UART type as 16[56]50 and set the tx fifo
threshold to 1.  That way you're only taking half the hit on interrupt
overhead.

-- 
Grant
