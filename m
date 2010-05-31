From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 4/4 v2] ARM: mach-shmobile: add SCIFA and SCIFB DMA slave definitions for sh7372
Date: Mon, 31 May 2010 13:51:43 +0900
Message-ID: <20100531045142.GG20358@linux-sh.org>
References: <Pine.LNX.4.64.1005231820190.3571@axis700.grange> <Pine.LNX.4.64.1005231836090.3571@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:49557 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab0EaEwC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 31 May 2010 00:52:02 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1005231836090.3571@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-serial@vger.kernel.org

On Sun, May 23, 2010 at 06:39:24PM +0200, Guennadi Liakhovetski wrote:
> SH7372 can use DMA with the SCI serial driver. Add required slave IDs and slave
> descriptors.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> v1 -> v2:
> 
> No need to move DMA platform devices to the top, they are placed correctly 
> by the new version of the
> 
> [PATCH 9/9 v2] ARM: mach-shmobile: add DMA support to sh7372, enable DMA for SDHI
> 
> patch
> 
>  arch/arm/mach-shmobile/include/mach/sh7372.h |   14 +++++
>  arch/arm/mach-shmobile/setup-sh7372.c        |   70 ++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+), 0 deletions(-)
> 
This is applied now, too.

You may want to double check to make sure all of the correct versions
have been applied and that you have nothing more outstanding.
