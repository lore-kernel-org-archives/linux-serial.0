From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] tty: 8250: fix a missing check for pci_ioremap_bar
Date: Fri, 15 Mar 2019 06:43:51 +0100
Message-ID: <22a8194b-52d9-f954-ef80-8e56da859d8c@suse.cz>
References: <20190315045617.7616-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190315045617.7616-1-kjlu@umn.edu>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Kangjie Lu <kjlu@umn.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, pakki001@umn.edu, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 15. 03. 19, 5:56, Kangjie Lu wrote:
> pci_ioremap_bar could fail. The fix captures the failure and
> pass an error code upstream. This can avoid potential NULL
> pointer dereferences in the future.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/tty/serial/8250/8250_lpss.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 98dbc796353f..e95332d8b35e 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
...
> @@ -203,7 +207,7 @@ static void qrk_serial_exit_dma(struct lpss8250 *lpss)
>  	dw_dma_remove(&lpss->dma_chip);
>  }
>  #else	/* CONFIG_SERIAL_8250_DMA */
> -static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}
> +static int qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}

So you have to return something here now.

>  static void qrk_serial_exit_dma(struct lpss8250 *lpss) {}
>  #endif	/* !CONFIG_SERIAL_8250_DMA */
>  

regards,
-- 
js
suse labs
