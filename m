From: Paul Schilling <paul.s.schilling@gmail.com>
Subject: Re: [PATCH 02/14] ARM : SAMSUNG : Add RS485 support.
Date: Sun, 23 Oct 2011 12:12:13 -0500
Message-ID: <CAC=G6syuf-J4am1mHRg-5gzqy661yOT9pUK2vQyToLPtv4tvEg@mail.gmail.com>
References: <1319255194-4799-1-git-send-email-paul.s.schilling@gmail.com>
	<20111022134726.GD21374@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47294 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab1JWRMQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 23 Oct 2011 13:12:16 -0400
In-Reply-To: <20111022134726.GD21374@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Boojin Kim <boojin.kim@samsung.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

See Comments inline.

On Sat, Oct 22, 2011 at 8:47 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Oct 21, 2011 at 10:46:34PM -0500, Paul Schilling wrote:
>> +config SAMSUNG_HAS_RS485
>> + =A0 =A0 bool "Enable RS485 support for Samsung"
>> + =A0 =A0 depends on SERIAL_SAMSUNG && (MACH_CONDOR2440 || MACH_COND=
OR2416 || MACH_MINI2440)
>> + =A0 =A0 default y if (MACH_CONDOR2440 || MACH_CONDOR2416)
>> + =A0 =A0 default n if (MACH_MINI2440)
>> +
>> +config SAMSUNG_485_LOW_RES_TIMER
>> + =A0 =A0bool "Samsung RS-485 use low res timer during transmit"
>> + =A0 =A0depends on SERIAL_SAMSUNG && SAMSUNG_HAS_RS485
>> + =A0 =A0default n
>
> n is the default, so this doesn't need to be specified.

Sorry I can fix that.

>
>> +static void s3c24xx_serial_rx_fifo_enable(
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct uart_port *port,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int en)
>> +{
>> + =A0 =A0 unsigned long flags;
>> + =A0 =A0 unsigned int ucon;
>> + =A0 =A0 static unsigned int last_state =3D 1;
>> +/* FIXME */
>> + =A0 =A0 #if 0
>> + =A0 =A0 if (last_state !=3D en) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct s3c2410_uartcfg *cfg =3D s3c24xx_po=
rt_to_cfg(port);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&port->lock, flags);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ucon =3D rd_regl(port, S3C2410_UCON);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ucon &=3D ~(S3C2440_UFCON_RXTRIG32 | S3C24=
10_UCON_RXILEVEL);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (en) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucon |=3D cfg->ucon;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 wr_regl(port, S3C2410_UCON, ucon);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&port->lock, flags)=
;
>> + =A0 =A0 }
>> +#endif
>
> This looks like dead code.

It is broken dead code.  Performance of the RS485 code could be
increased if this code could be made to work.
right now I am forced to leave it in one character per interrupt so
that each character that's received is checked
against the token.  This code was supposed leave it in multi-byte FIFO
mode until the token byte is sent then switch to receiving
one byte at a time until the token is received.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set a short timer to to=
ggle RTS */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mod_timer(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 &(ourport->rs485_tx_timer),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 jiffies + usecs_to_jiffies(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ourport->char_time_usec
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 / 10));
>
> This could do with being better formatted. =A0Also, & doesn't need fo=
llowing
> parens.

when I ran checkpatch it complained that it exceeded 80 characters.  I
had trouble keeping this line
under 80 characters.

>
>> + =A0 =A0 /* Read UART transmit status register */
>> + =A0 =A0 utrstat =3D rd_regl(&(ourport->port), S3C2410_UTRSTAT);
>
> Doesn't need the parens.

I can remove the extra parentheses.

