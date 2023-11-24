Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WWtK3fD2"
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2420B0
	for <linux-serial@vger.kernel.org>; Fri, 24 Nov 2023 09:31:35 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a049d19b63bso309234366b.2
        for <linux-serial@vger.kernel.org>; Fri, 24 Nov 2023 09:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700847094; x=1701451894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MmcPyK3mkdrLM52uLYpIt1qXSSFyNhnpJboXxQydAo=;
        b=WWtK3fD2srRMxzUj0evOlz2xiOCJzmnLbLet49MdiPHVRVpimC8aSIq32N/+QXtle2
         gNXFSJaq96Zn4LbsK2HIBqqWbROd5+ANpzaQdErGCHVuRW7tH80CPizq65/2IhtVG46V
         J2XMJkCg1g6375A5y9lgTtdxSGxJZRW5dAm2cnRKxPphWwaeoSpJNzR1xqGfxhl2k2qs
         gUxlvo8Hs8G6kSPy5yMWUR5humP1gK9hN0+dkfCQ4Am0t+tsOpF3h7HAcKKjasnO6K19
         lc8fi7qBMZ4kkF+i0q+2TlWnv3dLkC1rCKmGNnuTUENFNRf2Hs/tlrHTAFqej5OrDSrX
         u0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700847094; x=1701451894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MmcPyK3mkdrLM52uLYpIt1qXSSFyNhnpJboXxQydAo=;
        b=Nm/uTrYVnlN2l12j0xfKXdwzSvLhCofe/Eun7uLLvVVnyQInL8F7+DGknnOQ3Dq4Wi
         m38A/kdpZ7VQL0ahoymuUx/PPMTubDw206qMHt22MAr/UxZpwdABCQW2LH5wD3E6fiID
         xAZlP2j5QlknmMsjFSwU8c5VfA7PRgUes3XoGlYkWBsnbRu9qrxel47jJPxt1JesvEot
         swyTIWN5a7331MDDAO9fCXoFqTolCry3w4SzjG8Hs6VEOwaGeFyGG9EqS2erpX7b2iv/
         ViFKG5FkgFTWqWElIpfIGegwzI0Wdoc4YOnFd7fXSNTX1Eg4shMcm1lqE/AmuKOZM2Jz
         AV5A==
X-Gm-Message-State: AOJu0YwtQY2I1RDDnnWwehOKBdHEvUz8fRldJpKndDoLBjrLlhAk+JuG
	hhetMg9uBJUS3fF65V3wlsCyhA==
X-Google-Smtp-Source: AGHT+IG6CMsfmQV5iDvLoyvWP8dLg5EMoM/S3qrMav9BlUgZwXuqbKVl403ib2zNmITpuo9KrFP3JA==
X-Received: by 2002:a17:907:2983:b0:9fb:da63:bb2f with SMTP id eu3-20020a170907298300b009fbda63bb2fmr2616757ejc.18.1700847094196;
        Fri, 24 Nov 2023 09:31:34 -0800 (PST)
Received: from localhost ([81.19.4.232])
        by smtp.gmail.com with ESMTPSA id h4-20020a170906398400b009fd541851f4sm2306940eje.198.2023.11.24.09.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 09:31:33 -0800 (PST)
Date: Fri, 24 Nov 2023 18:31:33 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v5 4/5] tty: Add SBI debug console support to HVC SBI
 driver
Message-ID: <20231124-cf60c92a6a7a2b220feab211@orel>
References: <20231124070905.1043092-1-apatel@ventanamicro.com>
 <20231124070905.1043092-5-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124070905.1043092-5-apatel@ventanamicro.com>

On Fri, Nov 24, 2023 at 12:39:04PM +0530, Anup Patel wrote:
> From: Atish Patra <atishp@rivosinc.com>
> 
> RISC-V SBI specification supports advanced debug console
> support via SBI DBCN extension.
> 
> Extend the HVC SBI driver to support it.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/tty/hvc/Kconfig         |  2 +-
>  drivers/tty/hvc/hvc_riscv_sbi.c | 37 ++++++++++++++++++++++++++-------
>  2 files changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
> index 4f9264d005c0..6e05c5c7bca1 100644
> --- a/drivers/tty/hvc/Kconfig
> +++ b/drivers/tty/hvc/Kconfig
> @@ -108,7 +108,7 @@ config HVC_DCC_SERIALIZE_SMP
>  
>  config HVC_RISCV_SBI
>  	bool "RISC-V SBI console support"
> -	depends on RISCV_SBI_V01
> +	depends on RISCV_SBI
>  	select HVC_DRIVER
>  	help
>  	  This enables support for console output via RISC-V SBI calls, which
> diff --git a/drivers/tty/hvc/hvc_riscv_sbi.c b/drivers/tty/hvc/hvc_riscv_sbi.c
> index 31f53fa77e4a..2f3571f17ecd 100644
> --- a/drivers/tty/hvc/hvc_riscv_sbi.c
> +++ b/drivers/tty/hvc/hvc_riscv_sbi.c
> @@ -39,21 +39,44 @@ static int hvc_sbi_tty_get(uint32_t vtermno, char *buf, int count)
>  	return i;
>  }
>  
> -static const struct hv_ops hvc_sbi_ops = {
> +static const struct hv_ops hvc_sbi_v01_ops = {
>  	.get_chars = hvc_sbi_tty_get,
>  	.put_chars = hvc_sbi_tty_put,
>  };
>  
> -static int __init hvc_sbi_init(void)
> +static int hvc_sbi_dbcn_tty_put(uint32_t vtermno, const char *buf, int count)
>  {
> -	return PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_ops, 16));
> +	return sbi_debug_console_write(buf, count);
>  }
> -device_initcall(hvc_sbi_init);
>  
> -static int __init hvc_sbi_console_init(void)
> +static int hvc_sbi_dbcn_tty_get(uint32_t vtermno, char *buf, int count)
>  {
> -	hvc_instantiate(0, 0, &hvc_sbi_ops);
> +	return sbi_debug_console_read(buf, count);
> +}
> +
> +static const struct hv_ops hvc_sbi_dbcn_ops = {
> +	.put_chars = hvc_sbi_dbcn_tty_put,
> +	.get_chars = hvc_sbi_dbcn_tty_get,
> +};
> +
> +static int __init hvc_sbi_init(void)
> +{
> +	int err;
> +
> +	if (sbi_debug_console_available) {
> +		err = PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_dbcn_ops, 256));
> +		if (err)
> +			return err;
> +		hvc_instantiate(0, 0, &hvc_sbi_dbcn_ops);
> +	} else if (IS_ENABLED(CONFIG_RISCV_SBI_V01)) {
> +		err = PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_v01_ops, 256));
> +		if (err)
> +			return err;
> +		hvc_instantiate(0, 0, &hvc_sbi_v01_ops);
> +	} else {
> +		return -ENODEV;
> +	}
>  
>  	return 0;
>  }
> -console_initcall(hvc_sbi_console_init);
> +device_initcall(hvc_sbi_init);
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
