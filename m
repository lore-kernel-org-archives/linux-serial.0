Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MxQRVrfX"
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7A71BC
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 14:36:27 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7b34ddcc625so6685839f.1
        for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 14:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700606187; x=1701210987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Czx5VSw2pBO1b75rdOa8rP1Tn4/X67nT2FHShLEAAdk=;
        b=MxQRVrfXf+3CP4m6yY2Y7mnm4FqdZ2BmFBtogv0eO2jO1m6opXMLXjUB1gtR7B83Xh
         GxG4U1navJnKcYtRY7ibdLVOJL2EIMHBjfUg/ZJfWxBwQD0SsiwN9McknoQLzKzM1PM2
         ZL8bScI2opde5gJrrbrmcQxE6EoFPts3ynFY1NU8G/GSMgmmKnriUExVF8S/2j6dcjPo
         nDnNH3ZjgV099hsvVaBgxdkFXS3Y7fs+OoTQGsb+YSPqqlJcBjJOSyn0Sh10AF9bmxUp
         ewBijHANYMvBhvJg4dCYGezrvoA+I3OiwO6qEPaTjRCG0GKFts2YVievFf//8/pHfwkf
         qIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700606187; x=1701210987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Czx5VSw2pBO1b75rdOa8rP1Tn4/X67nT2FHShLEAAdk=;
        b=Y74Hx2SAs3DXPy/ek/O6B/joBsRwhHdbcAAtvTzQl1b+Zq4+jdtpgblMOA71eVBFZC
         5Y2FYOhUDlwnnAN3YiTOKPUzaa8tWFeXKaytR1Im3QgQo7QLKW3r+/w6Zwru7vursp1k
         FIsuLmPll4VdZyZKO9P/1hgV6jT277WOLJizdi7eCfzrgPWTidVqTmm79nNip7H045fW
         BwASyEh8lbTuhn9V5auTZ5sEm+kudEfHHweNwJS1uqyXdhB+yJlvXvrwh8/q5bl72JFC
         dCWgn590KH2J/PZLb/8V6Gs8xGrGmBXqWp0HLSiGh/Ho1b0gynsOTFNXNIoXKbOHArNi
         cLeg==
X-Gm-Message-State: AOJu0YzcSQVJ5+E3NFz9ZQWZPd7H7SAmZu72rfPccit3+hxm4Uw1ld4A
	nTPEo3XiR6z23vGibNk/R7mumw==
X-Google-Smtp-Source: AGHT+IGfRVAH/8cvT9hmm4Ha5Eu0JN6NTmiZ2ExPb4m6TDcyvIXswopr0JkqwntNsAW38gNPKGfKow==
X-Received: by 2002:a92:cac2:0:b0:357:f72d:ad06 with SMTP id m2-20020a92cac2000000b00357f72dad06mr285038ilq.2.1700606186826;
        Tue, 21 Nov 2023 14:36:26 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:3d43:c8e2:1496:e620? ([2605:a601:adae:4500:3d43:c8e2:1496:e620])
        by smtp.gmail.com with ESMTPSA id 8-20020a056e020ca800b0034aa175c9c3sm3434455ilg.87.2023.11.21.14.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 14:36:26 -0800 (PST)
Message-ID: <70ff59ea-378c-4d53-899a-eafffcad22fd@sifive.com>
Date: Tue, 21 Nov 2023 16:36:25 -0600
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
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231118033859.726692-2-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Anup,

On 2023-11-17 9:38 PM, Anup Patel wrote:
> The functions sbi_console_putchar() and sbi_console_getchar() are
> not defined when CONFIG_RISCV_SBI_V01 is disabled so let us add
> stub of these functions to avoid "#ifdef" on user side.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/include/asm/sbi.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 0892f4421bc4..66f3933c14f6 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -271,8 +271,13 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>  			unsigned long arg3, unsigned long arg4,
>  			unsigned long arg5);
>  
> +#ifdef CONFIG_RISCV_SBI_V01
>  void sbi_console_putchar(int ch);
>  int sbi_console_getchar(void);
> +#else
> +static inline void sbi_console_putchar(int ch) { }
> +static inline int sbi_console_getchar(void) { return -ENOENT; }

"The SBI call returns the byte on success, or -1 for failure."

So -ENOENT is not really an appropriate value to return here.

Regards,
Samuel

> +#endif
>  long sbi_get_mvendorid(void);
>  long sbi_get_marchid(void);
>  long sbi_get_mimpid(void);

