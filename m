Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fCGuC6t2"
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64472115
	for <linux-serial@vger.kernel.org>; Thu, 14 Dec 2023 07:07:40 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so6953821a12.1
        for <linux-serial@vger.kernel.org>; Thu, 14 Dec 2023 07:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702566460; x=1703171260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9lMPrZwLiHFysOzsWqCBFNM5vjGopX4XPDNLVg4mW8=;
        b=fCGuC6t2nN42viOr2YKBAq0Xo+hUP/amRbiGwv5e07F6PM6Mz+7Qzwi8Fs/ucMcYC3
         jZUtbY7uUH83tmsBWDQiU7PSXgAbdVKVxK+B+ruiRN/iRXF4903eqTh7qyWKvZOzcyHW
         qNNku8yRzWPt9p6JxnHLUDcBeH9ig3E+74EPq+NhnmScZm//E3f+6h4qQH1yGuztgw+A
         wEqLBIA4ektv/MpIXTQc5iUHjld32HE0/V2KWFTYrILpAm1FVwRe/csOy2V5o9g+TWIT
         8P5Ldid5sSWvqZ+MOEw1nX+rfl3Bof3rc60I4FVnfH6ckR8GBKLJf6bggQ0pmgNey/f8
         Q+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702566460; x=1703171260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9lMPrZwLiHFysOzsWqCBFNM5vjGopX4XPDNLVg4mW8=;
        b=Ovsa4O0sqC3Jzao+p3L5uCqCPXdzm+hBNDAmqiH1KGY4b0V8L/P0XdmN742521xKNW
         ebp6Rbk6lPf4nZt8Hqy+tmwx6sDDJE2CPef6HoHEXd3f2VPIoor66cppkpU4m4QOwReC
         2DBen7nzdXt7WXIn7RWGADGyZT66FHF1r9RDb8j72kgcbXRC2qCYIO1ZZpDX8zsMdTBr
         loSarMk+SwPwwJbcl0vaYFId8ENxnScVMHoUY3xp/5iOyI4XQXipLiHHh+L55D2zmWhL
         Yj363UBz1f8G9e4VuSljgMKAkjXCvpUjq6z1YjjpYWCAgGWkXYg/RDQNHKMVoChRZIWr
         mPUw==
X-Gm-Message-State: AOJu0Yyb1TGkFDDYDwpx18jD07NHhLuP9qbEwjfuH6W6lJbGd8/Qb7e0
	8bKG0+q/Nh7rYiOQS4NKCKFFI+L4ojtQF3LRwuGmPQ==
X-Google-Smtp-Source: AGHT+IEe4LHmA9Ois0luIdXZnO0T77VZxNQ9yNINBTZ2R/6zYH/aXq6Vfe7Uba+cQAfGN4QaX7I8+rAiF6Etw8yknyU=
X-Received: by 2002:a17:90b:388:b0:28a:f2dd:9441 with SMTP id
 ga8-20020a17090b038800b0028af2dd9441mr1630238pjb.64.1702566459845; Thu, 14
 Dec 2023 07:07:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org> <20231214105243.3707730-2-tudor.ambarus@linaro.org>
In-Reply-To: <20231214105243.3707730-2-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 14 Dec 2023 09:07:28 -0600
Message-ID: <CAPLW+4kr=aVjuqGz3ps5f6EzM+QASTFEoB57g+fR7jKH0s+1Zw@mail.gmail.com>
Subject: Re: [PATCH 01/13] dt-bindings: clock: google,gs101: fix CMU_TOP gate
 clock names
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: peter.griffin@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
	conor+dt@kernel.org, andi.shyti@kernel.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, catalin.marinas@arm.com, 
	will@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com, 
	cw00.choi@samsung.com, arnd@arndb.de, andre.draszik@linaro.org, 
	saravanak@google.com, willmcvicker@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 4:52=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> The gs101 clock names are derived from the clock register names under
> some certain rules. In particular, for the gate clocks the following is
> documented and expected in the gs101 clock driver:
>
>   Replace CLK_CON_GAT_CLKCMU      with CLK_GOUT_CMU and gout_cmu
>   Replace CLK_CON_GAT_GATE_CLKCMU with CLK_GOUT_CMU and gout_cmu
>
>   For gates remove _UID _BLK _IPCLKPORT and _RSTNSYNC
>

Doesn't it break existing gs101 device tree?

> The CMU TOP gate clock names missed to include the required "CMU"
> differentiator which will cause name collisions with the gate clock names
> of other clock units. Fix the TOP gate clock names and include "CMU" in
> their name.
>
> Fixes: 0a910f160638 ("dt-bindings: clock: Add Google gs101 clock manageme=
nt unit bindings")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

(snip)
