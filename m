From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: serial: imx: disable DMA for RS-485 on i.MX6 SMP
Date: Sun, 2 Jul 2017 22:47:31 +0200
Message-ID: <20170702204731.GA7174@archie.localdomain>
References: <CAOMZO5DA++c95DPrmzOHfFtD+zFcW6G9-0_cRBtg0E8TA8dwXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5DA++c95DPrmzOHfFtD+zFcW6G9-0_cRBtg0E8TA8dwXg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <fabio.estevam@nxp.com>, u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>
List-Id: linux-serial@vger.kernel.org

Hi Fabio,

On Tue, Jun 20, 2017 at 08:49:28PM -0300, Fabio Estevam wrote:
> Hi Clemens,
> 
> On Tue, Jun 20, 2017 at 1:13 PM, Fabio Estevam <festevam@gmail.com> wrote:
> 
> > The subject gives the impression that the DMA will only be disabled
> > for RS485, but the impact of this change is wider.
> >
> > For example: if I have a mx6q system with a Bluetooth serial
> > connection I can no longer use DMA with your change applied.
> >
> > Ideally we should fix the RS485 DMA bug. If that is not possible, then
> > at least we need to restrict this change to the RS485 case.
> >
> > Maybe we need to pass "linux,rs485-enabled-at-boot-time" in device
> > tree and then use this property to deceide if DMA will be enabled or
> > not:
> >
> > if (!uart_console(port) && !sport->dma_is_inited && !sport->rs485_enabled)
> 
> Could you please test the two attached patches and see if it solves the issue?
> 
> Unfortunately I no longer have access to the RS485 half-duplex board.
> 
> Just make sure to pass 'linux,rs485-enabled-at-boot-time' in your
> device tree, thanks.

The two patches work for me!

You can add my Tested-by tag if/when you submit them.

Tested-by: Clemens Gruber <clemens.gruber@pqgruber.com>

Regards,
Clemens
