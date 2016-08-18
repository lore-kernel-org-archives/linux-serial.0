From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 17:25:30 -0500
Message-ID: <CAL_Jsq+_uyycf+_eGr+864juxM4153ctoUMz9r=+tZG_Or7zUw@mail.gmail.com>
References: <20160818011445.22726-1-robh@kernel.org> <20160818152528.569eb426@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160818152528.569eb426@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 18, 2016 at 9:25 AM, One Thousand Gnomes
<gnomes@lxorguk.ukuu.org.uk> wrote:
> On Wed, 17 Aug 2016 20:14:42 -0500
> Rob Herring <robh@kernel.org> wrote:
>
> This was proposed ages ago and the point clearly made that
>
> a) the idea doesn't work because uarts are not required to use the uart
> layer and even those that do sometimes only use half of it
>
> b) that you should use the tty_port abstraction
>
> So instead of just waiting some months and recycling the proposals it's
> unfortunate that no listening and reworking was done.
>
> https://lkml.org/lkml/2016/1/18/177
>
> So I'm giving this a large neon flashing NAK, because none of the
> problems have been addressed.
>
>> Currently, devices attached via a UART are not well supported in the
>> kernel. The problem is the device support is done in tty line disciplines,
>> various platform drivers to handle some sideband, and in userspace with
>> utilities such as hciattach.
>
> For most platforms it works very nicely and out of the box. The only
> real issue I have actually seen is the bandwidth issue from early tty
> based 3G modems. That's not hard to fix with some tty buffer changes.
> Basically you need a tty port pointer that is atomic exchangable and
> points either to the usual tty queue logic or to a 'fastpath' handler
> which just gets thrown a block of bytes and told to use them or lose them
> - which is the interface the non n_tty ldiscs want anyway. That's exactly
> what you would need to fix to support in kernel stuff as well. The tty
> queue mechanism for devices that can receive in blocks just becomes a
> fastpath.
>
> There are some disgusting Android turds floating around out of tree where
> people use things like userspace GPIO line control but you won't fix most
> of those anyway because they are generally being used for user
> space modules including dumb GPS where the US government rules won't allow
> them to be open sourced anyway.
>
>> - Split out the controller for uart_ports into separate driver. Do we see
>>   a need for controller drivers that are not standard serial drivers?
>
> As I told you over six months ago uart_port is not the correct
> abstraction. You need to be working at the tty_port layer. The original
> design of tty_port was indeed partly to push towards being able to have a
> serial interface that is in use but not open to user space. The rather
> nice rework that the maintainers have done to put the buffers in the
> tty_port takes it closer still.
>
> Plenty of the classic serial port interfaces also don't use the UART
> layer including every USB device (which is most of them these days), SDIO
> and others. USB has to be covered for this to be sensible.

Plenty? Really?. Lets break down the tty drivers in the kernel which
don't use uart_port.

Consoles/Debug:
arch/alpha/kernel/srmcons.c
arch/cris/arch-v10/kernel/debugport.c
arch/ia64/hp/sim/simserial.c
arch/m68k/emu/nfcon.c
arch/parisc/kernel/pdc_cons.c
arch/xtensa/platforms/iss/console.c
drivers/char/ttyprintk.c
drivers/tty/bfin_jtag_comm.c
drivers/tty/ehv_bytechan.c
drivers/tty/hvc/hvc_console.c
drivers/tty/hvc/hvcs.c
drivers/tty/hvc/hvsi.c
drivers/tty/serial/kgdb_nmi.c
drivers/tty/mips_ejtag_fdc.c
drivers/tty/metag_da.c
drivers/misc/pti.c

SDIO UART:
drivers/mmc/card/sdio_uart.c

S390 (don't think BT dongle is a use case):
drivers/s390/char/con3215.c
drivers/s390/char/sclp_tty.c
drivers/s390/char/sclp_vt220.c
drivers/s390/char/tty3270.c

Firewire serial:
drivers/staging/fwserial/fwserial.c

Amiga serial:
drivers/tty/amiserial.c

Android emulator:
drivers/tty/goldfish.c

Multi-port serial boards (standard connectors and not embedded with
sideband signals):
drivers/tty/cyclades.c
drivers/tty/isicom.c
drivers/tty/moxa.c
drivers/tty/mxser.c
drivers/tty/rocket.c
drivers/tty/synclink.c
drivers/tty/synclink_gt.c
drivers/tty/synclinkmp.c
drivers/char/pcmcia/synclink_cs.c
drivers/ipack/devices/ipoctal.c
drivers/staging/dgnc/dgnc_tty.c

Modems (already a slave device):
drivers/isdn/capi/capi.c
drivers/isdn/gigaset/interface.c
drivers/isdn/i4l/isdn_tty.c
drivers/tty/nozomi.c
drivers/tty/ipwireless/tty.c
drivers/tty/serial/ifx6x60.c
drivers/net/usb/hso.c
drivers/staging/gdm724x/gdm_tty.c
drivers/usb/class/cdc-acm.c

USB:
drivers/usb/gadget/function/u_serial.c
drivers/usb/serial/usb-serial.c

Virtual devices:
net/bluetooth/rfcomm/tty.c
net/irda/ircomm/ircomm_tty.c

Could be updated to use uart_port:
drivers/tty/serial/crisv10.c

The only ones here I see us caring about are USB and SDIO as you
mentioned. SDIO suffers from the same embedded problem we are trying
to solve here with UART slave devices. The devices are always soldered
down with sideband GPIOs and power. If there is any device, then it's
ultimately going to need its own SDIO driver, not the the generic
sdio-uart. So the generic sdio-uart is pretty useless except maybe for
a discreet SDIO card which I haven't seen in at least 10 years or in a
product for 15 years.

That leaves usb-serial. If the current support is good enough, then
that will continue to work (as you said elsewhere, can't break
userspace). If someone really wants to do USB serial and wire in
sideband controls, then we could provide a host driver that hooks into
usb_serial_port.

> Your changes also don't work because serial uart drivers are not obliged
> to use any of the uart buffering helpers and particularly on the rx side
> many do not do so and the performance hit would be too high.

Do you have an example?

The only uart buffering helper is for the receive side with
uart_insert_char. Sure, a character at a time is not efficient, but
that is easily rectified. Or do you mean something else?

Rob
