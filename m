Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747145821B
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705701824; cv=none; b=S5FjyTwx7rL/N+ihVe6cKU0YYt0GUZ+cBIka5a29wRTnegqOJhynEGl1ovpX+1UNpjyWZnBXvXbybYH9UPkc6TvnTnU/rqTxi4hpCe75UZrlv8w86fNdv+G4yzlA5iz45fYg4mlgqDrAfVp6kqOVJW9Eu/SPi5JtjqALgqWtYVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705701824; c=relaxed/simple;
	bh=UK0vew5OPvSZbMAryrGZG51aWIjGOLTwWnU0d+JZhpc=;
	h=Date:Subject:In-Reply-To:Message-ID:Mime-Version:Content-Type:CC:
	 From:To; b=JnkFWMI8LIBmC/0shrgF4gmgS5ulT4pWlkvT3gzy//tg0/m8YzrilGWQZaWcOU+ZK3eqS1G8TFPLHp2z4VHDnAI97W7AMA1phP4mB9vfv+CJrIDUj++cq70Vs3mW3YOIpyL61mdIBcRcU1qtxJIO+x1d64dkY22duCuQYRierfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nkRgJE94; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nkRgJE94"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ce942efda5so1007675a12.2
        for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 14:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705701822; x=1706306622; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5aaVzBMeeZblMbEUbDFmZomg/HzP8H1Gn+gnGtwevNs=;
        b=nkRgJE94OGEwBbf4XFDE7WCcKD26VaPWlMlNvY+ay0pGa++pwg7ENvD/7Ejd69vmd2
         4dfLVOC8FzQ/a/4fw3JNU4d0gNBKV7z+n2hFYmNO+M/q81/ZbVC4+t8fX4MIfiKSN/Tg
         YN+0J5Y3T8CehtTZUD3GfZRuOz+bL8otbsL5UJ5vg5PV/JYn5rhhL6xTcQo+HmIKPVFx
         y7hSNYNXF8juGB9DgrJUFlXNePF1vHmSKVhG6Iv0kyHGCG14gc3vChQ6PQgsd4FO/HkH
         6Td/hBLVKwZKxXefoNpSv2Ub1iIhq0EEVReEQkNmmI4zVyJ+ZEldKn+smkySa3ivZqOE
         h5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705701822; x=1706306622;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aaVzBMeeZblMbEUbDFmZomg/HzP8H1Gn+gnGtwevNs=;
        b=ZVcA8dtq595tw5mdPHAYGcz/3E3XwZNQ7BZgQhqlNgdYQDbQpz6xzb/puVwPAuaZ0N
         1KHvMlA/dYWNM2rTFFi+aOkcFLwxWjp+ykpf0WqUJRDQKAMtnWm0vpzbL5Y533yHn77x
         yGejpFhjvfwJsZgmwSU4XlqB2u8uenPhirydL5XMByfZamYdV0Ce8c0T4333gVDW1b8+
         GhmjPYCGdWWqlAFTFhk2L8Ar2aD6a18J5vH7XMpD1xIOw5MySvI8uKJhOh1BDb59VlFe
         Cng4xuCssmKj7uZD1Zi+jjaMSYlVqm+IzqP9cGQAj91vqIMj5eCuJ6mEJ2g3pHz1JcWc
         BikA==
X-Gm-Message-State: AOJu0YxDnI9JFQRiDcEoVaxtCzR/71JgN39Re/v4RC7Otbyz8VkS3k5j
	IuV1/Wc8XvCO1bGucetYt0G4Wu0Mz0bqdze4/0+afSr0LOF0Xzbdu+32NOlnRssybz0X/83KeCl
	c
X-Google-Smtp-Source: AGHT+IGftZP2Jl+VwJV08AVdkfiAwWPWCiEg5yYwDaS6Y+0pO5wM+PStwOKVnAiNRaDx+cdEX7oaxg==
X-Received: by 2002:a17:90b:30c6:b0:28f:f70f:ee60 with SMTP id hi6-20020a17090b30c600b0028ff70fee60mr415981pjb.8.1705701821779;
        Fri, 19 Jan 2024 14:03:41 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id e16-20020a170902cf5000b001d5c38bfa33sm3486111plg.307.2024.01.19.14.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 14:03:41 -0800 (PST)
Date: Fri, 19 Jan 2024 14:03:41 -0800 (PST)
X-Google-Original-Date: Fri, 19 Jan 2024 14:03:11 PST (-0800)
Subject:     Re: [PATCH] tty: hvc: Fix the RISC-V SBI driver for a refactoring
In-Reply-To: <20240119215612.20529-2-palmer@rivosinc.com>
Message-ID: <mhng-dd8222be-f59f-4422-8cf5-dbefccf63f5f@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
CC: linux-riscv@lists.infradead.org, Greg KH <gregkh@linuxfoundation.org>,
  jirislaby@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  ajones@ventanamicro.com, Atish Patra <atishp@rivosinc.com>, apatel@ventanamicro.com,
  linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
  linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Palmer Dabbelt <palmer@rivosinc.com>

On Fri, 19 Jan 2024 13:56:13 PST (-0800), Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> I missed the int->size_t refactoring in f32fcbedbe92 ("tty: hvc: convert
> to u8 and size_t"), which causes the newly used ops in 88ead68e764c
> ("tty: Add SBI debug console support to HVC SBI driver") to fail to
> build due to a
>
> linux/drivers/tty/hvc/hvc_riscv_sbi.c:59:15: error: incompatible function pointer types initializing 'ssize_t (*)(uint32_t, const u8 *, size_t)' (aka 'long (*)(unsigned int, const unsigned char *, unsigned long)') with an expression of type 'int (uint32_t, const char *, int)' (aka 'int (unsigned int, const char *, int)') [-Wincompatible-function-pointer-types]
>         .put_chars = hvc_sbi_dbcn_tty_put,
>
> Fixes: f32fcbedbe92 ("tty: hvc: convert to u8 and size_t")
> Fixes: 88ead68e764c ("tty: Add SBI debug console support to HVC SBI driver")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I now remember Anup pointing this one out, but looks like I forgot about
> it.
> ---
>  drivers/tty/hvc/hvc_riscv_sbi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/hvc/hvc_riscv_sbi.c b/drivers/tty/hvc/hvc_riscv_sbi.c
> index 2f3571f17ecd..c08718be8e73 100644
> --- a/drivers/tty/hvc/hvc_riscv_sbi.c
> +++ b/drivers/tty/hvc/hvc_riscv_sbi.c
> @@ -15,7 +15,7 @@
>
>  #include "hvc_console.h"
>
> -static int hvc_sbi_tty_put(uint32_t vtermno, const char *buf, int count)
> +static size_t hvc_sbi_tty_put(uint32_t vtermno, const char *buf, int count)

I got a little lost in my branches here, that should be "ssize_t".  I'll 
send a v2 when I figure out why my tester is acting oddly...

>  {
>  	int i;
>
> @@ -25,7 +25,7 @@ static int hvc_sbi_tty_put(uint32_t vtermno, const char *buf, int count)
>  	return i;
>  }
>
> -static int hvc_sbi_tty_get(uint32_t vtermno, char *buf, int count)
> +static size_t hvc_sbi_tty_get(uint32_t vtermno, char *buf, int count)
>  {
>  	int i, c;
