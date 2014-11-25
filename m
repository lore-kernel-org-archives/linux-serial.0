From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RFC] tty, serial, 8250: remove __init from function
 serial8250_console_setup()
Date: Tue, 25 Nov 2014 09:51:21 -0800
Message-ID: <20141125175121.GA32573@kroah.com>
References: <1416506456-2126-1-git-send-email-avanzini.arianna@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416506456-2126-1-git-send-email-avanzini.arianna@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arianna Avanzini <avanzini.arianna@gmail.com>
Cc: jslaby@suse.cz, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 20, 2014 at 07:00:56PM +0100, Arianna Avanzini wrote:
> Some RS232 adapters handled by this driver are hotpluggable. The function
> serial8250_console_setup() is called during device init and is defined with
> the __init macro. In case the driver is built-in, hotplugging the device after
> the initialization phase has been completed (and the related memory has been
> freed) results in a kernel crash.
> This commit fixes the issue by removing __init from the function definition.
> 
> Signed-off-by: Arianna Avanzini <avanzini.arianna@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index ca5cfdc..ca8108d 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -3237,7 +3237,7 @@ serial8250_console_write(struct console *co, const char *s, unsigned int count)
>  	serial8250_rpm_put(up);
>  }
>  
> -static int __init serial8250_console_setup(struct console *co, char *options)
> +static int serial8250_console_setup(struct console *co, char *options)
>  {
>  	struct uart_port *port;
>  	int baud = 9600;
> -- 
> 2.1.3

I don't apply "RFC" patches as it implies you don't even know if this
works or not.
