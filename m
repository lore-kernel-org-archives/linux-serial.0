Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677A42609C5;
	Sat, 30 Aug 2025 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756546536; cv=none; b=g2lK5bPEBNDH9OJ9rH7FFGkEjO9HE7t6QH6Q9aur6QIx2EsHaxoI1+4GwkYahryz+VqdHGEdgM2/ZHe63f9QE6RfT0l+qiiRNEKTtAHeluhMmqps4Bth5exMRIX4NeNinU1Joq5HCBUnDlaeqo6wO1iA4F/afdq3qMFAckJZJHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756546536; c=relaxed/simple;
	bh=6JkLe5EfbN9C9GjR1eCjNZ6BmN779SUhVtQJM/qfFus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTnxx7wxAZMCHE+KUi8LJkcBpDlvzTAfKhIflq26fNMW97rzqs1d/8r9Hs1rcJLLhWvPxJ6xgC9lAuoBkLDORrNXtlx3FnVxtX7BK+A52wjp2yPqwn9r/7wAar+u0EsueAGnrG0D4hrxalku0lYsRE+xlsiJX9mH0N2jYXXCwHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnX8coJy; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnX8coJy"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4df220483fso573092a12.2;
        Sat, 30 Aug 2025 02:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756546534; x=1757151334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Sn3FicMO1LmPCYGC4AfvhrejTX0X/7jDA+C0pHYCSI=;
        b=bnX8coJyESujMrHDjIMSd/UVN28cyoJfZ2qpIysWYx1vhLRLZPprt6l4U6A7clyf3f
         p/yv9Zy6LiER0JUe4AfnvzHayqn4LJan0/z5CGrr+UkeRAnQEfeRODvLl2zaj4cSSoch
         f4oor2lSF5ttRAW3xOJZedwAF0Ju4iRPWxbMA2TdRdks+6l6Yruj8cZ+Am448XfJD+ag
         4y8TBZU+nSd7ZMv7v+6fGRN8fFb9aiIqzyyurhEUDMrGz3k+Hmq014SlUEJHPfttvRUZ
         1S0sAXlBBjzPE6maAmKRoEbVDxZuI+dfd/tR/ZlmHqvdQGUX/k0XB6HPfGRXV8tWCBZj
         AdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756546534; x=1757151334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Sn3FicMO1LmPCYGC4AfvhrejTX0X/7jDA+C0pHYCSI=;
        b=LGrtrCNgj3ZrPqODO1SQDwN93wPCZTcMDbltw0kD/VoINLViO/4bUd80/0j2uWTj2m
         /ipOZS8yXgX4iLPUEXw6f0hXJbaUtL9Wyy7jT/Iz7U0osAohCg3jTPiPWd4lykyo3BKV
         L0b0UEr2o9BG4jQ5YPzgCdk+YDjBeCKCFIM5gePh/tibydb35Eo/ROMWyNHgogk0MM5A
         rutfze49s0hY/zgyzJKfgVKalZfGNTN6FVbo73gRYtzoiXa79bdbh56rtzSZFrKGmfxG
         Coq94jqM+LfdULSk/VZHpPVCq1/J/kxIBDfaCptNU8w5AFQf+ybgJ/QMlxH8zL0PkQM6
         2f7A==
X-Forwarded-Encrypted: i=1; AJvYcCVuUhpHmYrahK715h8CT26OBN2zkR4G7vCS+Sg3a94JQE205GszICdx23pmA0N1oJKzEpiGzH050G46MrM=@vger.kernel.org, AJvYcCWA5mUnTNAUmtlipr9xVUHDDvuoCAEIvTM370DuyGdqrRvS375AYyn4AKx8DUNGMkqdk9cc+SE+qCAzts2O@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7BryC/Va6kN+Yt0g1BoEdY/UBIh6PrnfAHd8gqDnXgxh9OH4E
	TZL0pBsXjTZiPXcwUbYg4OEFCYzx5dWAr5idIgsQa2UhrjFXe1bZLMpLpN/U/sD5WKY=
