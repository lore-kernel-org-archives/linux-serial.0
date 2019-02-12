From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: RFC: drop ISA support in the synlink tty driver?
Date: Tue, 12 Feb 2019 09:25:17 +0100
Message-ID: <20190212082517.GA27889@kroah.com>
References: <20190211132534.29407-1-hch@lst.de>
 <20190212075151.GA7588@kroah.com>
 <7585c8b6-6dc4-2556-d14f-2fd60dc7df90@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7585c8b6-6dc4-2556-d14f-2fd60dc7df90@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Feb 12, 2019 at 09:08:41AM +0100, Jiri Slaby wrote:
> On 12. 02. 19, 8:51, Greg Kroah-Hartman wrote:
> > On Mon, Feb 11, 2019 at 02:25:33PM +0100, Christoph Hellwig wrote:
> >> Hi Greg and Jiri,
> >>
> >> I've been working hard to get rid of the remaining callers the pass a
> >> NULL struct device to the DMA mapping functions and am almost done.
> >>
> >> The only non-trivial driver is the synclink driver, which has legacy
> >> early 90s style ISA support that doesn't use the device model at all.
> >>
> >> In theory we could convert it to an isa_driver, but without testing
> >> that seems rather dangerous.  So for now I would suggest that we
> >> remove the ISA support in this driver - if anyone cares enough we
> >> can resurrect it from the git history and convert it to use the driver
> >> model.
> > 
> > No objection from me at all, I'll go queue this up now, thanks.
> 
> Agreed, but I would kill also the MGSL_BUS_TYPE_ISA macro proper.

It's just a #define, in a uapi file, so we should probably leave it as
userspace programs _might_ depend on it.  I have no idea why, but oh
well...

thanks,

greg k-h
