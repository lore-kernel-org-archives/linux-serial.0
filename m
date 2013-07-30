From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 3/9] spi: tegra114: move to generic dma DT binding
Date: Tue, 30 Jul 2013 10:44:46 -0600
Message-ID: <51F7ED7E.5070000@wwwdotorg.org>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com> <1374639002-16753-4-git-send-email-rizhao@nvidia.com> <51F2CF53.30002@wwwdotorg.org> <20130730031536.GK15855@rizhao-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130730031536.GK15855@rizhao-lap>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Zhao <rizhao-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "djbw-b10kYP2dOMg@public.gmane.org" <djbw-b10kYP2dOMg@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On 07/29/2013 09:15 PM, Richard Zhao wrote:
> On Sat, Jul 27, 2013 at 03:34:43AM +0800, Stephen Warren wrote:
>> (Stripping CC list a bit)
>>
>> On 07/23/2013 10:09 PM, Richard Zhao wrote:
>>> - driver: remove use of nvidia,dma-request-selector
>>> 	  use dma_request_slave_channel to request channel
>>> - if dmas/dma-names are missing, it still supports cpu based transfer
>>> - update binding doc and specify dmas/dma-names properties as optional

>>> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
>>
>>> +Optional properties:
>>> +- dmas : The Tegra DMA controller's phandle and request selector for
>>> +  this SPI controller.
>>> +- dma-names : Should be "rx-tx".
>>
>> This should reference dma.txt which defines the DMA DT bindings. How about:
>>
>> ----------
>> Optional properties:
>> - dmas, dma-names : The DMA channel to use for DMA-mode operation. See
>>   dma.txt for the definition of these properties. A single entry named
>>   "rx-tx" must be specified.
>> ----------
> Ok. but how about replace "DMA channel" with "DMA request"?

Sure.
