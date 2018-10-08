From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] of: base: Change logic in of_alias_get_alias_list()
Date: Mon, 8 Oct 2018 10:07:32 -0500
Message-ID: <CAL_JsqLNMM6mS1oy1voDAibRk1Srcp7i8e3pESTnM957Rxp4ow@mail.gmail.com>
References: <e879d07e97b7f7fc46543315e9fb1b4bc8b7a352.1539001154.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e879d07e97b7f7fc46543315e9fb1b4bc8b7a352.1539001154.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 8, 2018 at 7:19 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> Check compatible string first before setting up bit in bitmap to also
> cover cases that allocated bitfield is not big enough.
> Show warning about it but let driver to continue to work with allocated
> bitfield to keep at least some devices (included console which
> is commonly close to serial0) to work.
>
> Fixes: b1078c355d76 ("of: base: Introduce of_alias_get_alias_list() to check alias IDs")
> Fixes: ae1cca3fa347 ("serial: uartps: Change uart ID port allocation")
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> I have looked at it and I don't think there should be necessary to
> report error immediately back with partially initialized bitfield.
> The reason is that still there could be a console device which is most
> likely below that max limit and it is worth to return at least that nbits
> properly filled.
> It will also enable cases that you can still continue to use aliases
> higher then fields prepared for devices without alias.

Seems reasonable. Plus if you had a new dtb which added an alias
greater than what the OS version supports, you would break that
system.

>
> To be fixed patches are present in tty-next branch.
>
> ---
>  drivers/of/base.c                  | 22 ++++++++++++----------
>  drivers/tty/serial/xilinx_uartps.c |  2 +-
>  2 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 908de45f966b..0b9611e196d1 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1953,13 +1953,15 @@ int of_alias_get_id(struct device_node *np, const char *stem)
>   * The function travels the lookup table to record alias ids for the given
>   * device match structures and alias stem.
>   *
> - * Return:     0 or -ENOSYS when !CONFIG_OF
> + * Return:     0 or -ENOSYS when !CONFIG_OF or
> + *             -EINVAL if alias ID is greater then allocated nbits

I think EOVERFLOW or ERANGE would be better as those are less common
and I take EINVAL as the caller made an error.

>   */
>  int of_alias_get_alias_list(const struct of_device_id *matches,
>                              const char *stem, unsigned long *bitmap,
>                              unsigned int nbits)
>  {
>         struct alias_prop *app;
> +       int ret = 0;
>
>         /* Zero bitmap field to make sure that all the time it is clean */
>         bitmap_zero(bitmap, nbits);
> @@ -1976,21 +1978,21 @@ int of_alias_get_alias_list(const struct of_device_id *matches,
>                         continue;
>                 }
>
> -               if (app->id >= nbits) {
> -                       pr_debug("%s: ID %d greater then bitmap field %d\n",
> -                               __func__, app->id, nbits);
> -                       continue;
> -               }
> -
>                 if (of_match_node(matches, app->np)) {
>                         pr_debug("%s: Allocated ID %d\n", __func__, app->id);
> -                       set_bit(app->id, bitmap);
> +
> +                       if (app->id >= nbits) {
> +                               pr_warn("%s: ID %d >= than bitmap field %d\n",
> +                                       __func__, app->id, nbits);
> +                               ret = -EINVAL;
> +                       } else {
> +                               set_bit(app->id, bitmap);
> +                       }
>                 }
> -               /* Alias exists but is not compatible with matches */
>         }
>         mutex_unlock(&of_mutex);
>
> -       return 0;
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(of_alias_get_alias_list);
>
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index d452dceb0cb3..29a18103182d 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1393,7 +1393,7 @@ static int cdns_get_id(struct platform_device *pdev)
>         if (!alias_bitmap_initialized) {
>                 ret = of_alias_get_alias_list(cdns_uart_of_match, "serial",
>                                               alias_bitmap, MAX_UART_INSTANCES);
> -               if (ret) {
> +               if (ret && ret != -EINVAL) {
>                         mutex_unlock(&bitmap_lock);
>                         return ret;
>                 }
> --
> 1.9.1
>
