From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 06/15] arm: dts: Add devicetree for OrangePi 2G IoT board
Date: Mon, 3 Dec 2018 09:53:57 -0600
Message-ID: <CAL_JsqJ=88ORdgbRDn+VWk9=ydShidqwOxdAMfDbH4W2drnXzA@mail.gmail.com>
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org> <20181121033652.12247-7-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121033652.12247-7-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Amit Kucheria <amit.kucheria@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, zhao_steven@263.net, overseas.sales@unisoc.com
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 20, 2018 at 9:38 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add initial devicetree support for OrangePi 2G IoT board from Xunlong.
>
> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm/boot/dts/Makefile                    |  2 +
>  .../boot/dts/rda8810pl-orangepi-2g-iot.dts    | 40 +++++++++++++++++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b0e966d625b9..a0fdad8f10dd 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -806,6 +806,8 @@ dtb-$(CONFIG_ARCH_QCOM) +=3D \
>         qcom-msm8974-sony-xperia-castor.dtb \
>         qcom-msm8974-sony-xperia-honami.dtb \
>         qcom-mdm9615-wp8548-mangoh-green.dtb
> +dtb-$(CONFIG_ARCH_RDA) +=3D \
> +       rda8810pl-orangepi-2g-iot.dtb
>  dtb-$(CONFIG_ARCH_REALVIEW) +=3D \

Question for Arnd/Olof: can we *please* start putting new SoC families
in sub-dirs?

Rob
