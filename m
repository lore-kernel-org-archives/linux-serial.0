Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3X+8ThW"
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4AA9D
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 23:49:50 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9ff26d7c0a6so389886966b.2
        for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 23:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700639389; x=1701244189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tA93eCFLSfnhMv8UdjAyC+zZ7+4dyfaA0Xw2zTteOig=;
        b=d3X+8ThWFydM2AXS5hj/F+orhp0lU70Y5J+MNByVF53CfGZMmcNAUnwoa1Kx/yjNSS
         bE5IG0mq+FAdd7PDkQayNyDo420urd9zlgyK68hSoxqkSH+XcEbfEgR5SwtmHCI5asRI
         /sHNP2taQZxLUKlWN6Dw7iZ6ZNbefXwUamfG+IkNraW++8lV+tV8qgDJMLUY8/dxubI7
         jYr02k2XBZFQFv297kaTl/OSkCChAqNsXJIOAMNkRMuKfUAshoBCyMDwas7WoAFtlejW
         Qtu4rFfOff4aVDYsLjpKrH7bFPAaLtBVW43qdKFGfoff5SnvoS6oT4ITC8GRxVRF5OSK
         /S4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700639389; x=1701244189;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tA93eCFLSfnhMv8UdjAyC+zZ7+4dyfaA0Xw2zTteOig=;
        b=T1a2MhGY58ovjK0vey0a0pGRvzjNoLYUeTi/rCfqwwKYHq8v+L5AY/O7K0ecrLXESr
         2Q1UtuuT7H1DvuFjk3dd7QseoYgm1/voPM9Dn/W+Jz/Pf+MUONOIuqHKhsbR0LBjCWpN
         XMsQS3ATk2+EKaT8f5L9dC03WsBAZh9EOKSbZaRuSs5ETxmS04c94VJgnGs5m3LOdaId
         EtObEPHE1eBeoP4BRbFXfgQNL1Gu6l2TX6dukbsiOOovkfMG1tr3KGYu6CSpOtoRi+sn
         Gyct9+egpo496pSY2x11mnTjIvCg/bg1WfsA537CpGCR6T7XPTDBLOnjVXLKVy9LbA57
         RBUA==
X-Gm-Message-State: AOJu0Yy6nXdBUQfmqZ5tZB5fwZRIzWRs57clrTwrFdCnP7RGknYOmpGr
	hfyLeP/IcEl1PkzTVJCdcosrYg==
X-Google-Smtp-Source: AGHT+IGLb9wZbJRJ1P2bvfJCf4gFjriONNwbkuU1fWwQ1XFrJzHgcrBULnkRPu2iTXoFZHalECh3dQ==
X-Received: by 2002:a17:906:cc:b0:9fe:43a0:4ac0 with SMTP id 12-20020a17090600cc00b009fe43a04ac0mr836991eji.24.1700639388592;
        Tue, 21 Nov 2023 23:49:48 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id i9-20020a170906250900b009ca522853ecsm6237228ejb.58.2023.11.21.23.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 23:49:48 -0800 (PST)
Message-ID: <35990cd2-a4d3-473e-893e-aa16c1c63289@linaro.org>
Date: Wed, 22 Nov 2023 08:49:44 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/19] dt-bindings: serial: samsung: Make
 samsung,uart-fifosize required property
Content-Language: en-US
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>
Cc: krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
 conor+dt@kernel.org, sboyd@kernel.org, tomasz.figa@gmail.com,
 s.nawrocki@samsung.com, linus.walleij@linaro.org, wim@linux-watchdog.org,
 linux@roeck-us.net, catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
 olof@lixom.net, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 cw00.choi@samsung.com, alim.akhtar@samsung.com, tudor.ambarus@linaro.org,
 andre.draszik@linaro.org, semen.protsenko@linaro.org, saravanak@google.com,
 willmcvicker@google.com, soc@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-watchdog@vger.kernel.org, kernel-team@android.com,
 linux-serial@vger.kernel.org
