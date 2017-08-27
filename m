From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 RESEND 1/2] dt-bindings: serial: 8250: Add MediaTek
 BTIF controller bindings
Date: Sun, 27 Aug 2017 22:00:55 +0300
Message-ID: <8548a72a-4bf3-d44a-6d26-d64721cffe85@gmail.com>
References: <cover.1503165144.git.sean.wang@mediatek.com>
 <29b52a3b95982f1097766d515aae09c57e11b002.1503165144.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <29b52a3b95982f1097766d515aae09c57e11b002.1503165144.git.sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org, jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, hpeter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org



On 08/19/2017 09:06 PM, sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> From: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> 
> Document the devicetree bindings in 8250.txt for MediaTek BTIF
> controller which could be found on MT7622 and MT7623 SoC.
> 
> Signed-off-by: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>   Documentation/devicetree/bindings/serial/8250.txt | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
> index 419ff6c..7528d90 100644
> --- a/Documentation/devicetree/bindings/serial/8250.txt
> +++ b/Documentation/devicetree/bindings/serial/8250.txt
> @@ -14,6 +14,9 @@ Required properties:
>   	  tegra132, or tegra210.
>   	- "nxp,lpc3220-uart"
>   	- "ralink,rt2880-uart"
> +	- For MediaTek MT7623, must contain "mediatek,mt7623-btif"
> +	- For other MediaTek SoCs , must contain "mediatek,<chip>-btif",
> +	  "mediatek,mt7623-btif" where <chip> is mt7622.

Hm, to me that's confusing. What about:
"mediatek,mt7623-btif": for MediaTek MT7623
"mediatek,mt7622-btif", "mediatek,mt7623-btif": for MediaTek MT7622

If in the future we have more SoCs that support the BTIF, we should add them 
like the mt7622 case.

Make sense?

Regards,
Matthias
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
