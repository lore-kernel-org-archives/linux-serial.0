From: Aras Vaichas <aras.vaichas@gmail.com>
Subject: Re: can't detect 16550A at port 0x010 on Vortex86dx board
Date: Mon, 9 Jul 2012 13:42:34 +0100
Message-ID: <CAJkQPO=GYpDYOTiQ+Z-cs34=RRwnJLED79Xo4sZXg_Nd_2xM_A@mail.gmail.com>
References: <CAJkQPOm_TpNp6Y=rx0x9EtH1zvvwOb5JAo7Z+45BKRQPru-4ZQ@mail.gmail.com>
 <20120706235459.5886e2ee@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:53581 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab2GIMnP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Jul 2012 08:43:15 -0400
Received: by qcro28 with SMTP id o28so6623189qcr.19
        for <linux-serial@vger.kernel.org>; Mon, 09 Jul 2012 05:43:14 -0700 (PDT)
In-Reply-To: <20120706235459.5886e2ee@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

On 6 July 2012 23:54, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> Would Linux block my ability to manually probe these i/o ports?
>
> Not beyond reserving the region which you've said you've covered.
>
> What you may want to try is making sure Linux doesn't program the DMA
> controller (in case its doing something which disables the port in poking
> at it).
>
> Beyond that I guess ask the manufacturer for info.

Thank you. It turned out that I needed to configure the Southbridge.

I managed to get a complete datasheet and I have set all the correct
registers in the Southbridge to enable COM9 at port 0x010 with irq 9
(default values). Either the BIOS or Linux changed it from the default
values. I set the correct values in my serial port init_ function and
autoconfig detects the UART now.

# dmesg
<snip>
Serial: 8250/16550 driver, 5 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
serial8250: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
serial8250: ttyS3 at I/O 0x2e8 (irq = 3) is a 16550A
Vortex init of South Bridge for COM9
serial8250.11: ttyS4 at I/O 0x10 (irq = 9) is a 16550A
</snip>


I still have a problem though, I can't seem to use the device. e.g.

# echo hello > /dev/ttyS4
sh: write error: Input/output error


# cat /dev/ttyS4
sh: write error: Input/output error


# picocom -b 115200 /dev/ttyS4

FATAL: failed to add device /dev/ttyS4: Filedes is not a tty


# cat .config
<snip>
#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_SERIAL_8250_NR_UARTS=5
CONFIG_SERIAL_8250_RUNTIME_UARTS=5
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_VORTEX=y
</snip>


# cat /proc/tty/drivers
/dev/tty             /dev/tty        5       0 system:/dev/tty
/dev/console         /dev/console    5       1 system:console
/dev/ptmx            /dev/ptmx       5       2 system
/dev/vc/0            /dev/vc/0       4       0 system:vtmaster
serial               /dev/ttyS       4 64-68 serial
pty_slave            /dev/pts      136 0-1048575 pty:slave
pty_master           /dev/ptm      128 0-1048575 pty:master
unknown              /dev/tty        4 1-63 console

There only appears to only be 4 ttySx drivers in use.


# cat /proc/tty/driver/serial
serinfo:1.0 driver revision:
0: uart:16550A port:000003F8 irq:4 tx:19983 rx:548 RTS|DTR|RI
1: uart:16550A port:000002F8 irq:3 tx:0 rx:0
2: uart:16550A port:000003E8 irq:10 tx:0 rx:0
3: uart:16550A port:000002E8 irq:11 tx:7 rx:0
4: uart:16550A port:00000010 irq:9 tx:0 rx:0

Aras
