From: Jesper Juhl <jj@chaosbits.net>
Subject: Re: [PATCH] drivers/tty/serial/crisv10: fix double assignment
Date: Mon, 11 Jul 2011 01:39:53 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1107110139070.2818@swampdragon.chaosbits.net>
References: <1310341051-27057-1-git-send-email-edwin@cheatah.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1310341051-27057-1-git-send-email-edwin@cheatah.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Edwin van Vliet <edwin@cheatah.nl>
Cc: starvik@axis.com, jesper.nilsson@axis.com, alan@linux.intel.com, linux-cris-kernel@axis.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, 11 Jul 2011, Edwin van Vliet wrote:

> Struct member dma_in_enabled was assigned twice in a row.
> 
> Signed-off-by: Edwin van Vliet <edwin@cheatah.nl>
> ---
>  drivers/tty/serial/crisv10.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
> index 225123b..0c55181 100644
> --- a/drivers/tty/serial/crisv10.c
> +++ b/drivers/tty/serial/crisv10.c
> @@ -330,7 +330,6 @@ static struct e100_serial rs_table[] = {
>  	  .dma_in_irq_description = "serial 1 dma rec",
>  #else
>  	  .dma_in_enabled = 0,
> -	  .dma_in_enabled = 0,
>  	  .dma_in_nbr = UINT_MAX,
>  	  .dma_in_irq_nbr = 0,
>  	  .dma_in_irq_flags = 0,
> 
Looks correct to me.
Reviewed-by: Jesper Juhl <jj@chaosbits.net>

-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
