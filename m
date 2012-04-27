From: Huang Shijie <shijie8@gmail.com>
Subject: Re: [PATCH 1/2] serial/imx: add DMA support
Date: Fri, 27 Apr 2012 11:18:15 -0400
Message-ID: <CAMiH66FoEYEqudAOx7Y8GpgjfT-gX2qOi0BjG0-X8xH8u24kSw@mail.gmail.com>
References: <1335436632-29499-1-git-send-email-b32955@freescale.com>
	<1335436632-29499-2-git-send-email-b32955@freescale.com>
	<20120426111116.GF24211@n2100.arm.linux.org.uk>
	<4F9A4417.7080107@freescale.com>
	<20120427082245.GJ24211@n2100.arm.linux.org.uk>
	<4F9A6AEE.30005@freescale.com>
	<20120427095003.GK24211@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38778 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760145Ab2D0PSR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Apr 2012 11:18:17 -0400
Received: by yhmm54 with SMTP id m54so452908yhm.19
        for <linux-serial@vger.kernel.org>; Fri, 27 Apr 2012 08:18:16 -0700 (PDT)
In-Reply-To: <20120427095003.GK24211@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Huang Shijie <b32955@freescale.com>, B20596@freescale.com, B20223@freescale.com, gregkh@linuxfoundation.org, r58066@freescale.com, linux-serial@vger.kernel.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com

On Fri, Apr 27, 2012 at 5:50 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 27, 2012 at 05:46:22PM +0800, Huang Shijie wrote:
>>>>> 1. How do you deal with transmitting the high-priority XON/XOFF
>>>>> =C2=A0 =C2=A0 =C2=A0characters (port->x_char) which occur with s/=
w flow control and
>>>>> =C2=A0 =C2=A0 =C2=A0the tty buffers fill up?
>>>>> 2. How do you deal with flow control in general? =C2=A0IOW, what =
happens
>>>>> =C2=A0 =C2=A0 =C2=A0when the remote end deasserts your CTS with h=
/w flow control enabled.
>> If the remote end deasserts my CTS, it means the remote will not sen=
d
>> any data.
>>
>> My DMA for RX will expire in the following steps:
>> [1] the UART only waits for 32 bytes time long
>> [2] the UART triggers an IDLE Condition Detect DMA.
>> [3] the dma_rx_callback() will release the DMA for Rx.
>
> Err, hang on. =C2=A0I think you're totally confused about hardware fl=
ow
> control. =C2=A0Certainly you're not using the correct terms for what =
you're
> describing.
>
> The CTS input normally controls the transmitter. =C2=A0In many hardwa=
re
> assisted hardware flow control setups, the deassertion of CTS merely
> prevents the transmitter starting a new character.
>
> This shouldn't have any effect on the receiver of the same UART at al=
l.
>
>>>>> =C2=A0 =C2=A0 =C2=A0How does your end deal with sending RTS accor=
ding to flow control
>>>>> =C2=A0 =C2=A0 =C2=A0conditions?
>>>>>
>> If a CTS is received after we sent out a RTS, it will follow the ste=
ps:
>> =C2=A0imx_int() --> imx_rtsint() --> uart_handle_cts_change() -->sta=
rt_tx()
>>
>> The start_tx() will create an TX DMA operation, and send out the dat=
a.
>
> The generation of RTS (connected to the remote ends CTS signal) is
> supposed to control whether the remote end sends you characters. =C2=A0=
RTS
http://en.wikipedia.org/wiki/Flow_control#Hardware_flow_control

=46rom the wiki, the generation of RTS (assert by the  "master end") is
used to send data
from the master to slave(the remote), not control the remote end sends
me characters.



Best Regards
Huang Shijie



> gets deasserted either by software control when you're running out of
> space to store the received characters, or (in the case of hardware
> assisted hardware flow control) your receivers FIFO fills above a
> certain watermark.
>
>>>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
