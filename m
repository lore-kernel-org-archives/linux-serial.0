From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: Re: [PATCH v3 2/5] tty: Introduce SER_RS485_SOFTWARE read-only flag
 for struct serial_rs485
Date: Thu, 3 Dec 2015 08:50:20 +0300
Message-ID: <CAJs94EY+QnYkgRPz=QNBqVYo7iC3EHvPjGZvOCA3Z3WJhLxJOg@mail.gmail.com>
References: <1447338836-8785-1-git-send-email-matwey@sai.msu.ru>
 <1447338836-8785-3-git-send-email-matwey@sai.msu.ru> <20151112195707.5e9cb1d8@lxorguk.ukuu.org.uk>
 <5644F4F2.2080408@hurleysoftware.com> <20151114152536.693d964c@lxorguk.ukuu.org.uk>
 <564A2BF5.8030305@hurleysoftware.com> <CAJs94EZ816QpSeCrXRgjmg4mn7zbOX1V3BMr7+63QVF0p4As-A@mail.gmail.com>
 <564CC472.8010505@hurleysoftware.com> <CAJs94EacZ8d636suzFYZPBsoyAiF0-pqdAyKPXZPSJ=qrXayvw@mail.gmail.com>
 <CAJs94EY=qAhn6dzH9JbREruoXrvZoJh6a4jZEFHrK_KGGAre8g@mail.gmail.com> <565F7CA2.5030505@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <565F7CA2.5030505@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com, linux-kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

2015-12-03 2:20 GMT+03:00 Peter Hurley <peter@hurleysoftware.com>:
> On 11/18/2015 02:49 PM, Matwey V. Kornilov wrote:
>> 2015-11-18 22:39 GMT+03:00 Matwey V. Kornilov <matwey@sai.msu.ru>:
>>> 2015-11-18 21:33 GMT+03:00 Peter Hurley <peter@hurleysoftware.com>:
>>>> On 11/17/2015 03:20 AM, Matwey V. Kornilov wrote:
>>>>> 2015-11-16 22:18 GMT+03:00 Peter Hurley <peter@hurleysoftware.com>:
>>>>>> On 11/14/2015 10:25 AM, One Thousand Gnomes wrote:
> [...]
>>>>>>> It's also not "easy to drop". If it ever goes in we are stuck with a
>>>>>>> pointless impossible to correctly set flag for all eternity.
>>>>>>>
>>>>>>> Please explain the correct setting for this flag when a device driver
>>>>>>> uses hardware or software or a mix according to what the silicon is
>>>>>>> capable of and what values are requested ? How will an application use the
>>>>>>> flag meaningfully. Please explain what will happen if someone discovers a
>>>>>>> silicon bug and in a future 4.x release turns an implementation from
>>>>>>> hardware to software - will they have to lie about the flag to avoid
>>>>>>> breaking their application code - that strikes me as a bad thing.
>>>>>>
>>>>>> The existing driver behavior is already significantly variant and needs
>>>>>> to be converged, which shouldn't be too difficult. Here's a quick summary:
>>>>>>
>>>>>> mcfuart         ignores delay values, delays unsupported
>>>>>> imx             clamps delay values to 0, delays unsupported
>>>>>> atmel           only delay_rts_after_send used; delay_rts_before_send does nothing
>>>>>> 8250_fintek     clamps delay values to 1, unclear if h/w delay is msecs
>>>>>> omap-serial*    software emulation (but tx empty polling not reqd)
>>>>>> lpc18xx-uart    clamps delay_rts_before_send to 0, unsupported
>>>>>>                 clamps delay_rts_after_send to max h/w value
>>>>>> max310x         returns -ERANGE if either delay value > h/w support (15 msecs)
>>>>>> sc16is7xx*      returns -EINVAL if delay_rts_after_send is set
>>>>>> crisv10*        clamps delay_rts_before_send to 1000 msecs
>>>>>>                 ignores delays_rts_after_send (after dma is delayed by 2 * chars)
>>>>>> * implements delay(s) in software
>>>>>>
>>>>>> The omap-serial emulation should not have been merged in its current form.
>>>>>>
>>>>>> IMO the proper driver behavior should be clamp to h/w limit so an application
>>>>>> can determine the maximum delay supported. If a delay is unsupported, it should
>>>>>> be clamped to 0. The application should check the RS485 settings returned by
>>>>>> TIOCSRS485 to determine how the driver set them.
>>>>>> [ Documentation/serial/serial-rs485.txt should suggest/model this action ]
>>>>>
>>>>> But the similar could be true for minimal supported delay. If user
>>>>> requires delay which is less than lower bound, the delay is raised to
>>>>> the lower bound. If user requires delay which is greater than upper
>>>>> bound, the delay is set to the upper bound. Then software
>>>>> implementation could use (tx fifo size / baudrate) as lower bound for
>>>>> delay_after_send.
>>>>
>>>> From the application point-of-view (really the only relevant semantics),
>>>> delay_dts_after_send refers to the number of milliseconds to delay the
>>>> toggle of RTS after the last bit has been _transmitted_.
>
> Is there consensus then about what the semantics of unsupported RS485 delay
> values are? I (or someone else) can trivially add the documentation and
> fixes to the existing in-tree drivers.
>
>
>>>> A couple of possibilities for improving the emulation are:
>>>> 1) Optionally using an HR timer for sub-jiffy turnaround.
>>>> 2) Only supporting 8250-based hardware that can be set to interrupt when
>>>>    both tx fifo and transmitter shift register are empty.
>>>
>>> This is to support the RS485 API with already exists in omap_serrial,
>>> but not in 8250_omap. And OMAP does not support tx line interrupt in
>>> UART mode. So the latter is not an option.
>>
>> Oh, I am sorry, it does support. There is "Supplementary Control
>> Register" described in 19.5.1.39
>
> For the moment then, can we add a UART_CAP_SW485 (not exposed to userspace)
> that enables this algorithm only for h/w that supports a both-empty interrupt
> mode. The probe or driver (ala 8250_omap) would opt-in and configure the h/w much
> like the omap-serial driver does now (with the SCR register).
>
> Does that seem like an acceptable compromise?
>
> Regards,
> Peter Hurley
>
> PS - I still need to review this series for how the timer logic works esp. wrt
> teardown.
>

Dear Peter,

I am working on v4, where I completely redesigned implementation. And
now I think that it is considerably better than v3.
It looks like the following:
https://github.com/matwey/linux/commits/8520_rs485_v4
But it is not ready yet, there is a bug somewhere.

In the v4, each subdriver decides separately if it needs rs485
emulation support. Then it enables it like the following:
https://github.com/matwey/linux/commit/4455e425fc045713fb921ccec695fe183f1558f0
Before calling serial8250_rs485_emul_enabled, the driver enables
interrupt on empty shift register (they are always there for omap_).

-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119991, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
