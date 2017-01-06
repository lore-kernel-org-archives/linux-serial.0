From: Fabio Estevam <festevam@gmail.com>
Subject: Re: imx: RS-485 problems during TX, maybe DMA related
Date: Fri, 6 Jan 2017 19:22:32 -0200
Message-ID: <CAOMZO5C3enuThR1DpcwNnqFdxd8tGoBwd76O62Gnviz8x1_a9w@mail.gmail.com>
References: <20170104160024.GA13442@archie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170104160024.GA13442@archie.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nandor Han <nandor.han@ge.com>, Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Clemens,

On Wed, Jan 4, 2017 at 2:00 PM, Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
> Hi,
>
> I observed odd behavior of the current tty/serial/imx.c driver in RS-485
> mode.
>
> RX works fine, but TX does not: When sending data, it arrives multiple

I am also trying to get rs485 in half-duplex mode to work on mx6dl
with kernel 4.9.

RX also works for me, but TX does not.

On my board it is the MX6QDL_PAD_CSI0_DAT16__UART4_RTS_B pin that
controls the rs485 transceiver flow, but I do not
see RTS to toggle to 1 during transmit. It stays always at 0.

I see you use CTS pin instead, but I thought RTS pin should be used.

On my userspace application I have:

/* enable RS485 mode: */
rs485conf.flags |= SER_RS485_ENABLED;

/* set logical level for RTS pin equal to 1 when sending: */
rs485conf.flags |= SER_RS485_RTS_ON_SEND;

/* set logical level for RTS pin equal to 0 after sending: */
rs485conf.flags &= ~(SER_RS485_RTS_AFTER_SEND);

Any ideas as to how to make RTS go to one so that the data can go
through the rs485 transceiver?

Thanks
