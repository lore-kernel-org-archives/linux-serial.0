Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C0B33EAFD;
	Thu, 11 Sep 2025 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601347; cv=none; b=EQXpy6M/DZqUUNEntKjLremcO/oppieDKSn2NkHh2csPquwTC2A/hEdrtHzrlV/HnhAJs93ZWOo7yJmdnW9xcW+JmC1Ycn6UXFJryLG6vhZ8SlrVKTW2aTM66Ay5Sr6ld12bLxlHMJyp0TbdxRwh2IWyqkil5Dafnt1FSJJAfyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601347; c=relaxed/simple;
	bh=oEHwdsG7PFk3cvd+M6jwNjfXhmP6roseGLMNWQos0VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVD0ql0zeXcZ34/6v1tJd9XTzI1bZfGC0gpgIGC2q7G8TTTxL+UNhKnLvKmEVCYHg1qLz8Rsc6Cj1W6zsyJwsRlhDLLfLlnbdwb+NkA9017paeaoUXhkReQgFDJseWugm4NYqFFzTtSRA47R6qhh3KpQRG2rnYRSGrSKZsRJy5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-88432e2975cso21350439f.2;
        Thu, 11 Sep 2025 07:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757601344; x=1758206144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdO1CSLui5RRcTpK5b6MAqtw8kcTxu+RvPzYwpqfiQQ=;
        b=uB0Fz98VVvdfdSXGhIQqx6rK18mkzD0ZijBH2co9svLOcqMdW08bV6pc+/OhlCrz6j
         hX5qnCwK0FRKNAIaFOl4Q5RVgrMTMZwfXT4EuVHtenPckPFbK4OhQS6q5neWvvWZSHNt
         4awUv3O5bvn53vv2Vg6ZA7rEhL6whS+GOKBBu+ivvI23Z5ReOYeOiMolTd6Sv1hYdVb4
         PnTIPL3mmYNRqiNEKM8m5vYBPOCzHqOS7XGyvS06g+1CIEJkoJfQ20k6kPkNZLSWshfj
         m4+tAap4M3GISQgNklEIbDY874dVghROh4vyX/0AXCYS3YpoZV0rZzOrx+beBQ5obyo+
         wr/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLduNZVadkfnYgjBQWJ3+ALaYy+YbXKskx5At3B4g2n8fP3wNMhwpAcPWAkEiILnW80IOjLjIC4FEj@vger.kernel.org, AJvYcCWlxRSahJLEZnLZft8jApl1q6obZx4lYvXSlTzXYsboSdFbjmfZWVvAx7ACffcz/z6eUC5o6RtHEniR5uu/@vger.kernel.org, AJvYcCXI8sbydsrtD83sKTrmIhVOl6LpG0lZ+9DYMSsDKOZOTNVi3Qurr+xCiTl0RS5vZ5qX7E+FLH8fznI/5HMfReesXss=@vger.kernel.org, AJvYcCXaJfpmFE2YBenqzSOxeV8dT4XfRwaew/N36KLT82fh4yUgmfo2bHkGMePwBrqJER+vrr/OTg1HlvOfffda@vger.kernel.org
X-Gm-Message-State: AOJu0YybYFhnTsz6LWjENCET/lTpNHvOBIRPMfRLH7fKqPf0dptnVDt5
	Peqb+iiEdHPUAHr2e8xmaW/5XG/XnFQUuXl97u16Ex0oI84NAp/nTJpUIKuzp+im
X-Gm-Gg: ASbGncvZbr2aiAVeFgFpTD5yMo5ztBsAx5rEWcZ+AOZtFsM/xynbwKoVk3JfeEf4n9C
	ArAa1wOrvx05lreJUxUDTtzdHsj+68d51y6D6KzbAwBrwRJmhpPM52xhoXNhHzSJWcmgB8B/kuY
	tdzGCvbxvnRXaSxzVrTM0zR+DChoRMdNojBxQSyXRqXHae0yQxnZz9tjZZFpP8e3YGlEJqIMft/
	DbT4jVgJYHpF8te51jeo8SMTUsJy0lDrPYZ6Vj2Vjvkv1YncOtoHm2Ha1gwxt1fpUuJc9nLg27l
	HC9RQ+8Y5q9zPS+yXVm5WqMvhfYJYzs5v43dAlUDB8llFxwQTrqNX1GZhxlNx/dxwYgcK92jNXt
	9YYOKeU5bnGmQwwJ01rcXThVvPYUm56VgW+ddh0iGgHocEsxWjRrsXfj3yGfo89Ed
