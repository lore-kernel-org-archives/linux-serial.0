Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E82A395AEB
	for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784575340; cv=none; b=VgFIqE9nV6Ara+qyLtfTSqptEgsRcD8VI/rbsR38pPtMFekvtZp4eVcYZ1cgS6j9fw5z67m4KhLuTy5Y338MqH227eNUdWXDvNqS0flQCfL47s7Dd1SZ4CxKPoB/QnD0/IR9jBJR2hmEVqeXt//lErjBJAY0r+IxvQ89MhySRds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784575340; c=relaxed/simple;
	bh=dZ9PqzvyFtar2RaK7XlD8g0TD5Y3r8HD349KnUrmZV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqkbH+VxoiY4jZX7b+glIA0v2MKla83k7dC7PFA+Y51Omq50Iy7JzteRh6ZkkgleN8gFuWAJgnE4uB23NYmuVOPoLtlWHSIhtSoZMmQoUmIGHkf5q3qlwkc2KcFGR0wRgEzDfIkajd4z5btc/OJYCJtwL/dkVZD527R0QxbfCro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=UUkZveV7; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="UUkZveV7"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9f5637634so4489955a34.3
        for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 12:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1784575337; x=1785180137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bGto1WUmtU2FuWuRVZZkJWBifnkd6qv0KZ7sGmDSExQ=;
        b=UUkZveV7MLZGrrSvIN+2ImylKapaxJqQkl7ndVgwOKWDHcH8YcvZ3emzBXVamPjFQf
         VCfeS9fhgRqZwQNOtSQn8fiGDRTPdLeKe9v/WqTSQCDZuFoe28tOQPbP6gI1n5kQCw/w
         X98dk8dHxY2AHpdRxSnwTJ6xbPxQTk3zJ9gbG4++a6fF2wyykXbGc0hiQ7/GdZI33cHr
         4LFrP70rr72Tek3AMqukeR0R4gTZsLiAmswaHZSO2xFcgFrbSeaJ/ZuXeUScCDHOWR1H
         ZIYPn2Ee0DxOKIoO6MAyuT+scoP8vDVU8bYUeQ8Q12TdthTOXYZszR++zrxw2qfaKoCP
         2uoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784575337; x=1785180137;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bGto1WUmtU2FuWuRVZZkJWBifnkd6qv0KZ7sGmDSExQ=;
        b=M/IWyixO2nWnr5lfDl5XdHR9NUfNR1jfVyGE3yBRz4H2cVGm/JYDSUwFYa2kQa7yr6
         c5afaT9H+JqS5cugFsmMcUj5HHclnwFhvJsYYRU4PLGO5MQ3zq2PgW6BIuALEybC5Pio
         z6NTqgH7JtDq7TG5YYIpySXTZiZNqF8I2Ryww17QGoTgkK9uAvhmtNuFAylp3rDR6fZB
         mhBfYe05meB7FH16/CcvSFxP3sxVNG8AkGVSDKJ5Be4bx9JgaYcikjqqHBKwdj32DmZY
         SbXaEzCBdJniKgpIT/e2LyO++IEwx6zIDIEH1LzqQpuEB6HvjmUq/iEnPcYepSi1MNGg
         avPQ==
X-Forwarded-Encrypted: i=1; AHgh+RoVuw4AD63DYClvmDqxEohZASuoBTaa1pWoZY3GLpPueRHFyUQU8XYVRVHdv/p9UziNuy5Uty3a8POEt8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXoi3H338yH81Bs2PqaWiXGdWC1CoxUKoq4wrRTPbtl37406DO
	5rlCEFQ44fwWYtt5c2I2LBHeCWLib0MBQakTpNK0cKXV06fIg9rtDTd8Lk1r/BWEgGw=
X-Gm-Gg: AfdE7cmKygyQ6ccqr96LeYy37EryPaZRshhmLGY1RdpziFckpEiCvNlZqCE+RsG9fQk
	RnYHnI4pU26tn/z577BkwIg7AB6Q6BliHGiE+O9mBnDtNs9+5xD5zAuiEfZ+eCCRhodN2tT+jsC
	8YFO+egKVPi/RgDh2skCWSTt4IbfIJ7IbePflobMviw4/z/YZ4+xEcH77R6GuuEGC6NjdjwcmKX
	YtH9/e8fzSw7FVitavKPzoAStoNpMM5LA1YtUYokVRK3ngbHI7ZZAcIbV8lRWUt+3NzZueCUhHb
	malzyrtxit7oXKvsXhDC0JwvB1nH/wUGoRwe9fT3ZRLd1tz+nqgM+KbHVJaZuuM2QFHeZjUnIP2
	JJCSOBG41SUgTbA6Aglj5O0+CLWGwm3x4cIwOYId7SdscL4ZGRcfz/Vg1u7sCJ74v5cjkYQXaI4
	Tqr1wP0rUxyK7x+EjUhGAwD2HfBhfkmbkVYNdGamLWOw==
