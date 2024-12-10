Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD4E1CD15
	for <linux-serial@vger.kernel.org>; Tue, 10 Dec 2024 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843797; cv=none; b=rSc2eT1FK+Ye5ZCZEsT8ZicovwJmbmz+niW19Yv+3VyHeKeZlCInZ4W2zXWPAliMHWNfNCgognCeq7o2ILTQ7L/GfRK+hls7VH/o1CVX+/WbRjv+Q7Ky/Q2yhSHJjccVKOsoEjXFn6Tvr8EEO67CAELDPWmk60nLXLANK/l/reE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843797; c=relaxed/simple;
	bh=cMEx2gf52bAp6BVsDAEzu6IQF+0HBT6Ws0MACSlPHkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejH+7u9cYAyHq0lGSjPJLJVZvRec8gAyZc7sPNjJ6H/TgWFGH8Wbj6B/vxcBjyR3ZE8V8S705qivgCwJ/LTCNIlzMESnytL142dhc8JTU1znOUA1FajoVKtHd8H0OumK2QEB57MITZYx3KJTfUiPRpE8bx6nODK3FZoOPwf34TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=qqldTwGz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="qqldTwGz"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so2531815f8f.0
        for <linux-serial@vger.kernel.org>; Tue, 10 Dec 2024 07:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1733843794; x=1734448594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3/Hk6Ku9xV4vYVPZ0mEkrD1qjVxMUjhQA0xZ6o+cH5w=;
        b=qqldTwGzXRHHpqXhnM9hHbNAaFWAL1WTB9KYrDkBO5pTXRZmwjeFI3ydxj5kEGXyOz
         jutBtLKMiKrBm893DEsz9/5dOW0pKR6vVX6N61ov6B67JTxLJKZz3nLytH1WpAF/MTqO
         gvSEy/0mldWkb/WNfDCsxP9RPiW7UlojdivkPqIAGjSXdqlUch/TWRvLA7cVtTMfdKbH
         1jbJ5ZLZdxPHaSx4Japbfe6MHsgGnGMB7CpNuvSuNNoFjWQiWB8J+LL3n3zqCgHyluOn
         mBPbQjUEAHdo+Fz42CbNPM2dZNcJF22SNV/ekbhI8CkoFrsh7ImCa5ZY9WWjfZh6I4i1
         tMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733843794; x=1734448594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/Hk6Ku9xV4vYVPZ0mEkrD1qjVxMUjhQA0xZ6o+cH5w=;
        b=NjyY2rzoHuSbyeGUNHtxzOcuEwXI42XVeASW4H4SqaKCsmjCO9U9FpvtA4rAWawd5w
         U+6CRzBmvxoCwR+Mdrs5fvoHWcmU4tVOJFsrlf/Nhhk7/C3KED6G+m6a0ZiGvs2otqO1
         xOjSObINvMotCbTQoQjBaqQ28ozVX3lIIGny8QNs8YiEAoRTw5R1MLVgJtcd79Ij2eYB
         zJOwJwLI9fE6eLmQhnlrkYzUuIIP63q5FqOEslSbbojAe9L4VWTU8BuHiOpan+wgQ1B8
         Gx29MxiruqV/cfcykHuU3vOvU3su5LaePD1w3IV5gkGmJsvC48e7uF1oPV4N2r77gkdd
         d6CA==
X-Forwarded-Encrypted: i=1; AJvYcCU9G/Vp3HlUSg8rVYCyIEFQQUMV4pWSy4GgwxHK9lbJfn4tUhl8ycS52LpT8awVZxkLZdost4zHZVtDN+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Q9NUdp/8mFWfSHMfNrQK2of6iJ14IfFCMvNP3VU8nWLrOCqH
	VuJ1XJ9Bw913PNMr8oSJdbJKHhfM/8wcQx/XYPsZUz4SyA+Nw1LnzFseADQVJjs=
X-Gm-Gg: ASbGncuilDYC0rlTj2C4utWr6G3lDAIkpfHl2GCUCodP+sCzjDeaCY4PR34YM/n8ucl
	4qQTnqmMxx39aulMkCIUdxgSF6Ll7RRaeOQ33Dh5C8cPP+q0cHZ7omydmKYFWhWzpYrE6fi8rtM
	fSfX4uuiQ7KacPEzuEIieVv0RM2kYVpSNoUyNjTYqJ7eDewV2zAeDtZmb17W8wZLVuqh9xQNtYJ
	hrYU8Fq5M1cHmXm/Xi8VDqE6X0I0m5+1WJQg453VYzMRMiFzjuSx5yszOqctPwvEWIJ26QCzEDJ
	9+OEcWr0RvjqwJye8rjlvdcIgNQdMtqzrgkS
X-Google-Smtp-Source: AGHT+IEZYgzuNEX0Ja8JZykHzolp0rxxgNyso24X5bGyQrupgg8bLOxUA1VlNVk3vdf2QdgJ1/xovw==
X-Received: by 2002:a05:6000:20c4:b0:386:2ea9:800 with SMTP id ffacd0b85a97d-386469d5155mr2165720f8f.18.1733843793561;
        Tue, 10 Dec 2024 07:16:33 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862de365f0sm13005754f8f.3.2024.12.10.07.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 07:16:33 -0800 (PST)
Date: Tue, 10 Dec 2024 15:16:31 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Amal Raj T <tjarlama@gmail.com>
Cc: danielt@kernel.org, dianders@chromium.org, jason.wessel@windriver.com,
	stephen.s.brennan@oracle.com, amalrajt@meta.com,
	osandov@osandov.com, linux-debuggers@vger.kernel.org,
	linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH 2/3] serial: Move LF -> CRLF replacement from serial
 console to kdb
Message-ID: <Z1hbT4OtEO9gz5Dg@aspen.lan>
References: <gmail>
 <20241210133448.3684593-1-tjarlama@gmail.com>
 <20241210133448.3684593-3-tjarlama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210133448.3684593-3-tjarlama@gmail.com>

On Tue, Dec 10, 2024 at 05:34:47AM -0800, Amal Raj T wrote:
> From: Amal Raj T <amalrajt@meta.com>
>
> The current implementation of `poll_put_char` in the serial console driver
> performs LF -> CRLF replacement, which can corrupt binary data. Since kdb
> is the only user of `poll_put_char`, this patch moves the LF -> CRLF
> replacement logic to kdb.

This description only explains why it is safe to change
uart_poll_put_char() but...



> Link: https://lore.kernel.org/linux-debuggers/Zy093jVKPs9gSVx2@telecaster/
>
> Signed-off-by: Amal Raj T <amalrajt@meta.com>
> ---
>  drivers/tty/serial/serial_core.c | 4 ----
>  kernel/debug/kdb/kdb_io.c        | 2 ++
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 74fa02b23772..ed18492b7f8f 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2142,8 +2142,6 @@ void uart_console_write(struct uart_port *port, const char *s,
>  	unsigned int i;
>
>  	for (i = 0; i < count; i++, s++) {
> -		if (*s == '\n')
> -			putchar(port, '\r');
>  		putchar(port, *s);
>  	}
>  }

... kgdb isn't the only user of uart_console_write() though, right?


Daniel.
