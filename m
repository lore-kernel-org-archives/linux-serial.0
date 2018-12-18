From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 03/11] ARM: Prepare RDA8810PL SoC
Date: Tue, 18 Dec 2018 14:51:32 +0100
Message-ID: <CAK8P3a3h8upNttd15EfBTAAP_EQEbQ0fsqtjjzYy9QZdzj=jmQ@mail.gmail.com>
References: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org> <20181218034132.5070-4-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218034132.5070-4-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>, gregkh <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-unisoc@lists.infradead.org, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, zhao_steven@263.net
List-Id: linux-serial@vger.kernel.org

On Tue, Dec 18, 2018 at 4:42 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> --- /dev/null
> +++ b/arch/arm/mach-rda/Kconfig
> @@ -0,0 +1,9 @@
> +menuconfig ARCH_RDA
> +       bool "RDA Micro SoCs"
> +       depends on ARCH_MULTI_V7
> +       select COMMON_CLK
> +       select GENERIC_IRQ_CHIP
> +       select RDA_INTC
> +       select RDA_TIMER
> +       help
> +         This enables support for the RDA Micro 8810PL SoC family.

I would drop the 'COMMON_CLK' and 'GENERIC_IRQ_CHIP' selects here,
as they are implied by ARCH_MULTI_V7.

      Arnd
