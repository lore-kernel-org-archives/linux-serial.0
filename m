Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EFE30DD04;
	Fri, 12 Sep 2025 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682711; cv=none; b=pANGTI8+NEI74cB/j1adXRnT9Mah7x9UJl0bEF9I7pZFwWxLR/ICxkmMGESK3QG0UhkuZVEFI1u9ETTQwdMX/A2pMCskypAnq49AHwiqHJvwE4tEsnVM+KC2LWCVmyuFJWfiHXTEGWhTE339At2PG4AG39Hs3yNMDXwyRoWW1Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682711; c=relaxed/simple;
	bh=NWoUK1L6tJ83jZRAUU7n305TX9o/58Nkp8C9PBewDA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOWb/c7NCO+JXfBICPYjtJC7occquVVC71PaWm7SJtXxWmEhoSWkUGqsehG4q4EznlNqTR0mumuerzZNslTWFjzz/FRCxEmLiplehlu/Wtd+U5sFol1LS9j6CIcKIRmNYJuaT7A1LSwd5ghR+c4t3EmumypFvOu4zcM+asHUE1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gm/WI1HU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gm/WI1HU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F6AC4CEF1;
	Fri, 12 Sep 2025 13:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757682711;
	bh=NWoUK1L6tJ83jZRAUU7n305TX9o/58Nkp8C9PBewDA0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gm/WI1HUJ7qodlaUKyUiOPYnTT1YpgeGs6d++xyokuvBZD9aGmAZV007oTMQlbdjD
	 Z3fUmKlNaPmXeK+doiPaonG1HdZBl+noHbQI+2VojQJuu/TDm/HQMCex6mIIMyeRx+
	 eovDjV/j7oHY4RobWFiTzqyUdbISnKrCaj1NN7Yc/+wetzYk1hFOUb6yfkdrxhsoRr
	 KRcflX7gQxRJb2b8TbZWdwc9VYAj2cco0hac2mM61EQPc0Nu6VYP5PRSkkERE1bGk4
	 K1NvSoQOcGeHLkbOMu9xozchSac5sKXA3BB0zgj4pRj66D8QyUBR23RWEipaZCZLzd
	 iKDl/xq9ur0ww==
Message-ID: <94913844-e8d2-41da-ab4b-90f69b021bc2@kernel.org>
Date: Fri, 12 Sep 2025 15:11:42 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tty: serial: samsung: Remove unused artpec-8 specific
 code
To: Ravi Patel <ravi.patel@samsung.com>,
 'Geert Uytterhoeven' <geert@linux-m68k.org>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, jesper.nilsson@axis.com,
 lars.persson@axis.com, alim.akhtar@samsung.com, arnd@kernel.org,
 andriy.shevchenko@linux.intel.com, geert+renesas@glider.be,
 thierry.bultel.yh@bp.renesas.com, dianders@chromium.org,
 robert.marko@sartura.hr, schnelle@linux.ibm.com, kkartik@nvidia.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@axis.com,
 ksk4725@coasia.com, kenkim@coasia.com, smn1196@coasia.com,
 pjsin865@coasia.com, shradha.t@samsung.com
References: <CGME20250911141714epcas5p29f591a1d645c9c69dc5b7d2c2d12af50@epcas5p2.samsung.com>
 <20250911141605.13034-1-ravi.patel@samsung.com>
 <20250911141605.13034-4-ravi.patel@samsung.com>
 <CAMuHMdVe-FULHWk3QCBENG7TsbEZyxj0N5shhESxWBWd49JmOw@mail.gmail.com>
 <6df0e227-896b-438a-913e-95b637aa2b14@kernel.org>
 <8aeda67e-404e-4deb-ac90-015f2325ef64@kernel.org>
 <000101dc2335$ccd62f60$66828e20$@samsung.com>
 <abfaef6f-dd40-441d-86ec-7cd37c1e06b5@kernel.org>
 <002201dc23a4$e27e29c0$a77a7d40$@samsung.com>
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
In-Reply-To: <002201dc23a4$e27e29c0$a77a7d40$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/09/2025 07:19, Ravi Patel wrote:
>>>> Ah, no, I mixed up patches with recent DTS for Artpec-8. This serial ABI
>>>> was accepted three years ago (!!!), so you are Geert absolutely right -
>>>> that's ABI break.
>>>
>>> Thank you for your review.
>>>
>>> The DTS patches for ARTPEC-8 is added recently (https://lore.kernel.org/linux-samsung-soc/20250901051926.59970-1-
>> ravi.patel@samsung.com/)
>>> Before that, there was no user (in DT) of "axis,artpec8-uart" compatible.
>>> So I am not convinced of ABI break (considering patch #1 and #2 goes first with review comment fixes)
>>
>>
>> ABI is defined by bindings and implemented by kernel. Having DTS user is
>> irrelevant to fact whether ABI is or is not broken.
>>
>> Having DTS user determines the known impact of known ABI breakage.
> 
> OK. So does that mean if someone adds the ABI then it cannot be reverted,
> because of it breaks backword compatibility (users are using ABI in their local DTB) ?
> 
> Please suggest what should be the proper way.


Three years ago you (as in plural) submitted the Artpec-8 bindings and
driver with purpose. I think it was also claimed that DTS might come or
might not come ever, so the purpose was to supported out of tree users.

This means you made a contract in the kernel for that support.

You cannot change that ABI, because otherwise the contract you made
three years ago meant nothing.

You need to keep full backwards compatibility in the kernel. Look at
mailing list or git log how others dealt with it.

Best regards,
Krzysztof
