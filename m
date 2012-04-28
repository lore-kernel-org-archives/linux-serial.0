From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 1/2] serial/imx: add DMA support
Date: Sat, 28 Apr 2012 16:53:01 +0800
Message-ID: <4F9BAFED.7030204@freescale.com>
References: <1335436632-29499-1-git-send-email-b32955@freescale.com> <1335436632-29499-2-git-send-email-b32955@freescale.com> <20120426111116.GF24211@n2100.arm.linux.org.uk> <4F9A4417.7080107@freescale.com> <20120427082245.GJ24211@n2100.arm.linux.org.uk> <4F9A6AEE.30005@freescale.com> <20120427095003.GK24211@n2100.arm.linux.org.uk> <CAMiH66FoEYEqudAOx7Y8GpgjfT-gX2qOi0BjG0-X8xH8u24kSw@mail.gmail.com> <20120427153031.GA27792@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:5306 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751897Ab2D1ItQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 28 Apr 2012 04:49:16 -0400
In-Reply-To: <20120427153031.GA27792@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Huang Shijie <shijie8@gmail.com>, B20596@freescale.com, B20223@freescale.com, gregkh@linuxfoundation.org, r58066@freescale.com, linux-serial@vger.kernel.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com

=E4=BA=8E 2012=E5=B9=B404=E6=9C=8827=E6=97=A5 23:30, Russell King - ARM=
 Linux =E5=86=99=E9=81=93:
> On Fri, Apr 27, 2012 at 11:18:15AM -0400, Huang Shijie wrote:
>> On Fri, Apr 27, 2012 at 5:50 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk>  wrote:
>>> On Fri, Apr 27, 2012 at 05:46:22PM +0800, Huang Shijie wrote:
>>>>>>> 1. How do you deal with transmitting the high-priority XON/XOFF
>>>>>>>       characters (port->x_char) which occur with s/w flow contr=
ol and
>>>>>>>       the tty buffers fill up?
>>>>>>> 2. How do you deal with flow control in general?  IOW, what hap=
pens
>>>>>>>       when the remote end deasserts your CTS with h/w flow cont=
rol enabled.
>>>> If the remote end deasserts my CTS, it means the remote will not s=
end
>>>> any data.
>>>>
>>>> My DMA for RX will expire in the following steps:
>>>> [1] the UART only waits for 32 bytes time long
>>>> [2] the UART triggers an IDLE Condition Detect DMA.
>>>> [3] the dma_rx_callback() will release the DMA for Rx.
>>> Err, hang on.  I think you're totally confused about hardware flow
>>> control.  Certainly you're not using the correct terms for what you=
're
>>> describing.
>>>
>>> The CTS input normally controls the transmitter.  In many hardware
>>> assisted hardware flow control setups, the deassertion of CTS merel=
y
>>> prevents the transmitter starting a new character.
>>>
>>> This shouldn't have any effect on the receiver of the same UART at =
all.
>>>
>>>>>>>       How does your end deal with sending RTS according to flow=
 control
>>>>>>>       conditions?
>>>>>>>
>>>> If a CTS is received after we sent out a RTS, it will follow the s=
teps:
>>>>   imx_int() -->  imx_rtsint() -->  uart_handle_cts_change() -->sta=
rt_tx()
>>>>
>>>> The start_tx() will create an TX DMA operation, and send out the d=
ata.
>>> The generation of RTS (connected to the remote ends CTS signal) is
>>> supposed to control whether the remote end sends you characters.  R=
TS
>> http://en.wikipedia.org/wiki/Flow_control#Hardware_flow_control
>>
>> > From the wiki, the generation of RTS (assert by the  "master end")=
 is
>> used to send data
>> from the master to slave(the remote), not control the remote end sen=
ds
>> me characters.
> Well, there's a lot of confusion over RTS.  Most implementations of i=
t
> are as per this paragraph on the above page:
>
>   A non-standard symmetric alternative, commonly called "RTS/CTS hand=
shaking,"
>   was developed by various equipment manufacturers. In this scheme, C=
TS is no
>   longer a response to RTS; instead, CTS indicates permission from th=
e DCE
>   for the DTE to send data to the DCE, and RTS indicates permission f=
rom
>   the DTE for the DCE to send data to the DTE. RTS and CTS are contro=
lled
>   by the DTE and DCE respectively, each independent of the other. Thi=
s was
>   eventually codified in version RS-232-E (actually TIA-232-E by that=
 time)
>   by defining a new signal, "RTR (Ready to Receive)," which is CCITT =
V.24
>   circuit 133. TIA-232-E and the corresponding international standard=
s were
>   updated to show that circuit 133, when implemented, shares the same=
 pin
>   as RTS (Request to Send), and that when 133 is in use, RTS is assum=
ed by
>   the DCE to be ON at all times
>
> This is what is actually used by all NULL modem cables, serial consol=
es,
> and many modems can be (sensibly) configured to support it.  Many
> modems can be configured via AT commands to respond as per the above
> paragraph too.
>
> And this is the hardware flow control scheme implemented by the Linux
> Kernel for CRTSCTS, plus the hardware assisted hardware flow control
> provided by industry standard UARTs such as the 1675x and later UARTs=
=2E
>
thanks a lot.

I will read the this explanation carefully, and fix my code.

Best Regards
Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
