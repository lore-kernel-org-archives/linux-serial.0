From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] Enable legacy support for serial ports when SERIAL_8250_PNP is disabled
Date: Wed, 11 Jul 2007 15:07:25 -0600
Message-ID: <200707111507.25412.bjorn.helgaas@hp.com>
References: <20070707233300.GA3267@dreamland.darkstar.lan> <200707091230.01556.bjorn.helgaas@hp.com> <68676e00707111240v28263cc7i13c033c8be1339b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:49551 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159AbXGKVPS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 11 Jul 2007 17:15:18 -0400
In-Reply-To: <68676e00707111240v28263cc7i13c033c8be1339b9@mail.gmail.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Luca <kronos.it@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 11 July 2007 01:40:07 pm Luca wrote:
> On 7/9/07, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > On Monday 09 July 2007 11:30:59 am Luca wrote:
> > > On 7/9/07, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > > > If you turn off
> > > > PNP completely, you will have "pnp_platform_devices == 0", and the
> > > > existing code will do what you need.
> > >
> > > Well for me it's a non-issue, I'm able to "work-around" it in many
> > > ways. My point is that a configuration that used to work and is still
> > > valid suddenly doesn't work anymore.
> >
> > You're right about that, and it is a legitimate issue.  But given the
> > fact that (PNP && !SERIAL_8250_PNP) should be relatively unusual, my
> > opinion is that it's not worth extra ifdefs in legacy_serial.c.
> >
> > If you have to use any workarounds like "legacy_serial.force", I think
> > that's a bug, and I'll fix it.
> 
> Ok, I double-checked: the serial port is usable during boot with PNP
> enabled, so no problem with dropping my patch.

Thanks a lot for checking!

Bjorn
