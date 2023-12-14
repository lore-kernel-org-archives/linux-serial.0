Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l+tWKgXG"
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C67311B
	for <linux-serial@vger.kernel.org>; Thu, 14 Dec 2023 06:09:43 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1c7b20f895so944728566b.2
        for <linux-serial@vger.kernel.org>; Thu, 14 Dec 2023 06:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702562981; x=1703167781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/3RQuNkLRKG8bKgPIldu8Ku3xY7yfi4XKy/b0IC08t8=;
        b=l+tWKgXGoq20hunhC7pGAIw0Ef+qDD41fvB2uNYNTNISgK4cq/IjlJUaHRGWSpLAEm
         loOXKdXf3S8/xmmvyPUTKaGs6i8dYqxYfm/epiMAl0q5LUVIOTjB7IN8WxsO6bxiq2bb
         G54vt7/xQL6IP/YkrbctQEg4hkY9dNdWSoy4u8Uh8aYbwZQSIH29hxpIUfMX4v7VkJSX
         ksCmCCqKlXvwRRG6o0GTgyjeoeO8aTGEGcp+sDapYEvcYBervl2GFYrcknfBCV7xycqu
         1OQY44p/yoq+NbYR+bO1MxCOGhR5K94vpZZ+aXRpRWvSV1v9iuBsGhe72fsVU6iIvOsR
         6mWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702562981; x=1703167781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3RQuNkLRKG8bKgPIldu8Ku3xY7yfi4XKy/b0IC08t8=;
        b=E+bFbUfS0k2ee262u0My1gmZlOeFPaam7HVPclwkfzPuJiOhkQj1HXnDOdOZrPi7BG
         39DxfD/5hjRbWFR35K3AvcgmA0axLibiY+B6dAWC+/Gp0OTiAtX8PrC2TEshpJ2A/k+A
         fIIY0f2LpYxIgMNTReSw3HHWXYEZkUZ8ZTS0sd8wsxQ4/I8T5+jlx3358ZHoyNePx/if
         Q7u6JFXnujRo+9Bg3c0d+5XL+JTTK999BN8BVb4m3S7eD0/l5VY7PouI+CCQ/LCn+wlR
         zUBH7HuM8fAbXkQ9+OL4KWuAslbGDilHH1e2Tdyi7Kq1w58nrCh9EAnTcl/7Hp/4JjIs
         Tm8g==
X-Gm-Message-State: AOJu0YzYeHH+g6MxboKp+pxhVdtzKLaivI5lx1hOe5gADnRX1EZitmew
	MzA8cwevqHFB6Kv3DRZlifcRkA==
X-Google-Smtp-Source: AGHT+IE7Uwl8ErU40fjRiJ15CIiA2TLlXGFMgyYhBgUnAqaz4nDkwt0+SdGL5BjePKkDBG8sk1zFNA==
X-Received: by 2002:a17:906:d96e:b0:a1c:b4d7:c78a with SMTP id rp14-20020a170906d96e00b00a1cb4d7c78amr4920685ejb.32.1702562981541;
        Thu, 14 Dec 2023 06:09:41 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id rm6-20020a1709076b0600b00a1bec12448csm9393020ejc.150.2023.12.14.06.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 06:09:41 -0800 (PST)
Message-ID: <64e35ae0-a751-40ee-b27f-8034e7817222@linaro.org>
Date: Thu, 14 Dec 2023 14:09:38 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] arm64: defconfig: sync with savedefconfig
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Peter Griffin <peter.griffin@linaro.org>,
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
 <20231214105243.3707730-13-tudor.ambarus@linaro.org>
 <1153987b-a818-454a-a292-57f2b3898771@app.fastmail.com>
 <93969025-606c-4e4c-9cbc-3c8351f95adb@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <93969025-606c-4e4c-9cbc-3c8351f95adb@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/14/23 13:19, Krzysztof Kozlowski wrote:
> On 14/12/2023 13:08, Arnd Bergmann wrote:

Hi, Arnd, Krzysztof,

Thanks for the review!

>> On Thu, Dec 14, 2023, at 11:52, Tudor Ambarus wrote:
>>> Sync the defconfig with savedefconfig as config options
>>> change/move over time.
>>>
>>> Generated with the following commands:
>>> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
>>> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- savedefconfig
>>> cp defconfig arch/arm64/configs/defconfig
> These are obvious. You cannot do it differently.

This was just a prerequisite patch for the next, where I made a config
builtin. Modifying defconfig shall be made in a similar manner, but it
seems it's not the case (144 line change here), and that's why I
considered it is worth specifying how I did it.

> 
>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>>> ---
>>>  arch/arm64/configs/defconfig | 144 +++++++++++++----------------------
>>>  1 file changed, 55 insertions(+), 89 deletions(-)
>> I usually ask for defconfig changes to be merged when someone just
>> adds a single line per patch, but a 144 line change is clearly too
>> big, please split this up.

The truth is I didn't think we care what configs get removed after a
savedefconfig. I see now after Arnd's review that we have a higher goal
and savedefconfig shall be used to identify misconfiguration.

> Anyway this should not go via my tree, because of possible conflicts.
> This commit, so the savedefconfig, must be prepared on linux-next, which
> should be mentioned in changelog for example. It also is not related to
> this patchset.

Please ignore this patch. Cheers,
ta
