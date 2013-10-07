From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] serial: tegra: remove deprecated IRQF_DISABLED
Date: Mon, 07 Oct 2013 11:07:11 -0600
Message-ID: <5252EA3F.9090101@wwwdotorg.org>
References: <1381041017-12806-1-git-send-email-michael.opdenacker@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1381041017-12806-1-git-send-email-michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Opdenacker <michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 10/06/2013 12:30 AM, Michael Opdenacker wrote:
> This patch proposes to remove the use of the IRQF_DISABLED flag
> 
> It's a NOOP since 2.6.35 and it will be removed one day.

Laxman, care to comment? I'm not sure why the code explicitly specifies
IRQF_DISABLED if it's already a no-op. Perhaps the code expects
IRQF_DISABLED to do something, and hence there's some bug that needs to
be fixed because of it doesn't?

> Signed-off-by: Michael Opdenacker <michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  drivers/tty/serial/serial-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
> index 0489a2b..dfe79cc 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -1018,7 +1018,7 @@ static int tegra_uart_startup(struct uart_port *u)
>  		goto fail_hw_init;
>  	}
>  
> -	ret = request_irq(u->irq, tegra_uart_isr, IRQF_DISABLED,
> +	ret = request_irq(u->irq, tegra_uart_isr, 0,
>  				dev_name(u->dev), tup);
>  	if (ret < 0) {
>  		dev_err(u->dev, "Failed to register ISR for IRQ %d\n", u->irq);
> 
