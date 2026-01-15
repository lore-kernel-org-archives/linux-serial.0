Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E5833EAFF
	for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472790; cv=none; b=XBtRsZgwq2XS6T3kFzzmg6//idqQG2c9NaTh2uwt+4eLuuO+qQpYlgythD72rstS4QDyo4SroM79wQm4W1MZxRKUQxn1Ff82oeBLDWyO2CUwQR+ydBA24inHdnkUgg0T37YgERkeCTLQ7YKbYA8k+2d7d2wOPPcGS7BPiXByAUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472790; c=relaxed/simple;
	bh=cTvHKPGvKDvdv3CW2phXagRp3ofYcYf6SwlYtKmyZc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJ1piay7tCNnmWMrQb3qMmQlY5uTMn2I0dHa17Jf0962748in5Pm/gW0lWodli2ohqE7mwQivAsFj0AvZBxxvY0Pq2Zpmq9FzugjHsQtOzOIiSZcwhrN+EeJDqJgMHiYnxPORQL2aWlc+gD89U/+8k/WMj9ktWXTcYrQv4w5EyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J/1izd82; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J/1izd82"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47d63594f7eso4746535e9.0
        for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 02:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768472787; x=1769077587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JLly7CGERK95lIS5prsdJ95HAbwiiwFAFGJDvTd/YQs=;
        b=J/1izd8202qGaEeoRfsgTbdNxGufyL/cwhFUjAPYTm0bu9tQpJGJoov2DY7UW3yv+k
         Ypk2IyteZoLy0Ofn43OPQzcJVdgCeFDdQROt5G/Ewr6MOecTqVDBDgQ+mtU9x0UAGyP2
         K+Hc/kMSUrrtITjz1+pKJas3OsP96nR2f7CQ/7VW/vygG1IugjSJNRCp1bJNrtx1XBNd
         lPade4Vb8ZX+T5T70bvoHGBQisN85xX4JdzqvTH7CqfVIah5867/eoV1gJgMA1WWNRti
         0RHH0X8T51pG7D9cK58LNI7ZdVv4wubDbEgPodpVF47rKp4sEj9URWJac9sTSlOjNXYS
         C4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768472787; x=1769077587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLly7CGERK95lIS5prsdJ95HAbwiiwFAFGJDvTd/YQs=;
        b=rJG5Aee2GZ+5AiVfw/nu72GbAfmxIErH4h4AFsm8zvtthWS5wvZxN5OSW9eVqwtnXn
         q9+wX2JOZpAZ43Ts9ljVvhAQV853hiWC+ltTf2kvtsQacslk9h5hzZmLIMDehUqtddJp
         Je9Hbt1wt1/kblPlGo4jxEipxchnyqGkkqXbjcm7OGYhOnCa6oqW7Y4QvHJBphJb7QyE
         onA4vT4+cwZuT9E1XRe6IZesvtWMLmqY6Y1Knsq/b8nrwortRbM/ueXch3lZ87dMQs0b
         kaF6IYEyTxJvTpxmWV6zOyryw1t79AxlH89LlLeFh8eyOukbjeoyMKwHSNApUbNfF7GB
         oOtw==
X-Forwarded-Encrypted: i=1; AJvYcCXEVWnqFEs87GpVldi0wGrTLIbGBdy7d7G5oY9zw1LqIFMNn+A/vkJG3/kdR4yHQSplLqXV+8V/zGjbc4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUuTy6vSsaUbIbNwIL4bqS8ULhev5fsIR8JsRo/XVPtF/zcFpt
	Ft5tmrbuuu0uAyDuStKyzqwrQuN2/n37qmEVQe04RlVhDkc8ZRhchzdCtk9RLhNDVUY=
X-Gm-Gg: AY/fxX4Zr7W5xHPnM93vd37wMjK3bHf9KF7Fzb2w+fRyd4+4C+h9dBtE627Y/+zMT05
	nPf9LylRi+ymIkfdg84DuBeZSzMnLIGQYzKhRktEEjtXoRzeCXWzvYga0e+DjV/ASL9J5VVfh/l
	Meo+SxV5YQEp/cOzOGYgCS+62b5PpWxUHDi/4DORzguD1VIOBZKjq5elUsXt8gHeNRqTKM9cSb0
	DmJNGXunTh5eQyHttNVD8qCWqjc0yHmoTppCjq0Qh2ceStOgQrqCWx6BTOcC5GYv6U3pm8kMv4G
	yS9Xlkmi4NhND+p5ogW0vygzISNoigIFDJAf4K7uOsFhVis+xE+2/z/RwQ4d75MYvJ+hrN9nXRN
	y1ZhaKuNYpCI/1zIx4iQIHpLZjHiZa9bvAYKE8K4X3uzTB09FvIa1rnKdc37UkM5BhpJmIH1CgO
	7m98NC+/COoaq9Bw==
X-Received: by 2002:a05:600c:8b77:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-47ee4819d6emr64067955e9.21.1768472787399;
        Thu, 15 Jan 2026 02:26:27 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6d90aasm4935338f8f.29.2026.01.15.02.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 02:26:26 -0800 (PST)
Date: Thu, 15 Jan 2026 11:26:18 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-hardening@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/19] m68k: emu: nfcon.c: Migrate to
 register_console_force helper
Message-ID: <aWjAysWXHUOHSisl@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-9-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-9-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:16, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

LGTM, nice cleanup!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
