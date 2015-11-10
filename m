From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: Re: [PATCH v2 3/3] tty: Add software emulated RS485 support for 8250
Date: Tue, 10 Nov 2015 14:35:59 +0300
Message-ID: <CAJs94EbGsjAfvpj3hgZO7DtkVz00-YYx+bzQQgO9C2cb70QHVQ@mail.gmail.com>
References: <1446890976-1817-1-git-send-email-matwey@sai.msu.ru>
 <1446890976-1817-3-git-send-email-matwey@sai.msu.ru> <563E20DE.7000209@hurleysoftware.com>
 <CAJs94EaWQSqqUzqRoXO=vfBCf7CE+0Gt8C5-zGOB=t6ND0bSBg@mail.gmail.com>
 <5640B071.8000806@hurleysoftware.com> <CAJs94EYKgNg3qWTyVg4AiJ8nFWgerCOmj5sH+vPGwwyEgp3Rjg@mail.gmail.com>
 <56411088.9050304@hurleysoftware.com> <CAJs94EZO6KP-3jWPAM-OqMc2rxekxojYbvssAjb3fvybS0-RtA@mail.gmail.com>
 <56411896.6060801@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56411896.6060801@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

2015-11-10 1:05 GMT+03:00 Peter Hurley <peter@hurleysoftware.com>:
> On 11/09/2015 04:43 PM, Matwey V. Kornilov wrote:
>> 2015-11-10 0:30 GMT+03:00 Peter Hurley <peter@hurleysoftware.com>:
>>> On 11/09/2015 10:45 AM, Matwey V. Kornilov wrote:
>>>> 2015-11-09 17:40 GMT+03:00 Peter Hurley <peter@hurleysoftware.com>:
>>>>> On 11/08/2015 05:52 AM, Matwey V. Kornilov wrote:
>>>>>> 2015-11-07 19:03 GMT+03:00 Peter Hurley <peter@hurleysoftware.com>:
>>>>>>> On 11/07/2015 05:09 AM, Matwey V. Kornilov wrote:
>>>
>>> [...]
>>>
>>>>>>>> +static void serial8250_rs485_start_tx(struct uart_8250_port *p)
>>>>>>>> +{
>>>>>>>> +     if (p->capabilities & UART_CAP_HW485 || !(p->port.rs485.flags & SER_RS485_ENABLED))
>>>>>>>> +             return;
>>>>>>>> +
>>>>>>>> +     if (p->port.rs485.flags & SER_RS485_RTS_ON_SEND) {
>>>>>>>> +             serial_port_out(&p->port, UART_MCR, UART_MCR_RTS);
>>>>>>>> +             if (p->port.rs485.delay_rts_before_send > 0)
>>>>>>>> +                     mdelay(p->port.rs485.delay_rts_before_send);
>>>>>>>
>>>>>>> So irqs are off for x msecs, and this cpu can't be used for anything else now?
>>>>>>> I think this needs to be solved differently; maybe with a timer?
>>>>>>
>>>>>> Call of serial8250_start_tx is wrapped with spin_lock_irq in serial_core.c:2154
>>>>>
>>>>> Yep, which is why I pointed out "irqs are off for x msecs".
>>>>>
>>>>>> I've tried to use msleep instead of mdelay but got "BUG: scheduling
>>>>>> while atomic".
>>>>>
>>>>> Right, can't sleep while irqs are off, which is why I suggested something
>>>>> like a timer.
>>>>
>>>> I am not sure that understand you correctly. Do you think that the
>>>> following would be ok?
>>>>
>>>> wait_queue_head_t wait;
>>>> init_waitqueue_head(&wait);
>>>> wait_event_timeout(wait, 0, p->port.rs485.delay_rts_before_send * HZ / 1000);
>>>
>>> Except for spinning, there is no way to wait-in-place with irqs off.
>>>
>>> You'll need to do something more complex, like
>>> 1. raise RTS
>>> 2. start a timer _and return early without starting tx_
>>> 3. timer goes off, handler actually starts tx
>>>
>>
>> I think this could lead to race conditions.
>> AFAIU when the kernel calls ops->start_tx(uport) and the function
>> returns, then it is supposed that the tx has been started.
>
> No; start_tx() must cause tx to become started, but tx does not
> have to have _already_ started when start_tx() returns.
>
> It would be very inefficient for start_tx() to _guarantee_ tx has
> already started _before_ returning. Note the 8250 driver merely
> writes to IER (which could be buffered and bridged).
>

Thank you, now this is becoming clear to me.

>> And that could be not true, if the timer is used.
>
> It's true that using a timer will be more complex with more state
> to manage, but being unable to service interrupts with this cpu for
> milliseconds is unacceptable.
>
> Regards,
> Peter Hurley
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119991, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
