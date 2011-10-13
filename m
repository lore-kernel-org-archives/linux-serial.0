From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] UART: add CSR SiRFprimaII SoC on-chip uart drivers
Date: Thu, 13 Oct 2011 21:45:26 +0800
Message-ID: <CAGsJ_4zvc=HaVURyARV0k6m7btfMjQo1frqmJa-OtE--eyCsFA@mail.gmail.com>
References: <1318487293-6963-1-git-send-email-Barry.Song@csr.com> <20111013105556.09d64d4d@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53269 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812Ab1JMNpr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Oct 2011 09:45:47 -0400
Received: by bkbzt4 with SMTP id zt4so1461619bkb.19
        for <linux-serial@vger.kernel.org>; Thu, 13 Oct 2011 06:45:46 -0700 (PDT)
In-Reply-To: <20111013105556.09d64d4d@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Barry Song <Barry.Song@csr.com>, Rong Wang <Rong.Wang@csr.com>, Bin Shi <Bin.Shi@csr.com>, Linus Walleij <linus.walleij@linaro.org>, workgroup.linux@csr.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Alan,
Thanks for your quick feedback.

2011/10/13 Alan Cox <alan@linux.intel.com>:
> Looks basically ok but somewhat outdated for the tty layer. In
> particular it needs to be aware of the refcounting on tty objects and
> of the fact we allow arbitary baud rate handling
>
>> +static struct sirfsoc_baudrate_to_regv baudrate_to_regv[] =3D {
>
> const

agree

>
>> +static unsigned int
>> +sirfsoc_uart_pio_rx_chars(struct uart_port *port, unsigned int
>> max_rx_count) +{
>> + =C2=A0 =C2=A0 unsigned int ch, rx_count =3D 0;
>> + =C2=A0 =C2=A0 int temp;
>> + =C2=A0 =C2=A0 struct tty_struct *tty =3D port->state->port.tty;
>
> tty =3D tty_port_tty_get(&port->state->port);
>
> [the newer tty code is refcounting, also tty can be NULL here and nee=
ds
> h handling accordingly]

agree

>
>> + =C2=A0 =C2=A0 while (!(rd_regl(port, SIRFUART_RX_FIFO_STATUS) &
>> +
>> SIRFUART_FIFOEMPTY_MASK(port))) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 temp =3D
>> tty_buffer_request_room(port->state->port.tty, 1);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(temp =3D=3D=
 0)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 port->icount.buf_overrun++;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 break;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> You don't need to do this - just uart_insert_char. If we run out of m=
id
> layer buffering it's not a port overrun as such (ie a fifo exceeded)
> it's a system wide memory crunch and something pretty serious and
> bigger is going on.
>
>> + =C2=A0 =C2=A0 port->icount.rx +=3D rx_count;
>> + =C2=A0 =C2=A0 tty_flip_buffer_push(tty);
>
> [Do these only if tty !=3D NULL obviously)
>
> and
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tty_kref_put(tty);
>
agree

>
>
>> +static void sirfsoc_uart_set_termios(struct uart_port *port,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct kterm=
ios *termios,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct kterm=
ios *old)
>> +{
>
> If you don't support CMSPAR then clear the bit in the passed termios.

actually it is supported if you read codes again.

>
>> + =C2=A0 =C2=A0 for (ic =3D 0; ic < SIRFUART_BAUD_RATE_SUPPORT_NR; i=
c++)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (baud_rate =3D=3D bau=
drate_to_regv[ic].baud_rate)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 clk_div_reg =3D baudrate_to_regv[ic].reg_val;
>> + =C2=A0 =C2=A0 if (clk_div_reg =3D=3D 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("SiRF UART: Canno=
t set Baud Rate (9600 ~
>> 4000000).\n");
>
> The baud rate is not guaranteed to be one the Bxxxxx values, you shou=
ld
> be computing it not using a table.

Rong has changed it to contain both Bxxx table and non-Bxxx
calculation. For Bxxx values, get set from table.
otherwise, calculate.

> Also the pr_err means any user can fill the logs with junk.
>
> The correct behaviour here is
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0compute the best timing for the baud rate =
requested
> =C2=A0 =C2=A0 =C2=A0 =C2=A0compute the actual baud rate obtained
>
> then report it back to the caller
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tty_termios_baud_rate(termios))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tty_termios_en=
code_baud_rate(termios, baud. baud);

agree

>
> The above assuming you set the same input and output rate
>
>
>
>> +static struct console sirfsoc_uart_console =3D {
>> + =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "ttyS",
>
> ttyS is 8250 devces. Pick a new name for your own.

ok. most devices have names like ttySQ, ttySA, ttySG... since our SoC
is named SiRFprimaII, i'd like to have ttySI?

>
>>
>> + =C2=A0 =C2=A0 .dev_name =C2=A0 =C2=A0 =C2=A0 =3D SIRFSOC_UART_NAME=
,
>> + =C2=A0 =C2=A0 .major =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D SIRFSOC=
_UART_MAJOR,
>> + =C2=A0 =C2=A0 .minor =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D SIRFSOC=
_UART_MINOR,
>
> Use dynamic allocations
>
>
>> +#define SIRFSOC_UART_NAME =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0"ttyS"
>> +#define SIRFSOC_UART_MAJOR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TTY_MAJOR
>> +#define SIRFSOC_UART_MINOR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 64
>
> These values belong to an existing inerface, don't reuse the names li=
ke
> that, and please use dynamic allocation for the numbers

agree

>
>> +#define uart_tx_port_tty_invalid(port) =C2=A0 \
>> + =C2=A0 =C2=A0 (((port)->state =3D=3D NULL) || ((port)->state->port=
=2Etty =3D=3D
>> NULL))
>
> This has no locking so little meaning - what guarantees it doesn't
> change =C2=A0under or after the call. I suspect you want to be checki=
ng and
> referencing the tty in one shot as in the example I gave above for th=
e
> rx fix.

agree.

-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
