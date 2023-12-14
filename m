Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eh8WBxT6"
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531D5120
	for <linux-serial@vger.kernel.org>; Thu, 14 Dec 2023 06:31:28 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54f4f7d082cso9241977a12.0
        for <linux-serial@vger.kernel.org>; Thu, 14 Dec 2023 06:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702564287; x=1703169087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VgJQbimhdbaMz8PSS4TWmPrQmjKzzald78cLvtVZ+/M=;
        b=eh8WBxT6Q0T3qFh1kwRQZApC3AmWMWC21CjpFyCAEALvcBx8K/cxF9foP0qc+YO6u4
         uIiUjO9uYDmJMdEsIF4h2BqDob2rD4zHhEaYosG/aI4byr5DJDqGNg01sGMpUY0HvP9k
         nlNugi0HzdUMAhmC5bk/adU02sQkmCaj1STs7OlWVGIR5WXdJ1zPgh68dVaVoCtDYLzO
         Yk3KDINaJrinLhnFOP2vm3vehZyj1EUU2OzAiQIelhyWhn+TRqP1IS/erCI6MnhSfG5U
         EgYZI0SnIGOZRgRhJaNE9Y1bhypoa0/KHKPG3bs6XLER/kw7aEOFqs+hydSV2tdFgshX
         QkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702564287; x=1703169087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgJQbimhdbaMz8PSS4TWmPrQmjKzzald78cLvtVZ+/M=;
        b=iVm5htPkMFFG4SatpugxcPa4LDWTqFW/fNH+1z6mvbD/ABVZUDygZyJPt+VrdIjWtt
         YgEuN0wgGPJpa+2V+J+N25z8D0yitBKPL3RgCbinTYoVdoOntpeEU/IaycTV9A+5PybI
         uBz/yorUs+SXDv78Mg15RvmYi8UBJ6kJRNsR2SNQyH77pyIKlU64yjt6itbnSOsqbPYf
         XkSNfwXS9C8hIgXcGiJkcq6nVeoc9HwJB2o51m/sv0rHsQmc3V7q6S+ChfYIi7j/MsxD
         BSbLGrka1nR71IW8h7SUeWlO5Kdo1bWX4mRCGB9bscIcS8QiGIzzBaSdYSqI6NwGf0au
         Y6Dg==
X-Gm-Message-State: AOJu0YxS9aBSPnfnZunfaOYaeuuJZlI9gE15G1uk1Rf3b601TtDnxiiQ
	8es1bO9JLQsdkaBa23g9z24s0g==
X-Google-Smtp-Source: AGHT+IHWZ078ljQ3KvRmktAtxA7HnfQvsB0QqyGy4IG0/hZ9rDcDubhsLYhJrI6GM7rvgcmCHZYcDw==
X-Received: by 2002:a17:906:4559:b0:a18:8b15:4d3d with SMTP id s25-20020a170906455900b00a188b154d3dmr5541926ejq.77.1702564286762;
        Thu, 14 Dec 2023 06:31:26 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id hw15-20020a170907a0cf00b00a1f761d9ffdsm8791995ejc.177.2023.12.14.06.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 06:31:26 -0800 (PST)
Message-ID: <584e036a-2ae7-4b88-a517-8f79c6baed4a@linaro.org>
Date: Thu, 14 Dec 2023 14:31:23 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] tty: serial: samsung: add gs101 earlycon support
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Peter Griffin <peter.griffin@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 andi.shyti@kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 saravanak@google.com, William McVicker <willmcvicker@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
 <20231214105243.3707730-6-tudor.ambarus@linaro.org>
 <1938fcf1-eb5d-4723-a6c6-d2fe2c6dd1c0@app.fastmail.com>
 <8808ceeb-35dc-4094-aec4-f43c7acd6174@linaro.org>
 <6962ac73-2f44-4c9e-8731-152087815454@app.fastmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <6962ac73-2f44-4c9e-8731-152087815454@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/14/23 14:19, Arnd Bergmann wrote:
> On Thu, Dec 14, 2023, at 13:52, Tudor Ambarus wrote:
>> On 12/14/23 12:01, Arnd Bergmann wrote:
>>> On Thu, Dec 14, 2023, at 11:52, Tudor Ambarus wrote:
>>>> +static int __init gs101_early_console_setup(struct earlycon_device *device,
>>>
>>
>> It works if in device tree one specifies the reg-io-width property and
>> sets it to 4. If the reg-io-width is not specified, the iotype defaults
>> to UPIO_MEM causing the SError interrupt on gs101 which makes the system
>> unusable.
> 
> In the case of incorrect DT data like a missing reg-io-width property,
> I would expect it to still fail once the regular console or tty takes
> over from earlycon.
> 
>> Also, if the earlycon comes specified from the kernel params, the
>> of_setup_earlycon() is no longer called and the earlycon will be set
>> solely based on the kernel params buffer, thus allowing users to crash
>> the kernel on wrong earlycon definitions.
> 
> But that in turn is the same as specifying any other incorrect earlycon.

I don't think you can crash the kernel if you use other earlycon as you
don't make accesses on the 32bit restricted bus. But I agree that if
using the correct earlycon name, and mmio instead mmio32, is equivalent
to not specifying reg-io-width in dt.

> 
>> If you think the change is fine, I can amend the commit message with the
>> description from above.
> 
> I'm still not convinced we need a special case here when everything else
> just requires passing the correct data.
> 

Well, I made this patch because I used a wrong bootargs earlycon
configuration and I ended up crashing the kernel. I couldn't see what
happens as kgdb is not available at that stage. Figuring out what was
going on made me spend some time. I hoped I'll be helpful and spare
others of the same mistakes and wasted time.

I'm ok to drop the patch as well, no pushing here. Please ignore.
Thanks for the review!

Cheers,
ta
