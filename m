From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: alloc_tty_driver fails with ENOMEM
Date: Tue, 6 Oct 2015 09:19:03 +0100
Message-ID: <20151006081903.GA19357@kroah.com>
References: <20151006064424.GD2472@tarshish>
 <20151006075307.GA18449@kroah.com>
 <20151006080345.GE2472@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151006080345.GE2472@tarshish>
Sender: linux-kernel-owner@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 06, 2015 at 11:03:46AM +0300, Baruch Siach wrote:
> Hi Greg,
> 
> On Tue, Oct 06, 2015 at 08:53:07AM +0100, Greg KH wrote:
> > On Tue, Oct 06, 2015 at 09:44:24AM +0300, Baruch Siach wrote:
> > > Since upgrading to kernel version from 4.1.x to 4.2.1 on Debian testing I 
> > > am getting on my PC the following usbserial module init failure when 
> > > connecting my PC to the i.MX6 SabreSD FTDI USB/serial connector:
> > > 
> > > [39987.092021] usb 1-5.1: new full-speed USB device number 4 using ehci-pci
> > > [39987.190805] usb 1-5.1: New USB device found, idVendor=0403, idProduct=6001
> > > [39987.190810] usb 1-5.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> > > [39987.190813] usb 1-5.1: Product: FT232R USB UART
> > > [39987.190817] usb 1-5.1: Manufacturer: FTDI
> > > [39987.190820] usb 1-5.1: SerialNumber: A903PDKT
> > > [39989.127918] systemd-udevd: page allocation failure: order:4, mode:0x2040d0
> > 
> > This shows that you have some serious memory issues happening here :(
> 
> Which part is showing this? Is the order too high? Unusual mode?

The page allocation failure of a "normal" allocation means that
something is going wrong outside of the USB subsystem.

thanks,

greg k-h
