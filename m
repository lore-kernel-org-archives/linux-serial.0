From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 4/4 v2] ARM: mach-shmobile: add SCIFA and SCIFB DMA slave
 definitions for sh7372
Date: Tue, 1 Jun 2010 09:30:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1006010928130.7762@axis700.grange>
References: <Pine.LNX.4.64.1005231820190.3571@axis700.grange>
 <Pine.LNX.4.64.1005231836090.3571@axis700.grange> <20100531045142.GG20358@linux-sh.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:28145 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753430Ab0FAH35 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 1 Jun 2010 03:29:57 -0400
In-Reply-To: <20100531045142.GG20358@linux-sh.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-serial@vger.kernel.org

On Mon, 31 May 2010, Paul Mundt wrote:

> On Sun, May 23, 2010 at 06:39:24PM +0200, Guennadi Liakhovetski wrote:
> > SH7372 can use DMA with the SCI serial driver. Add required slave IDs and slave
> > descriptors.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > 
> > v1 -> v2:
> > 
> > No need to move DMA platform devices to the top, they are placed correctly 
> > by the new version of the
> > 
> > [PATCH 9/9 v2] ARM: mach-shmobile: add DMA support to sh7372, enable DMA for SDHI
> > 
> > patch
> > 
> >  arch/arm/mach-shmobile/include/mach/sh7372.h |   14 +++++
> >  arch/arm/mach-shmobile/setup-sh7372.c        |   70 ++++++++++++++++++++++++++
> >  2 files changed, 84 insertions(+), 0 deletions(-)
> > 
> This is applied now, too.
> 
> You may want to double check to make sure all of the correct versions
> have been applied and that you have nothing more outstanding.

Apart from a wrong version of the "add DMA support to sh7372, enable DMA 
for SDHI" patch, which doesn't change much, the rest looks good to me. 
Thanks!

Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
