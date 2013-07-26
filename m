From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/9] spi: tegra114: move to generic dma DT binding
Date: Fri, 26 Jul 2013 13:34:43 -0600
Message-ID: <51F2CF53.30002@wwwdotorg.org>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com> <1374639002-16753-4-git-send-email-rizhao@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:41428 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704Ab3GZTer (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Jul 2013 15:34:47 -0400
In-Reply-To: <1374639002-16753-4-git-send-email-rizhao@nvidia.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Zhao <rizhao@nvidia.com>
Cc: devicetree@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-tegra@vger.kernel.org, Ian Campbell <ian.campbell@citrix.com>, linux-arm-kernel@lists.infradead.org, Mark Rutland <Mark.Rutland@arm.com>, linux-serial@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, rob.herring@calxeda.com, vinod.koul@intel.com, djbw@fb.com

(Stripping CC list a bit)

On 07/23/2013 10:09 PM, Richard Zhao wrote:
> - driver: remove use of nvidia,dma-request-selector
> 	  use dma_request_slave_channel to request channel
> - if dmas/dma-names are missing, it still supports cpu based transfer
> - update binding doc and specify dmas/dma-names properties as optional

I'll simply repeat the comments I already made downstream:

Most commit messages aren't written as bullet points. This might be
better written as:

----------
Convert the Tegra114 SPI driver to support the standard DMA device-tree
bindings.

Note that DMA mode is optional; if the DT properties required to support
DMA are missing, then the driver will fall back to pure CPU operation.
----------

> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt

> +Optional properties:
> +- dmas : The Tegra DMA controller's phandle and request selector for
> +  this SPI controller.
> +- dma-names : Should be "rx-tx".

This should reference dma.txt which defines the DMA DT bindings. How about:

----------
Optional properties:
- dmas, dma-names : The DMA channel to use for DMA-mode operation. See
  dma.txt for the definition of these properties. A single entry named
  "rx-tx" must be specified.
----------

