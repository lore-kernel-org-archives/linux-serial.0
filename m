Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EF0u/8wD"
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D0CB9
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 14:48:10 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7a9857c14c5so210629039f.3
        for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 14:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700606890; x=1701211690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ha2zL2RliN6J5b2kLDdhsZ6GbGCv9fZnJqsfyqkrjz4=;
        b=EF0u/8wDYnDq/mzYotbx4SZuvWtpVHtc0ek0+++Sx9lKALxa2HhcfhftDPGHItrgYP
         mOvbWORLeqEA4gheTOrDU7tAbjmmJgVSFXLo8XgzgmBetIRdzViMesogDTINvoMJRq17
         W88e7rT6ODkMZDtlTPEzuDmKe+KiQlN7EHAEJ4biPGDWCRCXUmwCOHEMiZpnjM75WkfF
         pitJfwviqcoJZnV1EM8B892CvTA7p+eoRGbUE3wSGlOHtlB5F7TxMdaRkw3d/LswvwGw
         ahQD1ZFaYgy7OCnp8wjaWc/Ge3FUSpLYbAuCwUNrKJsFEUUrXFM9PvaTkOIaCeulf3dO
         xonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700606890; x=1701211690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ha2zL2RliN6J5b2kLDdhsZ6GbGCv9fZnJqsfyqkrjz4=;
        b=fRMiuiu1Xa3rbsYnGJzftRxkfseETQtc/XvB9dCnczuk7gn1fT0GNErWMKrqQs2TVp
         2tmA8SHoh3BVxv1IZDwdO5BZRXr5v9+gxp8qpqfWpHdlrH/LD3AHHORvKbkN/HaXYQ3n
         c4qBkRbubKM5OCONY/N5rY/+M8M1Fgc4Ih/LhZSKLpfFAAQhCR2TnUgL5qH4XyECUOOr
         ccxKvcCUangzPil3Swa+cV7CyvT+Y9fXERCa5w4FSi4ul7+xV81vkE58Xon7ciJ6aCD7
         SzlREjKMxqphkhJnbmgNLnk/vvyP/g4ZD+vk1rLAraNFU4jbkpTV2sudrg7pK9mQF3qT
         ftvA==
X-Gm-Message-State: AOJu0YyMjj/O0oR6oU7xMxODud3LgWO7LUdZ/+9MJvUSXBMLmzEz3OAa
	gFbFc0zfLtvVxaoLrata/4facw==
X-Google-Smtp-Source: AGHT+IEqopk3WpneTwAJdQEga6tdFjb3hMHKJSSM4AtmRyuOtlB2pSKEyHj6RtL8C3xrT6bMg/cE5g==
X-Received: by 2002:a05:6602:c08:b0:7aa:125a:b0c4 with SMTP id fn8-20020a0566020c0800b007aa125ab0c4mr437169iob.5.1700606889842;
        Tue, 21 Nov 2023 14:48:09 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:3d43:c8e2:1496:e620? ([2605:a601:adae:4500:3d43:c8e2:1496:e620])
        by smtp.gmail.com with ESMTPSA id fj34-20020a056638636200b004290fd3a68dsm2835154jab.1.2023.11.21.14.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 14:48:09 -0800 (PST)
Message-ID: <fb72e212-711e-4be9-9b92-89b2dc121476@sifive.com>
Date: Tue, 21 Nov 2023 16:48:08 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] RISC-V: Enable SBI based earlycon support
Content-Language: en-US
To: Anup Patel <apatel@ventanamicro.com>
Cc: Conor Dooley <conor@kernel.org>, Andrew Jones <ajones@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
References: <20231118033859.726692-1-apatel@ventanamicro.com>
 <20231118033859.726692-6-apatel@ventanamicro.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231118033859.726692-6-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Anup,

On 2023-11-17 9:38 PM, Anup Patel wrote:
> Let us enable SBI based earlycon support in defconfigs for both RV32
> and RV64 so that "earlycon=sbi" can be used again.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/configs/defconfig      | 1 +
>  arch/riscv/configs/rv32_defconfig | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 905881282a7c..eaf34e871e30 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -149,6 +149,7 @@ CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_8250_DW=y
>  CONFIG_SERIAL_OF_PLATFORM=y
>  CONFIG_SERIAL_SH_SCI=y
> +CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
>  CONFIG_VIRTIO_CONSOLE=y
>  CONFIG_HW_RANDOM=y
>  CONFIG_HW_RANDOM_VIRTIO=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 89b601e253a6..5721af39afd1 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig

This file isn't used anymore since 72f045d19f25 ("riscv: Fixup difference with
defconfig"), so there's no need to update it. I'll send a patch deleting it.

Regards,
Samuel

> @@ -66,6 +66,7 @@ CONFIG_INPUT_MOUSEDEV=y
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_OF_PLATFORM=y
> +CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
>  CONFIG_VIRTIO_CONSOLE=y
>  CONFIG_HW_RANDOM=y
>  CONFIG_HW_RANDOM_VIRTIO=y

