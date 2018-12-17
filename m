From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: uartps: Add the device_init_wakeup
Date: Mon, 17 Dec 2018 16:44:52 +0100
Message-ID: <20181217154452.GA9844@kroah.com>
References: <ec9fdbdf1c444dc60edfc75a31583630e76a9b72.1544016009.git.michal.simek@xilinx.com>
 <20181217151520.GA12453@kroah.com>
 <333f4be8-a4ae-4276-e2ac-725d1ae4c9b0@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <333f4be8-a4ae-4276-e2ac-725d1ae4c9b0@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 17, 2018 at 04:29:56PM +0100, Michal Simek wrote:
> On 17. 12. 18 16:15, Greg Kroah-Hartman wrote:
> > On Wed, Dec 05, 2018 at 02:20:11PM +0100, Michal Simek wrote:
> >> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> >>
> >> Initialise the device wakeup.
> > 
> > Why?  This says what happened, which you can see from the patch itself,
> > but it does not say why this is needed at all.
> 
> We will fix this.
> 
> > 
> > Also, you sent 4 patches, without any numbering, so I have no idea what
> > order to apply them in.
> >
> > Please fix the changelog entries up and send this as a patch series so
> > that I can correctly apply them.
> 
> They are all independent that's why I have sent them separately as
> single patches.

But when you modify the same file, how am I supposed to know that?

thanks,

greg k-h