X-Google-Smtp-Source: AGHT+IE/7zJAEQxzz3RVVfq2tXIx5M/+aOiFd/XCp5cgKrEbakpL5+B/7v7GxHNiG0Ce/KdERW39Xg==
X-Received: by 2002:a05:6602:3fd2:b0:88c:3ad8:3f06 with SMTP id ca18e2360f4ac-88cb9e810b3mr1289141239f.12.1757601344226;
        Thu, 11 Sep 2025 07:35:44 -0700 (PDT)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-88f2d69e06asm68863939f.9.2025.09.11.07.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 07:35:44 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-4202550e2bcso1279375ab.1;
        Thu, 11 Sep 2025 07:35:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWY0GTJRhvweQ7SuQg2T26JBZ0JGE6DsmOERHT3Vlh+nXh4GWX15wzI0krxzggYQQQpXUrpyYIB4myRvT9T@vger.kernel.org, AJvYcCX4tRpVpG1A2C8toGHn9YkYaKm5xj6j5sRoqPrY9+wXN+WahV2oPtSbRVTy29hkgSDYGdXbUlpLbSdf7AFYqSsRKmo=@vger.kernel.org, AJvYcCX99zxWSmraBI3CHidCENVWiUOjRFdtQSHPRwcxeQg+xA9AaFjJh0uExdGh0KPY5v8pS0MAuZFs0n/ZnC6K@vger.kernel.org, AJvYcCXIoEShr3arao5CX8KuwK2+Lb8XILuieNN0SV28eM7lQ5G/GwnXtOEJbrACyE5y1bqo56bFp3kfkeGt@vger.kernel.org
X-Received: by 2002:a05:6102:5128:b0:525:9f17:9e55 with SMTP id
 ada2fe7eead31-53d24251fe0mr7482216137.32.1757600847846; Thu, 11 Sep 2025
 07:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250911141714epcas5p29f591a1d645c9c69dc5b7d2c2d12af50@epcas5p2.samsung.com>
 <20250911141605.13034-1-ravi.patel@samsung.com> <20250911141605.13034-4-ravi.patel@samsung.com>
In-Reply-To: <20250911141605.13034-4-ravi.patel@samsung.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Sep 2025 16:27:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVe-FULHWk3QCBENG7TsbEZyxj0N5shhESxWBWd49JmOw@mail.gmail.com>
X-Gm-Features: AS18NWA9988xiKX4_TVZURlwneQiJAxbodcHMKtf18AoQ7BwMpO-0BHXub4ifEg
Message-ID: <CAMuHMdVe-FULHWk3QCBENG7TsbEZyxj0N5shhESxWBWd49JmOw@mail.gmail.com>
Subject: Re: [PATCH 3/3] tty: serial: samsung: Remove unused artpec-8 specific code
To: Ravi Patel <ravi.patel@samsung.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, jesper.nilsson@axis.com, 
	lars.persson@axis.com, alim.akhtar@samsung.com, arnd@kernel.org, 
	krzk@kernel.org, andriy.shevchenko@linux.intel.com, geert+renesas@glider.be, 
	thierry.bultel.yh@bp.renesas.com, dianders@chromium.org, 
	robert.marko@sartura.hr, schnelle@linux.ibm.com, kkartik@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@axis.com, 
	ksk4725@coasia.com, kenkim@coasia.com, smn1196@coasia.com, 
	pjsin865@coasia.com, shradha.t@samsung.com
Content-Type: text/plain; charset="UTF-8"

Hi Ravi,

On Thu, 11 Sept 2025 at 16:17, Ravi Patel <ravi.patel@samsung.com> wrote:
> Since ARTPEC-8 is using exynos8895 driver data, remove the unused
> artpec-8 specific driver data.
>
> ARTPEC-8 is using exynos4210 for earlycon, so earlycon code
> for ARTPEC-8 is also not required.
>
> Signed-off-by: Ravi Patel <ravi.patel@samsung.com>

Thanks for your patch!

> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c

> @@ -2655,8 +2621,6 @@ static const struct of_device_id s3c24xx_uart_dt_match[] = {
>                 .data = S5L_SERIAL_DRV_DATA },
>         { .compatible = "samsung,exynos850-uart",
>                 .data = EXYNOS850_SERIAL_DRV_DATA },
> -       { .compatible = "axis,artpec8-uart",
> -               .data = ARTPEC8_SERIAL_DRV_DATA },
>         { .compatible = "google,gs101-uart",
>                 .data = GS101_SERIAL_DRV_DATA },
>         { .compatible = "samsung,exynos8895-uart",
> @@ -2828,8 +2792,6 @@ OF_EARLYCON_DECLARE(s5pv210, "samsung,s5pv210-uart",
>                         s5pv210_early_console_setup);
>  OF_EARLYCON_DECLARE(exynos4210, "samsung,exynos4210-uart",
>                         s5pv210_early_console_setup);
> -OF_EARLYCON_DECLARE(artpec8, "axis,artpec8-uart",
> -                       s5pv210_early_console_setup);
>
>  static int __init gs101_early_console_setup(struct earlycon_device *device,
>                                             const char *opt)

Removing these breaks backwards-compatibility with existing DTBs,
which lack the new "samsung,exynos8895-uart" fallback compatible value.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
