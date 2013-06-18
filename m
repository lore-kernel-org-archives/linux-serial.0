From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v3 04/10] serial: samsung: select Exynos specific driver
 data if ARCH_EXYNOS is defined
Date: Tue, 18 Jun 2013 19:31:06 +0900
Message-ID: <1c0e01ce6c0e$f0baf7d0$d230e770$%kim@samsung.com>
References: <1371466836-4111-1-git-send-email-chander.kashyap@linaro.org>
 <1371466836-4111-5-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:18575 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691Ab3FRKbI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Jun 2013 06:31:08 -0400
In-reply-to: 
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Kukjin Kim' <kgene.kim@samsung.com>, 'Chander Kashyap' <chander.kashyap@linaro.org>, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, t.figa@samsung.com, s.nawrocki@samsung.com, mark.rutland@arm.com, thomas.ab@samsung.com, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, jslaby@suse.cz

Kukjin Kim wrote:
> 
> Chander Kashyap wrote:
> >
> > All Exynos4/5 SoCs share a common driver data in the samsung serial
> > driver. Hence, let the driver data inclusion be based on ARCH_EXYNOS
> > instead of SOC specific definition.
> >
> > Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> 
> (+ Greg, Jiri)
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> Greg, Jiri, please take this in your tree with my ack if no problem on
> this.
> 
Greg, Jiri, since there are other changes for this in samsung tree so would
be nice if this could be sent to upstream with others via samsung tree. If
you have any concerns, please kindly let me know.

Thanks,
- Kukjin
> 
> > ---
> >  drivers/tty/serial/samsung.c |    4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> > index 2552c7f..e70d19a 100644
> > --- a/drivers/tty/serial/samsung.c
> > +++ b/drivers/tty/serial/samsung.c
> > @@ -1703,9 +1703,7 @@ static struct s3c24xx_serial_drv_data
> > s5pv210_serial_drv_data = {
> >  #define S5PV210_SERIAL_DRV_DATA	(kernel_ulong_t)NULL
> >  #endif
> >
> > -#if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212) ||
> \
> > -	defined(CONFIG_SOC_EXYNOS4412) || defined(CONFIG_SOC_EXYNOS5250) ||
> > \
> > -	defined(CONFIG_SOC_EXYNOS5440)
> > +#if defined(CONFIG_ARCH_EXYNOS)
> >  static struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
> >  	.info = &(struct s3c24xx_uart_info) {
> >  		.name		= "Samsung Exynos4 UART",
> > --
> > 1.7.9.5

