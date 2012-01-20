From: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] serial: trivial checkpatch fixes in drivers/tty/serial/8250.c
Date: Thu, 19 Jan 2012 16:23:41 -0800
Message-ID: <CAPnjgZ2MhDrUAbafRTuH=gEddTj7EiChe2tBdMvnL2avsbuNUA@mail.gmail.com>
References: <1327001868-29941-1-git-send-email-sjg@chromium.org>
	<1327002594.6404.27.camel@joe2Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:47698 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757390Ab2ATAXm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 19 Jan 2012 19:23:42 -0500
Received: by obcva7 with SMTP id va7so40787obc.19
        for <linux-serial@vger.kernel.org>; Thu, 19 Jan 2012 16:23:41 -0800 (PST)
In-Reply-To: <1327002594.6404.27.camel@joe2Laptop>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <trivial@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org

Hi Joe,

On Thu, Jan 19, 2012 at 11:49 AM, Joe Perches <joe@perches.com> wrote:
> On Thu, 2012-01-19 at 11:37 -0800, Simon Glass wrote:
>> This makes the file checkpatch clean, fixing these warnings:
>
> Some comments...

Thanks for the comments - all addressed I think. Will send a V2.

Regards,
Simon

>
>> This warning remains, since I am not sure how to fix it:
>> error: drivers/tty/serial/8250.c,2929: Macros with complex values sh=
ould
>> =A0 =A0 =A0 be enclosed in parenthesis
>
> you can ignore this warning.
>
>> diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
> []
>> @@ -669,7 +669,8 @@ static void disable_rsa(struct uart_8250_port *u=
p)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D !(mode & UART_RSA_MSR_FIFO);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!result) {
>> -
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_outp(up, UART_RSA=
_MSR, mode & ~UART_RSA_MSR_FIFO);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_outp(up, UART_RSA_M=
SR, mode
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 & ~UART_RSA_MSR_FIFO);
>
> If it's really necessary to use 80 columns,
> I'd prefer this sort of change be:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_outp(up, UART_R=
SA_MSR,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
mode & ~UART_RSA_MSR_FIFO);
>
> []
>> @@ -2006,7 +2010,8 @@ static int serial8250_startup(struct uart_port=
 *port)
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 if (!(up->port.flags & UPF_BUGGY_UART) &&
>> =A0 =A0 =A0 =A0 =A0 (serial_inp(up, UART_LSR) =3D=3D 0xff)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 printk_ratelimited(KERN_INFO "ttyS%d: LSR =
safety check engaged!\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk_ratelimited(KERN_INFO
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_info_ratelimited()
>
>
>> @@ -2019,10 +2024,13 @@ static int serial8250_startup(struct uart_po=
rt *port)
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_outp(up, UART_LCR, UART_LCR_CONF_=
MODE_B);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 fctr =3D serial_inp(up, UART_FCTR) & ~(UAR=
T_FCTR_RX|UART_FCTR_TX);
>> - =A0 =A0 =A0 =A0 =A0 =A0 serial_outp(up, UART_FCTR, fctr | UART_FCT=
R_TRGD | UART_FCTR_RX);
>> + =A0 =A0 =A0 =A0 =A0 =A0 fctr =3D serial_inp(up, UART_FCTR) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ~(UART=
_FCTR_RX | UART_FCTR_TX);
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_outp(up, UART_FCTR, fctr | UART_FCT=
R_TRGD |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 UART_FCTR_RX);
>
> I think it's better to have all the or's
> on the same line where possible.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_outp(up, UART_FCTR,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fctr | UART_FC=
TR_TRGD | UART_FCTR_RX);
>
>
>> @@ -3130,7 +3139,8 @@ static struct platform_device *serial8250_isa_=
devs;
>> =A0 */
>> =A0static DEFINE_MUTEX(serial_mutex);
>>
>> -static struct uart_8250_port *serial8250_find_match_or_unused(struc=
t uart_port *port)
>> +static struct uart_8250_port *serial8250_find_match_or_unused(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 struct uart_port *port)
>
> It might be better to use
>
> static struct uart_8250_port *
> serial8250_find_match_or_unused(struct uart_port *port)
> {
>> @ -3345,10 +3352,12 @@ MODULE_PARM_DESC(share_irqs, "Share IRQs with=
 other non-8250/16x50 devices"
>> =A0 =A0 =A0 " (unsafe)");
>>
>> =A0module_param(nr_uarts, uint, 0644);
>> -MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported. (1-"=
 __MODULE_STRING(CONFIG_SERIAL_8250_NR_UARTS) ")");
>> +MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported. (1-"=
 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0__MODULE_STRING(CONFIG_SERIAL_8250_NR_U=
ARTS) ")");
>
> Broken.
>
> Don't use line continuations with whitespace on the next line.
> Better not use line continations at all except in #defines
>
>
>> =A0module_param(skip_txen_test, uint, 0644);
>> -MODULE_PARM_DESC(skip_txen_test, "Skip checking for the TXEN bug at=
 init time");
>> +MODULE_PARM_DESC(skip_txen_test, \
>> + =A0 =A0 =A0 =A0 =A0 =A0 "Skip checking for the TXEN bug at init ti=
me");
>
> Useless line continuation.
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
