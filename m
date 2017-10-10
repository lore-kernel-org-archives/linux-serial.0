From: Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH v2] serial: sh-sci: Fix init data attribute for struct 'port_cfg'
Date: Mon, 9 Oct 2017 18:54:20 -0700
Message-ID: <CABXOdTcA725JqpCSeaP44=n0BOExp3uuJd6bimFC+FXOwm6CpA@mail.gmail.com>
References: <20171010012622.181557-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171010012622.181557-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <groeck@chromium.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 9, 2017 at 6:26 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> The __init attribute is meant to mark functions, use __initdata instead
> for the data structure.
>
> This fixes the following error when building with clang:
>
> drivers/tty/serial/sh-sci.c:3247:15: error: '__section__' attribute only
>   applies to functions, methods, properties, and global variables
>     static struct __init plat_sci_port port_cfg;
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> Changes in v2:
> - Change the attribute to __initdata instead of removing it
> - Update commit message
>
>  drivers/tty/serial/sh-sci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 784dd42002ea..f7f632213a8e 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3244,7 +3244,7 @@ early_platform_init_buffer("earlyprintk", &sci_driver,
>                            early_serial_buf, ARRAY_SIZE(early_serial_buf));
>  #endif
>  #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
> -static struct __init plat_sci_port port_cfg;
> +static struct plat_sci_port port_cfg __initdata;
>
>  static int __init early_console_setup(struct earlycon_device *device,
>                                       int type)
> --
> 2.14.2.920.gcf0c67979c-goog
>
