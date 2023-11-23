Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="cuNGAaXJ"
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D391B3
	for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 05:48:55 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507a5f2193bso940285e87.1
        for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 05:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1700747334; x=1701352134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYJ9RINpWO/etmrdmn1FP6FlQ9EPAx5C4AtYkJeamEI=;
        b=cuNGAaXJmWlRWqjJena6EFfVjKGaTvWz50yhLoPjEGVBOVDyrKuDtQAO2HT57j7tHQ
         KnbtiC8F+y86KMXPGZ5Vz6Eoiee/j0izmlHp/DrfhkIZt/C+oCqtBUnsyWaiazNB7vaB
         GDhgUMMzUIG+wmW+QS0seAE97+h3JBUuvBJP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700747334; x=1701352134;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYJ9RINpWO/etmrdmn1FP6FlQ9EPAx5C4AtYkJeamEI=;
        b=q6TrvaftXmHLtqzjPwUgJszz8GHELpf+hbp/50DkgE/w4f9BOBgkFMp+rWvxjo/CWg
         7gZzPpLty8P0ThkC29jUrRb7pOhhYR0Dvai+YIVIishl+J/Bk6uBWWHYXcZI5FSJ2lbo
         UE81P6GdaLiWAKxtYGjC8eAzjf4l5QTUZBDTVL50vi1BSRabsAWhPE7m4fYymPIzGWLE
         Ltl9eUu+id0oJJf/oHeem6RbUZkBPDxAhAPbxYQhCh0IaGqryYPA9dAQxsdQDLu1Jf1K
         /bQTcucfItjvWx6evAEo/hmwyjbWHtTwm+CW8gYUaAfiopz8bqvVTvBgIGk1QxVqMaKv
         cZuA==
X-Gm-Message-State: AOJu0YypGGq87q5e0rKRk3fxXPHmr+7gXeWMToy7e49+hqdre3szN+Km
	yhkR9maTV02rfw+H9hyzBJosuA==
X-Google-Smtp-Source: AGHT+IG4CVoPRUAn77ky2ffnCHCPrIVvxiwyxMrF5VOgYS9HaFefUSItqzrdzQkf09aJ01Bo2N1g3g==
X-Received: by 2002:a19:7512:0:b0:50a:a31c:39b1 with SMTP id y18-20020a197512000000b0050aa31c39b1mr865785lfe.9.1700747333878;
        Thu, 23 Nov 2023 05:48:53 -0800 (PST)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t6-20020a056512068600b005094486b705sm199933lfe.16.2023.11.23.05.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 05:48:53 -0800 (PST)
Message-ID: <b8df5f0c-a3cd-4cad-b1c6-db89686464fc@rasmusvillemoes.dk>
Date: Thu, 23 Nov 2023 14:48:52 +0100
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
To: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
 Lino Sanfilippo <LinoSanfilippo@gmx.de>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Peter Rosin <peda@axentia.se>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <20231122145344.GA18949@wunner.de>
 <e731c0a9-7a5c-41c3-87aa-d6937b99d01a@rasmusvillemoes.dk>
 <20231123103802.GA30056@wunner.de>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20231123103802.GA30056@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/11/2023 11.38, Lukas Wunner wrote:
> On Thu, Nov 23, 2023 at 11:07:16AM +0100, Rasmus Villemoes wrote:
>> On 22/11/2023 15.53, Lukas Wunner wrote:
>>> But if that patch gets accepted, we'd have *three* different modes:
>>> RS-232, RS-485, RS-422.  A single GPIO seems insufficient to handle that.
>>> You'd need at least two GPIOs.
>>
>> I don't see Crescent introducing any new gpio that needs to be handled.
>> In fact, I can't even see why from the perspective of the software that
>> rs422 isn't just rs232; there's no transmit enable pin that needs to be
>> handled. But maybe the uart driver does something different in rs422
>> mode; I assume he must have some update of some driver, since otherwise
>> the new rs422 bit should be rejected by the core. So I can't really see
>> the whole picture of that rs422 story.
> 
> The question is, could we conceivably have the need to support
> switching between the three modes RS-232, RS-485, RS-422.
> If yes, then the GPIO mux interface should probably allow for that.
> 
> As a case in point, the Siemens IOT 2040 has two serial ports
> which can be set to either of those three modes.  The signals
> are routed to the same D-sub socket, but the pins used are
> different.  See page 46 and 47 of this document:
> 
> https://cache.industry.siemens.com/dl/files/658/109741658/att_899623/v1/iot2000_operating_instructions_enUS_en-US.pdf
> 
> The driver for this product is 8250_exar.c.  It's an Intel-based
> product, so no devicetree, but it shows that such use cases exist.

OK. I did look at the mux-controller/mux-consumer bindings, but couldn't
really make heads or tails of it, and there aren't a whole lot of
examples in-tree. Also, the C API seems ... not quite what is needed
here. I realize that's not really anything to do with the best way to
describe the hardware, but that, plus the fact that the serial core
already handles a number of gpios controlling circuitry related to
rs485, was what made me go for one extra gpio.

How would a mux-consumer description look?

  mux-states = <&mux 0>, <&mux 1>;
  mux-state-names = "rs485", "rs232";

or should that be mux-controls? Would that be enough so that we're sure
that if and when a rs422 state is needed that could easily be
represented here?

Now implementation-wise, there's the complication that switching the mux
to/from rs485 mode must be done after/before the driver's ->rs485_config
is called, to avoid the transceiver temporarily being activated (thus
blocking/disturbing other traffic). That plus the need to mux_*_deselect
the old mode means the consumer (serial core in this case) ends up with
quite a lot of bookkeeping, and even more so taking error path into
consideration.

Rasmus

