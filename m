Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="egtvOHQ0"
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28697123
	for <linux-serial@vger.kernel.org>; Thu, 14 Dec 2023 08:15:42 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso11483623a12.3
        for <linux-serial@vger.kernel.org>; Thu, 14 Dec 2023 08:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702570540; x=1703175340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QbYix1w4UHJyJ+ioQYc4DJ91pPGmRQo7dHrqC9f0kgk=;
        b=egtvOHQ0Yi8ktTAKeS+Qi/PmdKfW0m5GP8IMExuS+YUHBES6F+6NNjCPxBiRKW1R/z
         DKOR6v292fE+cCpilsuVRacJpmcEM+GzqeYCUJE7aK1+AIUCo1535Cpz12lRLlcP+fHF
         cWuEyE+KykIqnrNKXj024KNWTcrI+YrUKYZnCA2twydlNCbQk+wGRQzHhnzsm7rSGpY7
         LFYrNKrrpKwSKxkmrYy0I/deLLKIxIf3SgUB5yh7dPy/l8r4afGXf4uo2RBZsOijt6ZE
         XWyh3R5brCouz0SFg29St1P37sQ8W70cWxDrKPpoWuW7nRoJaHaanb8Ydy7fm+tXMwc5
         lt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570540; x=1703175340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbYix1w4UHJyJ+ioQYc4DJ91pPGmRQo7dHrqC9f0kgk=;
        b=VMLCTuDhkkea/pITvM4bpCquqwAMK4D/VccSINFdfNS3s1cCS/mGoBn80Xv7CJk7PY
         Amjz/lP5D0u3DbbcgBLhp6tkIGTG0YxW53xWB1KfK7uUoXqwpfcUNL4CpABBqOS6F2uX
         RLWGcjEIF4TFKJ6yEu9tZDYmvDri0oaw6AdK9/CBhDA2DG8sknGutvREZZkM2Eiedy/4
         MDzkiMbWTvWAysaN094UHDcYoto8PUfWqgiHBScEdZqPizYggJjU2XqG02hKBomEjMnS
         gyylBtJXozXAkXYEDyUtCPiSj33NToIQyGkbUCp8PHQG+ZZPuaSBWnVhoiPFgWgVjlju
         gWaA==
X-Gm-Message-State: AOJu0YwI6TjDvRhfqa3CBn1MDqhQRFHd530Qtv8P9t71Xa8DnvmY8wX8
	tJ2k0WGNHg+S23KENwr+JqaR7g==
X-Google-Smtp-Source: AGHT+IFmRcLF0OoA8DEzmxgzOcTf6k0T0PqSZAePsKTXa0uwU1Db/V7XoFeTFuqChCFK/b/BWjhAbQ==
X-Received: by 2002:a17:906:560c:b0:a1d:f89d:7cb7 with SMTP id f12-20020a170906560c00b00a1df89d7cb7mr5469221ejq.92.1702570540553;
        Thu, 14 Dec 2023 08:15:40 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id v20-20020a170906489400b00a1de512fa24sm9537667ejq.191.2023.12.14.08.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 08:15:40 -0800 (PST)
Message-ID: <5de5cddd-2bab-4408-b31f-f48bef98f14c@linaro.org>
Date: Thu, 14 Dec 2023 16:15:37 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] clk: samsung: gs101: mark PERIC0 IP TOP gate clock
 as critical
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: peter.griffin@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
 sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
 alim.akhtar@samsung.com, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 catalin.marinas@arm.com, will@kernel.org, s.nawrocki@samsung.com,
 tomasz.figa@gmail.com, cw00.choi@samsung.com, arnd@arndb.de,
 andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
 <20231214105243.3707730-8-tudor.ambarus@linaro.org>
 <CAPLW+4mNjCbJ+VbKR66DFSkiXHyxdjgvwjN7azxjJQ6UxQikEw@mail.gmail.com>
 <f3d61c49-1a46-476c-b7a5-6cc6a06a33ed@linaro.org>
 <CAPLW+4=tyr8Pcoe6Wm0Wtmkk4udDpuAiOKy7+C+Fwa6mvt3VoQ@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4=tyr8Pcoe6Wm0Wtmkk4udDpuAiOKy7+C+Fwa6mvt3VoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/14/23 16:09, Sam Protsenko wrote:
