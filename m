Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5108C10E1
	for <linux-serial@vger.kernel.org>; Sat, 20 Jan 2024 04:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705724009; cv=none; b=TBGVw7eO2xGwqx/BjaBXbMoF1nZfGQAl506lFFa5dCGowRhHuVYFAvGejtbcNKFq66TF66BsJCFJjSvNwp80JrF+zoOKjDBzSIgtHIyMh0SyDcQfJuS8RHv596nsFnKIgAZosHu5PJEb4YYkov7G9IPxJAMoUF5ww/lanvAbEE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705724009; c=relaxed/simple;
	bh=4rthaKCXAcFjjd70A0veeQ2wIRDRjwsa6JFsOI341uY=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=FFohxwLK5soyGnITM2/J7ZoFAabMi9cEc5GwkLmRHMdTM0vhiJvAXemYggfxFOpukpEa0jebnyYNR35zNzNy1FBXDbc0r/th++fYfOMWRI8q7KIF9c+PnT6xkHwbFpoYfwVu8oI0T3h9m7xjHtWp7LEimer3uT+M311MJqsHuV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SH/VYrNp; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SH/VYrNp"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3606dc4fdf2so7056385ab.0
        for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 20:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705724006; x=1706328806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEQfFjGG9xeqy4UfcMEbmKUfJ92yD+DVChzT3CuoIZ8=;
        b=SH/VYrNp/EpuFcJL54/5cWk5BN0FQkkIgvcw43ijWvvsNCz9r1IL/mr6zl/yeUyi5/
         xUpaB8xCuwgaVzZrnVSs/EptEPGFx1GYf1WWshLsQRFA+9cD0Ze+ugRXM2bDBh9xydf1
         Ac9UQHAmH6HrcHDzrjXikHQiw63uEktVdlFp+24alM27xk+cFn4gWqEvNnpRj1UzAdub
         3Q/0wfoSJUhoWRsl9Xh0Q4apQr34CvAc7YhclMDVfxk6iWNKwbIJDTS1tR9OJgVAR8ML
         0GbBH66AOyehflXx69l1Cqz68tczNbntKvh0JNz+6Ma6oaQ7BNtiP9K3psn2ul8uDsNN
         gwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705724006; x=1706328806;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEQfFjGG9xeqy4UfcMEbmKUfJ92yD+DVChzT3CuoIZ8=;
        b=BIcKvzS82RrsVYXFBpA8I65S/xaqKzAUGP+u5pnCLvr/HWGlSDrfxFzfZk5qsyZ1wr
         /I1D2Odf/JzSQ44GeEapkzmz+e2HJsfVemb9TWqEG5JDUs0WDFB2iWnk2RuE/AETPEfr
         4Zop7Cy6WbKsGYUKWM+sZm0GdS1lf/wyHmn7rrqH+nv2Z2GSCQm+3j6p4zoj6MJEtWUn
         9VErMTYyqDHIvOcZg/Tr1dLshqa+/1TIyMLcm8b/vvlc5rizSOhb4w0VsKRL5/iiy69Z
         78GiJDM3Dbkwlo3W9kfgesOLqWHdTZCJDBbmNrS02j5FX2sFZAZ1TxF/l5WOy8cL/Lco
         rDpA==
X-Gm-Message-State: AOJu0YyLBMW7N6UfeB6nn+ueDHLTnT7JYk9OCt9Wts7W/8Vx+lpfDhSN
	cGnnuyY5b0disBl9A9vrD1RlNXx4IQMj7yZ06G7eX8uaBq1reJFTaa3Irpc2sb2klwPT0sGXejH
	u
X-Google-Smtp-Source: AGHT+IHn/lDsj6RpPJ5iOJ3naXMlOTNeOjJPdGGzDt9qU3TE5KrD+gOz+Skv2dSn1c3/Yo+fhVy9cA==
X-Received: by 2002:a92:c70f:0:b0:361:ab5c:210d with SMTP id a15-20020a92c70f000000b00361ab5c210dmr1150792ilp.32.1705724006287;
        Fri, 19 Jan 2024 20:13:26 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id kx6-20020a170902f94600b001d5f59fe6aasm3743602plb.37.2024.01.19.20.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 20:13:25 -0800 (PST)
Date: Fri, 19 Jan 2024 20:13:25 -0800 (PST)
X-Google-Original-Date: Fri, 19 Jan 2024 20:13:22 PST (-0800)
Subject:     Re: [PATCH v2] tty: hvc: Fix the RISC-V SBI driver for a refactoring
In-Reply-To: <CAAhSdy0naZf8aKkAH6MgYyLior3rZEjx0WWWgp4Ljakrb5q5XQ@mail.gmail.com>
CC: linux-riscv@lists.infradead.org, Greg KH <gregkh@linuxfoundation.org>,
  jirislaby@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  ajones@ventanamicro.com, apatel@ventanamicro.com, Atish Patra <atishp@rivosinc.com>,
  linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: anup@brainfault.org
