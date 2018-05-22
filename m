From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 2/8] dt-bindings: serial: Add bindings for
 nvidia,tegra194-tcu
Date: Tue, 22 May 2018 16:15:09 +0100
Message-ID: <3ddaafbd-d8cb-3cca-be4e-8c5c53fd9734@nvidia.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-3-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180508114403.14499-3-mperttunen@nvidia.com>
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
Cc: devicetree@vger.kernel.org, araza@nvidia.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


On 08/05/18 12:43, Mikko Perttunen wrote:
> Add bindings for the Tegra Combined UART device used to talk to the
> UART console on Tegra194 systems.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   .../bindings/serial/nvidia,tegra194-tcu.txt        | 35 ++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> new file mode 100644
> index 000000000000..86763bc5d74f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> @@ -0,0 +1,35 @@
> +NVIDIA Tegra Combined UART (TCU)
> +
> +The TCU is a system for sharing a hardware UART instance among multiple
> +systems withing the Tegra SoC. It is implemented through a mailbox-
> +based protocol where each "virtual UART" has a pair of mailboxes, one
> +for transmitting and one for receiving, that is used to communicate
> +with the hardware implementing the TCU.
> +
> +Required properties:
> +- name : Should be tcu
> +- compatible
> +    Array of strings
> +    One of:
> +    - "nvidia,tegra194-tcu"

Nit. We should say what device the above compatibility is applicable for ...

     - "nvidia,tegra194-tcu": for Tegra194

Cheers
Jon

-- 
nvpublic
