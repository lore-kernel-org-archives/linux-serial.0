From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: tegra186-hsp: Add shared interrupts
Date: Thu, 21 Jun 2018 09:05:13 +0100
Message-ID: <a6364fc7-3586-b4fd-1b8b-e145f7163ce5@nvidia.com>
References: <20180620122042.10950-1-mperttunen@nvidia.com>
 <20180620122042.10950-2-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180620122042.10950-2-mperttunen@nvidia.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mikko Perttunen <mperttunen@nvidia.com>, robh+dt@kernel.org, mark.rutland@arm.com, jassisinghbrar@gmail.com, gregkh@linuxfoundation.org, thierry.reding@gmail.com
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


On 20/06/18 13:20, Mikko Perttunen wrote:
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
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
> index b99d25fc2f26..620c249363ca 100644
> --- a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
> +++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
> @@ -15,12 +15,15 @@ Required properties:
>      Array of strings.
>      one of:
>      - "nvidia,tegra186-hsp"
> +    - "nvidia,tegra194-hsp", "nvidia,tegra186-hsp"
>  - reg : Offset and length of the register set for the device.
>  - interrupt-names
>      Array of strings.
>      Contains a list of names for the interrupts described by the interrupt
>      property. May contain the following entries, in any order:
>      - "doorbell"
> +    - "sharedN", where 'N' is a number from zero up to the number of
> +      external interrupts supported by the HSP instance minus one.
>      Users of this binding MUST look up entries in the interrupt property
>      by name, using this interrupt-names property to do so.
>  - interrupts

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
