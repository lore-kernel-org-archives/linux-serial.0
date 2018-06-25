From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: tegra186-hsp: Add shared interrupts
Date: Mon, 25 Jun 2018 13:07:39 -0600
Message-ID: <20180625190739.GA10143@rob-hp-laptop>
References: <20180620122042.10950-1-mperttunen@nvidia.com>
 <20180620122042.10950-2-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180620122042.10950-2-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: mark.rutland@arm.com, jassisinghbrar@gmail.com, gregkh@linuxfoundation.org, thierry.reding@gmail.com, jonathanh@nvidia.com, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 20, 2018 at 03:20:35PM +0300, Mikko Perttunen wrote:
> HSP interrupts can be routed through exposed "shared interrupts". These
> interrupts can be mapped to various internal interrupt lines. Add
> interrupt properties for shared interrupts to the tegra186-hsp device
> tree bindings. At the same time, add the compatibility string for
> tegra194-hsp, which is backwards compatible with tegra186.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     - Edited commit message to not say that doorbell interrupts cannot be
>       routed to shared interrupts.
>     - Added tegra194 compatibility string.
> 
>  Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
