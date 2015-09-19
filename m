From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: CH340/341: cannot open twice
Date: Sat, 19 Sep 2015 15:10:32 -0700
Message-ID: <20150919221032.GF2360@localhost>
References: <trinity-deaddc67-9f42-4260-9032-d3eb30b7e8f1-1442696993994@3capp-mailcom-lxa06>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <trinity-deaddc67-9f42-4260-9032-d3eb30b7e8f1-1442696993994@3capp-mailcom-lxa06>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "C. SB" <fenugrec-f9SIN1PjVWVBDgjK7y7TUQ@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Sat, Sep 19, 2015 at 11:09:54PM +0200, C. SB wrote:
> Hi,
> I'm having a strange issue with a CH340 usb-serial IC : I can only
> use/open it once. Here's what I try:

> The only solution is to unplug+replug the IC; any code using open()
> will fail with the same error.
> 
> lsusb output:
> Bus 002 Device 002: ID 1a86:7523 QinHeng Electronics HL-340 USB-Serial adapter
> 
> I tried only on kernels 4.0.6 and 4.1.6, system is archlinux x86-64.
> 
> Am I alone having this problem ?

I'm afraid not. There has been a couple of reports of problem with this
device. The reported problems have looked like hardware issues, but it
now seems like support for these devices is simply lacking in the
driver.

Could you try the vendor driver and see if that makes the device work so
that we'd know for sure?

Thanks,
Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
