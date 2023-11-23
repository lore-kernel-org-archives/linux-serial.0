Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lTPit1XT"
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099F8D5A
	for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 06:45:17 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-359c22c44d6so3276705ab.2
        for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 06:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700750716; x=1701355516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kuvt9r8KOWX1BiAT/c30zg7sLb0Byjj11/nVghaWWms=;
        b=lTPit1XT2HPqY99IpgW4zsjpbwYHf/Zug/4mebpjf2E+kTgsUo+53jFl4ThIo3CAQP
         IQheI+Q7o7JH8qAJtqSq2+KkdmzpyAU8Jw4fhMuChHoRJjI1PeN2xMKUvw2n02Kiu727
         HpiytbvdCGbzfbep0y5hKZbLFEhwjgAHNkXBNGiTv1BMi+JTDDSbV6vJOoGT26Lw5ePd
         1anxAif/020seGyo7abiSeIo6U3Jbrf7dRStSZQQcXbH9UVU8+vpbmPliP9tFuSGeeuX
         qgZLOb5SwzwvrxV6ANM3cHDpSre2XID0uAlgU4B3WHJEoXDaGx1xheMtBHzZ/t+9SrAH
         9wEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700750716; x=1701355516;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuvt9r8KOWX1BiAT/c30zg7sLb0Byjj11/nVghaWWms=;
        b=qHigDIlQR4NQo7L5xpXVh0nGJ2WHLhBreCZyq90o2u5+c1EzlCfU1iZ6CtOwd6GrJT
         X3qXnC88Hy1FQH8xQbfUTmukfDvKcghxmcSKWDa5DqGIar3KtI0x9cJvyeS5B6OdOApY
         /Ll4Q9DS60j5WR5OtWjOoLI6RNAfKwUCC0Zq5UabDGgBo2Vg01r4IgEGhzSB5JnH9LJI
         N1iEkpN0Pyts5q6DxE0D28gI/iR2/AHclvXgWT87jy35Azgx/30r7MOx0mVQAb+5/xjj
         y8D5rlioL+DYA2xfm2ryggQhqP5HGO0y+DxZROa6u05PcWxkl16U96nik+VOYXmNNyl+
         H6ZQ==
X-Gm-Message-State: AOJu0YyBsZwNHy0C0ji3HlOQeIXUbwdgBeN64ElX9uT+CajxSfgwpiSc
	Q2+vg29PFAbLYQvvn329+VxBiA==
X-Google-Smtp-Source: AGHT+IE6CculVp3F9Rtnr1OLtgszPmbMIieHBv875RrP/HPj2Ga5BLKHDujelRLOHcuKwZeQTRYzTQ==
X-Received: by 2002:a05:6e02:1285:b0:34f:70ec:d4cf with SMTP id y5-20020a056e02128500b0034f70ecd4cfmr5459643ilq.8.1700750716253;
        Thu, 23 Nov 2023 06:45:16 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:8976:165c:1b8d:1b61? ([2605:a601:adae:4500:8976:165c:1b8d:1b61])
        by smtp.gmail.com with ESMTPSA id s2-20020a056e021a0200b0035aeaed5112sm391231ild.84.2023.11.23.06.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 06:45:16 -0800 (PST)
Message-ID: <313e9a3e-0fe5-45e1-a164-1d55fb52898a@sifive.com>
Date: Thu, 23 Nov 2023 08:45:13 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] RISC-V: Add stubs for
 sbi_console_putchar/getchar()
Content-Language: en-US
To: Anup Patel <apatel@ventanamicro.com>
Cc: Conor Dooley <conor@kernel.org>, Andrew Jones <ajones@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
References: <20231118033859.726692-1-apatel@ventanamicro.com>
 <20231118033859.726692-2-apatel@ventanamicro.com>
 <70ff59ea-378c-4d53-899a-eafffcad22fd@sifive.com>
 <CAK9=C2U9aJDDd0JUhRqyLCF3dfyY5QBUrgyH+PKsT+pUKiB1xQ@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CAK9=C2U9aJDDd0JUhRqyLCF3dfyY5QBUrgyH+PKsT+pUKiB1xQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Anup,

On 2023-11-23 4:38 AM, Anup Patel wrote:
> On Wed, Nov 22, 2023 at 4:06 AM Samuel Holland
> <samuel.holland@sifive.com> wrote:
>> On 2023-11-17 9:38 PM, Anup Patel wrote:
>>> The functions sbi_console_putchar() and sbi_console_getchar() are
>>> not defined when CONFIG_RISCV_SBI_V01 is disabled so let us add
>>> stub of these functions to avoid "#ifdef" on user side.
>>>
>>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>>> ---
>>>  arch/riscv/include/asm/sbi.h | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
>>> index 0892f4421bc4..66f3933c14f6 100644
>>> --- a/arch/riscv/include/asm/sbi.h
>>> +++ b/arch/riscv/include/asm/sbi.h
>>> @@ -271,8 +271,13 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>>>                       unsigned long arg3, unsigned long arg4,
>>>                       unsigned long arg5);
>>>
>>> +#ifdef CONFIG_RISCV_SBI_V01
>>>  void sbi_console_putchar(int ch);
>>>  int sbi_console_getchar(void);
>>> +#else
>>> +static inline void sbi_console_putchar(int ch) { }
>>> +static inline int sbi_console_getchar(void) { return -ENOENT; }
>>
>> "The SBI call returns the byte on success, or -1 for failure."
>>
>> So -ENOENT is not really an appropriate value to return here.
> 
> Actually, I had -1 over here previously but based on GregKH's
> suggestion, we are now returning proper Linux error code here.
> 
> Also, all users of sbi_console_getchar() onlyl expect a negative
> value upon error so better to return proper Linux error code.

Alright, makes sense to me.

Regards,
Samuel

