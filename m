From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/1] Serial: DaVinci: Revert double IIR test
Date: Mon, 11 Aug 2008 14:47:01 -0700
Message-ID: <87tzdr5ine.fsf@deeprootsystems.com>
References: <48A04E34.9040306@acdstar.com>
	<87y733eb7n.fsf@deeprootsystems.com> <48A077D6.1090205@balister.org>
	<48A09655.3020009@acdstar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:62176 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbYHKVrH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 11 Aug 2008 17:47:07 -0400
Received: by wf-out-1314.google.com with SMTP id 27so4298628wfd.4
        for <linux-serial@vger.kernel.org>; Mon, 11 Aug 2008 14:47:06 -0700 (PDT)
In-Reply-To: <48A09655.3020009@acdstar.com> (Mark Lokowich's message of "Mon\, 11 Aug 2008 14\:43\:17 -0500")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mark Lokowich <lokowich@acdstar.com>
Cc: davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>, linux-serial@vger.kernel.org

Mark Lokowich <lokowich@acdstar.com> writes:

> Philip Balister wrote:
>> Kevin Hilman wrote:
>>> Mark Lokowich <lokowich@acdstar.com> writes:
>>>
>>>> Revert double IIR test in 8250 driver
>>>>
>>>
>>> Can you give a more detailed description of what the problem is that
>>> is being fixed?
>>
>> Without this patch, serial console behavior is strange. You type and
>> nothing is echoed and you hit return and things happen. It feels
>> like two processes are grabbing input.
>>
>> I think someone posted a more technical description, but I couldn't
>> find it quickly.
>>
>> Philip
>>
>    This section of the driver is a test for faulty 16650
>    implementations that require a backup timer.  The patch reverts the
>    change that compares two states (instead of one, as in 2.6.25.2) of
>    the IIR to determine if the workaround is required.  The DaVinci
>    UART does not need the backup timer, but the double conditional
>    passed, enabling the timer and causing interrupt handling errors on
>    the console and other UARTS.
>

Thanks Mark,

Do you have any recommendations for ways to conditionalize this code
so the test still works on other platforms.  Maybe via a new flag in
platform data?

I want to be sure there is a mainline-acceptable fix here, so we are
not divirging from mainline in generic code.

Kevin



>
>>
>>> This is in the generic 8250 driver so will affect all platforms.  For
>>> this to be accepted, it should be discussed on linux-serial[1]
>>>
>>> Kevin
>>>
>>>> Acked-by: Jaswinder Singh <jaswinder@embedio.com>
>>>> ---
>>>> --- linux-2.6/drivers/serial/8250.c
>>>> +++ linux-2.6-vanilla/drivers/serial/8250.c
>>>> @@ -1867,7 +1867,6 @@
>>>>     }
>>>>
>>>>     if (is_real_interrupt(up->port.irq)) {
>>>> -        unsigned char iir1;
>>>>         /*
>>>>          * Test for UARTs that do not reassert THRE when the
>>>>          * transmitter is idle and the interrupt has already
>>>> @@ -1881,7 +1880,7 @@
>>>>         wait_for_xmitr(up, UART_LSR_THRE);
>>>>         serial_out_sync(up, UART_IER, UART_IER_THRI);
>>>>         udelay(1); /* allow THRE to set */
>>>> -        iir1 = serial_in(up, UART_IIR);
>>>> +        serial_in(up, UART_IIR);
>>>>         serial_out(up, UART_IER, 0);
>>>>         serial_out_sync(up, UART_IER, UART_IER_THRI);
>>>>         udelay(1); /* allow a working UART time to re-assert THRE */
>>>> @@ -1894,7 +1893,7 @@
>>>>          * If the interrupt is not reasserted, setup a timer to
>>>>          * kick the UART on a regular basis.
>>>>          */
>>>> -        if (!(iir1 & UART_IIR_NO_INT) && (iir & UART_IIR_NO_INT)) {
>>>> +        if (iir & UART_IIR_NO_INT) {
>>>>             pr_debug("ttyS%d - using backup timer\n", port->line);
>>>>             up->timer.function = serial8250_backup_timeout;
>>>>             up->timer.data = (unsigned long)up;
>>>>
>>>>
>>>> _______________________________________________
>>>> Davinci-linux-open-source mailing list
>>>> Davinci-linux-open-source@linux.davincidsp.com
>>>> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
>>>
>>>
>>> [1] From MAINTAINERS:
>>>
>>> 8250/16?50 (AND CLONE UARTS) SERIAL DRIVER
>>> L:    linux-serial@vger.kernel.org
>>> W:    http://serial.sourceforge.net
>>> S:    Orphan
>>> _______________________________________________
>>> Davinci-linux-open-source mailing list
>>> Davinci-linux-open-source@linux.davincidsp.com
>>> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
>>>