> On Thu, Dec 14, 2023 at 10:01 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>>
>>
>> On 12/14/23 15:37, Sam Protsenko wrote:
>>> On Thu, Dec 14, 2023 at 4:52 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>>>
>>>> Testing USI8 I2C with an eeprom revealed that when the USI8 leaf clock
>>>> is disabled it leads to the CMU_TOP PERIC0 IP gate clock disablement,
>>>> which then makes the system hang. To prevent this, mark
>>>> CLK_GOUT_CMU_PERIC0_IP as critical. Other clocks will be marked
>>>> accordingly when tested.
>>>>
>>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>>>> ---
>>>>  drivers/clk/samsung/clk-gs101.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
>>>> index 3d194520b05e..08d80fca9cd6 100644
>>>> --- a/drivers/clk/samsung/clk-gs101.c
>>>> +++ b/drivers/clk/samsung/clk-gs101.c
>>>> @@ -1402,7 +1402,7 @@ static const struct samsung_gate_clock cmu_top_gate_clks[] __initconst = {
>>>>              "mout_cmu_peric0_bus", CLK_CON_GAT_GATE_CLKCMU_PERIC0_BUS,
>>>>              21, 0, 0),
>>>>         GATE(CLK_GOUT_CMU_PERIC0_IP, "gout_cmu_peric0_ip", "mout_cmu_peric0_ip",
>>>> -            CLK_CON_GAT_GATE_CLKCMU_PERIC0_IP, 21, 0, 0),
>>>> +            CLK_CON_GAT_GATE_CLKCMU_PERIC0_IP, 21, CLK_IS_CRITICAL, 0),
>>>
>>> This clock doesn't seem like a leaf clock. It's also not a bus clock.
>>> Leaving it always running makes the whole PERIC0 CMU clocked, which
>>> usually should be avoided. Is it possible that the system freezes
>>> because some other clock (which depends on peric0_ip) gets disabled as
>>> a consequence of disabling peric0_ip? Maybe it's some leaf clock which
>>> is not implemented yet in the clock driver? Just looks weird to me
>>> that the system hangs because of CMU IP clock disablement. It's
>>> usually something much more specific.
>>
>> The system hang happened when I tested USI8 in I2C configuration with an
>> eeprom. After the eeprom is read the leaf gate clock that gets disabled
>> is the one on PERIC0 (CLK_GOUT_PERIC0_CLK_PERIC0_USI8_USI_CLK). I assume
>> this leads to the CMU_TOP gate (CLK_CON_GAT_GATE_CLKCMU_PERIC0_IP)
>> disablement which makes the system hang. Either marking the CMU_TOP gate
>> clock as critical (as I did in this patch) or marking the leaf PERIC0
>> gate clock as critical, gets rid of the system hang. Did I choose wrong?
>>
> 
> Did you already implement 100% of clocks in CMU_PERIC0? If no, there

yes.

> is a chance some other leaf clock (which is not implemented yet in
> your driver) gets disabled as a result of PERIC0_IP disablement, which
> might actually lead to that hang you observe. Usually it's some
> meaningful leaf clock, e.g. GIC or interconnect clocks. Please check
> clk-exynos850.c driver for CLK_IS_CRITICAL and CLK_IGNORE_UNUSED flags
> and the corresponding comments I left there, maybe it'll give you more
> particular idea about what to look for. Yes, making the whole CMU
> always running without understanding why (i.e. because of which
> particular leaf clock) might not be the best way of handling this

because of CLK_GOUT_PERIC0_CLK_PERIC0_USI8_USI_CLK

> issue. I might be mistaken, but at least please check if you
> implemented all clocks for PERIC0 first and if making some meaningful
> leaf clock critical makes more sense.
> 

Thanks,
ta
