From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: serial: sprd: Add clocks and
 clocks-names properties
Date: Thu, 28 Feb 2019 13:52:20 -0600
Message-ID: <20190228195219.GA12933@bogus>
References: <cover.1550560916.git.baolin.wang@linaro.org>
 <c2b4db380c044bebe9fdf546b8a9f3aa351c6867.1550560916.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c2b4db380c044bebe9fdf546b8a9f3aa351c6867.1550560916.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org, broonie@kernel.org, lanqing.liu@unisoc.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 19 Feb 2019 15:31:12 +0800, Baolin Wang wrote:
> From: Lanqing Liu <lanqing.liu@unisoc.com>
> 
> This patch adds clocks and clocks-names properties, which are used to do
> power management for our UART driver.
> 
> Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  .../devicetree/bindings/serial/sprd-uart.txt       |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
