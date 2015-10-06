From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: alloc_tty_driver fails with ENOMEM
Date: Tue, 6 Oct 2015 11:03:46 +0300
Message-ID: <20151006080345.GE2472@tarshish>
References: <20151006064424.GD2472@tarshish>
 <20151006075307.GA18449@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151006075307.GA18449@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Greg,

On Tue, Oct 06, 2015 at 08:53:07AM +0100, Greg KH wrote:
> On Tue, Oct 06, 2015 at 09:44:24AM +0300, Baruch Siach wrote:
> > Since upgrading to kernel version from 4.1.x to 4.2.1 on Debian testing I 
> > am getting on my PC the following usbserial module init failure when 
> > connecting my PC to the i.MX6 SabreSD FTDI USB/serial connector:
> > 
> > [39987.092021] usb 1-5.1: new full-speed USB device number 4 using ehci-pci
> > [39987.190805] usb 1-5.1: New USB device found, idVendor=0403, idProduct=6001
> > [39987.190810] usb 1-5.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> > [39987.190813] usb 1-5.1: Product: FT232R USB UART
> > [39987.190817] usb 1-5.1: Manufacturer: FTDI
> > [39987.190820] usb 1-5.1: SerialNumber: A903PDKT
> > [39989.127918] systemd-udevd: page allocation failure: order:4, mode:0x2040d0
> 
> This shows that you have some serious memory issues happening here :(

Which part is showing this? Is the order too high? Unusual mode?

> > [39989.127923] CPU: 0 PID: 5856 Comm: systemd-udevd Not tainted 4.2.0-1-amd64 #1 Debian 4.2.1-2
> > [39989.127925] Hardware name: Gigabyte Technology Co., Ltd. EP45-DS3/EP45-DS3, BIOS F5 06/18/2008
> > [39989.127928]  0000000000000000 0000000000000004 ffffffff81548756 00000000002040d0
> > [39989.127931]  ffffffff8115266f ffff88007feddb00 0000000000000000 0000000000000001
> > [39989.127934]  0000000000000004 0000000000000040 ffff8800793ce7c0 00000000002040d0
> > [39989.127937] Call Trace:
> > [39989.127945]  [<ffffffff81548756>] ? dump_stack+0x40/0x50
> > [39989.127951]  [<ffffffff8115266f>] ? warn_alloc_failed+0xcf/0x130
> > [39989.127954]  [<ffffffff81155d74>] ? __alloc_pages_nodemask+0x2b4/0x9e0
> 
> As does this :(
> 
> What does 'free -h' show?

Here it is:

              total        used        free      shared  buff/cache   available
Mem:           2.0G        567M         77M         19M        1.3G        1.3G
Swap:          4.8G         24M        4.7G

Looks quite normal to me.

> I don't think this is a USB issue, you are just hitting it for some odd
> reason.

OK. Adding LKML. For reference, the original report is at 
http://article.gmane.org/gmane.linux.usb.general/131878.

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
