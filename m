From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] serial: core: stop passing NULL in uart_resume_port
Date: Thu, 26 Jul 2018 01:01:43 +0300
Message-ID: <CAHp75Ve7i0QsrjshtMMp0cb44Mtet-SHDN+XuQHF-EHH_KuZEQ@mail.gmail.com>
References: <20180725100450.22300-1-hu1.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725100450.22300-1-hu1.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Hu <hu1.chen@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jul 25, 2018 at 1:04 PM, Chen Hu <hu1.chen@intel.com> wrote:
> We found the baud rate is changed after S3 on some Intel Broxton
> platforms. The baud rate should be restored during resume. However, some
> set_termios() callback such as dw8250_set_termios() for DesignWare 8250
> will skip setting if old termios is NULL. We address this issue via
> passing a dummy.

Why does it need to be "fixed" here then?

>
> Signed-off-by: Chen Hu <hu1.chen@intel.com>
> ---
>  drivers/tty/serial/serial_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index f02965936f2e..8b815f1539e8 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2217,6 +2217,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
>         struct device *tty_dev;
>         struct uart_match match = {uport, drv};
>         struct ktermios termios;
> +       static struct ktermios dummy;
>
>         mutex_lock(&port->mutex);
>
> @@ -2277,7 +2278,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
>                         pm_runtime_put_autosuspend(uport->dev);
>                         if (ret == 0) {
>                                 if (tty)
> -                                       uart_change_speed(tty, state, NULL);
> +                                       uart_change_speed(tty, state, &dummy);
>                                 pm_runtime_get_sync(uport->dev);
>                                 spin_lock_irq(&uport->lock);
>                                 ops->set_mctrl(uport, uport->mctrl);
> --
> 2.13.0
>



-- 
With Best Regards,
Andy Shevchenko