References: <20231120212037.911774-1-peter.griffin@linaro.org>
 <20231120212037.911774-10-peter.griffin@linaro.org>
 <20231121151630.GA1692178-robh@kernel.org>
 <CADrjBPo4qw4eJLuGsv7aK4V7QjGR_n_MQ+W-Rrq92iATSLFHZQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CADrjBPo4qw4eJLuGsv7aK4V7QjGR_n_MQ+W-Rrq92iATSLFHZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/11/2023 18:15, Peter Griffin wrote:
> Hi Rob,
> 
> Thanks for your review.
> 
> On Tue, 21 Nov 2023 at 15:16, Rob Herring <robh@kernel.org> wrote:
>>
>> On Mon, Nov 20, 2023 at 09:20:27PM +0000, Peter Griffin wrote:
>>> Specifying samsung,uart-fifosize in both DT and driver static data is error
>>> prone and relies on driver probe order and dt aliases to be correct.
>>>
>>> Additionally on many Exynos platforms these are (USI) universal serial
>>> interfaces which can be uart, spi or i2c, so it can change per board.
>>>
>>> For google,gs101-uart and exynosautov9-uart make samsung,uart-fifosize a
>>> required property. For these platforms fifosize now *only* comes from DT.
>>>
>>> It is hoped other Exynos platforms will also switch over time.
>>
>> Then allow the property on them.
> 
> Not sure I fully understand your comment. Can you elaborate? Do you
> mean leave the 'samsung,uart-fifosize' as an optional property like it
> is currently even for the platforms that now require it to be present
> to function correctly?
> 
> I deliberately restricted the yaml change to only require this
> property for the SoCs that already set the 'samsung,uart-fifosize'  dt
> property. As setting the property and having the driver use what is
> specified in DT also requires a corresponding driver update (otherwise
> fifosize gets overwritten by the driver static data, and then becomes
> dependent on probe order, dt aliases etc). The rationale was drivers
> 'opt in' and add themselves to the compatibles in this patch as they
> migrate away from obtaining fifo size from driver static data to
> obtaining it from DT.

Your code diff looks like you are adding the property only to these models.

> 
>>
>>>
>>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
>>> ---
>>>  .../bindings/serial/samsung_uart.yaml           | 17 +++++++++++++++++
>>>  1 file changed, 17 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
>>> index ccc3626779d9..22a1edadc4fe 100644
>>> --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
>>> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
>>> @@ -133,6 +133,23 @@ allOf:
>>>              - const: uart
>>>              - const: clk_uart_baud0
>>>
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - google,gs101-uart
>>> +              - samsung,exynosautov9-uart
>>> +    then:
>>> +      properties:
>>> +        samsung,uart-fifosize:
>>> +          description: The fifo size supported by the UART channel.
>>> +          $ref: /schemas/types.yaml#/definitions/uint32
>>> +          enum: [16, 64, 256]
>>
>> We already have 'fifo-size' in several drivers. Use that. Please move
>> its type/description definitions to serial.yaml and make drivers just do
>> 'fifo-size: true' if they use it.
> 
> What do you suggest we do for the samsung,uart-fifosize property that
> is being used upstream?

Nothing, your diff is just wrong. Or at least nothing needed. Just drop
all this properties: here and only make it required for Google GS101.


> 
>>
>>> +
>>> +      required:
>>> +       - samsung,uart-fifosize
>>
>> A new required property is an ABI break. Please explain why that is okay
>> in the commit message.
>>
> 
> I can update the commit message to make clear there is an ABI break.
> As mentioned above the platforms where this is now required are either
> already setting the property or are new in this series. Is that
> sufficient justification?
Yes, but only first case. You need to order your patches correctly -
first is ABI break expecting ExynopsAutov9 to provide FIFO size in DTS
with its explanation. Second commit is adding GS101 where there is no
ABI break.

Best regards,
Krzysztof

