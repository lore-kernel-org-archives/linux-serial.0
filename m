From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH/RFC 3/8] of: Add helper function to check MMIO register
 endianness
Date: Wed, 12 Nov 2014 09:50:44 +0100
Message-ID: <54631F64.8080009@suse.cz>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com> <1415781993-7755-4-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:62902 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbaKLIus (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 03:50:48 -0500
In-Reply-To: <1415781993-7755-4-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org, robh@kernel.org
Cc: tushar.behera@linaro.org, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

On 11/12/2014, 09:46 AM, Kevin Cernekee wrote:
> SoC peripherals can come in several different flavors:
> 
>  - little-endian: registers always need to be accessed in LE mode (so the
>    kernel should perform a swap if the CPU is running BE)
> 
>  - big-endian: registers always need to be accessed in BE mode (so the
>    kernel should perform a swap if the CPU is running LE)
> 
>  - native-endian: the bus will automatically swap accesses, so the kernel
>    should never swap
> 
> Introduce a function that checks an OF device node to see whether it
> contains a "big-endian" or "native-endian" property.  For the former case,
> always return 1.  For the latter case, return 1 iff the kernel was built
> for BE (implying that the BE MMIO accessors do not perform a swap).
> Otherwise return 0, assuming LE registers.
> 
> LE registers are assumed by default because most existing drivers (libahci,
> serial8250, usb) always use readl/writel in the absence of instructions
> to the contrary, so that will be our fallback.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  drivers/of/base.c  | 23 +++++++++++++++++++++++
>  include/linux/of.h |  6 ++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 3823edf..9dd494a 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -552,6 +552,29 @@ int of_device_is_available(const struct device_node *device)
>  EXPORT_SYMBOL(of_device_is_available);
>  
>  /**
> + *  of_device_is_big_endian - check if a device has BE registers
> + *
> + *  @device: Node to check for availability
> + *
> + *  Returns 1 if the device has a "big-endian" property, or if the kernel
> + *  was compiled for BE *and* the device has a "native-endian" property.
> + *  Returns 0 otherwise.
> + *
> + *  Callers would nominally use ioread32be/iowrite32be if
> + *  of_device_is_big_endian() == 1, or readl/writel otherwise.
> + */
> +int of_device_is_big_endian(const struct device_node *device)
> +{
> +	if (of_property_read_bool(device, "big-endian"))
> +		return 1;
> +	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) &&
> +	    of_property_read_bool(device, "native-endian"))
> +		return 1;
> +	return 0;
> +}

This should actually return bool and use true/false.

-- 
js
suse labs
