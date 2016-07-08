From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2] serial: amba-pl011: complete support to ZTE uart
Date: Fri, 8 Jul 2016 10:11:18 +0800
Message-ID: <20160708021118.GB20896@tiger>
References: <1458717126-20814-1-git-send-email-jun.nie@linaro.org>
 <CABymUCN_Os0gxoWjfwB_8V4kEkwBqKcrCCRjH8+-gm-Xt3-tYQ@mail.gmail.com>
 <570CF1B3.8080305@linaro.org>
 <CABymUCPvayLkc5h-3e0671pEEO_SshNJazk7W0B_oAUfL-6r0w@mail.gmail.com>
 <20160428201106.GA2924@kroah.com>
 <CABymUCPH1CwxhBxGq5_epgn-19j9WrfrxxG8zuzpZnXk26Ps9A@mail.gmail.com>
 <20160707095453.GA10000@tiger> <20160707150107.GA20896@tiger>
 <20160707152802.GR1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160707152802.GR1041@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Peter Hurley <peter@hurleysoftware.com>, G Gregory <graeme.gregory@linaro.org>, Jason Liu <jason.liu@linaro.org>, Greg KH <greg@kroah.com>, Timur Tabi <timur@codeaurora.org>, linux-serial@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 07, 2016 at 04:28:02PM +0100, Russell King - ARM Linux wrote:
> So, if I were to do this, there wouldn't be any objection?
> 
> An alternative would be to use the real hardware ID if it exists, add
> a compatible to DT, and use of_device_is_compatible() in the driver
> to discover if it's a zte device.

Comparing to this, I think the "official" pseudo-ID approach is cleaner.
I will send a patch to incorporate the suggested changes below.

Thanks, Russell.

Shawn

> 
> 8<====
> Subject: [PATCH] amba: make ZTE pseudo-ID more "official"
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/tty/serial/amba-pl011.c | 4 ++--
>  include/linux/amba/bus.h        | 5 +++++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 77b05f5bf866..2dbe5776ac56 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2659,8 +2659,8 @@ static struct amba_id pl011_ids[] = {
>  		.data	= &vendor_st,
>  	},
>  	{
> -		.id	= 0xfefefe,
> -		.mask	= 0xffffff,
> +		.id	= AMBA_LINUX_ID(0x00, 0xf, 0xefe),
> +		.mask	= 0x00ffffff,
>  		.data	= &vendor_zte,
>  	},
>  	{ 0, 0 },
> diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
> index 3d8dcdd1aeae..dc29d504b4fc 100644
> --- a/include/linux/amba/bus.h
> +++ b/include/linux/amba/bus.h
> @@ -53,8 +53,13 @@ enum amba_vendor {
>  	AMBA_VENDOR_ST = 0x80,
>  	AMBA_VENDOR_QCOM = 0x51,
>  	AMBA_VENDOR_LSI = 0xb6,
> +	AMBA_VENDOR_LINUX = 0xef,	/* This value is not official */
>  };
>  
> +#define AMBA_LINUX_ID(conf, rev, part) \
> +	(((conf) & 0xff) << 24 | ((rev) & 0xf) << 20 | \
> +	 AMBA_VENDOR_LINUX << 12 | ((part) & 0xfff))
> +
>  extern struct bus_type amba_bustype;
>  
>  #define to_amba_device(d)	container_of(d, struct amba_device, dev)
> -- 
> 2.1.0
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
