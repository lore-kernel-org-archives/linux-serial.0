From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Fri, 19 Aug 2016 12:38:08 +0100
Message-ID: <20160819123808.05b9dc3c@lxorguk.ukuu.org.uk>
References: <20160818011445.22726-1-robh@kernel.org>
        <20160818152528.569eb426@lxorguk.ukuu.org.uk>
        <CAL_Jsq+_uyycf+_eGr+864juxM4153ctoUMz9r=+tZG_Or7zUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+_uyycf+_eGr+864juxM4153ctoUMz9r=+tZG_Or7zUw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> Plenty? Really?. Lets break down the tty drivers in the kernel which
> don't use uart_port.


That's the wrong list - those that use uart port but don't always use the
uart_insert_char helpers will also break. So you can start by adding

8250		
amba-pl011
atmel_serial
bcm63xx_uart
bfin_sport
bfin_sport_uart
crisv10
efm32-uart
etraxfs-uart
fsl_lpuart
icom
ifx6060
imx
ioc3_serial
ioc4_serial
kgdb_nmi
lantiq
lpc32xx_hs
m32r_sio
men_z135_uart
meson_uart
mpc52xx_uart
mps2-uart
mpsc
msm_serial
mux
mvebu-uart
mxs-auart
pch_uart
pic32_uart
pmac_zilog
samsung
serial-tegra
sh-sci
sirfsoc_uart
sn_console
sunhv
sunsab
sunsu
sunzilog
tilegx
timbuart
uartline
ucc_uart
vt8500_serial

Some of those you could handle reasonably easily as they are byte
oriented, however if your code takes any longer in clock terms to run on
the low end devices you'll be a regression. Some of these don't use
uart_insert_char because the cost of that tips them over the available
clock times.

Quite a few of them however use tty_insert_flip_string or the other
buffer handling functions, particularly when doing DMA so you would have
to do significant work to fit them into some 'byte callback' type model.

This again is why it needs to be at the tty_port layer. The receive paths
can be cleanly intercepted at the point you'd push to an ldisc - the
driver level code on rx doesn't care if you have a tty attached, because
bytes arrived whether the tty is open or not.

In the case of 8250 all the recent x86 class systems which have things
like bluetooth attached via the LPSS are using 8250 and with DMA so your
interface simply won't work.

There are also some other slight complications when you look at real
world implementations. Android devices tend to keep the GPS in userspace
so most of then can't use some magic extra API but just drive GPIO lines
via the sysfs GPIO interface. Most Android doesn't use the kernel BT
stack either.

Quite a few Android and other embedded devices also do power management by
shutting off the UART, routing the rx line to an edge triggered GPIO and
on the interrupt flipping the UART back on and losing the first byte,
picking a protocol that can recover from it.

Your model doesn't I think cover that, although I am somewhat at a loss as
to how to do that nicely!

> Consoles/Debug:
> arch/alpha/kernel/srmcons.c
> arch/cris/arch-v10/kernel/debugport.c
> arch/ia64/hp/sim/simserial.c
> arch/m68k/emu/nfcon.c
> arch/parisc/kernel/pdc_cons.c
> arch/xtensa/platforms/iss/console.c
> drivers/char/ttyprintk.c
> drivers/tty/bfin_jtag_comm.c
> drivers/tty/ehv_bytechan.c
> drivers/tty/hvc/hvc_console.c
> drivers/tty/hvc/hvcs.c
> drivers/tty/hvc/hvsi.c
> drivers/tty/serial/kgdb_nmi.c
> drivers/tty/mips_ejtag_fdc.c
> drivers/tty/metag_da.c
> drivers/misc/pti.c

You could attach a dongle of some sort to a supposed console/debug port
and people do that kind of crap on embedded devices to save a few cents.
The ones above look fine though.

> SDIO UART:
> drivers/mmc/card/sdio_uart.c

This is an area that definitely needs covering, except that the way the
power works may be completely opaque to the OS if it's something like an
ACPI OpRegion controlling it.

> S390 (don't think BT dongle is a use case):
> drivers/s390/char/con3215.c
> drivers/s390/char/sclp_tty.c
> drivers/s390/char/sclp_vt220.c
> drivers/s390/char/tty3270.c

I would prefer to think of the fact BT on S390 *would* work as a test of
the API being right.

> Firewire serial:
> drivers/staging/fwserial/fwserial.c
> 
> Amiga serial:
> drivers/tty/amiserial.c
> 
> Android emulator:
> drivers/tty/goldfish.c
> 
> Multi-port serial boards (standard connectors and not embedded with
> sideband signals):
> drivers/tty/cyclades.c
> drivers/tty/isicom.c
> drivers/tty/moxa.c
> drivers/tty/mxser.c
> drivers/tty/rocket.c
> drivers/tty/synclink.c
> drivers/tty/synclink_gt.c
> drivers/tty/synclinkmp.c
> drivers/char/pcmcia/synclink_cs.c
> drivers/ipack/devices/ipoctal.c
> drivers/staging/dgnc/dgnc_tty.c
> 
> Modems (already a slave device):
> drivers/isdn/capi/capi.c
> drivers/isdn/gigaset/interface.c
> drivers/isdn/i4l/isdn_tty.c
> drivers/tty/nozomi.c
> drivers/tty/ipwireless/tty.c
> drivers/tty/serial/ifx6x60.c
> drivers/net/usb/hso.c
> drivers/staging/gdm724x/gdm_tty.c
> drivers/usb/class/cdc-acm.c
> 
> USB:
> drivers/usb/gadget/function/u_serial.c
> drivers/usb/serial/usb-serial.c

Your list for USB is misleading. Just about every USB serial port uses
usb-serial as a midlayer so you are basically saying "Let's make a giant
weird special case". Just listing usb-serial would be like just listing
serial-core and saying you only support one device.

> That leaves usb-serial. If the current support is good enough, then
> that will continue to work (as you said elsewhere, can't break
> userspace). If someone really wants to do USB serial and wire in
> sideband controls, then we could provide a host driver that hooks into
> usb_serial_port.

Alreay happens when people are doing strange things nailing legacy
devices to HSIC/SSIC. USB is not just a pile of external cables that
always have the plug upside down, it has specifications for directly
routed low voltage on PCB consumers and bridges.

The fact you want two different host drivers and two APIs for the same
object connected to two identical interfaces but on different busses
should be raising alarm bells. We don't have different interfaces for
NE2000 over PCI or NE2000 over ISA !

> > Your changes also don't work because serial uart drivers are not obliged
> > to use any of the uart buffering helpers and particularly on the rx side
> > many do not do so and the performance hit would be too high.  
> 
> Do you have an example?
> 
> The only uart buffering helper is for the receive side with
> uart_insert_char. Sure, a character at a time is not efficient, but
> that is easily rectified. Or do you mean something else?

Not all of the uart drivers even use uart_insert_char. It's a convenience
helper that most of them bypass because it's completely useless if you
are doing things like DMA. Even the modern x86 PC UARTs don't and can't
use uart_insert_char and that basically is a killer.

Alan
