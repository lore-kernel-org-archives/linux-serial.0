From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 4/9] Documentation: DT: Add entries for bcm63xx UART
Date: Tue, 21 Oct 2014 07:49:51 +0200
Message-ID: <3370097.yeNWMGbi8v@wuerfel>
References: <1413838448-29464-1-git-send-email-cernekee@gmail.com> <2100909.UrHPDWWSai@wuerfel> <54459281.7050004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:61597 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbaJUFuJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Oct 2014 01:50:09 -0400
In-Reply-To: <54459281.7050004@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org, geert@linux-m68k.org, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

On Monday 20 October 2014 15:53:53 Florian Fainelli wrote:
> 
> For now, I suppose that s simple fix could be to use an anonymous clock
> request when probed via DT. This code you quote dates from 2008 when
> there was no clkdev in the kernel at all. So something like this would
> probably do it for now:
> 
> diff --git a/drivers/tty/serial/bcm63xx_uart.c
> b/drivers/tty/serial/bcm63xx_uart.c
> index e0b87d507670..1b914b85dd31 100644
> --- a/drivers/tty/serial/bcm63xx_uart.c
> +++ b/drivers/tty/serial/bcm63xx_uart.c
> @@ -819,7 +819,7 @@ static int bcm_uart_probe(struct platform_device *pdev)
>         if (!res_irq)
>                 return -ENODEV;
> 
> -       clk = clk_get(&pdev->dev, "periph");
> +       clk = clk_get(&pdev->dev, pdev->dev.of_node ? NULL : "periph");
>         if (IS_ERR(clk))
>                 return -ENODEV;
> 
> 

Yes, that would work. Just make sure the same bug doesn't creep in
for other drivers you are converting.

	Arnd
