From: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Subject: Re: [PATCH_V2 33/34] MIPS: initial MIPS Creator CI20 board support
Date: Wed, 04 Feb 2015 21:56:46 +0100
Message-ID: <1423083406.27378.5.camel@x220>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
	 <1423063323-19419-34-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423063323-19419-34-git-send-email-Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2015-02-04 at 15:22 +0000, Zubair Lutfullah Kakakhel wrote:
> From: Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> 
> Add a device tree for the Ingenic jz4780 based MIPS Creator CI20 board.
> Note that this is unselectable via Kconfig until the jz4780 SoC is made
> selectable in a later commit.
> 
> Signed-off-by: Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
> ---
>  arch/mips/boot/dts/Makefile      |   1 +
>  arch/mips/boot/dts/ci20.dts      |  21 +++++++
>  arch/mips/configs/ci20_defconfig | 127 +++++++++++++++++++++++++++++++++++++++
>  arch/mips/jz4740/Kconfig         |  10 +++
>  4 files changed, 159 insertions(+)
>  create mode 100644 arch/mips/boot/dts/ci20.dts
>  create mode 100644 arch/mips/configs/ci20_defconfig
>[...]
> diff --git a/arch/mips/jz4740/Kconfig b/arch/mips/jz4740/Kconfig
> index 4689030..72ac174 100644
> --- a/arch/mips/jz4740/Kconfig
> +++ b/arch/mips/jz4740/Kconfig
> @@ -7,3 +7,13 @@ config JZ4740_QI_LB60
>  	bool "Qi Hardware Ben NanoNote"
>  
>  endchoice
> +
> +choice
> +	prompt "Machine type"
> +	depends on MACH_JZ4780
> +	default JZ4780_CI20
> +
> +config JZ4780_CI20
> +	bool "MIPS Creator CI20"
> +
> +endchoice

This adds a choice with a single entry. What's the point?


Paul Bolle

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
