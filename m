Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3510532B9BB
	for <linux-serial@vger.kernel.org>; Fri, 13 Feb 2026 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770976819; cv=none; b=dPRzzXjUHMQtBnBfpFhWdSPawOoH7S6fjVhuFiCKtSf2ogC0/X6DEXyr77S6Kw41BhGYOcjDpSDRbr7Sap8LGWTV7RX0MXrnqwxsPErruWOFYFzsXemoxPevkh5eEpc2EVTKwAV5FHfj8Z5NijH9VhB1s8JFVp5cKNh3wXv4LK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770976819; c=relaxed/simple;
	bh=hYdt0mOemDPJEc1IUoghgDpAbwCI//ho6Xs7557o2JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GqNflWTz4IeebC5H4VAGCFeFzENVTnulnmAbYg7fIFmMaiz2IbAuHBk1Ak57vTzxYUxMrwBqgRodotdvTgQcSmWGjSo9Yig3/Yrw2uf0bSSUU8EGkStA/cJlvaecwwtXdr9695Kggw9U39SUCQkhlc91+mQHKZjINBKuRTJK3y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0rhLaau; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0rhLaau"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C697CC116C6;
	Fri, 13 Feb 2026 10:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770976818;
	bh=hYdt0mOemDPJEc1IUoghgDpAbwCI//ho6Xs7557o2JY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z0rhLaauXaXdw5GMiCVZvlmuVttugUxltUA9KgFX/KsmRmoxwGgcdk/fvtRntc//H
	 Sl7GW4RpkO9eqxZieH3Ce630v+UunWvAeLhzavWO8jvPXV8e7nMZMfyayX2YHo82Aj
	 l+glx2nuyEFItjnua9LmDA4QjsvLNA2eijR5zZD8no37y+xdi4xjMeTK/Sd/MUFRmQ
	 1TCUOkw7IUnBH5XhDY/Kr9Om4JqByhQ9Y8ff+kgDEAlpQs/6bTwmYsqngrdms6X+5I
	 AxlL926a0ISwK7gcKuuXqtusobA0dOvmNRejkyHd/w3UI61EZbLKkioQDi1wxg/FPR
	 2tcL/ZyvUa8lQ==
Message-ID: <6ba2a916-739c-4c4a-92a6-951707aaa212@kernel.org>
Date: Fri, 13 Feb 2026 11:00:10 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] LRW UART: dt-bindings: Add binding for LRW UART
To: LiuQingtao <qtliu@mail.ustc.edu.cn>, gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, neil.armstrong@linaro.org,
 bjorn.andersson@oss.qualcomm.com, marex@nabladev.com, dev@kael-k.io,
 mani@kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
 liu.wenhong35@zte.com.cn, liu.qingtao2@zte.com.cn, hu.yuye@zte.com.cn,
 dai.hualiang@zte.com.cn, deng.weixian@zte.com.cn, jia.yunxiang@zte.com.cn,
 bai.lu5@zte.com.cn, yang.susheng@zte.com.cn, shen.lin1@zte.com.cn,
 tan.hu@zte.com.cn, zuo.jiang@zte.com.cn
References: <20260213093334.9217-1-qtliu@mail.ustc.edu.cn>
 <20260213093334.9217-2-qtliu@mail.ustc.edu.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <20260213093334.9217-2-qtliu@mail.ustc.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2026 10:33, LiuQingtao wrote:
> From: Wenhong Liu <liu.wenhong35@zte.com.cn>
> 
> Add documentation for LRW UART devicetree bindings.
> 
> Signed-off-by: Wenhong Liu <liu.wenhong35@zte.com.cn>
> Signed-off-by: Qingtao Liu <liu.qingtao2@zte.com.cn>

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters


A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> ---
>  .../bindings/serial/lrw,lrw-uart.yaml         | 49 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  MAINTAINERS                                   |  7 +++
>  3 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/lrw,lrw-uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/lrw,lrw-uart.yaml b/Documentation/devicetree/bindings/serial/lrw,lrw-uart.yaml
> new file mode 100644
> index 000000000000..a2d41c278c4f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/lrw,lrw-uart.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/lrw-uart.yaml#

Never tested, NAK. There are several other issues here, but I am not
going through rest of review if you did not bother to even build test
it. Please open any other recent binding and apply same style here
(filename, descriptions etc), so you won't be repeating SAME mistakes.


> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LRW serial UART
> +
> +maintainers:
> +  - Wenhong Liu <liu.wenhong35@zte.com.cn>
> +  - Qingtao Liu <liu.qingtao2@zte.com.cn>
> +
> +description: |
> +  Should be something similar to "lrw,<chip>-uart"
> +  for the UART as integrated on a particular chip, It supports
> +  multiple CPU architectures, currently including e.g. RISC-V and ARM.
> +
> +properties:
> +  compatible:
> +    const: lrw,lrw-uart

No way lrw is a chip if this is a company.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - current-speed
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    uart0: serial@e0001800 {
> +      compatible = "lrw,lrw-uart";
> +      interrupt-parent = <&aplic0>;
> +      interrupts = <0x12 0x4>;
> +      reg = <0xe0001800 0x100>;
> +      clocks = <&bar_clk>;
> +      current-speed = <115200>;
> +    };
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index ee7fd3cfe203..ec9bf262f466 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -961,6 +961,8 @@ patternProperties:
>      description: Loongson Technology Corporation Limited
>    "^loongmasses,.*":
>      description: Nanjing Loongmasses Ltd.
> +  "^lrw,.*":
> +    description: LRW Corp.

What is the website/domain address?


Best regards,
Krzysztof
