From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: alloc_tty_driver fails with ENOMEM
Date: Tue, 6 Oct 2015 08:53:07 +0100
Message-ID: <20151006075307.GA18449@kroah.com>
References: <20151006064424.GD2472@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151006064424.GD2472@tarshish>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 06, 2015 at 09:44:24AM +0300, Baruch Siach wrote:
> Hi linux-usb list,
> 
> Since upgrading to kernel version from 4.1.x to 4.2.1 on Debian testing I am 
> getting on my PC the following usbserial module init failure when connecting 
> my PC to the i.MX6 SabreSD FTDI USB/serial connector:
> 
> [39987.092021] usb 1-5.1: new full-speed USB device number 4 using ehci-pci
> [39987.190805] usb 1-5.1: New USB device found, idVendor=0403, idProduct=6001
> [39987.190810] usb 1-5.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [39987.190813] usb 1-5.1: Product: FT232R USB UART
> [39987.190817] usb 1-5.1: Manufacturer: FTDI
> [39987.190820] usb 1-5.1: SerialNumber: A903PDKT
> [39989.127918] systemd-udevd: page allocation failure: order:4, mode:0x2040d0

This shows that you have some serious memory issues happening here :(

> [39989.127923] CPU: 0 PID: 5856 Comm: systemd-udevd Not tainted 4.2.0-1-amd64 #1 Debian 4.2.1-2
> [39989.127925] Hardware name: Gigabyte Technology Co., Ltd. EP45-DS3/EP45-DS3, BIOS F5 06/18/2008
> [39989.127928]  0000000000000000 0000000000000004 ffffffff81548756 00000000002040d0
> [39989.127931]  ffffffff8115266f ffff88007feddb00 0000000000000000 0000000000000001
> [39989.127934]  0000000000000004 0000000000000040 ffff8800793ce7c0 00000000002040d0
> [39989.127937] Call Trace:
> [39989.127945]  [<ffffffff81548756>] ? dump_stack+0x40/0x50
> [39989.127951]  [<ffffffff8115266f>] ? warn_alloc_failed+0xcf/0x130
> [39989.127954]  [<ffffffff81155d74>] ? __alloc_pages_nodemask+0x2b4/0x9e0

As does this :(

What does 'free -h' show?

I don't think this is a USB issue, you are just hitting it for some odd
reason.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
