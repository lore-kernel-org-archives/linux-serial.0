From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 1/2] serial: 8250_early: do not save and restore IER in
 write callback
Date: Wed, 28 Oct 2015 12:27:02 +0900
Message-ID: <CAK7LNASy6Y_Jqqw6JhTdxMy7Nc35PytWSeqHCM8UybrVYp1mnw@mail.gmail.com>
References: <1445660265-13668-1-git-send-email-yamada.masahiro@socionext.com>
	<1445660265-13668-2-git-send-email-yamada.masahiro@socionext.com>
	<562F821A.90509@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <562F821A.90509@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-serial@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Kevin Cernekee <cernekee@gmail.com>, Jiri Slaby <jslaby@suse.com>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

2015-10-27 22:54 GMT+09:00 Peter Hurley <peter@hurleysoftware.com>:
> Hi Masahiro,
>
> On 10/24/2015 12:17 AM, Masahiro Yamada wrote:
>> The IER has already been masked in early_serial8250_setup(), there is
>> no reason to save and restore it every time early_serial8250_write()
>> is called.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  drivers/tty/serial/8250/8250_early.c | 12 ------------
>>  1 file changed, 12 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
>> index 7aff3d8..559b681 100644
>> --- a/drivers/tty/serial/8250/8250_early.c
>> +++ b/drivers/tty/serial/8250/8250_early.c
>> @@ -99,20 +99,8 @@ static void __init early_serial8250_write(struct console *console,
>>  {
>>       struct earlycon_device *device = console->data;
>>       struct uart_port *port = &device->port;
>> -     unsigned int ier;
>> -
>> -     /* Save the IER and disable interrupts preserving the UUE bit */
>> -     ier = serial8250_early_in(port, UART_IER);
>> -     if (ier)
>> -             serial8250_early_out(port, UART_IER, ier & UART_IER_UUE);
>>
>>       uart_console_write(port, s, count, serial_putc);
>
>
>
>> -
>> -     /* Wait for transmitter to become empty and restore the IER */
>> -     wait_for_xmitr(port);
>
> This wait_for_xmitr() change needs to be in patch 2/2.
>


Why?

We no longer restore the IER.
We no longer have to wait here, either.



-- 
Best Regards
Masahiro Yamada
