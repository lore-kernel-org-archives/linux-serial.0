From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] serial: tegra: add serial driver
Date: Mon, 17 Dec 2012 15:04:04 -0700
Message-ID: <50CF96D4.6010705@wwwdotorg.org>
References: <1355746249-15347-1-git-send-email-ldewangan@nvidia.com> <50CF9043.8030308@wwwdotorg.org> <50CF9580.4050300@firmworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50CF9580.4050300-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mitch Bradley <wmb-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 12/17/2012 02:58 PM, Mitch Bradley wrote:
> On 12/17/2012 11:36 AM, Stephen Warren wrote:
>> On 12/17/2012 05:10 AM, Laxman Dewangan wrote:
>>> Nvidia's Tegra has multiple uart controller which supports:
>>> - APB dma based controller fifo read/write.
>>> - End Of Data interrupt in incoming data to know whether end
>>>   of frame achieve or not.
>>> - Hw controlled RTS and CTS flow control to reduce SW overhead.
>>
>>> diff --git a/Documentation/devicetree/bindings/serial/nvidia,serial-tegra.txt b/Documentation/devicetree/bindings/serial/nvidia,serial-tegra.txt
>>
>>> +NVIDIA Tegra20/Tegra30 high speed (dma based) UART controller driver.
>>> +
>>> +Required properties:
>>> +- compatible : should be "nvidia,tegra20-hsuart", "nvidia,tegra30-hsuart".
>>
>> One question that isn't addressed here is:
>>
>> Tegra has 5 UARTs. All of them can use the existing 8250.c by specifying
>> compatible = "nvidia,tegra20-uart".
> 
> The way it is supposed to work is that the compatible property should
> list "nvidia,tegra30-hsuart" first, followed by a fallback name that
> refers to the generic 8250 compatibility.  Having the 8250.c driver bind
> to the more-specific tegra30-hsuart name is wrong.

8250.c binds to nvidia,tegra20-uart, so that aspect is fine.

However, the real issue is that we probably want 4 of the 5 ports to use
the plain old 8250.c (so as not to use up too many DMA channels), but
just 1 of the ports to use the DMA-capable high-performance driver (e.g.
the one that a particular board has hooked up to a Bluetooth radio). The
only way to do that with DT that I know of would be to specify different
subsets of legal compatible values for each UART in the per-board .dts file.
