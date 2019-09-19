From: Philipp Puschmann <philipp.puschmann@emlix.com>
Subject: Re: [PATCH v2] serial: imx: adapt rx buffer and dma periods
Date: Thu, 19 Sep 2019 13:40:03 +0200
Message-ID: <9923d405-a62d-0c6a-6039-f4a7bc3bf2e8@emlix.com>
References: <20190919102628.23621-1-philipp.puschmann@emlix.com>
 <20190919112216.qjkx5wvqhsadjxg5@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190919112216.qjkx5wvqhsadjxg5@pengutronix.de>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, yibin.gong@nxp.com, fugang.duan@nxp.com, l.stach@pengutronix.de, jslaby@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Uwe

Am 19.09.19 um 13:22 schrieb Uwe Kleine-König:
> On Thu, Sep 19, 2019 at 12:26:28PM +0200, Philipp Puschmann wrote:
>> Using only 4 DMA periods for UART RX is very few if we have a high
>> frequency of small transfers - like in our case using Bluetooth with
>> many small packets via UART - causing many dma transfers but in each
>> only filling a fraction of a single buffer. Such a case may lead to
>> the situation that DMA RX transfer is triggered but no free buffer is
>> available. While we have addressed the dma handling already with
>> "dmaengine: imx-sdma: fix dma freezes" we still want to avoid
> 
> Is this statement still true now that you split this patch out of your
> bigger series?
Yes. The dma patches care about stopping DMA channel. This patch tries to
avoid that the channel runs out of usable buffers (aka dma periods).

> 
>> UART RX FIFO overrun. So we decrease the size of the buffers and
>> increase their number and the total buffer size.
> 
> What happens when such an RX FIFO overrun happens? Are characters lost?
> Or only time?
Good question. In explanation i have missed an important point:
When using HW flowcontrol via RTS/CTS and the buffer is full CTS is used to
tell the remote device - here the Bluetooth chip - to stop sending data.
For a while this prevents losing of characters. But then the remote device
comes into trouble as its internal TX buffers runs over. Depends on the
device how it handles this case and if it recovers if data flow is enabled
again.

In case without HW flow control characters would be lost. Depends on the upper
layer what happens then.

> Does your change have an influence if I do fewer but
> bigger transfers?
Don't think so. The dma periods are raw data buffers. If one is full the next one
is being used. For the performance i don't see a significant difference between
using 1 kB buffers or 4 kB buffers.

Regards,
Philipp

> 
> Best regards
> Uwe
>
