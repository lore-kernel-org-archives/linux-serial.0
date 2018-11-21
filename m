From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 06/15] arm: dts: Add devicetree for OrangePi 2G IoT board
Date: Wed, 21 Nov 2018 09:55:18 +0100
Message-ID: <CAK8P3a0OqD=mxJmc2hPTp2s1-i1MPZWsjDF37hjSDKrFpzGxWg@mail.gmail.com>
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org> <20181121033652.12247-7-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121033652.12247-7-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, gregkh <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, zhao_steven@263.net, overseas.sales@unisoc.com
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 21, 2018 at 4:38 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> +       aliases {
> +               serial0 = &uart0;
> +               serial1 = &uart1;
> +               serial2 = &uart2;
> +       };
>
+
> +&uart2 {
> +       status = "okay";
> +       clocks = <&uart2_clk>;
> +};

This is clearly mismatched here: you mark only one uart as 'enabled, but
list three of them as aliases. Having 'serial0' point to a disabled uart
may easily break applications that expect the first one to be the
console.

Best make that

       serial0 = &uart2;

and drop the other ones if only one of them is exposed on the
board. If all three are usable, you should enable them all here,
and make sure that the numbering of the aliases matches the
labels on the board or its documentation.

        Arnd
