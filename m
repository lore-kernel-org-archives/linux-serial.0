From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6/9] drivers: tty: 68328serial.c: Use tabs for indentation
Date: Sat, 12 Dec 2015 23:08:00 -0800
Message-ID: <20151213070800.GA3832@kroah.com>
References: <1449830170-15096-1-git-send-email-frederik.voelkel@fau.de>
 <1449830170-15096-7-git-send-email-frederik.voelkel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449830170-15096-7-git-send-email-frederik.voelkel@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Frederik =?iso-8859-1?Q?V=F6lkel?= <frederik.voelkel@fau.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, linux-kernel@i4.cs.fau.de, Lukas Braun <lukas.braun@fau.de>
List-Id: linux-serial@vger.kernel.org

On Fri, Dec 11, 2015 at 11:36:06AM +0100, Frederik V=F6lkel wrote:
> The patch replaces the spaces used for indentation at some points wit=
h
> tabs.
>=20
> Signed-off-by: Frederik V=F6lkel <frederik.voelkel@fau.de>
> Signed-off-by: Lukas Braun <lukas.braun@fau.de>
> ---
>  drivers/tty/serial/68328serial.c | 82 ++++++++++++++++++++----------=
----------
>  1 file changed, 41 insertions(+), 41 deletions(-)
>=20
> diff --git a/drivers/tty/serial/68328serial.c b/drivers/tty/serial/68=
328serial.c
> index 0982c1a..22f52e0 100644
> --- a/drivers/tty/serial/68328serial.c
> +++ b/drivers/tty/serial/68328serial.c
> @@ -228,17 +228,17 @@ static int rs_put_char(char ch)
>  	unsigned long flags;
>  	int loops =3D 0;
> =20
> -        local_irq_save(flags);
> +	local_irq_save(flags);
> =20
>  	while (!(UTX & UTX_TX_AVAIL) && (loops < 1000)) {
> -        	loops++;
> -        	udelay(5);
> -        }
> +		loops++;
> +		udelay(5);
> +	}
> =20
>  	UTX_TXDATA =3D ch;
> -        udelay(5);
> -        local_irq_restore(flags);
> -        return 1;
> +	udelay(5);
> +	local_irq_restore(flags);
> +	return 1;
>  }
> =20
>  static void rs_start(struct tty_struct *tty)
> @@ -268,7 +268,7 @@ static void receive_chars(struct m68k_serial *inf=
o, unsigned short rx)
> =20
>  	/*
>  	 * This do { } while() loop will get ALL chars out of Rx FIFO=20
> -         */
> +	 */
>  #ifndef CONFIG_XCOPILOT_BUGS
>  	do {
>  #endif=09
> @@ -400,7 +400,7 @@ static int startup(struct m68k_serial *info, stru=
ct tty_struct *tty)
>  	 */
>  #ifdef USE_INTS
>  	uart->ustcnt =3D USTCNT_UEN | USTCNT_RXEN |=20
> -                 USTCNT_RX_INTR_MASK | USTCNT_TX_INTR_MASK;
> +		USTCNT_RX_INTR_MASK | USTCNT_TX_INTR_MASK;
>  #else
>  	uart->ustcnt =3D USTCNT_UEN | USTCNT_RXEN | USTCNT_RX_INTR_MASK;
>  #endif
> @@ -473,24 +473,24 @@ struct {
>  };
>  #else
>   hw_baud_table[18] =3D {
> -                 {0, 0}, /* 0 */
> -                 {0, 0}, /* 50 */
> -                 {0, 0}, /* 75 */
> -                 {0, 0}, /* 110 */
> -                 {0, 0}, /* 134 */
> -                 {0, 0}, /* 150 */
> -                 {0, 0}, /* 200 */
> -                 {0, 0}, /* 300 */
> -                 {7, 0x26}, /* 600 */
> -                 {6, 0x26}, /* 1200 */
> -                 {0, 0}, /* 1800 */
> -                 {5, 0x26}, /* 2400 */
> -                 {4, 0x26}, /* 4800 */
> -                 {3, 0x26}, /* 9600 */
> -                 {2, 0x26}, /* 19200 */
> -                 {1, 0x26}, /* 38400 */
> -                 {0, 0x26}, /* 57600 */
> -                 {1, 0x38}, /* 115200 */
> +	{0, 0}, /* 0 */
> +	{0, 0}, /* 50 */
> +	{0, 0}, /* 75 */
> +	{0, 0}, /* 110 */
> +	{0, 0}, /* 134 */
> +	{0, 0}, /* 150 */
> +	{0, 0}, /* 200 */
> +	{0, 0}, /* 300 */
> +	{7, 0x26}, /* 600 */
> +	{6, 0x26}, /* 1200 */
> +	{0, 0}, /* 1800 */
> +	{5, 0x26}, /* 2400 */
> +	{4, 0x26}, /* 4800 */
> +	{3, 0x26}, /* 9600 */
> +	{2, 0x26}, /* 19200 */
> +	{1, 0x26}, /* 38400 */
> +	{0, 0x26}, /* 57600 */
> +	{1, 0x38}, /* 115200 */
>  };=20
>  #endif
>  /* rate =3D 1036800 / ((65 - prescale) * (1<<divider)) */
> @@ -516,9 +516,9 @@ static void change_speed(struct m68k_serial *info=
, struct tty_struct *tty)
>  	uart->ustcnt =3D ustcnt & ~USTCNT_TXEN;
> =20
>  	i =3D cflag & CBAUD;
> -        if (i & CBAUDEX) {
> -                i =3D (i & ~CBAUDEX) + B38400;
> -        }
> +	if (i & CBAUDEX) {
> +		i =3D (i & ~CBAUDEX) + B38400;
> +	}
> =20
>  	uart->ubaud =3D PUT_FIELD(UBAUD_DIVIDE,    hw_baud_table[i].divisor=
) |=20
>  		PUT_FIELD(UBAUD_PRESCALER, hw_baud_table[i].prescale);
> @@ -907,16 +907,16 @@ static int get_lsr_info(struct m68k_serial *inf=
o, unsigned int *value)
>  static void send_break(struct m68k_serial *info, unsigned int durati=
on)
>  {
>  	m68328_uart *uart =3D &uart_addr[info->line];
> -        unsigned long flags;
> -        if (!info->port)
> -                return;
> -        local_irq_save(flags);
> +	unsigned long flags;
> +	if (!info->port)
> +		return;
> +	local_irq_save(flags);
>  #ifdef USE_INTS=09
>  	uart->utx.w |=3D UTX_SEND_BREAK;
>  	msleep_interruptible(duration);
>  	uart->utx.w &=3D ~UTX_SEND_BREAK;
>  #endif	=09
> -        local_irq_restore(flags);
> +	local_irq_restore(flags);
>  }
> =20
>  static int rs_ioctl(struct tty_struct *tty,
> @@ -1206,7 +1206,7 @@ rs68328_init(void)
>  			    rs_interrupt,
>  			    0,
>  			    "M68328_UART", info))
> -                panic("Unable to attach 68328 serial interrupt\n");
> +		panic("Unable to attach 68328 serial interrupt\n");
> =20
>  	    tty_port_link_device(&info->tport, serial_driver, i);
>  	}
> @@ -1295,11 +1295,11 @@ void m68328_console_write (struct console *co=
, const char *str,
>  {
>  	if (!m68328_console_initted)
>  		m68328_set_baud();
> -    while (count--) {
> -        if (*str =3D=3D '\n')
> -           rs_put_char('\r');
> -        rs_put_char(*str++);
> -    }
> +	while (count--) {
> +		if (*str =3D=3D '\n')
> +		    rs_put_char('\r');
> +	rs_put_char(*str++);

This line should also be indented one more tab, right?

> +	}

Please fix up and resend.

thanks,

greg k-h
