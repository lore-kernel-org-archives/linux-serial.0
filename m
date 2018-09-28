From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] tty: Convert to using %pOFn instead of device_node.name
Date: Fri, 28 Sep 2018 17:09:03 -0500
Message-ID: <CAL_JsqJfAsv-MOgk2Ycs2VBj2vK0m29B_3FxwJV5xUjnMbH4sg@mail.gmail.com>
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-46-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828015252.28511-46-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Aug 27, 2018 at 8:55 PM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linux-serial@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/tty/ehv_bytechan.c                  | 12 ++++++------
>  drivers/tty/serial/cpm_uart/cpm_uart_core.c |  8 ++++----
>  drivers/tty/serial/pmac_zilog.c             |  4 ++--
>  3 files changed, 12 insertions(+), 12 deletions(-)

Hey Greg, Is this still in your queue? Maybe you've just been extra
busy lately. ;)

Rob
>
> diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
> index eea4049b5dcc..769e0a5d1dfc 100644
> --- a/drivers/tty/ehv_bytechan.c
> +++ b/drivers/tty/ehv_bytechan.c
> @@ -128,8 +128,8 @@ static int find_console_handle(void)
>          */
>         iprop = of_get_property(np, "hv-handle", NULL);
>         if (!iprop) {
> -               pr_err("ehv-bc: no 'hv-handle' property in %s node\n",
> -                      np->name);
> +               pr_err("ehv-bc: no 'hv-handle' property in %pOFn node\n",
> +                      np);
>                 return 0;
>         }
>         stdout_bc = be32_to_cpu(*iprop);
> @@ -661,8 +661,8 @@ static int ehv_bc_tty_probe(struct platform_device *pdev)
>
>         iprop = of_get_property(np, "hv-handle", NULL);
>         if (!iprop) {
> -               dev_err(&pdev->dev, "no 'hv-handle' property in %s node\n",
> -                       np->name);
> +               dev_err(&pdev->dev, "no 'hv-handle' property in %pOFn node\n",
> +                       np);
>                 return -ENODEV;
>         }
>
> @@ -682,8 +682,8 @@ static int ehv_bc_tty_probe(struct platform_device *pdev)
>         bc->rx_irq = irq_of_parse_and_map(np, 0);
>         bc->tx_irq = irq_of_parse_and_map(np, 1);
>         if ((bc->rx_irq == NO_IRQ) || (bc->tx_irq == NO_IRQ)) {
> -               dev_err(&pdev->dev, "no 'interrupts' property in %s node\n",
> -                       np->name);
> +               dev_err(&pdev->dev, "no 'interrupts' property in %pOFn node\n",
> +                       np);
>                 ret = -ENODEV;
>                 goto error;
>         }
> diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> index 24a5f05e769b..ea7204d75022 100644
> --- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> +++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> @@ -1151,8 +1151,8 @@ static int cpm_uart_init_port(struct device_node *np,
>         if (!pinfo->clk) {
>                 data = of_get_property(np, "fsl,cpm-brg", &len);
>                 if (!data || len != 4) {
> -                       printk(KERN_ERR "CPM UART %s has no/invalid "
> -                                       "fsl,cpm-brg property.\n", np->name);
> +                       printk(KERN_ERR "CPM UART %pOFn has no/invalid "
> +                                       "fsl,cpm-brg property.\n", np);
>                         return -EINVAL;
>                 }
>                 pinfo->brg = *data;
> @@ -1160,8 +1160,8 @@ static int cpm_uart_init_port(struct device_node *np,
>
>         data = of_get_property(np, "fsl,cpm-command", &len);
>         if (!data || len != 4) {
> -               printk(KERN_ERR "CPM UART %s has no/invalid "
> -                               "fsl,cpm-command property.\n", np->name);
> +               printk(KERN_ERR "CPM UART %pOFn has no/invalid "
> +                               "fsl,cpm-command property.\n", np);
>                 return -EINVAL;
>         }
>         pinfo->command = *data;
> diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
> index 3d21790d961e..a4ec22d1f214 100644
> --- a/drivers/tty/serial/pmac_zilog.c
> +++ b/drivers/tty/serial/pmac_zilog.c
> @@ -1566,9 +1566,9 @@ static int pmz_attach(struct macio_dev *mdev, const struct of_device_id *match)
>          * to work around bugs in ancient Apple device-trees
>          */
>         if (macio_request_resources(uap->dev, "pmac_zilog"))
> -               printk(KERN_WARNING "%s: Failed to request resource"
> +               printk(KERN_WARNING "%pOFn: Failed to request resource"
>                        ", port still active\n",
> -                      uap->node->name);
> +                      uap->node);
>         else
>                 uap->flags |= PMACZILOG_FLAG_RSRC_REQUESTED;
>
> --
> 2.17.1
>
