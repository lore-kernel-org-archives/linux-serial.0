From: Mark Lokowich <lokowich-3mWahjwryh5BDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/1] Serial: DaVinci: Revert double IIR test
Date: Mon, 11 Aug 2008 14:43:17 -0500
Message-ID: <48A09655.3020009@acdstar.com>
References: <48A04E34.9040306@acdstar.com> <87y733eb7n.fsf@deeprootsystems.com>
	<48A077D6.1090205@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <48A077D6.1090205-6RQC9ztksjxg9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: davinci-linux-open-source <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org



Philip Balister wrote:
> Kevin Hilman wrote:
>> Mark Lokowich <lokowich-3mWahjwryh5BDgjK7y7TUQ@public.gmane.org> writes:
>>
>>> Revert double IIR test in 8250 driver
>>>
>>
>> Can you give a more detailed description of what the problem is that
>> is being fixed?
>
> Without this patch, serial console behavior is strange. You type and 
> nothing is echoed and you hit return and things happen. It feels like 
> two processes are grabbing input.
>
> I think someone posted a more technical description, but I couldn't 
> find it quickly.
>
> Philip
>
    This section of the driver is a test for faulty 16650
    implementations that require a backup timer.  The patch reverts the
    change that compares two states (instead of one, as in 2.6.25.2) of
    the IIR to determine if the workaround is required.  The DaVinci
    UART does not need the backup timer, but the double conditional
    passed, enabling the timer and causing interrupt handling errors on
    the console and other UARTS.

    Mark

>
>> This is in the generic 8250 driver so will affect all platforms.  For
>> this to be accepted, it should be discussed on linux-serial[1]
>>
>> Kevin
>>
>>> Acked-by: Jaswinder Singh <jaswinder-TJMEihSVCElBDgjK7y7TUQ@public.gmane.org>
>>> ---
>>> --- linux-2.6/drivers/serial/8250.c
>>> +++ linux-2.6-vanilla/drivers/serial/8250.c
>>> @@ -1867,7 +1867,6 @@
>>>     }
>>>
>>>     if (is_real_interrupt(up->port.irq)) {
>>> -        unsigned char iir1;
>>>         /*
>>>          * Test for UARTs that do not reassert THRE when the
>>>          * transmitter is idle and the interrupt has already
>>> @@ -1881,7 +1880,7 @@
>>>         wait_for_xmitr(up, UART_LSR_THRE);
>>>         serial_out_sync(up, UART_IER, UART_IER_THRI);
>>>         udelay(1); /* allow THRE to set */
>>> -        iir1 = serial_in(up, UART_IIR);
>>> +        serial_in(up, UART_IIR);
>>>         serial_out(up, UART_IER, 0);
>>>         serial_out_sync(up, UART_IER, UART_IER_THRI);
>>>         udelay(1); /* allow a working UART time to re-assert THRE */
>>> @@ -1894,7 +1893,7 @@
>>>          * If the interrupt is not reasserted, setup a timer to
>>>          * kick the UART on a regular basis.
>>>          */
>>> -        if (!(iir1 & UART_IIR_NO_INT) && (iir & UART_IIR_NO_INT)) {
>>> +        if (iir & UART_IIR_NO_INT) {
>>>             pr_debug("ttyS%d - using backup timer\n", port->line);
>>>             up->timer.function = serial8250_backup_timeout;
>>>             up->timer.data = (unsigned long)up;
>>>
>>>
>>> _______________________________________________
>>> Davinci-linux-open-source mailing list
>>> Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
>>> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
>>
>>
>> [1] From MAINTAINERS:
>>
>> 8250/16?50 (AND CLONE UARTS) SERIAL DRIVER
>> L:    linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> W:    http://serial.sourceforge.net
>> S:    Orphan
>> _______________________________________________
>> Davinci-linux-open-source mailing list
>> Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
>> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
>>
