From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: imx: RS-485 problems during TX, maybe DMA related
Date: Sat, 7 Jan 2017 14:45:57 +0100
Message-ID: <20170107134557.GA12299@archie.localdomain>
References: <20170104160024.GA13442@archie.localdomain>
 <CAOMZO5C3enuThR1DpcwNnqFdxd8tGoBwd76O62Gnviz8x1_a9w@mail.gmail.com>
 <20170106225026.GA3804@archie.localdomain>
 <CAOMZO5CywajwZEL8K2ATfS80WzqY69YVX+3S7hq9_HmNdNAwaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5CywajwZEL8K2ATfS80WzqY69YVX+3S7hq9_HmNdNAwaw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Nandor Han <nandor.han@ge.com>, Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Fabio,

On Fri, Jan 06, 2017 at 10:31:16PM -0200, Fabio Estevam wrote:
> Yes, I have tried like this:
> 
> &uart4 {
>     pinctrl-names = "default";
>     pinctrl-0 = <&pinctrl_uart4>;
>     uart-has-rtscts;
>     status = "okay";
> };
> 
> pinctrl_uart4: uart4grp {
> fsl,pins = <
>     MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA 0x1b0b1
>     MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA 0x1b0b1
>    MX6QDL_PAD_CSI0_DAT16__UART4_CTS_B 0x1b0b1
> >;
> };

I also mux RTS_B even though it is unused, not sure if it this makes a
difference to also add MX6QDL_PAD_CSI0_DAT17_UART4_RTS_B in your case?

It should work like this, I don't think using an extra GPIO is
necessary.

> 
> So I was never able to observe the DE pin toggling correctly.

But did you set SER_RS485_RX_DURING_TX in your flags? This is counter
intuitive, but I observed that it would not work otherwise.

> Maybe you could share your userspace application with me offline?

I am using a patched version of the busybox stty utility, I posted the
patch here, feel free to use it:
https://gist.github.com/clemensg/29bd68b3cfd719bd01002a2acde9662c

I use stty -F /dev/ttymxc4 clocal cread -hupcl -ixon -opost rs485
-rs485rtsonsend rs485rtsaftersend rs485rxduringtx

But for you it is probably rs485rtsonsend and -rs485rtsaftersend?

Regards,
Clemens
