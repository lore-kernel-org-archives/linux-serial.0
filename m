From: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 04/10] serial: samsung: select Exynos specific driver
 data if ARCH_EXYNOS is defined
Date: Tue, 18 Jun 2013 08:19:48 -0700
Message-ID: <20130618151948.GC27677@kroah.com>
References: <1371466836-4111-1-git-send-email-chander.kashyap@linaro.org>
 <1371466836-4111-5-git-send-email-chander.kashyap@linaro.org>
 <1c0e01ce6c0e$f0baf7d0$d230e770$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1c0e01ce6c0e$f0baf7d0$d230e770$%kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Chander Kashyap' <chander.kashyap@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, t.figa@samsung.com, s.nawrocki@samsung.com, mark.rutland@arm.com, thomas.ab@samsung.com, jslaby@suse.cz
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 18, 2013 at 07:31:06PM +0900, Kukjin Kim wrote:
> Kukjin Kim wrote:
> > 
> > Chander Kashyap wrote:
> > >
> > > All Exynos4/5 SoCs share a common driver data in the samsung serial
> > > driver. Hence, let the driver data inclusion be based on ARCH_EXYNOS
> > > instead of SOC specific definition.
> > >
> > > Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> > 
> > (+ Greg, Jiri)
> > 
> > Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> > 
> > Greg, Jiri, please take this in your tree with my ack if no problem on
> > this.
> > 
> Greg, Jiri, since there are other changes for this in samsung tree so would
> be nice if this could be sent to upstream with others via samsung tree. If
> you have any concerns, please kindly let me know.
> 
> Thanks,
> - Kukjin
> > 
> > > ---
> > >  drivers/tty/serial/samsung.c |    4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> > > index 2552c7f..e70d19a 100644
> > > --- a/drivers/tty/serial/samsung.c
> > > +++ b/drivers/tty/serial/samsung.c
> > > @@ -1703,9 +1703,7 @@ static struct s3c24xx_serial_drv_data
> > > s5pv210_serial_drv_data = {
> > >  #define S5PV210_SERIAL_DRV_DATA	(kernel_ulong_t)NULL
> > >  #endif
> > >
> > > -#if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212) ||
> > \
> > > -	defined(CONFIG_SOC_EXYNOS4412) || defined(CONFIG_SOC_EXYNOS5250) ||
> > > \
> > > -	defined(CONFIG_SOC_EXYNOS5440)
> > > +#if defined(CONFIG_ARCH_EXYNOS)
> > >  static struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
> > >  	.info = &(struct s3c24xx_uart_info) {
> > >  		.name		= "Samsung Exynos4 UART",

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
