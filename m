Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B5E525A69;
	Thu, 15 Oct 2026 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070071; cv=none; b=FD8k6F59xTT1n0NnNm1b9ePubZux/mAbf8/TB08WOguSn3FQgxNhSpy7chN6rCzAn7aeMecfOkqCNxkTJCVVMVCzM+1vBHynJNqZ4EuqJy+/HUelwmSe33iz8uox3O7i6Sh3UB9L2duBgLRH/PQYqGznaw9RvSYUFmEeHVxYTXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070071; c=relaxed/simple;
	bh=Z7Ajd7UkvjpJE4SCW6+tEEpuAM+GxWaOjJPvp5T2YvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXGGmJQPg+oRSmT2Vhcb0iVAFQTp4a89UfH/ObwXxJEtXCrJIkZ8VqVvz4BMd8ayjY0JC75j0nUPWmLdd1UKddPuE8vL1O+6QPQJLwLXWPhCRoeXTrBCH3vLjDDrOYFzEVEEVV0X0ZUOvVUOgsbe6t/KmBTnwlwl+4Rq+pgQ8jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B391F000C4;
	Thu, 15 Oct 2026 13:14:28 +0000 (UTC)
Message-ID: <73a8df68-17da-4275-bb9d-8a6272b754e6@linux-m68k.org>
Date: Thu, 15 Oct 2026 23:14:26 +1000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] dt-bindings: serial: create binding for mcf-uart
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-m68k@lists.linux-m68k.org,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org
References: <20261013120831.1046590-1-gerg@linux-m68k.org>
 <20261013120831.1046590-5-gerg@linux-m68k.org>
 <20261014-expensive-shrewd-nautilus-abcab6@quoll>
 <d256f39c-6ed5-409a-a7ed-224165d00521@linux-m68k.org>
 <CAMuHMdUcGt7RBc0d1A-8O1Dt71RL=epPgmnetj_4NGCPvCj9LA@mail.gmail.com>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <CAMuHMdUcGt7RBc0d1A-8O1Dt71RL=epPgmnetj_4NGCPvCj9LA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geert,

On 15/10/26 19:19, Geert Uytterhoeven wrote:
> On Wed, 14 Oct 2026 at 14:56, Greg Ungerer <gerg@linux-m68k.org> wrote:
>> On 14/10/26 21:24, Krzysztof Kozlowski wrote:
>>> On Tue, Oct 13, 2026 at 10:07:02PM +1000, Greg Ungerer wrote:
>>>> Create documentation for a new binding to support the Freescale ColdFire
>>>> UART hardware block. This is found on pretty much all variants of the
>>>> M68K derived Freescale ColdFire family of System-on-Chip devices.
>>>>
>>>> It is not compatible with any other known UARTs.
>>>
>>> You never tested this, so limited review.
>>
>> It is tested. It is working and running on multiple ColdFire platforms.
>>
>>>> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> 
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/serial/fsl,mcf-uart.yaml
> 
>>>> +properties:
>>>> +  compatible:
>>>> +    const: fsl,mcf-uart
>>>
>>> What is the SoC name? MCF? Compatibles must be specific (see writing
>>> bindings doc).
>>
>> Yes. MCF = "Motorola ColdFire". It is the SoC prefix used for naming of all
>> ColdFire parts (which is dozens of variants):
>>
>>    MCF5206
>>    MCF5208
>>    MCF5307
>>    MCF54415
>>    etc
>>
>> Even when Motorola became Freescale they stuck with MCF on all ColdFire parts.
> 
> I guess you want:
> 
>     items:
>       - enum:
>           - fsl,mcf5206
>           - fsl,mcf5208
>           - fsl,mcf5307
>             [...]
>       - const: fsl,mcf-uart
> 
> As no new (possibly incompatible) Coldfire parts will appear, a generic
> fallback looks reasonable to me.

It will be a long list of variants - thanks Freescale. Quite a few of the SoC
parts have sub-parts with different single digits, for example:

    mcf54410, mcf54415, mcf54416, mcf54417, mcf54118

At a quick count I can see about 42 variants. 
I don't mind adding the full list if that is preferred.


> An "mcf" vs. "motorola" vendor prefix might still be a discussion point ;-)

At least they didn't rename the chip part numbers when they renamed the company ;-)

Regards
Greg

