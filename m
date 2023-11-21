Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SippKTRu"
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8313191
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 14:41:28 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7a683bd610dso210724539f.1
        for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 14:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700606488; x=1701211288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6Y5P6vvizTkCcH4d/w5IMJ1P3rAQH0RFmdfD+hCzFk=;
        b=SippKTRuhIN+Tm6Ut4P3RFBAAExms/ddv4eoR9OxmXCt/h7ClDFBpFqFz0wLphpMQr
         5va03IrpKhS5jmjAWzObhba6k+AJcoIxy+X8SPt3LwZx+3eGzwqS8lBg8U4fFqvt0Jky
         WTLCgiJOXQnbD/9pFhV3rNIqjUe19MitqRtyg+pS3PvEps4QZbA8/FxGLyTx8jQ9vAfK
         oWXO6QAn7OuWdjrs3ZlagUTw+mnu8QYELLNOpuvHFguXSPUOUnV0df2XC7KnZSSAILPc
         UfVzanVQp53Jb6OcBOZ1NiBMb/oZ/hwUKgr0/UkhEDh1w4S/PugxU6AEb+lAPgI4ELbb
         tDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700606488; x=1701211288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6Y5P6vvizTkCcH4d/w5IMJ1P3rAQH0RFmdfD+hCzFk=;
        b=CNvj5dBcSp3VTzMytlB/zOi8eXpYMJEYyE0LXNkiQu9eyHYymg0W9nFCizas8mgo25
         tO/BVE6ADP4Pe8uONll9++Kl7JSu6ddxr0RNpYhq85zxka+q+a/IUOpieRDYvVP113Wn
         tTYL/EzD8ueh43UZXtZAqokxkzJJWlNl89JWlaMyI1GKmHGCm+Ja2ET0vmTzUoXEpInE
         /1YsvBstqM5HKVbAHtZE5evHcaF3oMIEMeLb+ynZvaFzKpLyY5HcZw7aBaNgH9PRuSsN
         ykNS852h18P/VXbhFLFGM3QVH3kSFxsc4TpCCqyTUs6I2EU7wWbFF7pYW+eQdWa74PJc
         pPMQ==
X-Gm-Message-State: AOJu0YxhHr57tL5YDEQhH5cacqgnBY89Zz3bZuDliiIlWn6Y6hTTAM9Y
	Auj16jdFXs/Qgz5P0qejCWCnJw==
X-Google-Smtp-Source: AGHT+IFH/7RqkC4+CMkzTbT30NHfcCp/3hQroU+yf96S1nn9LE96a/StCjzs0+QoFrxTjKwkdSqwCg==
X-Received: by 2002:a6b:f719:0:b0:79f:d04d:ce5a with SMTP id k25-20020a6bf719000000b0079fd04dce5amr326806iog.2.1700606488169;
        Tue, 21 Nov 2023 14:41:28 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:3d43:c8e2:1496:e620? ([2605:a601:adae:4500:3d43:c8e2:1496:e620])
        by smtp.gmail.com with ESMTPSA id s7-20020a056602010700b007b34b374dd1sm509116iot.18.2023.11.21.14.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 14:41:27 -0800 (PST)
Message-ID: <8c0f4eba-1923-4686-b07b-1f3b78b298e9@sifive.com>
Date: Tue, 21 Nov 2023 16:41:26 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] tty/serial: Add RISC-V SBI debug console based
 earlycon
Content-Language: en-US
To: Anup Patel <apatel@ventanamicro.com>
Cc: Conor Dooley <conor@kernel.org>, Andrew Jones <ajones@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
References: <20231118033859.726692-1-apatel@ventanamicro.com>
 <20231118033859.726692-4-apatel@ventanamicro.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231118033859.726692-4-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Anup,

On 2023-11-17 9:38 PM, Anup Patel wrote:
> We extend the existing RISC-V SBI earlycon support to use the new
> RISC-V SBI debug console extension.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  drivers/tty/serial/Kconfig              |  2 +-
>  drivers/tty/serial/earlycon-riscv-sbi.c | 24 ++++++++++++++++++++----
>  2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 732c893c8d16..1f2594b8ab9d 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -87,7 +87,7 @@ config SERIAL_EARLYCON_SEMIHOST
>  
>  config SERIAL_EARLYCON_RISCV_SBI
>  	bool "Early console using RISC-V SBI"
> -	depends on RISCV_SBI_V01
> +	depends on RISCV_SBI
>  	select SERIAL_CORE
>  	select SERIAL_CORE_CONSOLE
>  	select SERIAL_EARLYCON
> diff --git a/drivers/tty/serial/earlycon-riscv-sbi.c b/drivers/tty/serial/earlycon-riscv-sbi.c
> index 27afb0b74ea7..5351e1e31f45 100644
> --- a/drivers/tty/serial/earlycon-riscv-sbi.c
> +++ b/drivers/tty/serial/earlycon-riscv-sbi.c
> @@ -15,17 +15,33 @@ static void sbi_putc(struct uart_port *port, unsigned char c)
>  	sbi_console_putchar(c);
>  }
>  
> -static void sbi_console_write(struct console *con,
> -			      const char *s, unsigned n)
> +static void sbi_0_1_console_write(struct console *con,
> +				  const char *s, unsigned int n)
>  {
>  	struct earlycon_device *dev = con->data;
>  	uart_console_write(&dev->port, s, n, sbi_putc);
>  }
>  
> +static void sbi_dbcn_console_write(struct console *con,
> +				   const char *s, unsigned int n)
> +{
> +	sbi_debug_console_write(n, __pa(s));

This only works for strings in the linear mapping or the kernel mapping (not
vmalloc, which includes the stack). So I don't think we can use __pa() here.

> +}
> +
>  static int __init early_sbi_setup(struct earlycon_device *device,
>  				  const char *opt)
>  {
> -	device->con->write = sbi_console_write;
> -	return 0;
> +	int ret = 0;
> +
> +	if (sbi_debug_console_available) {
> +		device->con->write = sbi_dbcn_console_write;
> +	} else {
> +		if (IS_ENABLED(CONFIG_RISCV_SBI_V01))

"else if", no need for the extra block/indentation.

Regards,
Samuel

> +			device->con->write = sbi_0_1_console_write;
> +		else
> +			ret = -ENODEV;
> +	}
> +
> +	return ret;
>  }
>  EARLYCON_DECLARE(sbi, early_sbi_setup);

