From: Juha Lumme <juha.lumme@gmail.com>
Subject: setserial failing strangely on omap development board (beagleboard)
Date: Fri, 28 Oct 2011 14:24:32 +0900
Message-ID: <CAF-Ht3z71GqeYpm+UChJeC1PZ-OddmiekL0v1KpRpM1ztPVwZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64656 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909Ab1J1FYc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Oct 2011 01:24:32 -0400
Received: by ggnb1 with SMTP id b1so3364444ggn.19
        for <linux-serial@vger.kernel.org>; Thu, 27 Oct 2011 22:24:32 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi all,

Not sure this is really the right place, but I've been stuck with this
problem for a while now, and seems like there are a lot of people on
this list who work with the serial stuff..
If this is not the place to discuss this type of issue, can someone
help me to the right place ? There aren't many places discussing
serial port stuff it seems, and on most forums, if there is some
serial port stuff, it will be for normal desktop linuxes, where this
works without problems...

I'm trying to develop an application to work with serial infra-red
module, but I'm having difficulties to even get my module started. My
HW is Beagleboard, which has 1 UART serial port, normally used for
console, which I have disabled (I re-created the boot.scr, without the
console arguments), and I have modified the getty config, not to try
to attach to ttyO2.
On 3.x omap kernels, the serial port is now called ttyOx instead of
ttySx, though I guess that doesn't really matter ? I guess the port
and irq are the most important things

During boot, I can see following information regarding the configuratio=
n:
[=A0=A0=A0 0.000000] Kernel command line: console=3Dtty0 root=3D/dev/mm=
cblk0p2
rootwait ro vram=3D12MB omapfb.mode=3Ddvi:1280x720MR-16@
60 fixrtc buddy=3Dnone mpurate=3Dauto
[=A0=A0=A0 0.000000] console [tty0] enabled
[=A0=A0=A0 0.768524] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72)=
 is a OMAP UART0
[=A0=A0=A0 0.768768] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73)=
 is a OMAP UART1
[=A0=A0=A0 0.769012] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74)=
 is a OMAP UART2
[=A0=A0=A0 0.769226] omap_uart.3: ttyO3 at MMIO 0x49042000 (irq =3D 80)=
 is a OMAP UART3


When system tries to load the lirc module (for infra-red) I get this
complain about IRQ being busy:
[ =A0 12.396392] lirc_serial: IRQ 74 busy

Now, I'm not sure now why that is still happening, as I think nobody
should be connected to ttyO2 anymore. But anyway, around internet
people say I should release the UART manually, and I try it with
setserial, with strange reply:
ubuntu@omap:/etc$ sudo setserial /dev/ttyO2 uart none
Cannot set serial info: Invalid argument
If I try without sudo, I get "Permission denied"

Also strangely, when I try to look at the port status:
ubuntu@omap:/etc$ sudo setserial -g /dev/ttyO[0-3]
/dev/ttyO0, UART: undefined, Port: 0x0000, IRQ: 72
/dev/ttyO1, UART: undefined, Port: 0x0000, IRQ: 73
/dev/ttyO2, UART: undefined, Port: 0x0000, IRQ: 74
/dev/ttyO3, UART: undefined, Port: 0x0000, IRQ: 80

Shoudn't there be something in those port addresses ?
Does it matter that "MMIO" is used ? Normally IO port seems to be
indeed 0x**** format, now the address for serial port is much higher
(0x********)

Thanks,
Juha
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
