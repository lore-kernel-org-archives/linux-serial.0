From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [patch v1 2/2] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
Date: Wed, 2 Aug 2017 08:31:29 -0700
Message-ID: <ce3c9f04-1651-8b59-839e-e27783b222ff@infradead.org>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
 <1501679918-20486-3-git-send-email-oleksandrs@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501679918-20486-3-git-send-email-oleksandrs@mellanox.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Shamray <oleksandrs@mellanox.com>, gregkh@linuxfoundation.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, joel@jms.id.au, jiri@resnulli.us, tklauser@distanz.ch, linux-serial@vger.kernel.org, mec@shout.net, vadimp@maellanox.com, system-sw-low-level@mellanox.com, Jiri Pirko <jiri@mellanox.com>
List-Id: linux-serial@vger.kernel.org

On 08/02/2017 06:18 AM, Oleksandr Shamray wrote:
> 
> diff --git a/drivers/jtag/Kconfig b/drivers/jtag/Kconfig
> index a8d0149..7bf709c 100644
> --- a/drivers/jtag/Kconfig
> +++ b/drivers/jtag/Kconfig
> @@ -16,3 +16,16 @@ menuconfig JTAG
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called jtag.
>  
> +menuconfig JTAG_ASPEED
> +	tristate "Aspeed SoC JTAG controller support"
> +	depends on JTAG
> +	---help---
> +	  This provides a support for Aspeed JTAG device, equipped on
> +	  Aspeed SoC 24xx and 25xx families. Drivers allows programming
> +	  of hardware devices, connected to SoC through the JTAG interface.
> +
> +	  If you want this support, you should say Y here.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called aspeed_jtag.

In the Makefile, it looks like it is called jtag-aspeed.

> +
> diff --git a/drivers/jtag/Makefile b/drivers/jtag/Makefile
> index e811330..e9fa7fa 100644
> --- a/drivers/jtag/Makefile
> +++ b/drivers/jtag/Makefile
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_JTAG)		+= jtag.o
> +obj-$(CONFIG_JTAG_ASPEED)	+= jtag-aspeed.o


-- 
~Randy
