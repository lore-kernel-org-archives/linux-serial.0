From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] serial: pl011: Move uart_register_driver call to
 device probe
Date: Thu, 13 Feb 2014 10:27:01 -0800
Message-ID: <20140213182701.GA32578@kroah.com>
References: <1390208555-27770-1-git-send-email-tushar.behera@linaro.org>
 <1390208555-27770-3-git-send-email-tushar.behera@linaro.org>
 <20140120100415.GX15937@n2100.arm.linux.org.uk>
 <20140213181216.GB24155@kroah.com>
 <20140213181559.GB30257@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140213181559.GB30257@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tushar Behera <tushar.behera@linaro.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org, jslaby@suse.cz, ben.dooks@codethink.co.uk, broonie@kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 13, 2014 at 06:15:59PM +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 13, 2014 at 10:12:16AM -0800, Greg KH wrote:
> > On Mon, Jan 20, 2014 at 10:04:15AM +0000, Russell King - ARM Linux wrote:
> > > On Mon, Jan 20, 2014 at 02:32:35PM +0530, Tushar Behera wrote:
> > > > uart_register_driver call binds the driver to a specific device
> > > > node through tty_register_driver call. This should typically happen
> > > > during device probe call.
> > > > 
> > > > In a multiplatform scenario, it is possible that multiple serial
> > > > drivers are part of the kernel. Currently the driver registration fails
> > > > if multiple serial drivers with same default major/minor numbers are
> > > > included in the kernel.
> > > > 
> > > > A typical case is observed with amba-pl011 and samsung-uart drivers.
> > > 
> > > NAK.  There should not be any other driver using amba-pl011's device numbers.
> > 
> > I agree, but there is.  And because of that, moving the registration to
> > the probe call fixes the issue with building a kernel with all of the
> > drivers built into them, so I'm going to take both of these patches, as
> > it does solve that problem, while still allowing the device number
> > collision to happen.
> 
> So what happens when two _devices_ are probed by this driver at the same
> time?

The bus that the driver is on will not allow that to happen, I thought
we went through this before...

And yes, devices on different busses could cause problems, but is that
the case here for these devices?  At first glance, I don't think that
can happen for these drivers.

thanks,

greg k-h
