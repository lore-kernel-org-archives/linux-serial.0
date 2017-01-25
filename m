From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/8] serial: st-asc: Allow handling of RTS line
Date: Wed, 25 Jan 2017 15:35:34 +0000
Message-ID: <20170125153534.GB19242@dell>
References: <20170124134310.27512-1-lee.jones@linaro.org>
 <20170125100722.GB17954@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170125100722.GB17954-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: jslaby-IBi9RG/b67k@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, 25 Jan 2017, Greg KH wrote:

> On Tue, Jan 24, 2017 at 01:43:02PM +0000, Lee Jones wrote:
> > When hardware flow-control is disabled, manual toggling of the UART's
> > reset line (RTS) using userland applications (e.g. stty) is not
> > possible, since the ASC IP does not provide this functionality in the
> > same was as some other IPs do.  Thus, we have to do this manually.
> > 
> > This set ensures the correct Pinctrl groups are configured and
> > obtained for both manual toggling of the RTS line and for the IP to
> > take over the lines when HW flow-control is requested by the user.
> > 
> > Lee Jones (8):
> >   serial: st-asc: Ignore the parity error bit if 8-bit mode is enabled
> >   serial: st-asc: Provide RTS functionality
> >   serial: st-asc: Read in all Pinctrl states
> >   serial: st-asc: (De)Register GPIOD and swap Pinctrl profiles
> >   ARM: dts: STiH410-b2260: Identify the UART RTS line
> >   ARM: dts: STiH407-pinctrl: Add Pinctrl group for HW flow-control
> >   ARM: dts: STiH407-family: Use new Pinctrl groups
> >   ARM: dts: STiH407-family: Enable HW flow-control
> > 
> >  arch/arm/boot/dts/stih407-family.dtsi  |  7 +--
> >  arch/arm/boot/dts/stih407-pinctrl.dtsi | 12 ++++-
> >  arch/arm/boot/dts/stih410-b2260.dts    |  1 +
> >  drivers/tty/serial/st-asc.c            | 98 +++++++++++++++++++++++++++++++---
> >  4 files changed, 105 insertions(+), 13 deletions(-)
> > 
> 
> I'll ignore this series due to the kbuild problems :(

It's strange.

These didn't happen locally ... and aiaiai was also happy.

Nevertheless, I will fix-up and resend.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
