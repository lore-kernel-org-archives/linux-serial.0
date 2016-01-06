From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/6] 8250/Kconfig: add config option
 CONFIG_SERIAL_8250_AMD
Date: Wed, 6 Jan 2016 11:46:02 +0100
Message-ID: <20160106104602.GA19507@pd.tnic>
References: <1451885501-2710-1-git-send-email-annie.wang@amd.com>
 <1451885501-2710-2-git-send-email-annie.wang@amd.com>
 <20160104144118.GJ22941@pd.tnic>
 <BLUPR12MB0433ABAC5C5D27D3FD0F4BF381F40@BLUPR12MB0433.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BLUPR12MB0433ABAC5C5D27D3FD0F4BF381F40@BLUPR12MB0433.namprd12.prod.outlook.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Wang, Annie" <Annie.Wang@amd.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Wan, Vincent" <Vincent.Wan@amd.com>, "Xue, Ken" <Ken.Xue@amd.com>, Robin Murphy <robin.murphy@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, "Li, Tony" <Tony.Li@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 06, 2016 at 02:08:18AM +0000, Wang, Annie wrote:
> How about I add select ARM_AMBA and SERIAL_8250 in arch/x86/Kconfig?

Yeah, select sounds good in that case, except in that particular case ...

> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index db3622f..0fe6657 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -537,11 +537,15 @@ config X86_AMD_PLATFORM_DEVICE
>         depends on ACPI
>         select COMMON_CLK
>         select PINCTRL
> +       select SERIAL_8250
> +       select ARM_AMBA

... that's a X86_AMD_PLATFORM_DEVICE which selects ARM thing? i.e.,
ARM_AMBA. Can that even work?

[ Rant on the side: And that ARM_AMBA thing has, of course, no effing
  help text. Dammit, people need to start explaining those cryptic
  abbreviations. Somewhere in the code I found "Advanced Microcontroller
  Bus Architecture". This is clearly suboptimal. ]

So why does the X86 platform device need to select the AMBA crap?

>         ---help---
>           Select to interpret AMD specific ACPI device to platform device
>           such as I2C, UART, GPIO found on AMD Carrizo and later chipsets.
>           I2C and UART depend on COMMON_CLK to set clock. GPIO driver is
> -         implemented under PINCTRL subsystem.
> +         implemented under PINCTRL subsystem. Carrizo's UART is implemented
> +         under SERIAL_8250. Carrizo's UART DMA device is an amba device,
> +         it selects ARM_AMBA option.

As I already said before, please refrain from using platform names like
Carrizo because people have no clue what those are. Only the marketing
people do. Use CPU family + models instead.

> CPU_SUP_AMD is only configured in X86 arch. AMD future  ARM64 processors may
> also need acpi to platform support.

So this code is going to be shared between X86 and ARM64?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
