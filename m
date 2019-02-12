From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: RFC: drop ISA support in the synlink tty driver?
Date: Tue, 12 Feb 2019 08:51:51 +0100
Message-ID: <20190212075151.GA7588@kroah.com>
References: <20190211132534.29407-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190211132534.29407-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Feb 11, 2019 at 02:25:33PM +0100, Christoph Hellwig wrote:
> Hi Greg and Jiri,
> 
> I've been working hard to get rid of the remaining callers the pass a
> NULL struct device to the DMA mapping functions and am almost done.
> 
> The only non-trivial driver is the synclink driver, which has legacy
> early 90s style ISA support that doesn't use the device model at all.
> 
> In theory we could convert it to an isa_driver, but without testing
> that seems rather dangerous.  So for now I would suggest that we
> remove the ISA support in this driver - if anyone cares enough we
> can resurrect it from the git history and convert it to use the driver
> model.

No objection from me at all, I'll go queue this up now, thanks.

greg k-h
