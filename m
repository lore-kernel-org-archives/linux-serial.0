Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.74.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794058585;
	b=2zRA1a/zRUBojeX+mJLyv+RTjwwwY/DN78kZL4CcnmCztx4FEp2aEJ4bGpoLCkcWossb
	 Nc7yC7Wmz7YJye5ZMWiftwUJQeuf7RtxZd4N6eHAVkGMbyvYCwBcNgXsgtqF/xgdRUBmp
	 c3ewWTLIRd1IZ7dCDMjY8gz5nNoOa3hOe19As6Foa6uE7sYI3jBoteBLk2Kc5vMsgMUtI
	 YFt+PBEC6aZO7pydeNeqErCY0ywraxHsEdfS6+zHYv+FsSYrzDYsdEVlrtnmUCS6auhkw
	 Esnc2k0+IS/g7T/6Y5LjG8F+V1HxY/pY0uyXNmpVoM/+NyH3u9hTfhBKBC8HtrmZu5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058585;
	h=DMARC-Filter:Received:X-ICL-RepId:X-ICL-Out-Info:Dkim-Signature:
	 mail-alias-created-date:Received:Content-Type:Mime-Version:Subject:
	 From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Info-Out:X-Proofpoint-GUID:
	 X-JNJ;
	bh=rFxyzpjR8N7WWh7CzPxB6p/viDtuv0fjnp7Ia/uade4=;
	b=m7YLmIE7KZJRPtMsMuAifRMWcDS8OYvgMHrMB438YYFBRZdZwJDuIOj82D6wHgFZzg7A
	 LTC/NhTZiNOGikfxIElBnBWZ9MXpEGbE9UzE6OYpDVaO4rGUHd+zbTyhp5uAjUbFc4Iar
	 qebOY/igEL0AeGvxKfjywsJRyAgYp3A1pO+31KBrEU4HbfnXvagNk6Jit2ZeRQ3OWX/VW
	 3ZeUbtXWLIydgdpih+VvQSj+z7f89eVgkc5EHNFEWhZzC71YePUxJDAjqh/JlQCtcXd8E
	 1WNOYGhFG59aKhq8JvEylvkp58jz2T2ZqOO7qjLYE4ykjkWVwmmlIO8de1611AmTkFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=udp0.com;
	spf=pass smtp.mailfrom=udp0.com;
	dkim=pass header.d=udp0.com header.i=@udp0.com header.a=rsa-sha256 header.s=sig1 header.b=jpBoo1XD;
	arc=none smtp.remote-ip=57.103.74.23
