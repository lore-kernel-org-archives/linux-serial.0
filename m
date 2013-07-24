From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 7/9] ASoC: tegra: move to generic DMA DT binding
Date: Wed, 24 Jul 2013 08:58:27 +0200
Message-ID: <51EF7B13.4050207@metafoo.de>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com> <1374639002-16753-8-git-send-email-rizhao@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1374639002-16753-8-git-send-email-rizhao@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Richard Zhao <rizhao@nvidia.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, alsa-devel@alsa-project.org, grant.likely@linaro.org, rob.herring@calxeda.com, rob@landley.net, swarren@wwwdotorg.org, vinod.koul@intel.com, djbw@fb.com, broonie@kernel.org, gregkh@linuxfoundation.org, lgirdwood@gmail.com, linuxzsc@gmail.com, ldewangan@nvidia.com, dev@lynxeye.de
List-Id: linux-serial@vger.kernel.org

On 07/24/2013 06:10 AM, Richard Zhao wrote:
> - add tegra_dma_filter_data to specify dma info
>    DMA DT binding needs the device that raise dma request and dma name
>    to request a dma channel. tegra30_i2s is a special case. It should be ahub
>    device and it also has dma name that cannot handled by ASoC dmaengine code.
>    So we pass the info using filter data in snd_dmaengine_dai_dma_data.

How about extending the generic dmaengine PCM driver so that it is possible to 
specify the the DMA channel names? I think that will make the code a bit 
simpler and also allow you to remove tegra_pcm.c completely eventually.

- Lars
