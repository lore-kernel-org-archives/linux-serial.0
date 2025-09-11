Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C045A1D8DFB;
	Thu, 11 Sep 2025 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581227; cv=none; b=C/yZ5ElxCmyL0svSivVqwdZRCOKs0xw3oxQdHW7p6+FxbZPPAWmJGdmBojfPvlftFQU+3Rt0mcDYxG55JvZH6Q7oSQ9k3yfpBDp0aGuRvuZGIWX/k19BgmiOzwM9Flh7+TxFJxWlWBgmipzXMk78MbH+2in9UieXUbqotbdMam0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581227; c=relaxed/simple;
	bh=MABwQ3+7+YgcFQDg54W+M2+alk8Qc13M7omCKmNLchA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SItP38qGMzYMHbqBKnaBVI2xP0pA9BQDnU7fjuCx4zto3K3NRvREX52udJdLg2KMclB/vPFD8S6wF9qjOK1BK7KtLsADwopAfW//3HxByhpgPAq8D4nuU0DY3x1LwMRq+0qRC7VPm9sOtEpCMcSVGxzGHxsmdL7E5xAEXz6hyoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jM9vdag0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jM9vdag0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B612C4CEF0;
	Thu, 11 Sep 2025 09:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757581227;
	bh=MABwQ3+7+YgcFQDg54W+M2+alk8Qc13M7omCKmNLchA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jM9vdag0netknClNaegVXbSNE5BWspMqNy9BlafJAJ0HELbecIkZwE1ouHRxstzAo
	 +6ndafzcoP3G/wt1kLeURKBAKr3hakdube+TSEI1Z8tiXE7vU+FkyQqp0ykXyO8F9d
	 DU2x9BXytTNORNhVb2EIJ/pYJVOQ57NKj833XJ4pxgGAvQbV6PoBq0jXzCZ+8xWQDe
	 xrJor3WeNnLiF6kxYaI6LyI2Pddm4GCJjORGB23fnCvjRVz/siglJj8kkAjL/c69cC
	 XPIBkFZAT4TSAgyNMXTXUDpFp5IFv1P9qiQPLqWCXDSnT2ycVvt4QV6Wxfwy7s11V2
	 4zf50kWU6bbJg==
Message-ID: <58fd8506-678e-409d-8283-1dc44c9aa8e2@kernel.org>
Date: Thu, 11 Sep 2025 11:00:22 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] LoongArch: dts: Add uart new compatible string
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen
 <chenhuacai@loongson.cn>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Haowei Zheng <zhenghaowei@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
 loongarch@lists.linux.dev, devicetree@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <cover.1757318368.git.zhoubinbin@loongson.cn>
 <2f93b8f20c6e93a15258888998e926814bfd0adf.1757318368.git.zhoubinbin@loongson.cn>
 <20250910-fast-seahorse-of-valor-bf6c86@kuoka>
 <CAMpQs4K-6Re=-gELPEg8kP_NKR5_1U=BD6fnXM3wgUF+eMtpGg@mail.gmail.com>
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
In-Reply-To: <CAMpQs4K-6Re=-gELPEg8kP_NKR5_1U=BD6fnXM3wgUF+eMtpGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/09/2025 09:55, Binbin Zhou wrote:
> Hi Krzysztof:
> 
> Thanks for your reply.
> 
> On Wed, Sep 10, 2025 at 4:27 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Tue, Sep 09, 2025 at 08:11:20PM +0800, Binbin Zhou wrote:
>>> Add loongson,ls2k*-uart compatible string on uarts.
>>>
>>> Co-developed-by: Haowei Zheng <zhenghaowei@loongson.cn>
>>> Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
>>> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
>>> ---
>>>  arch/loongarch/boot/dts/loongson-2k0500.dtsi | 2 +-
>>>  arch/loongarch/boot/dts/loongson-2k1000.dtsi | 2 +-
>>>  arch/loongarch/boot/dts/loongson-2k2000.dtsi | 2 +-
>>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/loongarch/boot/dts/loongson-2k0500.dtsi b/arch/loongarch/boot/dts/loongson-2k0500.dtsi
>>> index 588ebc3bded4..357de4ca7555 100644
>>> --- a/arch/loongarch/boot/dts/loongson-2k0500.dtsi
>>> +++ b/arch/loongarch/boot/dts/loongson-2k0500.dtsi
>>> @@ -380,7 +380,7 @@ tsensor: thermal-sensor@1fe11500 {
>>>               };
>>>
>>>               uart0: serial@1ff40800 {
>>> -                     compatible = "ns16550a";
>>> +                     compatible = "loongson,ls2k0500-uart", "ns16550a";
>>
>> You clearly never bothered to actually test this against own code.
> 
> Sorry, perhaps I should have included more detailed descriptions in
> the binding file.
> 
> As per Chapter 15 of the Loongson-3A5000 manual[1], the Loongson UART
> registers and functionality are compatible with the NS16550A. However,
> generic 16550A drivers cannot support full serial port capabilities,
> such as hardware flow control.
> 
> Based on your feedback in the V3 patchset[2], I attempted to use
> compatible fallbacks to avoid API breakage.
> 
> These fallbacks match according to the Makefile's compilation

DT bindings and fallbacks in DTS cannot match Makefile. You are mixing
concepts.

I said, this was not tested. I am 100% sure. Instead of replying with
irrelevant build related stuff, please come with actual arguments, e.g.
output (on some pastebin.com) of entire dtbs_check proving no new
warnings are there.

But even without warnings, I see with my own eyes that DTS is just
wrong. Or bindings.

Best regards,
Krzysztof
