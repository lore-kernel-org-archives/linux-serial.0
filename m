From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [RFC PATCH] always probe UART HW when options are not specified
Date: Thu, 17 Dec 2015 08:29:03 -0800
Message-ID: <5672E2CF.6080705@hurleysoftware.com>
References: <5672D18E.8000301@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5672D18E.8000301@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Frias <sf84@laposte.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, mason <slash.tmp@free.fr>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
List-Id: linux-serial@vger.kernel.org

On 12/17/2015 07:15 AM, Sebastian Frias wrote:
> ---
> 
> I think there are a few minor bugs on the 8250 UART code.
> 
> Below you can find a patch with a proposed solution.
> 
> In a nutshell:
> - probe_baud from 87515772c33ee8a0cc08d984a7d2401eeff074cd was
> converted into probe_port so that it reads all the parameters that
> uart_set_options require (namely baud, parity, bits, flow).
> - reading/writing to UART_DLL/UART_DLM directly are converted to
> using the read_dl/write_dl callbacks.
> - the port is always probed if there are no options (*).

Because I don't want to probe the port at all.

But must when using the
	earlycon=ttyS0,....

command-line (because the original hack expects that behavior).

Regards,
Peter Hurley

> (*): I'm not sure why commit 87515772c33ee8a0cc08d984a7d2401eeff074cd
> makes a difference in that regard, especially considering the commit
> log states that if there are no options, the hardware is assumed to
> be already initialised. Since uart_set_options is always called, the
> current hardware setup could be overwritten with different parameters
> if the actual hardware is not probed.
> 
> ---
>  drivers/tty/serial/8250/8250_core.c |   84 ++++++++++++++++++++++++++---------
>  1 file changed, 63 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 2c46a21..624667f 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -791,22 +791,19 @@ static int size_fifo(struct uart_8250_port *up)
>   */
>  static unsigned int autoconfig_read_divisor_id(struct uart_8250_port *p)
>  {
> -    unsigned char old_dll, old_dlm, old_lcr;
> +    unsigned char old_lcr;
>      unsigned int id;
> +    unsigned int old_dl;
>  
>      old_lcr = serial_in(p, UART_LCR);
> -    serial_out(p, UART_LCR, UART_LCR_CONF_MODE_A);
> -
> -    old_dll = serial_in(p, UART_DLL);
> -    old_dlm = serial_in(p, UART_DLM);
>  
> -    serial_out(p, UART_DLL, 0);
> -    serial_out(p, UART_DLM, 0);
> +    serial_out(p, UART_LCR, UART_LCR_CONF_MODE_A);
>  
> -    id = serial_in(p, UART_DLL) | serial_in(p, UART_DLM) << 8;
> +    old_dl = serial_dl_read(p);
> +    serial_dl_write(p, 0);
> +    id = serial_dl_read(p);
> +    serial_dl_write(p, old_dl);
>  
> -    serial_out(p, UART_DLL, old_dll);
> -    serial_out(p, UART_DLM, old_dlm);
>      serial_out(p, UART_LCR, old_lcr);
>  
>      return id;
> @@ -3440,22 +3437,67 @@ static void univ8250_console_write(struct console *co, const char *s,
>      serial8250_console_write(up, s, count);
>  }
>  
> -static unsigned int probe_baud(struct uart_port *port)
> +static int probe_port(struct uart_port *port, int *parity, int *bits, int *flow)
>  {
> -    unsigned char lcr, dll, dlm;
> +    struct uart_8250_port *up = up_to_u8250p(port);
> +    unsigned char lcr, efr;
>      unsigned int quot;
>  
>      lcr = serial_port_in(port, UART_LCR);
>      serial_port_out(port, UART_LCR, lcr | UART_LCR_DLAB);
> -    dll = serial_port_in(port, UART_DLL);
> -    dlm = serial_port_in(port, UART_DLM);
> +    quot = serial_dl_read(up);
> +    serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
> +    if (port->flags & UPF_EXAR_EFR)
> +        efr = serial_port_in(port, UART_XR_EFR);
> +    else
> +        efr = serial_port_in(port, UART_EFR);
>      serial_port_out(port, UART_LCR, lcr);
>  
> -    quot = (dlm << 8) | dll;
> -    return (port->uartclk / 16) / quot;
> +//word length select mask
> +#define WLS_MASK (0x3)
> +//parity enable
> +#define PEN (0x8)
> +//even parity select
> +#define EPS (0x10)
> +
> +    switch (lcr & WLS_MASK) {
> +    case 0: // 5bits
> +    case 1: // 6bits
> +        // Not supported by drivers/tty/serial/serial_core.c:uart_set_options() anyway
> +        WARN(true, "%s: probed uart word length (%u bits) is not supported by uart_set_options()\n", __FUNCTION__, (lcr & WLS_MASK) ? 5 : 6 );
> +        break;
> +    case 2: // 7bits
> +        *bits = 7;
> +        break;
> +    case 3: // 8bits
> +        *bits = 8;
> +        break;
> +    };
> +
> +    if (lcr & PEN)
> +    {
> +        if (lcr & EPS)
> +            *parity = 'e';
> +        else
> +            *parity = 'o';
> +    }
> +    else
> +        *parity = 'n';
> +
> +    if (efr & UART_EFR_CTS)
> +        *flow = 'r';
> +    else
> +        *flow = 'n';
> +
> +    if (quot)
> +        return (port->uartclk / 16) / quot;
> +    else
> +        WARN(true, "%s: quot is zero!\n", __FUNCTION__);
> +
> +    return -1;
>  }
>  
> -static int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
> +static int serial8250_console_setup(struct uart_port *port, char *options)
>  {
>      int baud = 9600;
>      int bits = 8;
> @@ -3467,8 +3509,8 @@ static int serial8250_console_setup(struct uart_port *port, char *options, bool
>  
>      if (options)
>          uart_parse_options(options, &baud, &parity, &bits, &flow);
> -    else if (probe)
> -        baud = probe_baud(port);
> +    else
> +        baud = probe_port(port, &parity, &bits, &flow);
>  
>      return uart_set_options(port, port->cons, baud, parity, bits, flow);
>  }
> @@ -3488,7 +3530,7 @@ static int univ8250_console_setup(struct console *co, char *options)
>      /* link port to console */
>      port->cons = co;
>  
> -    return serial8250_console_setup(port, options, false);
> +    return serial8250_console_setup(port, options);
>  }
>  
>  /**
> @@ -3537,7 +3579,7 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
>  
>          co->index = i;
>          port->cons = co;
> -        return serial8250_console_setup(port, options, true);
> +        return serial8250_console_setup(port, options);
>      }
>  
>      return -ENODEV;
> -- 
> 1.7.10.4
> 
