From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v4 15/15] MAINTAINERS: Add entry for RDA Micro SoC
 architecture
Date: Wed, 12 Dec 2018 14:53:42 +0100
Message-ID: <3e4b7143-6ed8-6006-cb07-d72bca40ce5f@suse.de>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
 <20181210173550.29643-16-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210173550.29643-16-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, daniel.lezcano@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com, devicetree@vger.kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, linux-unisoc@lists.infradead.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Mani,

Am 10.12.18 um 18:35 schrieb Manivannan Sadhasivam:
> Add MAINTAINERS entry for RDA Micro SoC architecture with myself
> and Andreas Färber as the maintainers.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  MAINTAINERS | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c3fbbb361f8..6411fb222590 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1945,6 +1945,21 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  
> +ARM/RDA MICRO ARCHITECTURE
> +M:	Andreas Färber <afaerber@suse.de>
> +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I'd suggest you swap the two of us here, making you the primary
maintainer. Or drop me, as I should be copied via linux-unisoc anyway.

I won't realistically have the bandwidth to drive review and more pull
requests at the moment, with Realtek already stuck in irqchip regression
for too long and LoRa making only slow progress.

Regards,
Andreas

> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +L:	linux-unisoc@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	arch/arm/boot/dts/rda8810pl-*
> +F:	drivers/clocksource/timer-rda.c
> +F:	drivers/irqchip/irq-rda-intc.c
> +F:	drivers/tty/serial/rda-uart.c
> +F:	Documentation/devicetree/bindings/arm/rda.txt
> +F:	Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
> +F:	Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
> +F:	Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
> +
>  ARM/REALTEK ARCHITECTURE
>  M:	Andreas Färber <afaerber@suse.de>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> 


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
