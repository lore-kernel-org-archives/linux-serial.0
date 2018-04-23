From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: serial: xuartps: Setup early console when uartclk
 is also passed
Date: Mon, 23 Apr 2018 10:48:10 +0200
Message-ID: <20180423084810.GA11893@kroah.com>
References: <2ef5ac478f8d32bc807ead758eb5d60744a44515.1523367208.git.michal.simek@xilinx.com>
 <20180423080641.GA20149@kroah.com>
 <ebc1b162-c5bf-3963-05ab-4b236f89966a@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ebc1b162-c5bf-3963-05ab-4b236f89966a@monstr.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 23, 2018 at 10:37:12AM +0200, Michal Simek wrote:
> On 23.4.2018 10:06, Greg Kroah-Hartman wrote:
> > On Tue, Apr 10, 2018 at 03:33:30PM +0200, Michal Simek wrote:
> >> Baudrate calculation depends on requested baudrate and uart clock.
> >> This patch is checking that uartclk is also passed.
> >>
> >> The same logic is used 8250_early.c/init_port function.
> >>
> >> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >> ---
> >>
> >>  drivers/tty/serial/xilinx_uartps.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> >> index b9b2bc76bcac..a654cda203c7 100644
> >> --- a/drivers/tty/serial/xilinx_uartps.c
> >> +++ b/drivers/tty/serial/xilinx_uartps.c
> >> @@ -1181,7 +1181,7 @@ static int __init cdns_early_console_setup(struct earlycon_device *device,
> >>  	/* only set baud if specified on command line - otherwise
> >>  	 * assume it has been initialized by a boot loader.
> >>  	 */
> >> -	if (device->baud) {
> >> +	if (port->uartclk && device->baud) {
> >>  		u32 cd = 0, bdiv = 0;
> >>  		u32 mr;
> >>  		int div8;
> >> -- 
> >> 1.9.1
> > 
> > This patch conflicts with the previous patch you sent: Subject: [PATCH]
> > serial: xuartps: Fix the early_console junk character issue
> > 
> > So, which one should I apply?
> > 
> > I've dropped both from my review queue now, please resend the one(s) you
> > want applied, in a patch series if needed.
> 
> First of all thanks for dropping. I forget that I have sent it in past.
> 
> Both patches are targeting the same problem. The first one is more
> destructive.
> 
> And this one is what 8250 is doing.
> 
> I have also sent
> "[PATCH] earlycon: Initialize port->uartclk based on clock-frequency
> property" which is filling uartclk based on DT to do proper divider
> calculation.
> 
> It means when patch above is applied we can keep divider calculation in
> the driver because it is using right values. If not we need to remove
> that baudrate calculation because it is not correct (uartclk is
> hardcoded to BASE_BAUD * 16 in of_setup_earlycon).
> And it is really a question if "port->uartclk = BASE_BAUD * 16" should
> be in of_setup_earlycon.

Ok, but what should I do here?  My patch queue for serial drivers is now
empty, so if you didn't get an automated email saying your patch was
applied, please resend what you think needs to be applied.

thanks,

greg k-h
