Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMt0DB1Q"
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF63EB
	for <linux-serial@vger.kernel.org>; Sun, 10 Dec 2023 15:37:37 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-286f8ee27aeso4034337a91.3
        for <linux-serial@vger.kernel.org>; Sun, 10 Dec 2023 15:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702251456; x=1702856256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktrngxJslvgVofvGRW3XnDoVArwbSMEwYrvNDYxqRMM=;
        b=ZMt0DB1Q5u/VunX6/Rvk8gpBiwSPBrENgKzbmODOnncUGcdkh5DCbWUhre+jDkRakt
         CBjK8novtFlEmzpQJUQrMgiRZv5tBVPuWp4Zc3Hx9Wx70ftNBNw57ZdF5jOur/y6fNh1
         Zo0w+91EDn7mPuWQeqK+Li0SrCfwSeH43cnajwANU+X67meTrbmqIz88Yvsl5YUYdAfw
         wBhkGcMCqqr1y2PUoxD/qNiADxqTa3e0JSjXjfMNed/bQ/F6Tlq0hdzaoi12xiYwr1/x
         SOCLcL6TJ08o96zDB/XxpSm803FLIpa3GwqUm28YtfyWcwZaAXCU1CyztJbKtDNHPANS
         k4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702251456; x=1702856256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktrngxJslvgVofvGRW3XnDoVArwbSMEwYrvNDYxqRMM=;
        b=LIhPRECmqHGk2NpVm7847+ba6JMR+1eGNJG/5muzY0Fxcp9roGbV/mfQBSWu8JPJQD
         wkLMLOVnlHnusfNnfANlZr8ztx1bPophXHIx/HBRpz7gXy3kU0pOuW4dhsBT8xEWrdJA
         rCFOheZOJ+APQTngI2RjacsuRgElvUX3U51+gk2PusE64nu46VntpQheVsuI6v/fVYhH
         swzBnBik1RAroXu8g/KsV32GrcATlynRPyWeHM9M/36R9f1AfCLH85i6ZIpHm81Lfj+Y
         QSx/tkdrnE5jj/YsrUBQYAUwdkZLFsIDffJQtrhKdh91BCOarswKwVFapXEJlDKcQpf6
         ybHw==
X-Gm-Message-State: AOJu0YxJIQnbOeZ/sUYERV0VziAV8FR96Ch96EBVfolKZu1+fCh1mPpl
	Wd6q8X3qADpQZZgWwuleO2/wTKBvhWMbNXePCgkPPw==
X-Google-Smtp-Source: AGHT+IGLsgr8i/Ys8RGtN0SYISZJUKEzU9RuUMU3J9K3efZNFIaGcYANt6ADR27OrFr246GC+h9HKAnCTaXxkKGU5BA=
X-Received: by 2002:a17:90a:db08:b0:286:6cc1:7803 with SMTP id
 g8-20020a17090adb0800b002866cc17803mr2455327pjv.70.1702251456635; Sun, 10 Dec
 2023 15:37:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231209233106.147416-1-peter.griffin@linaro.org> <20231209233106.147416-16-peter.griffin@linaro.org>
In-Reply-To: <20231209233106.147416-16-peter.griffin@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sun, 10 Dec 2023 17:37:25 -0600
Message-ID: <CAPLW+4nUT8Nf9zC6UrAMJ_OpLNqe7JWxKy7xp1+_+emNgG4qkA@mail.gmail.com>
Subject: Re: [PATCH v6 15/20] watchdog: s3c2410_wdt: Update QUIRK macros to
 use BIT macro
To: Peter Griffin <peter.griffin@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org, 
	tomasz.figa@gmail.com, s.nawrocki@samsung.com, linus.walleij@linaro.org, 
	wim@linux-watchdog.org, linux@roeck-us.net, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, olof@lixom.net, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, cw00.choi@samsung.com, alim.akhtar@samsung.com, 
	tudor.ambarus@linaro.org, andre.draszik@linaro.org, saravanak@google.com, 
	willmcvicker@google.com, soc@kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, kernel-team@android.com, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 9, 2023 at 5:31=E2=80=AFPM Peter Griffin <peter.griffin@linaro.=
org> wrote:
>
> Update the remaining QUIRK macros to use the BIT macro.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/watchdog/s3c2410_wdt.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wd=
t.c
> index 7ecb762a371d..b7a03668f743 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -107,11 +107,11 @@
>   * DBGACK_MASK bit disables the watchdog outputs when the SoC is in debu=
g mode.
>   * Debug mode is determined by the DBGACK CPU signal.
>   */
> -#define QUIRK_HAS_WTCLRINT_REG                 (1 << 0)
> -#define QUIRK_HAS_PMU_MASK_RESET               (1 << 1)
> -#define QUIRK_HAS_PMU_RST_STAT                 (1 << 2)
> -#define QUIRK_HAS_PMU_AUTO_DISABLE             (1 << 3)
> -#define QUIRK_HAS_PMU_CNT_EN                   (1 << 4)
> +#define QUIRK_HAS_WTCLRINT_REG                 BIT(0)
> +#define QUIRK_HAS_PMU_MASK_RESET               BIT(1)
> +#define QUIRK_HAS_PMU_RST_STAT                 BIT(2)
> +#define QUIRK_HAS_PMU_AUTO_DISABLE             BIT(3)
> +#define QUIRK_HAS_PMU_CNT_EN                   BIT(4)
>  #define QUIRK_HAS_DBGACK_BIT                   BIT(5)
>
>  /* These quirks require that we have a PMU register map */
> --
> 2.43.0.472.g3155946c3a-goog
>
