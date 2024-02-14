Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596315D912
	for <linux-serial@vger.kernel.org>; Wed, 14 Feb 2024 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925828; cv=none; b=lQR3ZxU9isDNrEPZ1GXLytFJjCpTjBNvN5FXSrrmYNfIuiiUjw+RTSbtKn1JR/d9hLRvv5AAAMtZvswXfhBWkZtRpdjmJvnW/YJllqSL978oRM716StD0jLFwsbxLtDDSrqR9gVL6OF0V3oVOGZv9tcycr+JiNLYdKFBNAMHcOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925828; c=relaxed/simple;
	bh=3ixfx9hvHowkdPW052W2BTLyOZIPcGFLydpr9ppzU6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYIwlhPPqn9Fl0g7N2TLPH4mHgMa68OvLEbIAJDFkJfSGSuAUXrFNiOqwwgQxJZVfdyFKkEE0qsBPgOJe1DLf0v/JWHVUNUoCNbTkvhQc1LIgk+5nCUJ12t3b6MaDZqUvwgiBs6gd5cBP2QP78C3G/Y5XQUtF/zzOAtlzqJxrL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=3FN5jaXx; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="3FN5jaXx"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7baa8097064so334750739f.3
        for <linux-serial@vger.kernel.org>; Wed, 14 Feb 2024 07:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1707925825; x=1708530625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSlVGbEelZs1+mCJGuJE5TbiYr0MAiLjyMJwC22PtNU=;
        b=3FN5jaXxmOUuARuGbkAUOBRUrTUQBEbCJpSW6jE5Yor5+pG74A3QLo0dAodUMc4VnX
         sFBGbwnzRqckIaTDnOL2ovj4OfwJZfhcC/izj+oyCtB3O1AKnfBEwoF5bgeF/8J9vgrv
         nVO0TZ4/bknWSzncZ3m3Kt7nG9CHRRoKj7Zwm+UK6xGdGVSXR5pcM/9tvK+UbAQfPIH7
         Pxf1wQurgOXXxFbxfpLhJ2sbOR+7n5GZdoXN2UdB68KrtE+fHK6p5kZCfMz2ttULqogj
         9BNwZ4aom/Mk4Xgj+d8hw7rSMVX5pZVEVY8nBelbzuED7oP97L5QtEUDCVmYtR2CgBZ1
         LlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707925825; x=1708530625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSlVGbEelZs1+mCJGuJE5TbiYr0MAiLjyMJwC22PtNU=;
        b=KA9+gi+UTLVQau3m7MBqihhiU39Ab9OsW4660VdUxsSeMws3zzLH0/qXK203FbkGcd
         rxg9BbIFSlMNZAYi93RxB6nh06WZFA+mx37TaCQJ6R3u+ZL92jU2J9GBnk/iiMH/y4t/
         cXkdBh+vhiGWaM49Mb2iLZ0HJLWK+QYoTDkEZ0a3eda9At3J5V0kBJhZ+nakLZ+WbRpg
         aOziHWfx3RARIc9iZSJvU5kA1GLnj+qLxDiVf3N/yMPb9JBE8AYhXanqo+qhDMYHflAz
         88J+2dktC1ygqek0eafrMXXzRK0v0SmPrhSwUv4PoIrClXSgAeoB42zddaHfI6RGDl58
         0YQg==
X-Forwarded-Encrypted: i=1; AJvYcCU7whB/kslsfwpog0A+/XVsqXGVwGqHhS1/7O6IRzVIar85+Nljq+4Mi+nragYy4mf3ohow2L/l3R1Oji0XgiXaQcbTYK0LTGBkiZtZ
X-Gm-Message-State: AOJu0YzVHY3ox+oQT7iYogJL3FqVmorg6q1WrWKA4bXmtwTjxX/PTxlf
	IWtGvWaLGGJ69W8tZg6E408dJIBB+wq/08HdSSKLe2NB4AQcPwqDg4xy1nipn7VsGyr5lIH6MoM
	eSAwuJKvRxI5+tu8beYQM4w6ZYlfdHbMtxHuNFQ==
X-Google-Smtp-Source: AGHT+IEg1mjBag5fQq6IiYnFAmtRUKSsf1C8M5YPUMlpqUwiUYtvbiinLPu7A8tR+cYW+rVJo79k/QL1npQnEykKim4=
X-Received: by 2002:a92:ca89:0:b0:363:d9eb:dae2 with SMTP id
 t9-20020a92ca89000000b00363d9ebdae2mr2993529ilo.13.1707925825474; Wed, 14 Feb
 2024 07:50:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214153429.16484-2-palmer@rivosinc.com>
In-Reply-To: <20240214153429.16484-2-palmer@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 14 Feb 2024 21:20:13 +0530
Message-ID: <CAAhSdy3Tf=9jD1Cd11RjwKyDFPA_gHTqxMXSJ3HwANFFnR-8dA@mail.gmail.com>
Subject: Re: [PATCH] tty: hvc: Don't enable the RISC-V SBI console by default
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Greg KH <gregkh@linuxfoundation.org>, 
	jirislaby@kernel.org, Atish Patra <atishp@rivosinc.com>, ajones@ventanamicro.com, 
	apatel@ventanamicro.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Emil Renner Berthing <kernel@esmil.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 9:06=E2=80=AFPM Palmer Dabbelt <palmer@rivosinc.com=
> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> The new SBI console has the same problem as the old one: there's only
> one shared backing hardware and no synchronization, so the two drivers
> end up stepping on each other.  This was the same issue the old SBI-0.1
> console drivers had, but that was disabled by default when SBI-0.1 was.
>
> So just mark the new driver as nonportable.
>
> Reported-by: Emil Renner Berthing <kernel@esmil.dk>
> Fixes: 88ead68e764c ("tty: Add SBI debug console support to HVC SBI drive=
r")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

LTGM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/tty/hvc/Kconfig | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
> index 6e05c5c7bca1..c2a4e88b328f 100644
> --- a/drivers/tty/hvc/Kconfig
> +++ b/drivers/tty/hvc/Kconfig
> @@ -108,13 +108,15 @@ config HVC_DCC_SERIALIZE_SMP
>
>  config HVC_RISCV_SBI
>         bool "RISC-V SBI console support"
> -       depends on RISCV_SBI
> +       depends on RISCV_SBI && NONPORTABLE
>         select HVC_DRIVER
>         help
>           This enables support for console output via RISC-V SBI calls, w=
hich
> -         is normally used only during boot to output printk.
> +         is normally used only during boot to output printk.  This drive=
r
> +         conflicts with real console drivers and should not be enabled o=
n
> +         systems that directly access the console.
>
> -         If you don't know what do to here, say Y.
> +         If you don't know what do to here, say N.
>
>  config HVCS
>         tristate "IBM Hypervisor Virtual Console Server support"
> --
> 2.43.0
>
>
