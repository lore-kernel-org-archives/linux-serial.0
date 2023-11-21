Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UZr8Dgb+"
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9E51A3
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 14:45:53 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7a67f447bf0so239968439f.2
        for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 14:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700606753; x=1701211553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7iA+kWZUEVLsdUBXgt5tCOpWMD0Y1GKECDIJZh9fHq4=;
        b=UZr8Dgb+BSFkZev0z0UBVkTSSjqphrlM04f0oWAyGm4QQbcZ1bMvz52iUmoRp1E/Xk
         ALT6YM6uBkYvNXIvPx0g+F8C3FXi973DOmH8bDp3mN8J4O/qOhQcSSQ/L00g4uLSz5kA
         yeXT+5AcL5bWNNvkngmtFA0SnxM3oylufc88V6Y+C3Hr8Ub+6kwiwnJCClwVaWuaULuD
         24OwamcZA4RXeUcdZ/hXLBoyipb2PY/Fg5Of8iMUGNT1/sJ/HvzDB3xwMi9cSZk/ZRW+
         I4gWhpNlQPVC5zrQYQSvXcNuAgUF+xC/1DsTnztrrqbkrBtdW70JGlqHx4L4y4EfHgxl
         iSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700606753; x=1701211553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7iA+kWZUEVLsdUBXgt5tCOpWMD0Y1GKECDIJZh9fHq4=;
        b=L5ijONxlg14dWQ8LHqF4f76mBo8SVQXuFXspTyk6UOX5Tee2TP45djhYR40tEjf4D4
         uvlEaVXsGCV6pOYFc51bwallKAWHNsXt/KI8USyvygOXqQrf/1zkVsueUBEc4dZueX13
         jZcy4hlEMThQOEx5Yn1dYCfsHjxlQKfKsZ6HXFyIRJVJS/Tz/2PQUoAhqVrSM+W3LT6A
         ZPi7zT5j+6LTtfi4dsqy351b2W3Ss7oguG7IaoGiDShcD1X4Z0tx8mx5sy+FM5mf0+cB
         4v+QSYM0s2nyGLSWhFCEeKTafWQ6oD2xPE3wYQJQojlj0lkZI4DwP/4EyZe3a+5gYw1T
         bejQ==
X-Gm-Message-State: AOJu0YxHlf7OTESvKS16Od4OgW3fGCtWFQOSRE9E9emGO5vmm4WlgKku
	rn6yW1Qcpmi9liqDRR8vjaJuTg==
X-Google-Smtp-Source: AGHT+IGhfz2kelvWRYhxoS/GC2I/AI6SPzGv2+DveMsAbESr2DRqPpVwoYyjSVjW8igCCV35ZmqdBw==
X-Received: by 2002:a6b:c812:0:b0:7a6:a089:572c with SMTP id y18-20020a6bc812000000b007a6a089572cmr316749iof.21.1700606752801;
        Tue, 21 Nov 2023 14:45:52 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:3d43:c8e2:1496:e620? ([2605:a601:adae:4500:3d43:c8e2:1496:e620])
        by smtp.gmail.com with ESMTPSA id p33-20020a056638192100b004664ef1a3c6sm1930255jal.155.2023.11.21.14.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 14:45:52 -0800 (PST)
Message-ID: <adf2a8f4-f675-4d27-8b46-5d80d3251b6c@sifive.com>
Date: Tue, 21 Nov 2023 16:45:51 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] RISC-V: Add SBI debug console helper routines
Content-Language: en-US
To: Anup Patel <apatel@ventanamicro.com>
Cc: Conor Dooley <conor@kernel.org>, Andrew Jones <ajones@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
References: <20231118033859.726692-1-apatel@ventanamicro.com>
 <20231118033859.726692-3-apatel@ventanamicro.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231118033859.726692-3-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Anup,

On 2023-11-17 9:38 PM, Anup Patel wrote:
> Let us provide SBI debug console helper routines which can be
> shared by serial/earlycon-riscv-sbi.c and hvc/hvc_riscv_sbi.c.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/sbi.h |  5 +++++
>  arch/riscv/kernel/sbi.c      | 43 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 66f3933c14f6..ee7aef5f6233 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -334,6 +334,11 @@ static inline unsigned long sbi_mk_version(unsigned long major,
>  }
>  
>  int sbi_err_map_linux_errno(int err);
> +
> +extern bool sbi_debug_console_available;
> +int sbi_debug_console_write(unsigned int num_bytes, phys_addr_t base_addr);
> +int sbi_debug_console_read(unsigned int num_bytes, phys_addr_t base_addr);
> +
>  #else /* CONFIG_RISCV_SBI */
>  static inline int sbi_remote_fence_i(const struct cpumask *cpu_mask) { return -1; }
>  static inline void sbi_init(void) {}
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 5a62ed1da453..73a9c22c3945 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -571,6 +571,44 @@ long sbi_get_mimpid(void)
>  }
>  EXPORT_SYMBOL_GPL(sbi_get_mimpid);
>  
> +bool sbi_debug_console_available;
> +
> +int sbi_debug_console_write(unsigned int num_bytes, phys_addr_t base_addr)
> +{
> +	struct sbiret ret;
> +
> +	if (!sbi_debug_console_available)
> +		return -EOPNOTSUPP;
> +
> +	if (IS_ENABLED(CONFIG_32BIT))
> +		ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE,
> +				num_bytes, lower_32_bits(base_addr),
> +				upper_32_bits(base_addr), 0, 0, 0);
> +	else
> +		ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE,
> +				num_bytes, base_addr, 0, 0, 0, 0);
> +
> +	return ret.error ? sbi_err_map_linux_errno(ret.error) : ret.value;
> +}
> +
> +int sbi_debug_console_read(unsigned int num_bytes, phys_addr_t base_addr)
> +{
> +	struct sbiret ret;
> +
> +	if (!sbi_debug_console_available)
> +		return -EOPNOTSUPP;
> +
> +	if (IS_ENABLED(CONFIG_32BIT))
> +		ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_READ,
> +				num_bytes, lower_32_bits(base_addr),
> +				upper_32_bits(base_addr), 0, 0, 0);
> +	else
> +		ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_READ,
> +				num_bytes, base_addr, 0, 0, 0, 0);
> +
> +	return ret.error ? sbi_err_map_linux_errno(ret.error) : ret.value;
> +}

Since every place that calls these functions will need to do the vmalloc lookup,
would it make sense to do it here, and have these take a pointer instead?

Regards,
Samuel

