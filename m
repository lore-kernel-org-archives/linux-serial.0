From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [RFC PATCH] always probe UART HW when options are not specified
Date: Mon, 11 Jan 2016 12:21:05 -0800
Message-ID: <56940EB1.40705@hurleysoftware.com>
References: <5672D18E.8000301@laposte.net>
 <5672E2CF.6080705@hurleysoftware.com> <5672E76A.3010506@laposte.net>
 <5672F588.8070503@hurleysoftware.com> <5672FD35.5070609@laposte.net>
 <56731689.70702@hurleysoftware.com> <56740FC3.50302@laposte.net>
 <5674204C.1000907@hurleysoftware.com> <56782DE5.7090708@laposte.net>
 <56798EC7.1030804@laposte.net> <5693C52B.90003@laposte.net>
 <5693D41E.8050601@hurleysoftware.com> <5693ECBA.50003@laposte.net>
 <5693FD3C.5080601@hurleysoftware.com> <56940936.6050807@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56940936.6050807@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Frias <sf84@laposte.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, mason <slash.tmp@free.fr>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
List-Id: linux-serial@vger.kernel.org

On 01/11/2016 11:57 AM, Peter Hurley wrote:
> On 01/11/2016 11:06 AM, Peter Hurley wrote:
>> On 01/11/2016 09:56 AM, Sebastian Frias wrote:
>>> On 01/11/2016 05:11 PM, Peter Hurley wrote:
>>>> On 01/11/2016 07:07 AM, Sebastian Frias wrote:
>>>>> On 12/22/2015 06:56 PM, Sebastian Frias wrote:
> 
> [...]
> 
>>> 2) What would it take to make the "rt2880" work with the 8250
>>> earlycon? I mean, it is already pretty much supported in there, what
>>> would be missing? (I don't see why it blocks on earlycon_map) And
>>> would it be worth doing?
>>
>> The rt2880 does not have the same register locations as a 8250.
>> The 8250 port driver remaps all register accesses with a LUT.
>>
>> Adding support would be trivial.
> 
> Please test.

To get this working with DT, you may need to apply part or all of
my "Earlycon cleanup" series from Apr last year that adds the 
necessary support for things like "reg-shift" DT properties.

I'll see what I can do about cleaning up and re-submitting that series.

Regards,
Peter Hurley


> --- >% ---
> Subject: [PATCH] serial: 8250: Add Au1x00/RT288x earlycon support
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  drivers/tty/serial/8250/8250_early.c | 52 ++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/serial_reg.h      | 13 +++++++++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
> index af62131..307fb23 100644
> --- a/drivers/tty/serial/8250/8250_early.c
> +++ b/drivers/tty/serial/8250/8250_early.c
> @@ -145,3 +145,55 @@ EARLYCON_DECLARE(uart8250, early_serial8250_setup);
>  EARLYCON_DECLARE(uart, early_serial8250_setup);
>  OF_EARLYCON_DECLARE(ns16550, "ns16550", early_serial8250_setup);
>  OF_EARLYCON_DECLARE(ns16550a, "ns16550a", early_serial8250_setup);
> +
> +
> +#ifdef CONFIG_SERIAL_8250_RT288X
> +
> +static void __init rt288x_putc(struct uart_port *port, int c)
> +{
> +	unsigned int status;
> +
> +	serial8250_early_out(port, AU1x00_TX, c);
> +
> +	for (;;) {
> +		status = serial8250_early_in(port, AU1x00_LSR);
> +		if ((status & BOTH_EMPTY) == BOTH_EMPTY)
> +			break;
> +		cpu_relax();
> +	}
> +}
> +
> +static void __init early_rt288x_write(struct console *console,
> +				      const char *s, unsigned int count)
> +{
> +	struct earlycon_device *device = console->data;
> +	struct uart_port *port = &device->port;
> +
> +	uart_console_write(port, s, count, rt288x_putc);
> +}
> +
> +static int __init early_rt288x_setup(struct earlycon_device *device,
> +				     const char *options)
> +{
> +	struct uart_port *port = &device->port;
> +	unsigned int ier;
> +
> +	if (!(device->port.membase || device->port.iobase))
> +		return -ENODEV;
> +
> +	/* Don't support direct init or any line-setting options */
> +	if (device->baud)
> +		return -EINVAL;
> +
> +	/* assume the device was initialized, only mask interrupts */
> +	ier = serial8250_early_in(port, AU1x00_IER);
> +	serial8250_early_out(port, AU1x00_IER, ier);
> +
> +	device->con->write = early_rt288x_write;
> +	return 0;
> +}
> +
> +EARLYCON_DECLARE(rt288x, early_rt288x_setup);
> +OF_EARLYCON_DECLARE(rt288x, "ralink,rt2880-uart", early_rt288x_setup);
> +
> +#endif /* CONFIG_SERIAL_8250_RT288X */
> diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
> index 1e5ac4e7..4d068ac 100644
> --- a/include/uapi/linux/serial_reg.h
> +++ b/include/uapi/linux/serial_reg.h
> @@ -376,5 +376,18 @@
>  #define UART_EXAR_TXTRG		0x0a	/* Tx FIFO trigger level write-only */
>  #define UART_EXAR_RXTRG		0x0b	/* Rx FIFO trigger level write-only */
>  
> +/*
> + * Register offsets for Au1x00/RT288x 8250-workalikes
> + */
> +#define AU1x00_RX	0
> +#define AU1x00_TX	1
> +#define AU1x00_IER	2
> +#define AU1x00_IIR	3
> +#define AU1x00_FCR	4
> +#define AU1x00_LCR	5
> +#define AU1x00_MCR	6
> +#define AU1x00_LSR	7
> +#define AU1x00_MSR	8
> +
>  #endif /* _LINUX_SERIAL_REG_H */
>  
> 