Received: from outbound.ms.icloud.com (ms-2002j-snip4-11.eps.apple.com [57.103.74.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D02606A32C
	for <linux-serial@vger.kernel.org>; Sat,  7 Nov 2026 13:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70D02606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=udp0.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=udp0.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=udp0.com header.i=@udp0.com header.a=rsa-sha256 header.s=sig1 header.b=jpBoo1XD
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-2 (Postfix) with ESMTPS id 843571800123;
	Sat, 07 Nov 2026 13:36:15 +0000 (UTC)
X-ICL-RepId: 01a1b639-5e0e-742c-ae14-7d8c8fec6c3d
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtKAEMGWwZeCEEHQwVaC1BcHA4Edx5WAAlWUAJaS1QUBA1XHQdFUR9UWEEOCloFUFEdXwIKBEcEWxdGA1NFXwMXEVABWB5WXloXXk1HH0BNYkkBWhlbHEAXSm5NUw8PBV0IA0NUBF9QVBFXUAtZcEYIOgspB0YEMgFKHlkEWQJdAT0FWRpYADZ8THJcci4LR3o4RglHWxwTVhUNTUMSQhUEG0YeQwRfL10XXgxeBQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=udp0.com; s=sig1; t=1794058578; x=1825594578; bh=rFxyzpjR8N7WWh7CzPxB6p/viDtuv0fjnp7Ia/uade4=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=jpBoo1XD0//T3x3qRCR3Z3oH2nqYkExzXIldw4NIjVynVI5fZHEr3L2hzRX8Sny9Z02fnJWaDQNuwhMK8iRqjRm22js9KKpQAJ/IY4CraHlxYUg3aZuoh3/spQ6rKIMzjlmql9DT7SYSQ3HvTEl0iwKd1He3z4TPF9hj3XYsFc0s1bJsOcc5oeIKHLcJEjxW6RpHU/x/LODRE3JpJF5GL1fst6N7eNl67tt+9CN6yA7+kZs006b/pdrA8u/DQlU4BDPPplhaaB0E61XvAudTkEtu4GbQNMllRFcQX955cZe4aj+AL8VhJnX3Rf+z7wtNf/PESsxgqn4kBkxW0RoV8Q==
mail-alias-created-date: 1755760572767
Received: from smtpclient.apple (unknown [17.156.208.39])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-2 (Postfix) with ESMTPSA id 2672D1800125;
	Sat, 07 Nov 2026 13:36:09 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 4/4] arm64: dts: mediatek: Add MT6833 and the Xiaomi Redmi
 Note 13 5G
From: i@udp0.com
In-Reply-To: <FmgvoyT_AgANJAPnjEgEdlKRY0s2nXWF2Wm88KAM2KNKgiWpC0VzBcAukgMmYb_8H67s9wIRvgqcDgWO79Yc-PjdNoBiUS1KejZMWptvLhM=@protonmail.com>
Date: Sat, 7 Nov 2026 21:35:56 +0800
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 linux-watchdog@vger.kernel.org,
 linux-serial@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2B61B8D0-6B82-4320-8E64-32FE4A1EE97C@udp0.com>
References: <20261107-mt6833-base-v1-0-bda21083e9f3@udp0.com>
 <20261107-mt6833-base-v1-4-bda21083e9f3@udp0.com>
 <FmgvoyT_AgANJAPnjEgEdlKRY0s2nXWF2Wm88KAM2KNKgiWpC0VzBcAukgMmYb_8H67s9wIRvgqcDgWO79Yc-PjdNoBiUS1KejZMWptvLhM=@protonmail.com>
To: Roman Vivchar <rva333@protonmail.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)
X-Proofpoint-ORIG-GUID: xg0NYAvCjjnnHfMB8W3AAJqLJ_pQYUaR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDA1NCBTYWx0ZWRfX9RZQ/dWoFKZx
 /2cLfeuzZW6f/zXPfQiw3r8iS8TU9ObxI0mhgkemMaDyP/qm+x9tbhIsp8jv+1qtjdU6+aIU9Zw
 VD2/UxmhxQkJxQNxMQ0bitFhk3+OIkqQGXrpEtui55jX/4Bjqh6qN2WQSGDbRn0rWQudYyw3kcA
 kjg6Qd7kCVCo6IlTZytoTVRsnZ8+9UqleUc9Hsdcx44VTFE99MIH5NkUh4BsAXR5MwJR0E2isax
 q0wiVyDFRVx4gM8zPLZjZG2n9+x4A0KemXXbt80Z+PwzFcxuv3OcQbNaPh0WMDPDW1FGBmZQXd7
 zZr0E1uqJkbXOC1nvgI/Di6Y4Ary4c86GuDaYmbTKFvgv+qvoMtwNYBxzDloEE=
