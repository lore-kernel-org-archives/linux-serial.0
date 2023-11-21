Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="RXoBwfeh"
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255A0F4
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 00:27:06 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so71168201fa.1
        for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 00:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1700555224; x=1701160024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqky3k19T0P2MCRPH6CIBr7V91/rccfoXJK3y1NnIu8=;
        b=RXoBwfehoJeAAb/T8P5AZOycCs9u/0JqoVsUak2sN+0067mnfQ1AfKWpPoA0h2H/Wm
         Gvqyv3IyRTjhWIzM+gyO3nnHGti4jUUqtPlXs6db13IBlyDO8kBVTooXalGTarVC3Wtm
         OzV47uDPgoZ7NUNZQMEvbkRHZNr0TdGXtnwZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700555224; x=1701160024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqky3k19T0P2MCRPH6CIBr7V91/rccfoXJK3y1NnIu8=;
        b=Qgg0W041ZiLPCMJfSrUP1kxbWsBKEAfK7wMiDVUle0/GUEUF/LCVJlqSHIWyZVW8Wv
         dLV9G7oy2P/5GuMZ7Nh9rSG+PTQekEmu7gq2eLwsFw8KID8bcu0ggymbW+0jpnDIsO1l
         Ua8ZwgdUr/zVVp2O2Ydx7CA+dh5CEu8P1+5iZXANFjJwtMEEE5LC9RL6wAYDUt8LKf93
         UFGB5hkNqvNKZhxvpOWoG9WFnvGlsGWJGNnYrl2V53GqjZ6IpMCQi0Me1KhQjmt4Hr2T
         bmh5CAXehBohypCw194Q8VF23gynPmSIhJVj1HjmC9z0bX/D4eaZT1IhfYHsZrwhvxbh
         L05A==
X-Gm-Message-State: AOJu0YystD4WDS6WFhaU/7QJIMeCxprcQGIHJOqJ+ZzxRG9YDvQU2e16
	wOQEVSxnrzLzrWF9R2G6dH9UxQ==
X-Google-Smtp-Source: AGHT+IG7PzEFDvOVbc3ydtu7vTECnzCAornzVcTrO06lZCCYRpGCSSlBQv14R0Tk5YeOTa04wIdxgQ==
X-Received: by 2002:a19:f60d:0:b0:50a:5df2:f322 with SMTP id x13-20020a19f60d000000b0050a5df2f322mr7380823lfe.13.1700555224253;
        Tue, 21 Nov 2023 00:27:04 -0800 (PST)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id fc14-20020a056512138e00b0050aa8602e7dsm970575lfb.181.2023.11.21.00.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 00:27:03 -0800 (PST)
Message-ID: <1c016987-da88-47f2-bc1b-fcbe4c71a5c9@rasmusvillemoes.dk>
Date: Tue, 21 Nov 2023 09:27:03 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Content-Language: en-US, da
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <fd5c7d9f-a52b-4abb-a0d4-f5bdf2a669de@linaro.org>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <fd5c7d9f-a52b-4abb-a0d4-f5bdf2a669de@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/11/2023 08.52, Krzysztof Kozlowski wrote:
> On 20/11/2023 16:10, Rasmus Villemoes wrote:
>> Some boards are capable of both rs232 and rs485, and control which
>> external terminals are active via a gpio-controlled mux. Allow
>> describing that gpio in DT so that the kernel can transparently handle
>> the proper setting when the uart is switched between rs232 and rs485
>> modes.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>  Documentation/devicetree/bindings/serial/rs485.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
>> index 9418fd66a8e9..e8136c7d22ed 100644
>> --- a/Documentation/devicetree/bindings/serial/rs485.yaml
>> +++ b/Documentation/devicetree/bindings/serial/rs485.yaml
>> @@ -61,6 +61,11 @@ properties:
>>        the active state enables RX during TX.
>>      maxItems: 1
>>  
>> +  rs485-mux-gpios:
>> +    description: GPIO pin to control muxing of the SOC signals to the RS485
>> +      transceiver.
>> +    maxItems: 1
> 
> Aren't you duplicating
> https://lore.kernel.org/all/3Nk.ZZrp.5w3Yn0Ecy5C.1bMzDp@seznam.cz/ ?

Hadn't seen that, but no, this is not at all the same. That patch seems
to define an input pin to tell whether to enable rs485 mode or not (sort
of early run-time version of the linux,rs485-enabled-at-boot-time).

> Anyway, similar comments: this does not look like generic RS485
> property. Are you saying that standard defines such GPIO?

No, I'm saying that several boards that exist in the wild have the
RX/TX/CTS etc. pins routed to a multiplexer, which in turn routes those
signals to either a rs485 transceiver or an rs232 driver (and those in
turn are connected to different screw terminals). So no, it's not a
property of the rs485 protocol itself, but very much related to making
use of rs485 (and rs232, though of course not simultaneously) on such
boards.

Would a link to a schematic help?

Rasmus