X-Received: by 2002:a05:6830:81ee:b0:7e9:b4d1:78b0 with SMTP id 46e09a7af769-7eda1157b00mr8626249a34.30.1784575336932;
        Mon, 20 Jul 2026 12:22:16 -0700 (PDT)
Received: from toolbox ([12.55.13.134])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edad91b8a5sm8911080a34.5.2026.07.20.12.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:22:16 -0700 (PDT)
Date: Mon, 20 Jul 2026 14:21:59 -0500
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, osama.abdelkader@gmail.com, andy.shevchenko@gmail.com, 
	jackzxcui1989@163.com, kees@kernel.org, sean@mess.org, alan@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, wangfushuai@baidu.com, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3] serial: 8250: Clear CON_PRINTBUFFER on port
 re-registration
Message-ID: <dnpnqx6fz4osobhi7ydt2pi6hvqb4lm5vonpfpwrl2nogpadmw@6bqiyjskjo5j>
References: <20260522101042.21976-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522101042.21976-1-fushuai.wang@linux.dev>

Hi Fushuai,

On Fri, May 22, 2026 at 06:10:42PM +0800, Fushuai Wang wrote:
> From: Fushuai Wang <wangfushuai@baidu.com>
> 
> When two PnP devices map to the same physical port, the serial8250 driver
> removes and re-registers the console structure for the same port.
> 
> During re-registration, the console structure still has CON_PRINTBUFFER set
> from the initial registration, which causes console_init_seq() to set
> console->seq to syslog_seq. This results in re-printing the entire
> system log buffer, which may lead to RCU stall on slow serial consoles.
> 
> Clear CON_PRINTBUFFER when re-registering a port to prevent duplicate
> log printing.
> 
> Fixes: 835d844d1a28 ("8250_pnp: do pnp probe before legacy probe")
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
> V2->V3: Clear CON_PRINTBUFFER when remove the port
> V1->V2: Add Fixes tag
> 
>  drivers/tty/serial/8250/8250_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Seems like this patch was added in next-20261717.

I'm noticing that this patch is causing no serial output to be visible
on riscv boards till the uart device is registered. Normally while
booting, we expect for all the prints made before this to be
buffered and appear post serial device initialization.

=> booti 0x11000000 0x21000000:${initrd_size} 0x31000000
Moving Image from 0x11000000 to 0x200000, end=1ca6000
[ 161.301] ## Flattened Device Tree blob at 31000000
[ 161.302]    Booting using the fdt blob at 0x31000000
[ 161.307]    Loading Ramdisk to 7653e000, end 7dd81853 ... OK
[ 161.366]    Loading Device Tree to 0000000076532000, end 000000007653d25d ... OK

Starting kernel ...

[    0.235159] printk: legacy console [ttyS0] enabled
[    0.238787] /soc/i2c@d401d800/pmic@41: Fixed dependency cycle(s) with /soc/i2c@d401d800/pmic@41/regulators/buck5

Most devs who are debugging might be booting with the earlycon boot
parameter. If earlycon is present, serial output is present, but
with earlycon missing (which is what most distros use), I don't get
any serial output till this point.

I observed this on a Milk-V Jupiter and a Hifive Premier P550. Same
behaviour in both cases.

Regards
Anirudh Srinivasan

> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index a428e88938eb..5419f1d22d47 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -716,8 +716,12 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>  	if (uart->port.type == PORT_8250_CIR)
>  		return -ENODEV;
>  
> -	if (uart->port.dev)
> +	if (uart->port.dev) {
> +		if (uart_console(&uart->port))
> +			uart->port.cons->flags &= ~CON_PRINTBUFFER;
> +
>  		uart_remove_one_port(&serial8250_reg, &uart->port);
> +	}
>  
>  	uart->port.ctrl_id	= up->port.ctrl_id;
>  	uart->port.port_id	= up->port.port_id;
> -- 
> 2.36.1
> 
