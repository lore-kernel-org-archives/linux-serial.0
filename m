From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/3] tty/serial: 8250_early: Add support for PXA UARTs
Date: Tue, 27 Jan 2015 08:05:25 -0600
Message-ID: <CAL_Jsq+Jm=0YRJ_uc+wk0YopVGBgcfJia_W+X8oRViq=ATsx6A@mail.gmail.com>
References: <1422334209-23125-1-git-send-email-robh@kernel.org>
 <1422334209-23125-3-git-send-email-robh@kernel.org>
 <54C78E32.4050406@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <54C78E32.4050406@hurleysoftware.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 27, 2015 at 7:10 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 01/26/2015 11:50 PM, Rob Herring wrote:
>> The PXA variant of the 8250 UART adds a UART enable bit which must not
>> be cleared. Make the earlycon support maintain this bit if it is set.
>> This implies some initialization of the UART, but we cannot
>> unconditionally set the bit as some other variants require this bit to
>> be clear for other functions.
>
> So if the bootloader doesn't enable the uart, then earlycon doesn't work?

Correct. Some earlycon drivers rely on this fact and don't do any
initialization. There is a patch posted also to skip init for the 8250
earlycon. We could rely on that instead, but the 1st chunk is still
needed.

The UART already being initialized should be pretty common for PXA
based systems. More so than x86 UARTs. I think it is better to work
under some conditions than none.

> Or is there some other piece that is enabling the uart after earlycon setup
> (besides the driver, of course)?
>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Jiri Slaby <jslaby@suse.cz>
>> Cc: linux-serial@vger.kernel.org
>> ---
>>  drivers/tty/serial/8250/8250_early.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
>> index ce2a8ab..c31a22b 100644
>> --- a/drivers/tty/serial/8250/8250_early.c
>> +++ b/drivers/tty/serial/8250/8250_early.c
>> @@ -93,10 +93,10 @@ static void __init early_serial8250_write(struct console *console,
>>       struct uart_port *port = &early_device->port;
>>       unsigned int ier;
>>
>> -     /* Save the IER and disable interrupts */
>> +     /* Save the IER and disable interrupts preserving the UUE bit */
>>       ier = serial8250_early_in(port, UART_IER);
>>       if (ier)
>> -             serial8250_early_out(port, UART_IER, 0);
>> +             serial8250_early_out(port, UART_IER, ier & UART_IER_UUE);
>>
>>       uart_console_write(port, s, count, serial_putc);
>>
>> @@ -127,9 +127,11 @@ static void __init init_port(struct earlycon_device *device)
>>       struct uart_port *port = &device->port;
>>       unsigned int divisor;
>>       unsigned char c;
>> +     unsigned int ier;
>>
>>       serial8250_early_out(port, UART_LCR, 0x3);      /* 8n1 */
>> -     serial8250_early_out(port, UART_IER, 0);        /* no interrupt */
>> +     ier = serial8250_early_in(port, UART_IER);
>> +     serial8250_early_out(port, UART_IER, ier & UART_IER_UUE); /* no interrupt */
>
> The trailing comment seems no longer relevant; how about below?

It is because we are still disabling interrupts.

>         /* Mask interrupts (preserve XScale's uart enable bit) */
>         serial8250_early_out(port, UART_IER, ier & UART_IER_UUE);
>
> OTOH, if the uart is disabled, shouldn't earlycon be disabled?

There's no way I can detect that.

Rob
