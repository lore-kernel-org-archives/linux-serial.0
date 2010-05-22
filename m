From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] sh: fix Oops in the serial SCI driver
Date: Sat, 22 May 2010 17:10:56 +0900
Message-ID: <20100522081056.GE17814@linux-sh.org>
References: <Pine.LNX.4.64.1005211728520.8450@axis700.grange> <Pine.LNX.4.64.1005211722410.8450@axis700.grange> <Pine.LNX.4.64.1005211721030.8450@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:40114 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928Ab0EVILA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 22 May 2010 04:11:00 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1005211728520.8450@axis700.grange> <Pine.LNX.4.64.1005211722410.8450@axis700.grange> <Pine.LNX.4.64.1005211721030.8450@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-serial@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>

On Fri, May 21, 2010 at 05:22:40PM +0200, Guennadi Liakhovetski wrote:
> Fix an Oops, triggering, if the DMA buffer allocation for the Rx channel in
> sh-sci.c fails.

On Fri, May 21, 2010 at 05:28:51PM +0200, Guennadi Liakhovetski wrote:
> This prevents the driver from unloading, while it is in use. Unloading of the
> driver, while its DMA channels are held, leads to a kernel Oops.

On Fri, May 21, 2010 at 05:30:12PM +0200, Guennadi Liakhovetski wrote:
> If all descriptors on a channel are terminated or the channel is released,
> update the completed cookie counter to match the last cookie. This prevents
> inconsistency warning on resumed DMA operation.

Applied, thanks.
