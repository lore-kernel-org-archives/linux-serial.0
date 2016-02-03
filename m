From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH 03/10] arm64: add Armada 3700 architecture entry
Date: Wed, 3 Feb 2016 14:24:51 +0800
Message-ID: <20160203142451.41381ff6@xhacker>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
	<1454436468-4241-4-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <1454436468-4241-4-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Tejun Heo <tj@kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2 Feb 2016 19:07:41 +0100 Gregory CLEMENT wrote:

> The Armada 3700 is an mvebu ARM64 SoC using one or two Cortex-A53 cores
> depending of the variant.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm64/Kconfig.platforms | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 21074f674bde..7da341f7b90d 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -1,5 +1,11 @@
>  menu "Platform selection"
>  
> +config ARCH_ARMADA_3700

Would it be better to use ARCH_MVEBU? IMHO, there will be more ARMv8 SoCs
from our EBU, do we plan to add one CONFIG_ARMADA_yyzz for each SoC?

> +	bool "Armada 3700 SoC Family"
> +	help
> +	  This enables support for Armada 3700 SoC Family. It is is an
> +	  ARMv8 based chipset belonging to the mvebu family.
> +
>  config ARCH_BCM_IPROC
>  	bool "Broadcom iProc SoC Family"
>  	help

