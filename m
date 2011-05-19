From: Pavan Savoy <pavan_savoy@sify.com>
Subject: Re: serial_core's port->count mess
Date: Thu, 19 May 2011 18:47:02 +0530
Message-ID: <BANLkTi=e2eWLy67y9Xe69PA_a-OUNR30cQ@mail.gmail.com>
References: <BANLkTim=dgCwFTeCyz273nBq4MGQs1FJsw@mail.gmail.com>
	<BANLkTim7OmA1y+Z_4CHZBCKu-uG_=9jJ=A@mail.gmail.com>
	<BANLkTikP__2Qh9cYUmA5jzgL_XxWB4rjhA@mail.gmail.com>
	<BANLkTik6f4rFcr+X=ov4y=48QCxF1=zvkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57809 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932671Ab1ESNRD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 19 May 2011 09:17:03 -0400
Received: by wya21 with SMTP id 21so1962940wya.19
        for <linux-serial@vger.kernel.org>; Thu, 19 May 2011 06:17:02 -0700 (PDT)
In-Reply-To: <BANLkTik6f4rFcr+X=ov4y=48QCxF1=zvkg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: linux-serial@vger.kernel.org

On Thu, May 19, 2011 at 6:42 PM, Govindraj <govindraj.ti@gmail.com> wro=
te:
>
> On Thu, May 19, 2011 at 6:21 PM, Pavan Savoy <pavan_savoy@sify.com> w=
rote:
>>
>> On Thu, May 19, 2011 at 3:58 PM, Govindraj <govindraj.ti@gmail.com> =
wrote:
>> >
>> > On Thu, May 19, 2011 at 3:08 PM, Pavan Savoy <pavan_savoy@sify.com=
>
>> > wrote:
>> >>
>> >> Hi,
>> >>
>> >> I have a device connected to my apps processor over UART, the ser=
ial
>> >> core's hooked up with omap-serial UART driver.
>> >> There is a scenario, where the device just fails to respond, and =
I
>> >> should be closing the UART & opening it again to re-try the reque=
st.
>> >> This is also coupled with power-cycling the chip.
>> >>
>> >> However a normal start/stop sequence where chip responds to every
>> >> request & I close UART when I'm done - is something like this,
>> >> [function name & line number in logs)
>> >> uart_open(1) called
>> >> uart_open: 1635
>> >> uart_open: 1651
>> >> uart_open: 1663
>> >> uart_open: 1674
>> >> omap-hsuart omap-hsuart.1: serial_omap_pm+1
>> >> omap-hsuart omap-hsuart.1: Enable CTS wakeup for UART 1
>> >> omap-hsuart omap-hsuart.1: serial_omap_startup+1
>> >> omap-hsuart omap-hsuart.1: serial_omap_set_mctrl+1
>> >> omap-hsuart omap-hsuart.1: serial_omap_get_mctrl+1
>> >> uart_open: 1686
>> >> uart_open: 1694
>> >> omap-hsuart omap-hsuart.1: serial_omap_set_mctrl+1
>> >> omap-hsuart omap-hsuart.1: serial_omap_set_termios+1
>> >> omap-hsuart omap-hsuart.1: serial_omap_set_mctrl+1
>> >> uart_open: 1705
>> >> uart_flush_buffer(1) called
>> >> omap-hsuart omap-hsuart.1: serial_omap_set_mctrl+1
>> >> omap-hsuart omap-hsuart.1: serial_omap_set_termios+1
>> >> omap-hsuart omap-hsuart.1: serial_omap_set_mctrl+1
>> >> omap-hsuart omap-hsuart.1: serial_omap_set_termios+1
>> >> uart_flush_buffer(1) called
>> >> uart_flush_buffer(1) called
>> >> uart_flush_buffer(1) called
>> >> omap-hsuart omap-hsuart.1: serial_omap_set_mctrl+1
>> >> omap-hsuart omap-hsuart.1: serial_omap_set_termios+1
>> >> uart_wait_until_sent(1), jiffies=3D4294954470, expire=3D429495447=
4...
>> >> omap-hsuart omap-hsuart.1: serial_omap_tx_empty+1
>> >> uart_wait_until_sent(1), jiffies=3D4294954471, expire=3D429495447=
5...
>> >> omap-hsuart omap-hsuart.1: serial_omap_tx_empty+1
>> >> (stc): st_tty_open
>> >>
>> >> uart_flush_buffer(1) called
>> >> uart_flush_buffer(1) called
>> >> uart_flush_buffer(1) called
>> >> (stk) :ldisc_install =3D 0
>> >> uart_close(1) called
>> >> uart_close: 1295
>> >> uart_close: 1316
>> >> uart_wait_until_sent(1), jiffies=3D4294951992, expire=3D429495199=
6...
>> >> omap-hsuart omap-hsuart.1: serial_omap_tx_empty+1
>> >> uart_close: 1327
>> >> omap-hsuart omap-hsuart.1: Disable CTS wakeup for UART1
>> >> uart_wait_until_sent(1), jiffies=3D4294951994, expire=3D429495199=
6...
>> >> omap-hsuart omap-hsuart.1: serial_omap_tx_empty+1
>> >> uart_close: 1345
>> >> omap-hsuart omap-hsuart.1: serial_omap_set_mctrl+1
>> >> omap-hsuart omap-hsuart.1: serial_omap_shutdown+1
>> >> omap-hsuart omap-hsuart.1: serial_omap_set_mctrl+1
>> >> uart_flush_buffer(1) called
>> >> uart_flush_buffer(1) called
>> >> omap-hsuart omap-hsuart.1: serial_omap_pm+1
>> >> uart_close: 1368
>> >> (stc): st_tty_close
>> >>
>> >> However, in a scenario where the chip fails to respond to one of =
the
>> >> requests, the start/stop sequence becomes something like this,
>> >> uart_open(1) called
>> >> uart_open: 1635
>> >> uart_open: 1651
>> >> uart_open: 1663
>> >> uart_open: 1705
>> >>
>> >> So, the problem seems to be that the port->count in the serial_co=
re
>> >> isn't 1 & hence the call,
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (port->count =3D=3D 1)
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uart_chang=
e_pm(state, 0);
>> >
>> > Actually port count will be incremented based on number of times
>> > the port will be opened. (file open do on the the given ttyOx inte=
rface)
>> > for the first tty open the count gets incremented to one and sets =
state
>> > to
>> > active
>> > (state, 0)
>> > if you open multiple times then the serial_core knows port in acti=
ve
>> > state
>> > so it is not necessary to call uart_change_pm(state, 0)
>>
>> Assuming multiple opens isn't that big a deal...
>> But I get a tcgetattr() failure then, and thereby unable to set the
>> default baud-rate
>> and hence send data over UART.
>
> Whats the error number?

strerror throws me Invalid arguments when the tcgetattr() fails.

>> >> doesn't seem to be happening, which is very critical. Also no cal=
ls
>> >> are made to uart_startup & hence omap-serial's startup.
>> >>
>> >> Where should I be looking as to why the port->count is messed up =
?
>> >> What is the this count used for?
>> >> Also how is this related to chip not responding to certain comman=
ds?
>> >
>> > Is the uart_clks cut? Try keeping uart clocks active always.
>>
>> Need to check this then....
>> How do I make sure they stay on ?
>
> you an avoid setting uart timeouts from sysfs entry or
> comment out omap_device_idle from */mach-omap2/serial.c file.

Yes, kind of familiar with 2nd approach - but need help on the sysfs en=
try ...
which one should I be looking for ? (hopefully available on all omap ke=
rnels..)

>>
>> > Govindraj.R
>> >
>> >>
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe linux-s=
erial"
>> >> in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-inf=
o.html
>> >
>> >
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