>
>> +/* Callback array*/
>> +enum hrtimer_restart (*callback_list[CONFIG_SERIAL_SAMSUNG_UARTS])(=
struct hrtimer *) =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 &rs485_hr_timer_callback_uart0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 &rs485_hr_timer_callback_uart1,
>> +
>> +#if CONFIG_SERIAL_SAMSUNG_UARTS > 2
>> + =A0 =A0 =A0 =A0 =A0 =A0 &rs485_hr_timer_callback_uart2,
>> +#endif
>> +
>> +#if CONFIG_SERIAL_SAMSUNG_UARTS > 3
>> + =A0 =A0 =A0 =A0 =A0 =A0 &rs485_hr_timer_callback_uart3,
>> +#endif
>
> Silly indentation - this doesn't need two tabs.
>
>> +};
>> +
>> +#endif
>> +#endif /* CONFIG_SAMSUNG_HAS_RS485 */
>> +
>> +
>> =A0static void s3c24xx_serial_stop_tx(struct uart_port *port)
>> =A0{
>> =A0 =A0 =A0 struct s3c24xx_uart_port *ourport =3D to_ourport(port);
>>
>> =A0 =A0 =A0 if (tx_enabled(port)) {
>> +#ifdef CONFIG_SAMSUNG_HAS_RS485
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ourport->rs485.flags & SER_RS485_ENABL=
ED) {
>> +#ifdef CONFIG_SAMSUNG_485_LOW_RES_TIMER
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set a short timer to to=
ggle RTS */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mod_timer(&(ourport->rs485=
_tx_timer),
>
> Doesn't need parens.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 jiffies + usecs_to_jiffies(ourport->char_time_usec * s3c24xx_seria=
l_tx_getfifocnt(ourport)));
>> +#else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ktime_t kt;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set time struct to one =
char time. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kt =3D ktime_set(0, ourpor=
t->char_time_nanosec);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Start the high res time=
r. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hrtimer_start(&(ourport->h=
r_rs485_tx_timer), kt, HRTIMER_MODE_REL);
>
> Doesn't need parens.
>
>> +#endif /* CONFIG_SAMSUNG_485_LOW_RES_TIMER */
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c24xx_serial_rx_fifo_ena=
ble(port, 0);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +#endif /* CONFIG_SAMSUNG_HAS_RS485 */
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_irq_nosync(ourport->tx_irq);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_enabled(port) =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (port->flags & UPF_CONS_FLOW)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (port->flags & UPF_CONS_FLOW) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c24xx_serial_rx_enable=
(port);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>
> Why are you reformatting code?

I will remove the reformatting of the code.

>
>> @@ -785,7 +1177,7 @@ static void s3c24xx_serial_set_termios(struct u=
art_port *port,
>> =A0 =A0 =A0 port->ignore_status_mask =3D 0;
>> =A0 =A0 =A0 if (termios->c_iflag & IGNPAR)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->ignore_status_mask |=3D S3C2410_UE=
RSTAT_OVERRUN;
>> - =A0 =A0 if (termios->c_iflag & IGNBRK && termios->c_iflag & IGNPAR=
)
>> + =A0 =A0 if ((termios->c_iflag & IGNBRK) && (termios->c_iflag & IGN=
PAR))
>
> More code reformatting.
>
>> @@ -830,7 +1228,7 @@ static void s3c24xx_serial_config_port(struct u=
art_port *port, int flags)
>> =A0{
>> =A0 =A0 =A0 struct s3c24xx_uart_info *info =3D s3c24xx_port_to_info(=
port);
>>
>> - =A0 =A0 if (flags & UART_CONFIG_TYPE &&
>> + =A0 =A0 if ((flags & UART_CONFIG_TYPE) &&
>
> And some more.
>
>> +#if 0
>> + =A0 =A0 dev_info(port., "rts: on send =3D %i, after =3D %i, enable=
d =3D %i",
>
> That can't be correct - and as its #if 0'd out, either remove this or
> fix it to be correct (and use dev_dbg if you want it to be debugging.=
)
>
>> +static ssize_t s3c24xx_serial_set_485_mode(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, size_t count)
>> +
>> +{
>> + =A0 =A0 struct uart_port *port =3D s3c24xx_dev_to_port(dev);
>> + =A0 =A0 struct s3c24xx_uart_port *ourport =3D to_ourport(port);
>> +
>> + =A0 =A0 if (!strncmp(buf, "Enabled", 7)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ourport->rs485.flags |=3D SER_RS485_ENABLE=
D;
>> + =A0 =A0 } else if (!strncmp(buf, "Disabled", 8)) {
>
> Do you really require the first character to be capitalized?
>
>> +#ifdef CONFIG_SAMSUNG_HAS_RS485
>> +
>> + =A0 =A0 ret =3D device_create_file(&dev->dev, &dev_attr_485_status=
);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: failed to add 485 sta=
tus attr.\n", __func__);
>
> pr_err() ? =A0dev_err() ?
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
