From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH -next 02/12] serial: earlycon: Emit earlycon name in the
 OF table
Date: Thu, 5 Mar 2015 09:13:58 -0600
Message-ID: <CAL_Jsq+aj1oWYGLOV4F9c6ZWb79fN56hQiGEZE98+7zHqLX6fg@mail.gmail.com>
References: <1425489871-22415-1-git-send-email-peter@hurleysoftware.com> <1425489871-22415-3-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425489871-22415-3-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 4, 2015 at 11:24 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> The OF device name of the earlycon is never used because there is no
> device; re-purpose the name field to store the earlycon name in
> the OF earlycon table. Earlycon will use the table entry to
> fixup the console name and index.
>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  include/linux/serial_core.h | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 8aeec49..c523785 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -29,6 +29,7 @@
>  #include <linux/tty.h>
>  #include <linux/mutex.h>
>  #include <linux/sysrq.h>
> +#include <linux/mod_devicetable.h>
>  #include <uapi/linux/serial_core.h>
>
>  #ifdef CONFIG_SERIAL_CORE_CONSOLE
> @@ -353,8 +354,18 @@ extern int of_setup_earlycon(unsigned long addr,
>                  = { .name  = __stringify(_name),                       \
>                      .setup = func  }
>
> -#define OF_EARLYCON_DECLARE(name, compat, fn)                          \
> -       _OF_DECLARE(earlycon, name, compat, fn, void *)

The purpose of this was to follow the same structure for all users of
this. We're not there yet, but this moves in the wrong direction.

> +#ifdef CONFIG_OF
> +#define EARLYCON_OF_TABLE_ATTR __used __section(__earlycon_of_table)
> +#else
> +#define EARLYCON_OF_TABLE_ATTR __attribute__((unused))
> +#endif
> +
> +#define OF_EARLYCON_DECLARE(_name, compat, fn)                         \
> +       static const struct of_device_id __of_table_##_name             \
> +               EARLYCON_OF_TABLE_ATTR                                  \
> +                = { .name = __stringify(_name),                        \

While convenient, this is an abuse of name which is supposed to be the
DT node name.

Perhaps instead of trying to make the earlycon have the right name,
the real console can know the matching earlycon's name?

Rob

> +                    .compatible = compat,                              \
> +                    .data = (fn == (void *)NULL) ? fn : fn  }
>
>  struct uart_port *uart_get_console(struct uart_port *ports, int nr,
>                                    struct console *c);
> --
> 2.3.1
>
