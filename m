From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH v3 05/12] arm64: add mvebu architecture entry
Date: Tue, 16 Feb 2016 14:12:12 +0800
Message-ID: <20160216141212.00f037e5@xhacker>
References: <1454951660-13289-1-git-send-email-gregory.clement@free-electrons.com>
	<1454951660-13289-6-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <1454951660-13289-6-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Omri Itach <omrii@marvell.com>, linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Hans de Goede <hdegoede@redhat.com>, Lior Amsalem <alior@marvell.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Tejun Heo <tj@kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Dear Gregory,

On Mon, 8 Feb 2016 18:14:13 +0100 Gregory CLEMENT wrote:

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
> index 21074f674bde..c621e69ed170 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -1,5 +1,11 @@
>  menu "Platform selection"
>  
> +config ARCH_MVEBU

it's better to keep ARCH_YYZZ sorted in alphabetic order

Thanks,
Jisheng

> +	bool "Marvell EBU SoC Family"
> +	help
> +	  This enables support for Marvell EBU family such as the
> +	  Armada 3700 SoC family.
> +
>  config ARCH_BCM_IPROC
>  	bool "Broadcom iProc SoC Family"
>  	help

