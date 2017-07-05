From: Romain Perier <romain.perier@collabora.com>
Subject: Re: [PATCH 3/7] serial: imx: init dma_is_{rx|tx}ing variables
Date: Wed, 5 Jul 2017 12:14:57 +0200
Message-ID: <91cc9a48-58e9-98a9-58aa-1a949b9b5552@collabora.com>
References: <20170630120446.13994-1-romain.perier@collabora.com>
 <20170630120446.13994-4-romain.perier@collabora.com>
 <20170630141329.6144cddd@karo-electronics.de>
 <20170703065221.imbpbybsrd3of4ec@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170703065221.imbpbybsrd3of4ec@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nandor Han <nandor.han@ge.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello,


Le 03/07/2017 à 08:52, Uwe Kleine-König a écrit :
> On Fri, Jun 30, 2017 at 02:13:29PM +0200, Lothar Waßmann wrote:
>> Hi,
>>
>> On Fri, 30 Jun 2017 14:04:42 +0200 Romain Perier wrote:
>>> From: Nandor Han <nandor.han@ge.com>
>>>
>>> Initialize both dma_is_{rx|tx}ing variables when DMA is enabled to avoid
>>> checking uninitialized variables if port shutdown is requested before
>>> DMA channels get a chance to start.
>>>
>>> Signed-off-by: Nandor Han <nandor.han@ge.com>
>>> Signed-off-by: Romain Perier <romain.perier@collabora.com>
>>> ---
>>>  drivers/tty/serial/imx.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>>> index 188063d..81fb413 100644
>>> --- a/drivers/tty/serial/imx.c
>>> +++ b/drivers/tty/serial/imx.c
>>> @@ -1225,6 +1225,9 @@ static void imx_enable_dma(struct imx_port *sport)
>>>  
>>>  	imx_setup_ufcr(sport, TXTL_DMA, RXTL_DMA);
>>>  
>>> +	sport->dma_is_rxing = 0;
>>> +	sport->dma_is_txing = 0;
>>> +
>>>  	sport->dma_is_enabled = 1;
>>>  }
>>>  
>> sport is devm_kzalloc()ed, so the variables are initialized to 0 anyway.
> I'd agree to Lothar's statement. Did you find this issue by inspection,
> or does it fix a compiler warning? Do you think there is an actual
> problem?
>
> Best regards
> Uwe
>
What does happen if the UART port is shutdown and then re-enabled ? I
don't think that kzalloc will work in this case

Regards,
Romain