Message-ID: <mhng-c6ffd557-de85-4e89-b8aa-c4ac80951e81@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Fri, 19 Jan 2024 19:59:11 PST (-0800), anup@brainfault.org wrote:
> On Sat, Jan 20, 2024 at 4:15 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>>
>> From: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> I missed the int->size_t refactoring in f32fcbedbe92 ("tty: hvc: convert
>> to u8 and size_t"), which causes the newly used ops in 88ead68e764c
>> ("tty: Add SBI debug console support to HVC SBI driver") to fail to
>> build due to a
>>
>> linux/drivers/tty/hvc/hvc_riscv_sbi.c:59:15: error: incompatible function pointer types initializing 'ssize_t (*)(uint32_t, const u8 *, size_t)' (aka 'long (*)(unsigned int, const unsigned char *, unsigned long)') with an expression of type 'int (uint32_t, const char *, int)' (aka 'int (unsigned int, const char *, int)') [-Wincompatible-function-pointer-types]
>>         .put_chars = hvc_sbi_dbcn_tty_put,
>>
>> Fixes: f32fcbedbe92 ("tty: hvc: convert to u8 and size_t")
>> Fixes: 88ead68e764c ("tty: Add SBI debug console support to HVC SBI driver")
>> Link: https://lore.kernel.org/r/20240119215612.20529-2-palmer@rivosinc.com
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>> Changes since v1 <20240119215612.20529-2-palmer@rivosinc.com>:
>> * Fix the return and arguments correctly.
>> * Also fix the hvc_sbi_dbcn_tty_{get,put}().
>> ---
>>  drivers/tty/hvc/hvc_riscv_sbi.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/tty/hvc/hvc_riscv_sbi.c b/drivers/tty/hvc/hvc_riscv_sbi.c
>> index 2f3571f17ecd..f8cd3310ef35 100644
>> --- a/drivers/tty/hvc/hvc_riscv_sbi.c
>> +++ b/drivers/tty/hvc/hvc_riscv_sbi.c
>> @@ -15,7 +15,7 @@
>>
>>  #include "hvc_console.h"
>>
>> -static int hvc_sbi_tty_put(uint32_t vtermno, const char *buf, int count)
>> +static ssize_t hvc_sbi_tty_put(uint32_t vtermno, const u8 *buf, size_t count)
>>  {
>>         int i;
>>
>> @@ -25,7 +25,7 @@ static int hvc_sbi_tty_put(uint32_t vtermno, const char *buf, int count)
>>         return i;
>>  }
>>
>> -static int hvc_sbi_tty_get(uint32_t vtermno, char *buf, int count)
>> +static ssize_t hvc_sbi_tty_get(uint32_t vtermno, u8 *buf, size_t count)
>
> The hvc_sbi_tty_put() and hvc_sbi_tty_get() functions are already
> updated in Linus's tree. We only need to fix hvc_sbi_dbcn_tty_put()
> and hvc_sbi_dbcn_tty_get()
>
> Please rebase this fix upon Linux-6.8-rc1 whenever that is available.

Ya, it's kind of clunky: we added functions at the same time as the 
refactoring, so there's no good clean tree to apply a patch to.  Right 
now I've actually got this bundled up into a merge, that's usually the 
worst option but it's about as good as I could come up with -- Linus 
still hasn't merged my part 2, so I'm going to send a part 3 once I get 
through the tests on my end.

So we'll see, likely tomorrow, and then I'll deal with the fallout after 
rc1...

>
>>  {
>>         int i, c;
>>
>> @@ -44,12 +44,12 @@ static const struct hv_ops hvc_sbi_v01_ops = {
>>         .put_chars = hvc_sbi_tty_put,
>>  };
>>
>> -static int hvc_sbi_dbcn_tty_put(uint32_t vtermno, const char *buf, int count)
>> +static ssize_t hvc_sbi_dbcn_tty_put(uint32_t vtermno, const u8 *buf, size_t count)
>>  {
>>         return sbi_debug_console_write(buf, count);
>>  }
>>
>> -static int hvc_sbi_dbcn_tty_get(uint32_t vtermno, char *buf, int count)
>> +static ssize_t hvc_sbi_dbcn_tty_get(uint32_t vtermno, u8 *buf, size_t count)
>>  {
>>         return sbi_debug_console_read(buf, count);
>>  }
>> --
>> 2.43.0
>>
>>
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
>
> Thanks,
> Anup
