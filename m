From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH linux-next 1/1] tty/serial: at91: fix I/O accesses on
 RHR and THR for AVR32
Date: Fri, 31 Jul 2015 09:03:20 +0200
Message-ID: <55BB1DB8.4010601@atmel.com>
References: <b950edd352e715d7f1f0d5ca4856ae4fec56890f.1438260564.git.cyrille.pitchen@atmel.com> <20150730174605.GE27985@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150730174605.GE27985@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, egtvedt@samfundet.no, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Le 30/07/2015 19:46, Alexandre Belloni a =E9crit :
> On 30/07/2015 at 16:33:38 +0200, Cyrille Pitchen wrote :
>> This patch fixes I/O accesses on the Receiver Holding Register and o=
n the
>> Transmitter Holding Register. Indeed AVR32 can only perform 32bit I/=
O
>> accesses on registers: using 8bit I/O accesses would read or write g=
arbage
>> data.
>>
>> Fixes: commit b5199d468177 ("tty/serial: at91: add support to FIFOs"=
)
>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>=20
> Also, tested on at91rm9200ek.

Great! thanks Alexandre.


>> ---
>> Hi all,
>>
>> this patch fixes a bug on AVR32 introduced by the support of FIFOs f=
or
>> AT91. Indeed when FIFOs are enabled they work in Multiple Data mode.
>> The Multiple Data mode allows to read up to 4 data from the Receiver
>> Holding Register (RHR) or write up to 4 data into the Transmitter Ho=
lding
>> Register (THR) in a single I/O access. Hence when only one data is t=
o be
>> read from the RHR or written into the THR, the driver cannot use 32b=
it I/O
>> access anymore but must use 8bit I/O access instead.
>>
>> For ARM-base AT91 SoCs, 8bit I/O accesses can always be used even wh=
en
>> FIFOs are not available. However AV32 can only use 32bit I/O accesse=
s.
>>
>> Since atmel_uart_readb(), resp. atmel_uart_writeb(), was created by =
the
>> FIFO support patch to access the RHR, resp. the THR, this patch repl=
aces
>> it by atmel_uart_read_char(), resp. atmel_uart_write_char(). Hence t=
he
>> actual width of the I/O access now depends only on the architecture.
>>
>> All registers but RHR and THR use 32bit I/O accesses.
>>
>> This patch was tested on a at91sam9260ek board.
>>
>> Best Regards,
>>
>> Cyrille
>>
>> ChangeLog:
>>
>> v1: initial version
>>
>>  drivers/tty/serial/atmel_serial.c | 37 +++++++++++++++++++++++++++-=
---------
>>  1 file changed, 27 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/=
atmel_serial.c
>> index e91b3b2f0590..5ca5cf3e9359 100644
>> --- a/drivers/tty/serial/atmel_serial.c
>> +++ b/drivers/tty/serial/atmel_serial.c
>> @@ -204,16 +204,33 @@ static inline void atmel_uart_writel(struct ua=
rt_port *port, u32 reg, u32 value)
>>  	__raw_writel(value, port->membase + reg);
>>  }
>> =20
>> -static inline u8 atmel_uart_readb(struct uart_port *port, u32 reg)
>> +#ifdef CONFIG_AVR32
>> +
>> +/* AVR32 cannot handle 8 or 16bit I/O accesses but only 32bit I/O a=
ccesses */
>> +static inline u8 atmel_uart_read_char(struct uart_port *port)
>> +{
>> +	return __raw_readl(port->membase + ATMEL_US_RHR);
>> +}
>> +
>> +static inline void atmel_uart_write_char(struct uart_port *port, u8=
 value)
>>  {
>> -	return __raw_readb(port->membase + reg);
>> +	__raw_writel(value, port->membase + ATMEL_US_THR);
>>  }
>> =20
>> -static inline void atmel_uart_writeb(struct uart_port *port, u32 re=
g, u8 value)
>> +#else
>> +
>> +static inline u8 atmel_uart_read_char(struct uart_port *port)
>>  {
>> -	__raw_writeb(value, port->membase + reg);
>> +	return __raw_readb(port->membase + ATMEL_US_RHR);
>>  }
>> =20
>> +static inline void atmel_uart_write_char(struct uart_port *port, u8=
 value)
>> +{
>> +	__raw_writeb(value, port->membase + ATMEL_US_THR);
>> +}
>> +
>> +#endif
>> +
>>  #ifdef CONFIG_SERIAL_ATMEL_PDC
>>  static bool atmel_use_pdc_rx(struct uart_port *port)
>>  {
>> @@ -658,7 +675,7 @@ static void atmel_rx_chars(struct uart_port *por=
t)
>> =20
>>  	status =3D atmel_uart_readl(port, ATMEL_US_CSR);
>>  	while (status & ATMEL_US_RXRDY) {
>> -		ch =3D atmel_uart_readb(port, ATMEL_US_RHR);
>> +		ch =3D atmel_uart_read_char(port);
>> =20
>>  		/*
>>  		 * note that the error handling code is
>> @@ -709,7 +726,7 @@ static void atmel_tx_chars(struct uart_port *por=
t)
>> =20
>>  	if (port->x_char &&
>>  	    (atmel_uart_readl(port, ATMEL_US_CSR) & atmel_port->tx_done_ma=
sk)) {
>> -		atmel_uart_writeb(port, ATMEL_US_THR, port->x_char);
>> +		atmel_uart_write_char(port, port->x_char);
>>  		port->icount.tx++;
>>  		port->x_char =3D 0;
>>  	}
>> @@ -718,7 +735,7 @@ static void atmel_tx_chars(struct uart_port *por=
t)
>> =20
>>  	while (atmel_uart_readl(port, ATMEL_US_CSR) &
>>  	       atmel_port->tx_done_mask) {
>> -		atmel_uart_writeb(port, ATMEL_US_THR, xmit->buf[xmit->tail]);
>> +		atmel_uart_write_char(port, xmit->buf[xmit->tail]);
>>  		xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
>>  		port->icount.tx++;
>>  		if (uart_circ_empty(xmit))
>> @@ -2294,7 +2311,7 @@ static int atmel_poll_get_char(struct uart_por=
t *port)
>>  	while (!(atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_RXRDY))
>>  		cpu_relax();
>> =20
>> -	return atmel_uart_readb(port, ATMEL_US_RHR);
>> +	return atmel_uart_read_char(port);
>>  }
>> =20
>>  static void atmel_poll_put_char(struct uart_port *port, unsigned ch=
ar ch)
>> @@ -2302,7 +2319,7 @@ static void atmel_poll_put_char(struct uart_po=
rt *port, unsigned char ch)
>>  	while (!(atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY))
>>  		cpu_relax();
>> =20
>> -	atmel_uart_writeb(port, ATMEL_US_THR, ch);
>> +	atmel_uart_write_char(port, ch);
>>  }
>>  #endif
>> =20
>> @@ -2409,7 +2426,7 @@ static void atmel_console_putchar(struct uart_=
port *port, int ch)
>>  {
>>  	while (!(atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY))
>>  		cpu_relax();
>> -	atmel_uart_writeb(port, ATMEL_US_THR, ch);
>> +	atmel_uart_write_char(port, ch);
>>  }
>> =20
>>  /*
>> --=20
>> 1.8.2.2
>>
>=20


--=20
Nicolas Ferre
