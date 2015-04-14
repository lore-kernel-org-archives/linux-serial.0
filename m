From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: of-serial: Remove device_type = "serial"
 registration
Date: Tue, 14 Apr 2015 09:38:45 +0200
Message-ID: <20150414073845.GA9054@kroah.com>
References: <b8ba9c125be49a8a70a04807179c5f7fe79b1ae0.1428935724.git.michal.simek@xilinx.com>
 <20150413170044.GD32634@kroah.com>
 <552CA12F.30800@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <552CA12F.30800@monstr.eu>
Sender: stable-owner@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

On Tue, Apr 14, 2015 at 07:10:07AM +0200, Michal Simek wrote:
> Hi Greg,
> 
> On 04/13/2015 07:00 PM, Greg Kroah-Hartman wrote:
> > On Mon, Apr 13, 2015 at 04:35:27PM +0200, Michal Simek wrote:
> >> Do not probe all serial drivers by of_serial.c which are using
> >> device_type = "serial"; property. Only drivers which have valid
> >> compatible strings listed in the driver should be probed.
> > 
> > Why?  This was added for some reason, what has changed since then?
> 
> I was discussing this patch with Arnd over IRC.
> 
> This is what Arnd was saying yesterday.
> "when I wrote that driver initially, the idea was that it would get used
> as a stub to hook up all other serial drivers
> but after that, the common code learned to create platform devices from DT"
> 
> and resolution from our discussion was to remove this line because make
> no sense to probe all drivers which has device_type = "serial".
> It was causing the problem on one system with xilinx_uartps and 16550a
> IP where of_serial failed to register for xilinx_uartps and because of
> irq_dispose_mapping removed irq_desc. Then when xilinx_uartps was asking
> for irq with request_irq() it was returning EINVAL.
> 
> The first problem was that of_serial tried to bind driver because of
> device_type = "serial"; and the second problem was in xilinx_uartps
> driver by incorrectly using platform_get_resources() which doesn't
> create irq mapping which is fixed by the second patch.

All of this should have been in the patch description, as we have no
idea what your irc conversation was.

Please fix up and resend.

thanks,

greg k-h
