From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: serial: sprd: Add dma properties to
 support DMA mode
Date: Tue, 12 Mar 2019 13:22:02 -0500
Message-ID: <20190312182202.GA10396@bogus>
References: <cover.1551689518.git.baolin.wang@linaro.org>
 <5ef1bbcf1d78829f28377a599d81d0adc7d61ef1.1551689518.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5ef1bbcf1d78829f28377a599d81d0adc7d61ef1.1551689518.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org, broonie@kernel.org, lanqing.liu@unisoc.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon,  4 Mar 2019 16:58:23 +0800, Baolin Wang wrote:
> From: Lanqing Liu <lanqing.liu@unisoc.com>
> 
> This patch adds dmas and dma-names properties for the UART DMA mode.
> 
> Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  .../devicetree/bindings/serial/sprd-uart.txt       |    6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
