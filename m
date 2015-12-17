From: Sebastian Frias <sf84@laposte.net>
Subject: Re: [PATCH] use callbacks to access UART_DLL/UART_DLM
Date: Thu, 17 Dec 2015 19:07:05 +0100
Message-ID: <5672F9C9.1010601@laposte.net>
References: <5672D89A.4090307@laposte.net> <yw1xoadpcbbn.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <yw1xoadpcbbn.fsf@unicorn.mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?windows-1252?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <damm@opensource.se>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Mason <slash.tmp@free.fr>
List-Id: linux-serial@vger.kernel.org

On 12/17/2015 05:02 PM, M=E5ns Rullg=E5rd wrote:
> Sebastian Frias <sf84@laposte.net> writes:
>
>> ---
>> resending as plain-text
>> ---
>>    drivers/tty/serial/8250/8250_core.c |   17 +++++++----------
>>    1 file changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_core.c
>> b/drivers/tty/serial/8250/8250_core.c
>> index 2c46a21..9ca863c 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -791,22 +791,19 @@ static int size_fifo(struct uart_8250_port *up=
)
>>     */
>>    static unsigned int autoconfig_read_divisor_id(struct uart_8250_p=
ort *p)
>
> What tree are you working against?  Current mainline has that functio=
n
> in 8250_port.c.

Sorry, wrong patch. On mainline is about the same, I'll post it.

>
>>    {
>> -    unsigned char old_dll, old_dlm, old_lcr;
>> +    unsigned char old_lcr;
>>        unsigned int id;
>> +    unsigned int old_dl;
>
> Your patch is messed up.  Consider using "git send-email" instead.

I don't know what happened there, thanks for the suggestion.

>
>>        old_lcr =3D serial_in(p, UART_LCR);
>> -    serial_out(p, UART_LCR, UART_LCR_CONF_MODE_A);
>> -
>> -    old_dll =3D serial_in(p, UART_DLL);
>> -    old_dlm =3D serial_in(p, UART_DLM);
>>
>> -    serial_out(p, UART_DLL, 0);
>> -    serial_out(p, UART_DLM, 0);
>> +    serial_out(p, UART_LCR, UART_LCR_CONF_MODE_A);
>>
>> -    id =3D serial_in(p, UART_DLL) | serial_in(p, UART_DLM) << 8;
>> +    old_dl =3D serial_dl_read(p);
>> +    serial_dl_write(p, 0);
>> +    id =3D serial_dl_read(p);
>> +    serial_dl_write(p, old_dl);
>>
>> -    serial_out(p, UART_DLL, old_dll);
>> -    serial_out(p, UART_DLM, old_dlm);
>>        serial_out(p, UART_LCR, old_lcr);
>>
>>        return id;
>> --
>
> If you left the blank lines alone, the patch would end up much easier=
 to
> understand.  In this diff, some of the lines listed as added or remov=
ed
> have actually not changed, and that's not immediately obvious.
>

The old code had some blank lines, which I suppose were there for clari=
ty.
I attempted to follow the same idea.
But I don't mind changing the code as you wish.
