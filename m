From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [patch v4 3/5] DT nodes for AST2500 DMA UART driver
Date: Thu, 1 Aug 2019 13:28:03 -0600
Message-ID: <CAL_Jsq+jP6iDdthmXdKVroq5NLWNKgBoZ8Y99TwccFFAerfKBA@mail.gmail.com>
References: <1564147640-30753-1-git-send-email-open.sudheer@gmail.com> <1564147640-30753-4-git-send-email-open.sudheer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1564147640-30753-4-git-send-email-open.sudheer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "sudheer.v" <open.sudheer@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Mark Rutland <mark.rutland@arm.com>, ShivahShankar Shakarnarayan rao <shivahshankar.shankarnarayanrao@aspeedtech.com>, Sudheer V <sudheer.veliseti@aspeedtech.com>, sudheer veliseti <sudheer.open@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jul 26, 2019 at 7:25 AM sudheer.v <open.sudheer@gmail.com> wrote:
>
> From: sudheer veliseti <sudheer.open@gmail.com>
>
> DT node for DMA controller(ast_uart_sdma) doesn't bind to any DMA controller driver.
> This is because Software for DMA controller is not based on DMA framework,but is dedicated
> and serves only UARTs in AST2500. ast_uart_sdma node is searched by compatible string in the
> driver software.basic use of this node is to provide register base address of DMA controller and DMA irq number(<50>).
> IRQ of DMA controller is of crucial importance, which does RX and TX of UART data.
>
> uart nodes dma_uart1,2...etc binds to the platform driver.
> irq numbers <9>,<32>,<33>,<34> in dma_uart nodes install ISRs which are of not much interest in uart data TX/RX .
>
>
> Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
> ---
>
> changes from v3->v4:
> -
> changes from v2->v3:
> - change logs added
>
>  arch/arm/boot/dts/aspeed-ast2500-evb.dts | 21 +++++++
>  arch/arm/boot/dts/aspeed-g5.dtsi         | 71 ++++++++++++++++++++++--
>  2 files changed, 88 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
> index 5dbb33c10c4f..4da09fbe94df 100644
> --- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
> +++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
> @@ -64,6 +64,27 @@
>         status = "okay";
>  };
>
> +&ast_uart_sdma {
> +       status = "okay";
> +};
> +
> +&dma_uart1 {
> +       status = "okay";
> +};
> +
> +&dma_uart2 {
> +       status = "okay";
> +};
> +
> +&dma_uart3 {
> +       status = "okay";
> +};
> +
> +&dma_uart4 {
> +       status = "okay";
> +};
> +
> +
>  &mac0 {
>         status = "okay";
>
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 674746513031..fb7b3ed463de 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -23,10 +23,10 @@
>                 i2c11 = &i2c11;
>                 i2c12 = &i2c12;
>                 i2c13 = &i2c13;
> -               serial0 = &uart1;
> -               serial1 = &uart2;
> -               serial2 = &uart3;
> -               serial3 = &uart4;
> +               serial0 = &dma_uart1;
> +               serial1 = &dma_uart2;
> +               serial2 = &dma_uart3;
> +               serial3 = &dma_uart4;
>                 serial4 = &uart5;
>                 serial5 = &vuart;
>                 peci0 = &peci0;
> @@ -497,6 +497,69 @@
>                                 status = "disabled";
>                         };
>
> +                       ast_uart_sdma: uart_sdma@1e79e000 {
> +                               compatible = "aspeed,ast-uart-sdma";
> +                               reg = <0x1e79e000 0x400>;
> +                               interrupts = <50>;
> +                               status = "disabled";
> +                       };
> +
> +                       dma_uart1: dma_uart1@1e783000{
> +                               compatible = "aspeed,ast-sdma-uart";
> +                               reg = <0x1e783000 0x1000>;

Now you have 2 nodes at the same address. That's not valid. Please
build your dtbs with 'W=1' which will warn against this. Adding DMA
support should not be a whole new node. Nodes correspond to h/w
blocks, not drivers.

The old node has a reset, you don't need that? Seems strange too that
only 1 uart has a reset.

> +                               reg-shift = <2>;
> +                               interrupts = <9>;
> +                               clocks = <&syscon ASPEED_CLK_GATE_UART1CLK>;
> +                               dma-channel = <0>;

This is the channel in ast_uart_sdma? Just because you decided not to
do a DMA engine driver, doesn't mean you can't use the DMA binding.
Considering you need to map clients to the provider, use the DMA
binding.

> +                               no-loopback-test;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pinctrl_txd1_default
> +                                                        &pinctrl_rxd1_default>;
> +                               status = "disabled";
> +                       };
> +
> +                       dma_uart2: dma_uart2@1e78d000{
> +                               compatible = "aspeed,ast-sdma-uart";
> +                               reg = <0x1e78d000 0x1000>;
> +                               reg-shift = <2>;
> +                               interrupts = <32>;
> +                               clocks = <&syscon ASPEED_CLK_GATE_UART2CLK>;
> +                               dma-channel = <1>;
> +                               no-loopback-test;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pinctrl_txd2_default
> +                                                        &pinctrl_rxd2_default>;
> +                               status = "disabled";
> +                       };
> +
> +                       dma_uart3: dma_uart3@1e78e000{
> +                               compatible = "aspeed,ast-sdma-uart";
> +                               reg = <0x1e78e000 0x1000>;
> +                               reg-shift = <2>;
> +                               interrupts = <33>;
> +                               clocks = <&syscon ASPEED_CLK_GATE_UART3CLK>;
> +                               dma-channel = <2>;
> +                               no-loopback-test;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pinctrl_txd3_default
> +                                                        &pinctrl_rxd3_default>;
> +                               status = "disabled";
> +                       };
> +
> +                       dma_uart4: dma_uart4@1e78f000{
> +                               compatible = "aspeed,ast-sdma-uart";
> +                               reg = <0x1e78f000 0x1000>;
> +                               reg-shift = <2>;
> +                               interrupts = <34>;
> +                               clocks = <&syscon ASPEED_CLK_GATE_UART4CLK>;
> +                               dma-channel = <3>;
> +                               no-loopback-test;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pinctrl_txd4_default
> +                                                        &pinctrl_rxd4_default>;
> +                               status = "disabled";
> +                       };
> +
>                         i2c: bus@1e78a000 {
>                                 compatible = "simple-bus";
>                                 #address-cells = <1>;
> --
> 2.17.1
>
