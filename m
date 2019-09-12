From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 0/4] Fix UART DMA freezes for iMX6
Date: Thu, 12 Sep 2019 15:23:34 -0300
Message-ID: <CAOMZO5BKiZGF=iR071DaWLp-_7wTVJKLbOn3ihwPeVVSNF6nCg@mail.gmail.com>
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190911144943.21554-1-philipp.puschmann@emlix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Puschmann <philipp.puschmann@emlix.com>, Robin Gong <yibin.gong@nxp.com>, Fugang Duan <fugang.duan@nxp.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Vinod <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, dmaengine@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Philipp,

Thanks for submitting these fixes.

On Wed, Sep 11, 2019 at 11:50 AM Philipp Puschmann
<philipp.puschmann@emlix.com> wrote:
>
> For some years and since many kernel versions there are reports that
> RX UART DMA channel stops working at one point. So far the usual workaround was
> to disable RX DMA. This patches try to fix the underlying problem.
>
> When a running sdma script does not find any usable destination buffer to put
> its data into it just leads to stopping the channel being scheduled again. As
> solution we we manually retrigger the sdma script for this channel and by this
> dissolve the freeze.
>
> While this seems to work fine so far a further patch in this series increases
> the number of RX DMA periods for UART to reduce use cases running into such
> a situation.
>
> This patch series was tested with the current kernel and backported to
> kernel 4.15 with a special use case using a WL1837MOD via UART and provoking
> the hanging of UART RX DMA within seconds after starting a test application.
> It resulted in well known
>   "Bluetooth: hci0: command 0x0408 tx timeout"
> errors and complete stop of UART data reception. Our Bluetooth traffic consists
> of many independent small packets, mostly only a few bytes, causing high usage
> of periods.
>
>
> Philipp Puschmann (4):
>   dmaengine: imx-sdma: fix buffer ownership
>   dmaengine: imx-sdma: fix dma freezes
>   serial: imx: adapt rx buffer and dma periods
>   dmaengine: imx-sdma: drop redundant variable

I have some suggestions:

1. Please split this in two series: one for dmaengine and other one for serial

2. Please add Fixes tag when appropriate, so that the fixes can be
backported to stable kernels.

3. Please Cc Robin and Andy

Thanks
