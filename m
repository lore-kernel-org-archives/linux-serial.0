Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB377225D7
	for <linux-serial@vger.kernel.org>; Tue,  5 Nov 2024 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823143; cv=none; b=Ep00oHSlFZhRqpxWMjOjBl3/WYWyUgh/il7ltH9UiNnEfi+tpQ5oE47IB/Md1Eswrd3CAY4nFLESBVrGjjCultIfIE49SowUYpTZD9ucyec5b3kl3BDL0vIljptD4WhVkzRI2VLpOPPKdCaSzkEHBijhmCIDXKFhmm+LQ/qD/zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823143; c=relaxed/simple;
	bh=I2iRxkKM3NVWx6uzM/D8cb0+2M5mNdXMffas92BQWb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfYVg7uS7lZHfWOaxuYIHOMfEOgQFjidNuOjXfVB/fmJqOtOkrbfhurVS+/xSLdEfcnOL3XEj1H1+HbHqhgw/QD50LWybXAfs+6I0quBHqugUOqfVJEUwFqR/8yQ/Y/aOmW/0csqm48PU3M/EHlcp4pAXknnm9z10rbXOEhrLpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XH15P0nX; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XH15P0nX"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so6476805e87.1
        for <linux-serial@vger.kernel.org>; Tue, 05 Nov 2024 08:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730823140; x=1731427940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ttEjCbfgdrl3BvdcxSy4ImFqrGW8bqc6UJKJrO4z/W4=;
        b=XH15P0nXH0JnXxkhNgKSvra/9I6ccz2rNz5MPSZAmxmzGF2E2n2rUuVelhZmtdC9+d
         atYKStBhCotae630pUu7TN2Iwpnzaokei4QsZDhPCFwFLTlogOg2sVBE3HpELpGA5Y4v
         so6NFVpJFk1MesZlmYTuFbSK5osIHijCA7KuP8ftDFK1KjAJUdPBYiItwrXnYTc/HHCN
         bgUntHX17HO1Z7mlDqHw/saDCfSbU7GJGZXp1HV5FIDRqyPuNTmgZT6bez6eT+RFNFWY
         /sJzGbo2+bGAP8Va/IoKTFK3KWb9ArDTxhilCJSbz17vKNP96Ji5IUf+v4P3Ec89IY5N
         Sb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730823140; x=1731427940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttEjCbfgdrl3BvdcxSy4ImFqrGW8bqc6UJKJrO4z/W4=;
        b=TB1ZJ1SbnIV09YfcsyzglHFEhgXJV9FZkzgCEYMesmGKmi399FQk9GJgrDNnR5bP7z
         X7VbSLzNPQoob9k0OyT/FnThCRV2Q13BSMtupSPVzkoVcVVepIopsYlb6795eCULFdNT
         2PTmkrjAv/XyB5eRAUF1D+BZhnwG4trnn9piiGR/QseRKxdqYqrqU/4FGzbX+tYnLoBy
         5+SXM9xrgre/ht2HGZjD1aF05AKSAH0nR+o0Z1wMc3T3u8CLPAO7YEVcFHKGyua2DvDj
         bkv7OGLNCgv13lSsQlklvLxjb3wq+WGm+51Y/4lzxN426rGEBecEfF/BO7DNyXsbYiOW
         g0OA==
X-Forwarded-Encrypted: i=1; AJvYcCUtsqCq3tMYDd7emBFMJ4NUTLq3SErwKF2nKGxdO5R33lsyXczwzV5DpGkmu3oj0rgItylJZy4+uxEtskA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzNaDe98sQ8tbliifZPIBf6oEAbiiLwfSWxhbXDiDy7g1mKwCw
	w8TkJbOH9GRZUtMjQocSpCmnxZ0SG7KdPpRHCo3g5J2pFtaELtK8hJjGwCodzX0=
X-Google-Smtp-Source: AGHT+IHPUZr9A8FatRKEkRnjc/0qlX1T40Gkj0a50Y3dgrMI0+B4zd94X/VE7MRVgwbK4ko1t11QaQ==
X-Received: by 2002:a05:6512:4022:b0:539:e333:1822 with SMTP id 2adb3069b0e04-53b348b7dc7mr18666577e87.4.1730823139852;
        Tue, 05 Nov 2024 08:12:19 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd947c26sm226956235e9.26.2024.11.05.08.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 08:12:19 -0800 (PST)
Date: Tue, 5 Nov 2024 17:12:17 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH tty-next v3 2/6] serial: 8250: Use high-level write
 function for FIFO
Message-ID: <ZypD4Uu7Xbbq7iMe@pathway.suse.cz>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025105728.602310-3-john.ogness@linutronix.de>

On Fri 2024-10-25 13:03:24, John Ogness wrote:
> Currently serial8250_console_fifo_write() directly writes into the
> UART_TX register, rather than using the high-level function
> serial8250_console_putchar(). This is because
> serial8250_console_putchar() waits for the holding register to
> become empty. That would defeat the purpose of the FIFO code.
> 
> Move the LSR_THRE waiting to a new function
> serial8250_console_wait_putchar() so that the FIFO code can use
> serial8250_console_putchar(). This will be particularly important
> for a follow-up commit, where output bytes are inspected to track
> newlines.
> 
> This is only refactoring and has no functional change.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Looks good:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
