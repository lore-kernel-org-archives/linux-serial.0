From: Fabio Estevam <festevam@gmail.com>
Subject: Re: imx: RS-485 problems during TX, maybe DMA related
Date: Fri, 6 Jan 2017 22:31:16 -0200
Message-ID: <CAOMZO5CywajwZEL8K2ATfS80WzqY69YVX+3S7hq9_HmNdNAwaw@mail.gmail.com>
References: <20170104160024.GA13442@archie.localdomain> <CAOMZO5C3enuThR1DpcwNnqFdxd8tGoBwd76O62Gnviz8x1_a9w@mail.gmail.com>
 <20170106225026.GA3804@archie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170106225026.GA3804@archie.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nandor Han <nandor.han@ge.com>, Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Clemens,

On Fri, Jan 6, 2017 at 8:50 PM, Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:

> But according to the i.MX Pins tool, they can be muxed vice-versa too.
> So if you connected the transceiver-enable to ball L4 (CSI0_DAT16), you
> could mux MX6QDL_PAD_CSI0_DAT16__UART4_CTS_B and
> MX6QDL_PAD_CSI0_DAT17__UART4_RTS_B instead?

Yes, I have tried like this:

&uart4 {
    pinctrl-names = "default";
    pinctrl-0 = <&pinctrl_uart4>;
    uart-has-rtscts;
    status = "okay";
};

pinctrl_uart4: uart4grp {
fsl,pins = <
    MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA 0x1b0b1
    MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA 0x1b0b1
   MX6QDL_PAD_CSI0_DAT16__UART4_CTS_B 0x1b0b1
>;
};

In this case the DE pin of the rs485 transceiver is always at 0 then
RX works and TX does not.

Then I tried to use a gpio for controling the rts line:

&uart4 {
    pinctrl-names = "default";
    pinctrl-0 = <&pinctrl_uart4>;
    rts-gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>;
    status = "okay";
};

pinctrl_uart4: uart4grp {
fsl,pins = <
    MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA 0x1b0b1
    MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA 0x1b0b1
    MX6QDL_PAD_CSI0_DAT16__GPIO6_IO02 0x1b0b1
>;
}

In this case the DE pin of the rs485 transceiver is always at 1, then
TX works and RX does not.

So I was never able to observe the DE pin toggling correctly.

Maybe you could share your userspace application with me offline?

Thanks
