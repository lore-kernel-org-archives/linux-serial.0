From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] serial: stm32: update interrupt initialization
Date: Mon, 5 Mar 2018 18:50:31 -0600
Message-ID: <20180306005031.fqwlwd2yodly4i7k@rob-hp-laptop>
References: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
 <1519815044-22669-3-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1519815044-22669-3-git-send-email-bich.hemon@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bich HEMON <bich.hemon@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 28, 2018 at 10:51:17AM +0000, Bich HEMON wrote:
> For each port, get each IRQ using its specific name instead of its index.
> 
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> ---
>  drivers/tty/serial/stm32-usart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index 0fa735b..5c85cbc 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -680,8 +680,8 @@ static int stm32_init_port(struct stm32_port *stm32port,
>  	port->flags	= UPF_BOOT_AUTOCONF;
>  	port->ops	= &stm32_uart_ops;
>  	port->dev	= &pdev->dev;
> -	port->irq	= platform_get_irq(pdev, 0);
> -	stm32port->wakeirq = platform_get_irq(pdev, 1);
> +	port->irq	= platform_get_irq_byname(pdev, "event");
> +	stm32port->wakeirq = platform_get_irq_byname(pdev, "wakeup");

This change is not necessary. The interrupts should be at fixed indices.

>  	stm32port->fifoen = stm32port->info->cfg.has_fifo;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -- 
> 1.9.1
