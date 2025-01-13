Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBEF231CA3;
	Mon, 13 Jan 2025 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736754133; cv=none; b=ebF7RmQQ4Tn7RoLGpku7KHhuLBU8VicH2qbxzQpXGUfw/KIxQHfXXbRulYGbMILAcNhz1bGXNaEGoLZjDO/dgk7VVLYru11bnhiX1vsE8i4tPLbPYxfQ3gvYgUlFmQwvjvkZN2wNn2e4CwDFYDhLOD1NG5MThs0vbifdaXNCP5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736754133; c=relaxed/simple;
	bh=P0UjRQ/hGunWLonrV0Kdt3gfD3d/N1TG43eLYqhW888=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xb4Ty8xM/bTvA+mhv5X9OyWqaL9eR/pmlEK+0ujLh5lJR2YCMetPG80mzWyY3XuqjrDf4X35rB2qLEYagG+tTkRGeOXsUPZEf4WkZHc0t+kLzq3aFmZ3OsDYc7mIUB4xKWPM0rqdy2mAGxPl2wObSP59PQQRz2F1UE4YGJNeo/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQMnxZB9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQMnxZB9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A777C4CEE2;
	Mon, 13 Jan 2025 07:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736754132;
	bh=P0UjRQ/hGunWLonrV0Kdt3gfD3d/N1TG43eLYqhW888=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lQMnxZB9hIk4JqSFCd9Bx8OwlUPj6amJxaxbMr3DaDe0/KvkoNHVjP9GbfFmBCWj+
	 oVrrlVkzWEhH9MheF9VUFNyg+HesvgmCHtwpySEqCdEwxuaSZUE4Aq6mu657q/cAgH
	 93X/af2ZJfVyy2xW/ww+K4CayiawDbvQ+0imF4klfqrBgpnXoTfxE5cMwx+csd7V8Z
	 R4b+d3VIT6l6gJltwQ0ul8Qcxpm/+vQAAmaFnaYsj/7gz1B+XYD3aT5AP1TK9vxfZx
	 lwVUfVe6W1zaalFSVXQSfYhTVck231no64FKc9ZZFThG6zWF+XfK9O93o2/yQG6BhV
	 tzSFMDy5ZiS5w==
Message-ID: <3d2504b7-a566-4921-b04c-0eb272c93bae@kernel.org>
Date: Mon, 13 Jan 2025 08:42:04 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: serial: Add a new compatible string for
 ums9632
To: wenhua lin <wenhua.lin1994@gmail.com>
Cc: Stanislav Jakubek <stano.jakubek@gmail.com>, wenhua.lin@unisoc.com,
 Zhaochen.Su@unisoc.com, Zhirong.Qiu@unisoc.com,
 baolin.wang@linux.alibaba.com, brgl@bgdev.pl, cixi.geng@linux.dev,
 conor+dt@kernel.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, orsonzhai@gmail.com, robh@kernel.org,
 xiongpeng.wu@unisoc.com, zhang.lyra@gmail.com
References: <Zz8m8PqHX_7VzgoP@standask-GA-A55M-S2HP>
 <0b9495e8-b89e-4fff-b7a0-060d7631522a@kernel.org>
 <CAB9BWhdAQS5f2OpH8-PZXCWtWWybPJ+UaLvQNu4UacPF_sCg2A@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
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
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
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
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <CAB9BWhdAQS5f2OpH8-PZXCWtWWybPJ+UaLvQNu4UacPF_sCg2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/01/2025 03:29, wenhua lin wrote:
> On Thu, Nov 21, 2024 at 9:34 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 21/11/2024 13:26, Stanislav Jakubek wrote:
>>> Correct me if I'm wrong, but this patch seems incorrect to me.
>>> The 1st patch suggets that the sc9632-uart is incompatible with sc9836-uart,
>>> but here you make it fallback to it anyway.
>>>
>>> Also, both of the patches seem to have made it to linux-next without the
>>> reviews/Acks from maintainers. Maybe Greg was a bit too fast here :)
>>
>> Yeah, this looks odd and considering totally empty commit msg (nothing
>> useful there), it looks like wrong choice.
>>
>> Please explain the compatibility aspects. In the future: you have entire
>> commit msg to describe the hardware, instead of repeating the obvious -
>> what is visible from the diff.
>>
>> Best regards,
>> Krzysztof
> 
> Hi Krzysztof:
>    Thank you very much for your review, we will correct it in patch v2.
I wrote - commit msg, not changelog. Sigh...

Best regards,
Krzysztof
