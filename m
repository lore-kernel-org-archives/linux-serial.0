Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F38735B632;
	Wed, 13 May 2026 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695672; cv=none; b=SIihVqbCE6aYJTK7VG5prqLkCkM0+WynZY1FSfvnkcI+79TGKWvUqnanKMDMGdEZuLijPxQQefZdOoQQTQQanC1PAqdsCKEK/TnvEO+ou1qNyKnMu7iPRBEzjLd7uNLbmyu5zZBtsY/GGacBwM9yrgXkdOoaP/z41hOBy66j7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695672; c=relaxed/simple;
	bh=2OZp1D4J6nCudtldfqfQQZXSnW0Ffzi18jRZlS94kJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwXdZSTedxwaZihfuma1rnNMcu1npuxim1+P8lftE9cP6C6xMrICjHGuvdhFtRvJL4x1KDjygn1H4qBi/g84SRVCnx7TGDLj0mT0RN8ue1qi8NmUb1Upo2ZHWbWahzGDRsiwfOrFU2+8Axf1C+4AMG/KSPadYahEar8YGq8E7GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+fgN9Gl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+fgN9Gl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E014C19425;
	Wed, 13 May 2026 18:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778695671;
	bh=2OZp1D4J6nCudtldfqfQQZXSnW0Ffzi18jRZlS94kJ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K+fgN9GlffBqKLi+Yd72iVzB5CqPvtLP1MLZoYxSsBX3VqhGXicZgEOBdQZaF3y+A
	 E3h27Le0yc2sWj3ay60rX6FpQeaR+gDfiVe1BgVMrzVPu1zZ27yF1TgrKm5S5H655W
	 Y2TftOuhDqJJtwNESwcAiaYWhZzVV2W+MLAngReD1Ls7o3gmPuG51KqICyVGRpb3TK
	 3WFBC6lHwXrl+fSexkNwF7i2wcqhSxicc8Wm63YVli3D8+Tcp863sR3M7VnktqOvRT
	 0XzAODnCXaa4Gd/1Qf+wkLiWfSN/c+VxX92IKzR3Or+tT92XKKdhIwOfLMx75lliZa
	 os4o6PhfdzmCg==
Message-ID: <04b8c5eb-03fa-444c-86c1-07beb20e13f5@kernel.org>
Date: Wed, 13 May 2026 20:07:42 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] LRW UART: dt-bindings: Add binding for LRW UART
To: liu.qingtao2@zte.com.cn
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marex@nabladev.com, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 rdunlap@infradead.org, geert+renesas@glider.be, quic_zongjian@quicinc.com,
 arturs.artamonovs@analog.com, robert.marko@sartura.hr,
 hvilleneuve@dimonoff.com, thierry.bultel.yh@bp.renesas.com,
 julianbraha@gmail.com, flavra@baylibre.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, liu.wenhong35@zte.com.cn,
 dai.hualiang@zte.com.cn, deng.weixian@zte.com.cn, jia.yunxiang@zte.com.cn,
 bai.lu5@zte.com.cn, yang.susheng@zte.com.cn, shen.lin1@zte.com.cn,
 zuo.jiang@zte.com.cn, hu.shengming@zte.com.cn, gao.rui@zte.com.cn,
 tan.hu@zte.com.cn
References: <202605130853.64D8r4bc045011@mse-fl2.zte.com.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <202605130853.64D8r4bc045011@mse-fl2.zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/05/2026 10:43, liu.qingtao2@zte.com.cn wrote:
> Thanks for your kindly review. Sorry for the delay.
> 
>> On 13/02/2026 10:33, LiuQingtao wrote:
>>> From: Wenhong Liu <liu.wenhong35@zte.com.cn>
>>>
>>> Add documentation for LRW UART devicetree bindings.
>>>
>>> Signed-off-by: Wenhong Liu <liu.wenhong35@zte.com.cn>
>>> Signed-off-by: Qingtao Liu <liu.qingtao2@zte.com.cn>
>>
>> Please use subject prefixes matching the subsystem. You can get them for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching. For bindings, the preferred subjects are
>> explained here:
>> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
>>
>>
>> A nit, subject: drop second/last, redundant "bindings". The
>> "dt-bindings" prefix is already stating that these are bindings.
>> See also:
>> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 
> Thanks for the notice. I will change the subject to "Add devicetree binding for ZTE LRX UART controller"
> in the v2 patch series.

NAK. Read the comment again. You improved nothing.

> 
> 
>>> ---
>>>  .../bindings/serial/lrw,lrw-uart.yaml         | 49 +++++++++++++++++++
>>>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>>>  MAINTAINERS                                   |  7 +++
>>>  3 files changed, 58 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/serial/lrw,lrw-uart.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/serial/lrw,lrw-uart.yaml b/Documentation/devicetree/bindings/> serial/lrw,lrw-uart.yaml
>>> new file mode 100644
>>> index 000000000000..a2d41c278c4f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/serial/lrw,lrw-uart.yaml
>>> @@ -0,0 +1,49 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/serial/lrw-uart.yaml#
>>
>> Never tested, NAK. There are several other issues here, but I am not
>> going through rest of review if you did not bother to even build test
>> it. Please open any other recent binding and apply same style here
>> (filename, descriptions etc), so you won't be repeating SAME mistakes.
>>
>>
> 
> Sorry, i tested on an older version kernel.
> No errors or warnings ever showed up running the command
> "make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/serial/zte,lrx-uart.yaml".
> 

Don't work on older kernel. It's not an excuse.

Best regards,
Krzysztof