X-Authority-Info-Out: v=2.4 cv=AqjjHe9P c=1 sm=1 tr=0 ts=6aef2951
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bJxQ3BvwTHO1ZzqQ4rYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: xg0NYAvCjjnnHfMB8W3AAJqLJ_pQYUaR
X-JNJ: AAAAAAABXO7N7jFApZXgqN86sy/Yyaev+vDbjjG0xhSRuPW5ySlxe5l1R1j4CMFko3eWZy
 9uiccDWS1id2lmROUcivh7iBWIivtxpZ/Kud+KJQjUC7bkXI4LJzLh8Zs7Ud5rrrhQS1Uj
 RFkLqucaRqwPikr5cEG5cqxjkZucnJ4vaobuPGdKWkYfCVjv6QieusvzMVYv3ioK3depGx
 G9W0MiSsnnNHrCk/xOS1j7M0Y/76sO9Vh4kN4ic9sM4xrmmPfhL9P8h8sOwRGsBG3q00AZ
 6ZQE4LnPipbKSVrvs8umLGl+/UFk06QnGZGcWyRkbjCLUAgy19Z815n9YfxYa1MkGnsQe/
 7nLgrj9GYv2ctsy7n4WAqNK0idSLi0wkajpl8pfnxjTUiV7fFU35qAVZp1ZjTtUDxEWCtx
 diBeQ3wes7rKFLDkUPvKiwpejcA0ofr7+rEyeWwo7/aNL0FT0aath+U9E1+FhNGStHakmp
 DpYF8Uh3ZB1rAcsqaET0C+oWjK96mycfKMGnlCq3FnY6j0mb6+HhuRpPQzPN2z2BRqoE36
 esR9PUGMs6iR/HS+0onlnyCX26OWV19grkILNM+ZPve3Fgfr9RiRGaGcC6fMGcCQ1X2Pth
 TuNvTE7JZXfOtbv8r2clkwutkqWaCwWTm4tzk2R407PDLKILKG+sPtiK4/E26YDHMCfiCr
 xnodOd3j2qdmfnkw2mdQ9fLp1HIaUVKPj+eEnVdaIytBgBdNO8OwL2Wy8jeRvIccLC/W+d
 WWlvZMqCUN3S7bTz8SGQxDlYXrZCebAOS91tlzLSmG3zX4IyDZD0ZGXVa0/VGFJJkhboYk
 gSgyGv2Fsv4oalcwPgGSaKJuri5Z4eIKm1wJf7a0UhSaInsS9ADE6fbWAJvJZHNYR3q8De
 0RtP4ve8OLCM8+tErYUpjAHq1RegJ3K+/m2vBXOTDjcU2FSslOkc4TiV5xLO1wHk1mcRgf
 U21buSbmy6IWR8BggjsUeCBYrVSgKVuNP5NSeoIx3q7SqpDVvOhuP6muDzvkbg5TKZt58p
 L3Ud24Qe3iQioL23RDgdDlA1Q/GxMPxYbg6LWBG3dSdCyKtR5qUmb/Gr4STYWV4HnmSx+O
 bQn30Aon0BQDj0A142jMgLPJ7i/gm7xuRjlosBEkaxsxpHdSB1QDcTGSz4JB1J8brrz5FI
 SitIkmbYJmODT7L9BGhydaHKcbtqs96iU59kJJEYF2X055uXf8W7/Tjb6OBx9yqcXY2BN2
 egQCx2yexGksEUoDPP5FhYCIS9JqWLNECij2swduqb0vnKI+voWtUwQA+ObZlULRg3cIfl
 ssN6NMHsHkexDBDKZf7AFw5GhXPZ3sb7CIn+Scr8Jp6brlhMQGueKZhQNN1UOihHvjid06
 jCrns1WbLuJTfXRohsi3kbmz6XGaLqII660RA82/beAaeo3SzjsAbMaAAM4Bso+bdgvRkK
 HqJd/7qsATUd6mi0nnKt/jCNOY0knc

Hi Roman,

On Saturday, November 7th, 2026, Roman Vivchar wrote:
> Shouldn't the boot shim populate /memory and the dynamic =
/reserved-memory
> nodes from the vendor FDT instead of hardcoding them here? There are
> multiple phone variants, which may have different reserved memory =
addresses.

It already does: it takes the memory node and the regions LK reserves
from the tree LK passes, matched by address, so the ones here are only
the values from a 6 GB unit. You're right that they don't belong here,
then. In v2 the memory node will be left for the shim to size, and
reserved-memory will keep only what the kernel uses itself: the ramoops
region and the framebuffer.

> No interrupts?

I don't know of one routed to Linux. MediaTek's device tree for this
phone gives the watchdog none, nor do the mainline ones for MT8186,
MT8188, MT8192 and MT8195, and MediaTek's kernel registers a handler
with the secure firmware (MTK_SIP_KERNEL_WDT) for watchdog timeouts
rather than taking an interrupt.

Best regards,
Rui=
