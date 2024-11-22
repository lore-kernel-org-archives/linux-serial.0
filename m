Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF71B2309BF;
	Fri, 22 Nov 2024 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288703; cv=none; b=O1wDxSzioyhYs5vr2ckXPBzW8//qJo5wJNchCjjAT7LP3GNk2okVnbC59eg4WbN42iFEaBZ4w6s1sY4iFcdu6X74t5M6SeyF7Xqt8ke7EsSTsdRATObNR1pi3SBxXrqWnJS9bnBX3qC/qrllFUoY+CRLN+0nR+FB1AKiH1ccYM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288703; c=relaxed/simple;
	bh=hn1Y560QVQ0Uknl6r7bzviI2BE7dU0uOMrfSfl65Mw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaIL2Xlv9QCHgEFQLX0SzzXR4HnrG/Tqqe5rUaXSmZWwgxP/fBXL7XP/rYqMN+QZMlVzFJ8tmb9sTw3HKU5iEe8foEFR/5KDgCpQedhpDlDEnFGJHoB/NOlGBtECBOIDpNFmyIGsJzrSGL2k8vou5cWyJ6MF0a9Ry3K8bjY4DDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvYCgY7M; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvYCgY7M"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea8de14848so1942380a12.2;
        Fri, 22 Nov 2024 07:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732288700; x=1732893500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mC0ibQILczdDOL3K7/Vw0e389ozSt7wo4Pk380de68=;
        b=DvYCgY7Mr0Iwh8ftoVXU/oZvDoRvOkq6MrZKwTVYY6HoisqEkZQvcBL4egZP7ZaFUs
         83Ity1MkMl3QmZgp5gpb/2CBQyBKaADay2M9qKgfF/y6jnCYNJ0U6jlVby8+b27vXJT3
         V1MG4DnocxLS6iX71DR0kXU3d7zwaTiNDdo+QYtsy/3cj3lnfwBgbCQZaiSvPmhQQlAJ
         x/Cbaw9BOvF7b6bT3TMoAsKh4c0yqkqSg0kK4ADYCs1fw0ZiSWsZd+sMk4rs7ddiKU8x
         uJp2HNHSCoia2lP3jfxxiTWbyHwrobmycvG3qtGgpDoiiBHpB2ZwZ5zMnmN7Y1icuBKd
         +0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288700; x=1732893500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mC0ibQILczdDOL3K7/Vw0e389ozSt7wo4Pk380de68=;
        b=EQ0qyMh1D1c5ImXNVEMzOk/7mTWFcmqt/+IJCJkjYvEwonADRMAB1sI9xT1I/aI6ut
         l0ZX/HwqHO+P3sC6DM4Yq0W5wjP8Vt+SkGkFXAwpBsFNLR/8abyKaS6rlwngSa2lmHft
         gj8tgPSnUCQvQ5511QIme7kAW6StYP96kcnSGDrvLwW6yj8M1ftY3cmjeonXZuu/cQlv
         gKRNHfEWAcMhW5NYFJUnca5n0ZsaxVJZV77hrPIxI61z9qvfNy3FFPKKJJIoTrwIP1D4
         WBZH3B8wHDzj6tzKP2SOQCC367BpqO2G25cSboG/qC5FRt8JezcBEnlGn3AVb6brhP8d
         nRyg==
X-Forwarded-Encrypted: i=1; AJvYcCU6yCOVb+vZKKb5xTz/sMxi1GyLmqYsKCYgpjBlRVYl7opjdO1gnP+1f9+GBuWYkrcBeVkv5R7JYY9QJOE=@vger.kernel.org, AJvYcCV5Y8oJEIwfD2ecSRrTm7hRbgoq0mePZvzdYbEPzOt6wmr3sFUYFC7kJ5DJMov0dWede2LpigEsn85zU/+o@vger.kernel.org
X-Gm-Message-State: AOJu0YzxVpIBUZOZVII6IHNB3Q4LfkqdoT8NWS6v5gqhzNyg2TLvSgpL
	5l2SjzCP/EOFlx+VKneQIlmCdfX5nolO5v78K/MP3LKX9k6+n1Pa
X-Gm-Gg: ASbGncvVqJBQDpPDoMmVjwvyKL+Y3UUluTX192qTmkZGfGRe+Wsc1Mw6ri0vRClvGcb
	hWfAPqY0DP3uQ1yfH9d2k+fW/OXRSsmJ+3hRXjWSwmHZx160kKcBXrS86m2yuvjDiE/RFcW+cxA
	XAx2x7aWfoCbXnACIrH1NN4Px9BR9qMAiOoQvsdPlKECEI4ujduZphp5c4M2ajr2RLuM9w90XcO
	BqTqdg+S/tZ49yarGZylGXoDo9SJ13/nax8PbtJtaP4vFGNwhW3FvWiQdBrgmY=
X-Google-Smtp-Source: AGHT+IHdenufjeYqL6ObinYdlziNp1lXtTyN8KlS46tZAjNTWmQRiZ8cbDwiQt/4VutvxqKEB4b8/Q==
X-Received: by 2002:a05:6a20:2d09:b0:1db:dfe6:53f5 with SMTP id adf61e73a8af0-1e09e61f524mr3692529637.45.1732288700124;
        Fri, 22 Nov 2024 07:18:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcbfc0857sm1764245a12.10.2024.11.22.07.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:18:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 22 Nov 2024 07:18:18 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Message-ID: <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
 <20240405152924.252598-2-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405152924.252598-2-schnelle@linux.ibm.com>

On Fri, Apr 05, 2024 at 05:29:24PM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
> compile time. We thus need to add HAS_IOPORT as dependency for those
> drivers using them unconditionally. For 8250 based drivers some support
> MMIO only use so fence only the parts requiring I/O ports.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
...
> @@ -422,10 +443,12 @@ static void set_io_from_upio(struct uart_port *p)
>  	up->dl_write = default_serial_dl_write;
>  
> +	default:
> +		WARN(1, "Unsupported UART type %x\n", p->iotype);

So, according to this patch, the serial uart on microblaze, nios2,
openrisc, xtensa, and possibly others is not or no longer supported.

WARNING: CPU: 0 PID: 0 at drivers/tty/serial/8250/8250_port.c:470 serial8250_set_defaults+0x1a8/0x22c
Unsupported UART type 0

Any special reason ?

Guenter
