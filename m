From: Colin Ian King <colin.king@canonical.com>
Subject: NACK: [PATCH][serial-next] serial-uartlite: fix null pointer
 dereference on pointer port
Date: Tue, 13 Nov 2018 09:39:11 +0000
Message-ID: <1bf40dc1-86dc-468a-f741-39ccdc02e67a@canonical.com>
References: <20181113093814.27598-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181113093814.27598-1-colin.king@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 13/11/2018 09:38, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer port is dereferenced on port->private_data when assigning pointer
> pdata before port is null checked, leading to a potential null pointer
> dereference.  Fix this by assigning pdata after the null pointer check on
> port.
> 
> Detected by CoverityScan, CID#1475434 ("Dereference before null check")
> 
> Fixes: 3b209d253e7f ("serial-uartlite: Do not use static struct uart_driver out of probe()")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/tty/serial/uartlite.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index 4a7989df5ff5..0eff33cd9f24 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -715,10 +715,12 @@ static int ulite_release(struct device *dev)
>  static int __maybe_unused ulite_suspend(struct device *dev)
>  {
>  	struct uart_port *port = dev_get_drvdata(dev);
> -	struct uartlite_data *pdata = port->private_data;
>  
> -	if (port)
> +	if (port) {
> +		struct uartlite_data *pdata = port->private_data;
> +
>  		uart_suspend_port(pdata->ulite_uart_driver, port);
> +	}
>  
>  	return 0;
>  }
> 

Sorry for the noise, I sent the wrong fix. V2 coming soon.
