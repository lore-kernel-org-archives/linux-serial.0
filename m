From: Romain Perier <romain.perier@collabora.com>
Subject: Re: [PATCH v2 1/6] serial: imx: only set DMA rx-ing when DMA starts
Date: Thu, 6 Jul 2017 10:31:38 +0200
Message-ID: <49bfa666-b036-3ed9-8209-9ea59468371b@collabora.com>
References: <20170705130706.10388-1-romain.perier@collabora.com>
 <20170705130706.10388-2-romain.perier@collabora.com>
 <20170705132910.nmixhnh4l6h2hlga@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170705132910.nmixhnh4l6h2hlga@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nandor Han <nandor.han@ge.com>
List-Id: linux-serial@vger.kernel.org

Hello,


Le 05/07/2017 à 15:29, Uwe Kleine-König a écrit :
> Hello,
>
> On Wed, Jul 05, 2017 at 03:07:01PM +0200, Romain Perier wrote:
>> From: Nandor Han <nandor.han@ge.com>
>>
>> Avoid the situation when `dma_is_rxing` could incorrectly signal that
>> DMA RX channel is receiving data in case DMA preparation or sg mapping
>> fails.
>>
>> This commit fixes the issues by moving the assignment of dma_is_rxing
>> out of imx_disable_rx_int(), then the variable is set to 1 from
>> start_rx_dma() only when the preparation is correctly done.
> I'd write:
>
> 	There are a few issues with setting dma_is_rxing to 1 in
> 	imx_disable_rx_int:
>
> 	 - Currently always after imx_disable_rx_int() the function
> 	   start_rx_dma() is called. This dependency isn't obvious though.
> 	 - start_rx_dma() does error checking and might exit without enabling
> 	   DMA but keeping dma_is_rxing 1.
>
> 	So the more natural place for setting dma_is_rxing to 1 is in
> 	start_rx_dma after all errors are checked.
>
> If you use this, there is nothing left of Nandor Han's patch and you can
> drop his authorship.
>
> Best regards
> Uwe
>
Ok, will do. No other feedback for the rest of the series ? (just to
know if I send a v3 or If I wait a bit...)

Thanks,
Romain
