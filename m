Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E10D10FC
	for <linux-serial@vger.kernel.org>; Sat, 20 Jan 2024 03:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705723166; cv=none; b=NiU/6rvSBSsNvkNLuYv7tPsx0j8qObOWKnZnjetNkb3NuMTHONluHcxCDBghJYN9QiNg4TNtH9/Gu7jAsn8FslgF4JckNxXyzPvyuncIEv3EKpnktG8J7Wbqf4G0OUtRLyCCj/Lknm3TrhXy22rx4D87ByKw0yy+W1oJ1/q9iy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705723166; c=relaxed/simple;
	bh=owW4MPVe7RBYKQzYe4QKg/APdDGIG9NhmwHwHuaMnNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=puG/uYkGn70Wc0OkaPGiScl6QP6DxXfxXA5JnFzjOVSp8jlU3h+VwcsiGT4pw0EWzU59PoFVn3J4xjtkfyOa9XyENGH8sjHGlYKaVAjZMAWHESUlTq7qv2G734Y4ik8fz0pU9nipjrqia2BQIGE4TbKBrGTZHkAe5RTLkftvwVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=H1VG32Jh; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="H1VG32Jh"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3606ad581a5so7076345ab.1
        for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 19:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1705723163; x=1706327963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUdj33zU6WPp9NMXR1jDLao5OoMg89mIJNooFVUpnh0=;
        b=H1VG32JhcxkcCTJVlDDHMs8zWauAyUFM5l2cmKm1D8qnQ9uYbbgMjvQ/cEKGfQcAn0
         mhOFjZhBDchoMOl4eddIZpRn6I7feHBEgFoG7jD9jtGKpqN9LG6R42M+X/yViAiXNj8a
         n41Y2PFH9GITwYHfarPi+9gdIsLMJIVfBn1vH/brQTknm137GyzMcBuG3bOzdYmmqNKL
         eR9a8By/clLSQ7jwCwtH/29ohe0BC978zCek2d3S/PPKqmzYryofs7vOxzib/bEtl1nB
         XnfDdDqm9CuNRgstAoRkZzvQd9ykTbPVIxLD3RIGn+0mJjQWqNQ/sfgUGJkRaka6q7Rl
         g1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705723163; x=1706327963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUdj33zU6WPp9NMXR1jDLao5OoMg89mIJNooFVUpnh0=;
        b=dEefqUS+K+decZkKTZFhrNHUctRYE9kVdwN7XEtaBCW6kunYIgwtOLXfLdC1LvDoXN
         X0CJ5XuYzIj32oRb1bBNcjIgfbCYZoKzNdzez0lz818Wu2oNEWQ3BblxbPuXYRp0NlE7
         Lkhunv8ulfk+P37B28Ls+fWcwDLI3DJ76AGtg6p9SFG5AZc2wBQTgYeac95ZnXgSwTq7
         WQUmCyYuNGcBSlhHxYUlTfv/8WmV30EP+OWLrIXaoO4eszeTRRHW/NEImkbCqYXZcxei
         KRvidoQ2OAzhaneyH3zQI3IOtnFC2cEDTsd860fdQrd/MV6eQbY5bbdTwJAadFGT7ae7
         sQfg==
X-Gm-Message-State: AOJu0YzQpfzfIWmrQsu0uaGS5/FTXV1j+5L/IAQwH54so16zMaXqWdfY
	X32D+rV8ENTuNJ7pKC7dbUbRWReZOVFbpY7vv2Vy0uqJZEiWuP7c/F9h4obO4MNR+hK86/ULgDU
	GIY7cuOfFvHnKmdKtMABZZEOCBc9hG0/tuw/14A==
X-Google-Smtp-Source: AGHT+IE/vAYx8mnNdDKMAblUXSdltL/8n5TCQTrCXmLC8zaNaqz1vAs/Oe/IS8XQjJqKfiNn3hNoFDPDJZHtazYV8Ls=
X-Received: by 2002:a92:b70a:0:b0:360:7190:f895 with SMTP id
 k10-20020a92b70a000000b003607190f895mr854939ili.52.1705723162955; Fri, 19 Jan
 2024 19:59:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119224404.26695-2-palmer@rivosinc.com>
