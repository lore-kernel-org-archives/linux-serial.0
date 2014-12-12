From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/4] serial: fsl_lpuart: fix various DMA related issues
Date: Fri, 12 Dec 2014 09:32:44 -0500
Message-ID: <20141212143244.GA2219@kroah.com>
References: <1417134205-4400-1-git-send-email-stefan@agner.ch>
 <677f2c62b6b6c1fe8e16cd38d5f20d47@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <677f2c62b6b6c1fe8e16cd38d5f20d47@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: jslaby@suse.cz, jingchang.lu@freescale.com, shawn.guo@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Dec 12, 2014 at 02:44:06PM +0100, Stefan Agner wrote:
> Any thoughts on this patchset? Would have hopped that it makes it into
> 3.19 as those are mostly fixes.

"mostly"?

I'll get to these after 3.19-rc1 is out, but it really looks like these
will be for 3.20-rc1, unless you break them up into "bugfix only" type
patches.

thanks,

greg k-h
