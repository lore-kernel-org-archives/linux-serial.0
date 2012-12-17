From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] serial: tegra: add serial driver
Date: Mon, 17 Dec 2012 14:36:03 -0700
Message-ID: <50CF9043.8030308@wwwdotorg.org>
References: <1355746249-15347-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1355746249-15347-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 12/17/2012 05:10 AM, Laxman Dewangan wrote:
> Nvidia's Tegra has multiple uart controller which supports:
> - APB dma based controller fifo read/write.
> - End Of Data interrupt in incoming data to know whether end
>   of frame achieve or not.
> - Hw controlled RTS and CTS flow control to reduce SW overhead.

> diff --git a/Documentation/devicetree/bindings/serial/nvidia,serial-tegra.txt b/Documentation/devicetree/bindings/serial/nvidia,serial-tegra.txt

> +NVIDIA Tegra20/Tegra30 high speed (dma based) UART controller driver.
> +
> +Required properties:
> +- compatible : should be "nvidia,tegra20-hsuart", "nvidia,tegra30-hsuart".

One question that isn't addressed here is:

Tegra has 5 UARTs. All of them can use the existing 8250.c by specifying
compatible = "nvidia,tegra20-uart". However, the 8250.c driver doesn't
support the DMA features of this driver. This driver is an alternate
driver for the same HW that allows DMA to be used with it, etc.

Since DT is supposed to describe the HW, modifying the DT to change the
compatible value in order to select a different driver in Linux doesn't
seem correct, or is it? Is there any kind of precedent for how to select
different drivers for the same HW at run-time? I'd wondered about using
the sysfs bind/unbind "methods" from user-space as the driver selection
mechanism...
