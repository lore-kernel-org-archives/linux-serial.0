Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1761CB32E
	for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2024 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022674; cv=none; b=SnD4Fnq+P2iZOhVUShfPvpcrug1aoT7kOiYXHwoID+uxRqi+nkgNboSXIudMk5IDgYB7iuWUk4JiubtX93s1tjrTexWA5wedlZmlqfpUvwro2S/4mSTe5bvQD79fj6S5DgjC/fqxHDpzLSkzqNeFJZJ5NxM+J7+RcRvv53yPEXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022674; c=relaxed/simple;
	bh=bmNNDqeFo0fMTzvHS6jtF7fSAgNTqZ7flns0YOd3/ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6Vqs/Hn7yCgHKbUqMoOjJXT3er/ZXpHvW0aF67oUkNQ9ThCWV++5o5JRjET9xQFXlzGTTrsPzhyJzOh/ODHYuB6hCKdaS/r2MDmFDL8eV7TCmyt+iWTsB5qi14PW+kvQ2ohCaBFAPGmtb6R4QuYubSMEfwg2KYiMq70QPgZ64Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kBGr66Ba; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kBGr66Ba"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc65329979so14362935ad.0
        for <linux-serial@vger.kernel.org>; Wed, 07 Aug 2024 02:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723022671; x=1723627471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8FROlorW16Zop1LbDsLiZBpuBm4Au9Y6KtWsJXN+Z00=;
        b=kBGr66BaHmu3K/Sa2YLBtoBtxdD6UWGHDV5GbWqRLH41hOeFA1zfUO2hjvqkLJSQ7B
         6sI8eybw/AYes+9pU267Su66gZ8maFTo3hOPuweVHFRAkIkY+cjvJ+yss4w7KkK3PlbE
         FE0SP9ibMXzItu/TvlldAKOWYQclZargcedLZDuVtgqxvMjoZY/HuOxlOTQ/M0NdI7SD
         Lv485wpBQauhq97j5kxIBLH4FxRnjGdBc/JYazItA2f1nAKTEGozGP8aFEQxsmUksYZN
         Vj3P/A45prUj63o3XS2nzxlakWhKa2Ir38OSksJ2odIPqPlk0mK6kUSdAe0T+HRaD+51
         M2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723022671; x=1723627471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FROlorW16Zop1LbDsLiZBpuBm4Au9Y6KtWsJXN+Z00=;
        b=kbjYnDvfp/gM2VrYXh1goxr4WemxoOTe/KAYw+xPxLw4QxoMfjY0SHe2luEf18Jkzf
         srOwq48Ru5HT/jT1/EnqPB5uQ5LI5Y8yjYaV9CUXz4j6qiwfkVyFeWRTwuMwRATRycXH
         vQ0KtrvUDBnQpH36MnwXaAS5IWT7Zx0vQtPXT4ij3LqToJ5p6s4GrRR7I8ZO5gF5kdJ3
         00FHvy8g4CjngmgwQwM2s+I23RWnVk7ihs/t2CB3uGxxlPqUj+nbowu/PIikmcPkd0C0
         O6P0zIjk366Ztq2+L4NshNaA8w6eUD9wZqTnyUvmZJgq4zwoc6FuvsF9gzhSZhg1W3cA
         H6dA==
X-Forwarded-Encrypted: i=1; AJvYcCXKDKp6cfsKfGuwLTFdSoy2cGe6M8g5f+vTgmISG++GuCDsia2OwG0z39tk9FQIDYOEzaE0B5X38m6ypW5QHdLkZ9JEc+ofWLyaF8be
X-Gm-Message-State: AOJu0YwrH+QOy37Mu/ZhuDt0CDV6olvsCYLDXfD55d0PyWsVccCif39g
	XZK1LKdNzbMKT0lQtTadB0l1hmmdpwAHAuLlw8vbUI/8qTsqp6rxZrQG9FV1mjg=
X-Google-Smtp-Source: AGHT+IG9Ngcy5IvNGg0A8Puz7JeQ55YvdVlMQJe76hw9S2YP6DI0q5U9+upeIiWRzv8d4EAl7xlNtQ==
X-Received: by 2002:a17:902:ce8c:b0:1fd:a0e9:910 with SMTP id d9443c01a7336-1ff574a6ff9mr213460025ad.62.1723022671052;
        Wed, 07 Aug 2024 02:24:31 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2007d1184d9sm22821265ad.216.2024.08.07.02.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:24:30 -0700 (PDT)
Date: Wed, 7 Aug 2024 14:54:25 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: 8250_platform: remove ACPI_PTR() annotation
Message-ID: <ZrM9SRgRLYXIL8B1@sunil-laptop>
References: <20240807075751.2206508-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807075751.2206508-1-arnd@kernel.org>

On Wed, Aug 07, 2024 at 09:57:43AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The acpi_platform_serial_table[] array is defined globally without
> an #ifdef check for CONFIG_ACPI, so ACPI_PTR() makes no sense
> here:
> 
> drivers/tty/serial/8250/8250_platform.c:271:36: error: 'acpi_platform_serial_table' defined but not used [-Werror=unused-const-variable=]
>   271 | static const struct acpi_device_id acpi_platform_serial_table[] = {
> 
> Fixes: d9e5a0ce2f16 ("serial: 8250_platform: Enable generic 16550A platform devices")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/8250/8250_platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
> index 306b488aa996..c9ef988d58b3 100644
> --- a/drivers/tty/serial/8250/8250_platform.c
> +++ b/drivers/tty/serial/8250/8250_platform.c
> @@ -281,7 +281,7 @@ static struct platform_driver serial8250_isa_driver = {
>  	.resume		= serial8250_resume,
>  	.driver		= {
>  		.name	= "serial8250",
> -		.acpi_match_table = ACPI_PTR(acpi_platform_serial_table),
> +		.acpi_match_table = acpi_platform_serial_table,

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks!
Sunil
