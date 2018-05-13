From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 6/8] serial: Add Tegra Combined UART driver
Date: Sun, 13 May 2018 17:16:36 +0300
Message-ID: <CAHp75VfYF_u2bZ+temGbReEB9K-t3A75aUNYwffyv9-=zEi0Lw@mail.gmail.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com> <20180508114403.14499-7-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180508114403.14499-7-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jassi Brar <jassisinghbrar@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, araza@nvidia.com, devicetree <devicetree@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, linux-tegra@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, May 8, 2018 at 2:44 PM, Mikko Perttunen <mperttunen@nvidia.com> wrote:
> The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
> multiplexing multiple "virtual UARTs" into a single hardware serial
> port. The TCU is the primary serial port on Tegra194 devices.
>
> Add a TCU driver utilizing the mailbox framework, as the used mailboxes
> are part of Tegra HSP blocks that are already controlled by the Tegra
> HSP mailbox driver.

First question, can it be done utilizing SERDEV framework?

> +static void tegra_tcu_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
> +{

> +       (void)port;
> +       (void)mctrl;

Huh?

> +}

> +static void tegra_tcu_uart_stop_tx(struct uart_port *port)
> +{
> +       (void)port;
> +}

Ditto.

> +               if (written == 3) {
> +                       value |= 3 << 24;
> +                       value |= BIT(26);
> +                       mbox_send_message(tcu->tx, &value);

> +               }

(1)

> +       }
> +
> +       if (written) {
> +               value |= written << 24;
> +               value |= BIT(26);
> +               mbox_send_message(tcu->tx, &value);
> +       }

(2)

These are code duplications.

> +static void tegra_tcu_uart_stop_rx(struct uart_port *port)
> +{
> +       (void)port;
> +}
> +
> +static void tegra_tcu_uart_break_ctl(struct uart_port *port, int ctl)
> +{
> +       (void)port;
> +       (void)ctl;
> +}
> +
> +static int tegra_tcu_uart_startup(struct uart_port *port)
> +{
> +       (void)port;
> +
> +       return 0;
> +}
> +
> +static void tegra_tcu_uart_shutdown(struct uart_port *port)
> +{
> +       (void)port;
> +}
> +
> +static void tegra_tcu_uart_set_termios(struct uart_port *port,
> +                                      struct ktermios *new,
> +                                      struct ktermios *old)
> +{
> +       (void)port;
> +       (void)new;
> +       (void)old;
> +}

Remove those unused stub contents.

> +       return uart_set_options(&tegra_tcu_uart_port, cons,
> +                               115200, 'n', 8, 'n');

Can't it be one line?

> +static void tegra_tcu_receive(struct mbox_client *client, void *msg_p)
> +{
> +       struct tty_port *port = &tegra_tcu_uart_port.state->port;

> +       uint32_t msg = *(uint32_t *)msg_p;

Redundant casting.

> +       unsigned int num_bytes;
> +       int i;
> +

> +       num_bytes = (msg >> 24) & 0x3;

Two magic numbers.

> +       for (i = 0; i < num_bytes; i++)
> +               tty_insert_flip_char(port, (msg >> (i*8)) & 0xff, TTY_NORMAL);
> +
> +       tty_flip_buffer_push(port);
> +}

> +MODULE_AUTHOR("Mikko Perttunen <mperttunen@nvidia.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("NVIDIA Tegra Combined UART driver");
> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index dce5f9dae121..eaf3c303cba6 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -281,4 +281,7 @@
>  /* MediaTek BTIF */
>  #define PORT_MTK_BTIF  117
>
> +/* NVIDIA Tegra Combined UART */
> +#define PORT_TEGRA_TCU 118

Check if there is an unused gap. IIRC we still have one near to 40ish.

-- 
With Best Regards,
Andy Shevchenko
