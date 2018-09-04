From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH 4/5] serial: sprd: Change 'int' to 'unsigned int'
Date: Tue, 4 Sep 2018 14:55:39 +0800
Message-ID: <CAAfSe-uuYbF+4cxvJNxsazDVhF4LKFLBCzWzkp6GKjCmyKc80A@mail.gmail.com>
References: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
 <59172367ea674d5d4a3bd7c4d52362445174536e.1533950271.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <59172367ea674d5d4a3bd7c4d52362445174536e.1533950271.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, Orson Zhai <orsonzhai@gmail.com>, Mark Brown <broonie@kernel.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 11 August 2018 at 09:34, Baolin Wang <baolin.wang@linaro.org> wrote:
> The register offset value should be 'unsigned int' type.
>
> Moreover, prefer 'unsigned int' to bare use of 'unsigned'.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>

> ---
>  drivers/tty/serial/sprd_serial.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 03b0cd4..8d5c9cd 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -109,12 +109,14 @@ struct sprd_uart_port {
>  static struct sprd_uart_port *sprd_port[UART_NR_MAX];
>  static int sprd_ports_num;
>
> -static inline unsigned int serial_in(struct uart_port *port, int offset)
> +static inline unsigned int serial_in(struct uart_port *port,
> +                                    unsigned int offset)
>  {
>         return readl_relaxed(port->membase + offset);
>  }
>
> -static inline void serial_out(struct uart_port *port, int offset, int value)
> +static inline void serial_out(struct uart_port *port, unsigned int offset,
> +                             int value)
>  {
>         writel_relaxed(value, port->membase + offset);
>  }
> @@ -598,8 +600,7 @@ static void sprd_putc(struct uart_port *port, int c)
>         writeb(c, port->membase + SPRD_TXD);
>  }
>
> -static void sprd_early_write(struct console *con, const char *s,
> -                                   unsigned n)
> +static void sprd_early_write(struct console *con, const char *s, unsigned int n)
>  {
>         struct earlycon_device *dev = con->data;
>
> --
> 1.9.1
>
