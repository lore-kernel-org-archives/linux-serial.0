From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH LINUX v4 06/13] tty: xuartps: Move request_irq to after
 setting up the HW
Date: Wed, 16 Dec 2015 06:37:57 -0800
Message-ID: <56717745.3060306@hurleysoftware.com>
References: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
 <1449376769-13369-7-git-send-email-soren.brinkmann@xilinx.com>
 <5669F172.6020503@hurleysoftware.com> <20151215154136.GU3358@xsjsorenbubuntu>
 <5670A1B6.6050708@hurleysoftware.com> <20151216090339.GX3358@xsjsorenbubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151216090339.GX3358@xsjsorenbubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>
List-Id: linux-serial@vger.kernel.org

On 12/16/2015 01:03 AM, S=C3=B6ren Brinkmann wrote:
> On Tue, 2015-12-15 at 03:26PM -0800, Peter Hurley wrote:
>> On 12/15/2015 07:41 AM, S=C3=B6ren Brinkmann wrote:
>>> On Thu, 2015-12-10 at 01:41PM -0800, Peter Hurley wrote:
>>>> On 12/05/2015 08:39 PM, Soren Brinkmann wrote:
>>>>> Request_irq() should be _after_ h/w programming, otherwise an
>>>>> interrupt could be triggered and in-progress before the h/w has b=
een
>>>>> setup.
>>>>
>>>> Slight misunderstanding. My fault; I should have been more explici=
t.
>>>>
>>>> 1. Any setup necessary for the isr not to be confused and misdirec=
t spurious
>>>>    interrupts (or hang) should be before installing the isr with r=
equest_irq()
>>>>    None of this code should trigger an interrupt.
>>>> 2. Clear pending interrupts
>>>> 3. Install the isr with request_irq()
>>>> 4. Enable interrupts
>>>
>>> Isn't that what the startup function is doing now - more or less. I
>>> think 3 and 4 are swapped to release the lock and then do the
>>> request_irq, but I believe that should be OK.
>>> The startup function configures the HW. Clears the ISR. Enables the
>>> intended IRQs and then does the request_irq call.
>>
>> If the driver enables interrupts before installing the isr with requ=
est_irq()
>> and an interrupt occurs there will the no handler to catch it and EO=
I the
>> device.
>=20
> Really? Shouldn't the IRQ be masked in the interrupt controller until
> everything is in place?

Sorry, I'm used to shared interrupts, where that isn't the case.

Regards,
Peter Hurley
