From: Patrice CHOTARD <patrice.chotard@st.com>
Subject: Re: [PATCH v2 09/10] ARM: dts: STiH407-family: Use new Pinctrl groups
Date: Mon, 30 Jan 2017 10:10:39 +0000
Message-ID: <ce65d79a-3697-40f8-edd5-026c68588489@st.com>
References: <20170127172804.23881-1-lee.jones@linaro.org>
 <20170127172804.23881-10-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170127172804.23881-10-lee.jones@linaro.org>
Content-Language: en-US
Content-ID: <CD968295BC5BFB459938DF159DB06E1B@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "dt@kernel.org" <dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@stlinux.com" <kernel@stlinux.com>
List-Id: linux-serial@vger.kernel.org

Hi Lee

On 01/27/2017 06:28 PM, Lee Jones wrote:
> Having just defined some new Pinctrl groups for when when HW flow-

double "when"

> control is {en,dis}abled, let's reference them for use within the
> driver.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 3 +--
>  arch/arm/boot/dts/stih410-b2260.dts   | 5 ++++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index c8b2944..e480e32 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -222,9 +222,8 @@
>  			compatible = "st,asc";
>  			reg = <0x9830000 0x2c>;
>  			interrupts = <GIC_SPI 122 IRQ_TYPE_NONE>;
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&pinctrl_serial0>;
>  			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> +			/* Pinctrl moved out to a per-board configuration */
>
>  			status = "disabled";
>  		};
> diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
> index fa16aba..8deecf6 100644
> --- a/arch/arm/boot/dts/stih410-b2260.dts
> +++ b/arch/arm/boot/dts/stih410-b2260.dts
> @@ -62,8 +62,11 @@
>  		/* Low speed expansion connector */
>  		uart0: serial@9830000 {
>  			label = "LS-UART0";
> -			status = "okay";
> +			pinctrl-names = "default", "manual-rts";
> +			pinctrl-0 = <&pinctrl_serial0_flowctrl>;
> +			pinctrl-1 = <&pinctrl_serial0>;
>  			rts-gpios = <&pio17 3 GPIO_ACTIVE_LOW>;
> +			status = "okay";
>  		};
>
>  		/* Low speed expansion connector */
>
