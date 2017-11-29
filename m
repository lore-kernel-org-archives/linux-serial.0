From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] jsm_tty: Fix a possible null pointer dereference in two
 functions
Date: Wed, 29 Nov 2017 09:23:07 -0800
Message-ID: <1511976187.19952.65.camel@perches.com>
References: <5c78db97-88f5-8655-9a47-eeee0a043fba@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5c78db97-88f5-8655-9a47-eeee0a043fba@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>, Jiri Slaby <jslaby@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2017-11-29 at 17:40 +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 29 Nov 2017 17:30:36 +0100
> 
> Move two debug messages so that a null pointer access can not happen
> for the variable "ch" in these functions.

An actual defect fix!

Here you could probably cc stable too.

> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 669fef464468d3f02d60a5cf725fc097e03c5cb8 ("serial: jsm: Convert jsm_printk to jsm_dbg")
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/tty/serial/jsm/jsm_tty.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
> index 469927d37b41..a34eed7344e5 100644
> --- a/drivers/tty/serial/jsm/jsm_tty.c
> +++ b/drivers/tty/serial/jsm/jsm_tty.c
> @@ -521,11 +521,10 @@ void jsm_input(struct jsm_channel *ch)
>  	int s = 0;
>  	int i = 0;
>  
> -	jsm_dbg(READ, &ch->ch_bd->pci_dev, "start\n");
> -
>  	if (!ch)
>  		return;
>  
> +	jsm_dbg(READ, &ch->ch_bd->pci_dev, "start\n");
>  	port = &ch->uart_port.state->port;
>  	tp = port->tty;
>  
> @@ -647,10 +646,10 @@ static void jsm_carrier(struct jsm_channel *ch)
>  	int virt_carrier = 0;
>  	int phys_carrier = 0;
>  
> -	jsm_dbg(CARR, &ch->ch_bd->pci_dev, "start\n");
>  	if (!ch)
>  		return;
>  
> +	jsm_dbg(CARR, &ch->ch_bd->pci_dev, "start\n");
>  	bd = ch->ch_bd;
>  
>  	if (!bd)
