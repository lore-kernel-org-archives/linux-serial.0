Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="odLvzRyw"
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DACB9
	for <linux-serial@vger.kernel.org>; Wed, 22 Nov 2023 00:20:58 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-46283d552e9so1295320137.1
        for <linux-serial@vger.kernel.org>; Wed, 22 Nov 2023 00:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700641257; x=1701246057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4I8dRODFUwv8GNo/5lVqWf42DaYrEmmY1wMx98kbsuI=;
        b=odLvzRywKLvkWkcm6Z/Zy1hDwAhXTPapvw0AO3ePOU9vFYzD5xRmy1pmPaHdBZxCmL
         Bw23TKP8axRvPHBytCL0Qytuo22fqU+3ybY/W28GC24sKp7lFYYIA+5XGjQXEnYZlId3
         bgrCckS/u5FjCmuZtm+Z7e6a6PvvnBvvWAIB4YYnXAmfMT7V1R2zhw9uVae08eouX9og
         dEkpFzxfuMRJyb5Dmidd5Pv/0OlqGR6fvAEtisT2EW2USLA2SoGXNC/EPmo686C76JZ9
         4SL6z6yurV5/5EOxWf36sKEiec7eputDfissmYYn3EcvUno+xGGyIfY3V7GdxBwofTuJ
         Ljlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700641257; x=1701246057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4I8dRODFUwv8GNo/5lVqWf42DaYrEmmY1wMx98kbsuI=;
        b=DIkIAcju9T3wTklHmLb3vP4tT4C93ICTYV0divkvcnA3OcscPttzC3/vQls8wb1mau
         4cvp/8osx8OKzDGa2rrss5QdN3gkKKsxccwrq2W8TXBbaD91ptc8OE33L9FXkZC+ZHB8
         +IFQVZrbk2AJD56whuQzteUegjHy4MPiF6HnowXCSQhZaGQXVWOQiXaL8rL1cwnsEsff
         5UACZ8Fm0bANJB9a3utXH5EW5AZ59cfV7B61yodA3G0YDU7XCd4EjAo++iOwkdACjlUY
         zdqVb7okpgbQi5/sxkwIANN+JyRo8Lxzu692MH2kolchLQpamotLFrDsMlFEUXovhzVn
         78EQ==
X-Gm-Message-State: AOJu0YxXomlR6apOnNCKsMqwu6JiEkqUgRsfo1fCp5G2J7wmH9YG6OrE
	mUD+7pQjh/UWi4JI/ogkBLUZsf9zC+GV/I1qMgtOvw==
X-Google-Smtp-Source: AGHT+IH6MXRD7recCukd9ZPlXrdn9+l+K/d0U/kF9HaOQ28/JOjYehYeGW3YeHAn90fSzCuc3t+BUm1b6U6nd0pNRfU=
X-Received: by 2002:a05:6102:108a:b0:462:7f9d:d263 with SMTP id
 s10-20020a056102108a00b004627f9dd263mr1596382vsr.8.1700641256954; Wed, 22 Nov
 2023 00:20:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120212037.911774-1-peter.griffin@linaro.org>
 <20231120212037.911774-16-peter.griffin@linaro.org> <CAPLW+4m+vG62V++izkycRYEhcTpoT+G=g+3Y4j8vqEpeX2uEPw@mail.gmail.com>
 <8d838a0b-6a13-4538-8dd6-e044ebfabca7@roeck-us.net> <82df32ea-9ca9-44ac-b1ca-719f68d4f58b@linaro.org>
In-Reply-To: <82df32ea-9ca9-44ac-b1ca-719f68d4f58b@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 22 Nov 2023 08:20:43 +0000
Message-ID: <CADrjBPpjMtF36rA3_5NmKk8iw1vEoBZVCTw1auowWte8KGie8g@mail.gmail.com>
Subject: Re: [PATCH v4 15/19] watchdog: s3c2410_wdt: Add support for WTCON
 register DBGACK_MASK bit
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Sam Protsenko <semen.protsenko@linaro.org>, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, 
	conor+dt@kernel.org, sboyd@kernel.org, tomasz.figa@gmail.com, 
	s.nawrocki@samsung.com, linus.walleij@linaro.org, wim@linux-watchdog.org, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, olof@lixom.net, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, cw00.choi@samsung.com, 
	alim.akhtar@samsung.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
	saravanak@google.com, willmcvicker@google.com, soc@kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	kernel-team@android.com, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof / Guenter / Sam,

On Wed, 22 Nov 2023 at 07:53, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/11/2023 19:10, Guenter Roeck wrote:
>
> >>>   static const struct s3c2410_wdt_variant drv_data_gs101_cl1 = {
> >>> @@ -291,7 +296,7 @@ static const struct s3c2410_wdt_variant drv_data_gs101_cl1 = {
> >>>          .cnt_en_reg = GS_CLUSTER1_NONCPU_OUT,
> >>>          .cnt_en_bit = 7,
> >>>          .quirks = QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_MASK_RESET | QUIRK_HAS_PMU_CNT_EN |
> >>> -                 QUIRK_HAS_WTCLRINT_REG,
> >>> +                 QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_DBGACK_BIT,
> >>>   };
> >>>
> >>
> >> This patch states it's adding the feature, but in fact it's also
> >> enabling this feature for gs101. Suggest moving this patch before the
> >> one enabling gs101 wdt. This way, one patch will only add the feature,
> >> and another patch will enable gs101 entirely (with this feature used).
> >> At least it seems like more atomic approach to me.
> >>
> >
> > Both approaches have their merits and their downsides. I for my part am not
> > even sure if DBGACK_MASK should be enabled unconditionally if supported.
> > With your approach, it would be impossible (or at least more difficult) to
> > revert if it turns out to be broken and/or have unexpected side effects.
> > That seems less desirable to me than the current approach.
>
> Reversing the patches does not change this. It is enabled
> unconditionally in current order as well.
>
> Sam's idea is correct here - first you add support for new quirk, then
> you add new SoC which will use this quirk. Doing the other way - first
> SoC and then new quirk - looks like SoC was added incomplete.

Sure I can swap the order around if that's what you prefer.

I ordered it this way so it was clear who the user of the new debug feature was.

Peter
