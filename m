From: Sebastian Frias <sf84@laposte.net>
Subject: Re: [RFC PATCH] always probe UART HW when options are not specified
Date: Thu, 17 Dec 2015 20:05:15 +0100
Message-ID: <5673076B.4030905@laposte.net>
References: <5672D18E.8000301@laposte.net> <5672E2CF.6080705@hurleysoftware.com> <5672E76A.3010506@laposte.net> <20151217172143.GA20049@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151217172143.GA20049@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, mason <slash.tmp@free.fr>, =?windows-1252?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
List-Id: linux-serial@vger.kernel.org

On 12/17/2015 06:21 PM, Greg Kroah-Hartman wrote:
> On Thu, Dec 17, 2015 at 05:48:42PM +0100, Sebastian Frias wrote:
>> On 12/17/2015 05:29 PM, Peter Hurley wrote:
>>> On 12/17/2015 07:15 AM, Sebastian Frias wrote:
>>>> ---
>>>>
>>>> I think there are a few minor bugs on the 8250 UART code.
>>>>
>>>> Below you can find a patch with a proposed solution.
>>>>
>>>> In a nutshell:
>>>> - probe_baud from 87515772c33ee8a0cc08d984a7d2401eeff074cd was
>>>> converted into probe_port so that it reads all the parameters that
>>>> uart_set_options require (namely baud, parity, bits, flow).
>>>> - reading/writing to UART_DLL/UART_DLM directly are converted to
>>>> using the read_dl/write_dl callbacks.
>>>> - the port is always probed if there are no options (*).
>>>
>>> Because I don't want to probe the port at all.
>>>
>>> But must when using the
>>> 	earlycon=ttyS0,....
>>>
>>> command-line (because the original hack expects that behavior).
>>
>> Ok, we are using:
>>
>> "console=ttyS0 earlyprintk"
>>
>> and the 8250 (with CONFIG_SERIAL_8250_RT288X=y) driver.
>>
>> The hardware is setup prior to Linux boot.
>> We don't want Linux to change the UART settings, just to pick up whatever
>> settings the UART has and take over UART.
>
> Don't do that :)
> Linux can't "know" what happened before it started to the hardware and
> expect to work properly.

But it seems it was designed to work in that case :)
Commit 87515772c33ee8a0cc08d984a7d2401eeff074cd says that is not 
documented, but was made so that it works.

I can understand that normally Linux should take over all devices it is 
supposed to handle, initialise them, etc. and then it expects to retain 
full ownership of those devices.
But UART end-points need to agree on the communication parameters 
beforehand (and do not re-negotiate them mutually on-the-fly), that's 
why it seems important for Linux to avoid changing the parameters of an 
already configured UART.

If Linux does not "know" what happened before to some device, then maybe 
it's better if it does not touch it (or to be able to tell it that it 
should not touch the device)
The proposed solution of probing and setting up the same way also works.

>
>> How do you suggest we do that? Right now, since it does not probe, it just
>> messes up the UART config setup before booting Linux.
>
> pass in the same settings as you previously set up, that way there is no
> change.

We may not know them.
Indeed, when running under an SoC emulator, clocks sometimes run at 
arbitrary speeds, so if we hard-code the parameters, then that Linux 
Image+DT combo are bound to that specific clock.
Other times the clocks have strange ratios or the clock generators may 
not even be there, we may not even have a bootloader.
However, and at least in our case, when the SoC design is started in the 
emulator, the UART is setup automatically, which allows any device 
booting up to simply write to the UART and have its logs output.

In the past we used to have a forked Linux where some #ifdef would just 
bypass the UART init.
In Linux 4.x we found that bypassing the call to set_termios would do 
the trick.
But if we could avoid having any #ifdef at all and just use regular 
Linux features, it would be better.

Does that makes sense?

Thanks, regards,

Sebastian

>
> thanks,
>
> greg k-h
>
