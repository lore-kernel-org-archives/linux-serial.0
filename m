From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 0/9] ARM: tegra: move to generic DMA DT binding
Date: Fri, 26 Jul 2013 13:25:20 -0600
Message-ID: <51F2CD20.6030700@wwwdotorg.org>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Richard Zhao <rizhao@nvidia.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, alsa-devel@alsa-project.org, grant.likely@linaro.org, rob.herring@calxeda.com, rob@landley.net, vinod.koul@intel.com, djbw@fb.com, broonie@kernel.org, gregkh@linuxfoundation.org, lgirdwood@gmail.com, linuxzsc@gmail.com, ldewangan@nvidia.com, dev@lynxeye.de
List-Id: linux-serial@vger.kernel.org

On 07/23/2013 10:09 PM, Richard Zhao wrote:
> The patch series aim to move apbdma to generic DT binding.
> 
> Changes:
> - It add dmas/dma-names properties while leave
>   nvidia,dma-request-selector to be compatible.
> - update apbdma driver and dma client drivers
> - ASoC tegra adds a new struct to pass device and dma-name.
> - at last, remove legacy nvidia,dma-request-selector

I would like to take this series through the Tegra tree to simplify
dependencies. So, I'm looking for ack's on the drivers rather than for
them to be applied. I had hoped Richard would point this out when
posting the patches.
