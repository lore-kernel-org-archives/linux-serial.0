From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] serial: change the divisor latch only when prescalar
 actually changed
Date: Thu, 3 Feb 2011 14:15:22 -0800
Message-ID: <20110203221522.GA4019@kroah.com>
References: <20110125070154.GI3315@kai-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110125070154.GI3315@kai-debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Yin Kangkai <kangkai.yin@linux.intel.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, "Woodhouse, David" <david.woodhouse@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 25, 2011 at 03:01:54PM +0800, Yin Kangkai wrote:
> From: Yin Kangkai <kangkai.yin@intel.com>
> 
> In 8250.c original ns16550 autoconfig code, we change the divisor latch when
> we goto to high speed mode, we're assuming the previous speed is legacy. This
> some times is not true.

This doesn't apply to the linux-next tree, care to refresh it and resend
it?

thanks,

greg k-h