X-Gm-Gg: ASbGncvQX3WfmZ2wqQTIqC+HMlYCYf5K1f5F+Mdj0AdNihBA2L0S6Jew+p0UdO0iOnv
	IZWjaSPsbh6DvGdCDKSWdwWRqIybDO6eUjZQaTocbXXFvoj/6qmDLIlBTfqKoFrjwFxCKCgtsvK
	iRbNusixzfju2jGb37wD8S705kEzCJD/H2JmyO9RplwNrNG4V/g9oMwRtOaTAGb7x1Lg40vn/kQ
	EHeRiHXJfCcOOqgpjNU/IsW3d+Ifil/NuLWjPfpGVPxuGBTrkDzpb45dfmlnJsn1dj90oznXD87
	gz4Za0LsyJr94JtTantN+3cgtBGgCusiuzCiUYbwfMLKZqzY5USpzE4jt+JmMX4rnlONxVMGNZw
	m6WYsGPyqIxdrYUnOCHUGdihfo7w5Lrsy
X-Google-Smtp-Source: AGHT+IGuJg3XvY8U7HYxeZn8FQJPz0UmfNqYgY5f11RYraj5FDMkIHAaW0srFGfzJ5qj4GdMYRGojA==
X-Received: by 2002:a17:903:2347:b0:24a:8d5e:932 with SMTP id d9443c01a7336-24a8d5e0c28mr13869555ad.23.1756546534488;
        Sat, 30 Aug 2025 02:35:34 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2490374417dsm47367655ad.52.2025.08.30.02.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 02:35:34 -0700 (PDT)
Date: Sat, 30 Aug 2025 17:34:24 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Karol Gugala <kgugala@antmicro.com>, 
	Mateusz Holenko <mholenko@antmicro.com>, Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: Inochi Amaoto <inochiama@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] serial: liteuart: polling all interrupts in the IRQ
 process
Message-ID: <vxnamwloznpdjvn4ars4wfx5jnixcybvv62vpvipr5z2lzod4p@zxx4xiyru2yd>
References: <20250826081445.505947-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826081445.505947-1-inochiama@gmail.com>

On Tue, Aug 26, 2025 at 04:14:44PM +0800, Inochi Amaoto wrote:
> When using liteuart with aplic and imsic, the new interrupt will lost
> if the interrupt handler can not handle all the data. This is simply
> because the interrupt line will never be low, and the aplic will not
> send the interrupt to imsic again.
> 
> Handle all data in the IRQ handler until no data incoming.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  drivers/tty/serial/liteuart.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 6429e8f11f36..436e8f06fb75 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -140,11 +140,17 @@ static irqreturn_t liteuart_interrupt(int irq, void *data)
>  	 * irq[save|restore] spin_lock variants to cover all possibilities
>  	 */
>  	uart_port_lock_irqsave(port, &flags);
> -	isr = litex_read8(port->membase + OFF_EV_PENDING) & uart->irq_reg;
> -	if (isr & EV_RX)
> -		liteuart_rx_chars(port);
> -	if (isr & EV_TX)
> -		liteuart_tx_chars(port);
> +
> +	isr = litex_read8(port->membase + OFF_EV_PENDING);
> +
> +	while (isr & uart->irq_reg) {
> +		if (isr & EV_RX)
> +			liteuart_rx_chars(port);
> +		if (isr & EV_TX)
> +			liteuart_tx_chars(port);
> +		isr = litex_read8(port->membase + OFF_EV_PENDING);
> +	}
> +
>  	uart_port_unlock_irqrestore(port, flags);
>  
>  	return IRQ_RETVAL(isr);
> -- 
> 2.51.0
> 

Just ignore this patch. The problem is caused by our incorrect
hardware implementation. And everything works fine as the hardware
is fixed.

Regards
Inochi
