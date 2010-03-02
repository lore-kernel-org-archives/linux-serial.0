From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 0/2] Implement DMA support for the sh-sci.c serial driver
Date: Tue, 2 Mar 2010 12:13:10 +0900
Message-ID: <20100302031310.GC20256@linux-sh.org>
References: <Pine.LNX.4.64.1002181624190.4373@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:46200 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab0CBDNq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Mar 2010 22:13:46 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1002181624190.4373@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <damm@opensource.se>, Dan Williams <dan.j.williams@intel.com>, linux-serial@vger.kernel.org

On Thu, Feb 18, 2010 at 05:29:59PM +0100, Guennadi Liakhovetski wrote:
> The two patches in this series add DMA support to the sh-sci SCI(F) serial 
> driver. The worst problem is partial reception. Since we don't know in 
> advance how many bytes we're going to receive, we submit a DMA buffer 
> _and_ enable the Rx interrupt. When data arrives, we get an interrupt and 
> the data is written into DMA buffers. In the ISR we then set a timeout, if 
> within this time we get no DMA completion callback, we have a partial 
> buffer. Unfortunately, dmaengine API currently doesn't support retrieving 
> partially received DMA buffers, therefore we have to hijack the 
> .device_terminate_all() call to collect the data. A better approach would 
> be to add a stop-transfer / collect-partial call to the API.
> 
I've rolled these patches in as well, with some minor cleanups and
dependency fixups.

As none of the CPUs presently enable this yet, this will remain fairly
experimental, but it's enough to get people playing with it under 2.6.34.
We'll have to do some more iterative changes for 2.6.35, as well as
gradually getting it wired up on more CPUs, in addition to making it
configurable per-channel. This also gives us the time to get the
dmaengine API extensions worked out with Dan.