In-Reply-To: <20240119224404.26695-2-palmer@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 20 Jan 2024 09:29:11 +0530
Message-ID: <CAAhSdy0naZf8aKkAH6MgYyLior3rZEjx0WWWgp4Ljakrb5q5XQ@mail.gmail.com>
Subject: Re: [PATCH v2] tty: hvc: Fix the RISC-V SBI driver for a refactoring
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Greg KH <gregkh@linuxfoundation.org>, 
	jirislaby@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu, ajones@ventanamicro.com, 
	apatel@ventanamicro.com, Atish Patra <atishp@rivosinc.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 4:15=E2=80=AFAM Palmer Dabbelt <palmer@rivosinc.com=
> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> I missed the int->size_t refactoring in f32fcbedbe92 ("tty: hvc: convert
> to u8 and size_t"), which causes the newly used ops in 88ead68e764c
> ("tty: Add SBI debug console support to HVC SBI driver") to fail to
> build due to a
>
> linux/drivers/tty/hvc/hvc_riscv_sbi.c:59:15: error: incompatible function=
 pointer types initializing 'ssize_t (*)(uint32_t, const u8 *, size_t)' (ak=
a 'long (*)(unsigned int, const unsigned char *, unsigned long)') with an e=
xpression of type 'int (uint32_t, const char *, int)' (aka 'int (unsigned i=
nt, const char *, int)') [-Wincompatible-function-pointer-types]
>         .put_chars =3D hvc_sbi_dbcn_tty_put,
>
> Fixes: f32fcbedbe92 ("tty: hvc: convert to u8 and size_t")
> Fixes: 88ead68e764c ("tty: Add SBI debug console support to HVC SBI drive=
r")
> Link: https://lore.kernel.org/r/20240119215612.20529-2-palmer@rivosinc.co=
m
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> Changes since v1 <20240119215612.20529-2-palmer@rivosinc.com>:
> * Fix the return and arguments correctly.
> * Also fix the hvc_sbi_dbcn_tty_{get,put}().
> ---
>  drivers/tty/hvc/hvc_riscv_sbi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/hvc/hvc_riscv_sbi.c b/drivers/tty/hvc/hvc_riscv_=
sbi.c
> index 2f3571f17ecd..f8cd3310ef35 100644
> --- a/drivers/tty/hvc/hvc_riscv_sbi.c
> +++ b/drivers/tty/hvc/hvc_riscv_sbi.c
> @@ -15,7 +15,7 @@
>
>  #include "hvc_console.h"
>
> -static int hvc_sbi_tty_put(uint32_t vtermno, const char *buf, int count)
> +static ssize_t hvc_sbi_tty_put(uint32_t vtermno, const u8 *buf, size_t c=
ount)
>  {
>         int i;
>
> @@ -25,7 +25,7 @@ static int hvc_sbi_tty_put(uint32_t vtermno, const char=
 *buf, int count)
>         return i;
>  }
>
> -static int hvc_sbi_tty_get(uint32_t vtermno, char *buf, int count)
> +static ssize_t hvc_sbi_tty_get(uint32_t vtermno, u8 *buf, size_t count)

The hvc_sbi_tty_put() and hvc_sbi_tty_get() functions are already
updated in Linus's tree. We only need to fix hvc_sbi_dbcn_tty_put()
and hvc_sbi_dbcn_tty_get()

Please rebase this fix upon Linux-6.8-rc1 whenever that is available.

>  {
>         int i, c;
>
> @@ -44,12 +44,12 @@ static const struct hv_ops hvc_sbi_v01_ops =3D {
>         .put_chars =3D hvc_sbi_tty_put,
>  };
>
> -static int hvc_sbi_dbcn_tty_put(uint32_t vtermno, const char *buf, int c=
ount)
> +static ssize_t hvc_sbi_dbcn_tty_put(uint32_t vtermno, const u8 *buf, siz=
e_t count)
>  {
>         return sbi_debug_console_write(buf, count);
>  }
>
> -static int hvc_sbi_dbcn_tty_get(uint32_t vtermno, char *buf, int count)
> +static ssize_t hvc_sbi_dbcn_tty_get(uint32_t vtermno, u8 *buf, size_t co=
unt)
>  {
>         return sbi_debug_console_read(buf, count);
>  }
> --
> 2.43.0
>
>

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup
