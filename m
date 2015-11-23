From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATH RESEND v2 03/10] tty: xuartps: Always enable transmitter in
 start_tx
Date: Mon, 23 Nov 2015 08:05:54 +0100
Message-ID: <5652BAD2.4090000@xilinx.com>
References: <1447963344-16266-1-git-send-email-soren.brinkmann@xilinx.com>
 <1447963344-16266-4-git-send-email-soren.brinkmann@xilinx.com>
 <564F0E75.5020100@hurleysoftware.com>
 <20151120152849.GU32017@xsjsorenbubuntu>
 <564F4A95.3010303@hurleysoftware.com>
 <20151120165804.GV32017@xsjsorenbubuntu>
 <564F5574.4070407@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <564F5574.4070407@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On 20.11.2015 18:16, Peter Hurley wrote:
> On 11/20/2015 11:58 AM, S=C3=B6ren Brinkmann wrote:
>> On Fri, 2015-11-20 at 11:30AM -0500, Peter Hurley wrote:
>>> On 11/20/2015 10:28 AM, S=C3=B6ren Brinkmann wrote:
>>>> On Fri, 2015-11-20 at 07:13AM -0500, Peter Hurley wrote:
>>>>> On 11/19/2015 03:02 PM, Soren Brinkmann wrote:
>>>>>> start_tx must start transmitting characters. Regardless of the s=
tate of
>>>>>> the circular buffer, always enable the transmitter hardware.
>>>>>
>>>>> Why?
>>>>>
>>>>> Does cdns_uart_stop_tx() actually stop the transmitter so that
>>>>> data remains in the transmitter?
>>>>
>>>> Well, I saw my system freezing and the cause seemed to be that the=
 UART
>>>> receiver and/or transmitters were disabled while the system was tr=
ying
>>>> to print. Hence, I started questioning all locations touching the
>>>> transmitter/receiver enable. I read the docs in
>>>> https://www.kernel.org/doc/Documentation/serial/driver, which simp=
ly
>>>> says "Start transmitting characters." for start_tx(). Hence, I tho=
ught,
>>>> this function is probably supposed to just do that and start the
>>>> transmitter. I'll test whether this patch can be dropped.
>>>
>>> I don't think that patch would fix any freeze problems, but restart=
ing
>>> the transmitter even if the circ buffer is empty may be necessary t=
o
>>> push out remaining data when the port is restarted after being stop=
ped.
>>>
>>> IOW, something like
>>>
>>> 	if (uart_tx_stopped(port))
>>> 		return;
>>>
>>> 	....
>>>
>>>
>>> 	if (uart_circ_empty(&port->state->xmit)
>>> 		return;
>>
>> Thanks! I'll change the patch accordingly.
>>
>>>
>>>
>>> Below is a (work-in-progress) serial driver validation test for flo=
w
>>> control handling (it may need some tuning for slow line speeds).
>>> Usual caveats apply. Takes ~40secs @ 115200.
>>
>> I'll try to get that running on my system.
>=20
> The test below should pass too, but I know it won't because this xili=
nx
> driver isn't handling x_char at all.
>=20
> Aside: does this h/w have rts driver/cts receiver?
>=20
> --- >% ---
> --- /dev/null	2015-11-20 07:19:13.265468435 -0500
> +++ xchar.c	2015-11-20 11:55:26.210233102 -0500
> @@ -0,0 +1,354 @@
> +/*
> + * x_char unit test for tty drivers

All these tests looks very interesting. Do you have any any
work-in-progress repo with other tests? It will be good to run all of
them to validate our drivers.

Thanks,
Michal
