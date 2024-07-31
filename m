Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B071C8FC3
	for <linux-serial@vger.kernel.org>; Wed, 31 Jul 2024 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722438577; cv=none; b=frysCzAxX2D0IGUNcS39zTURXa1B+k5HbnVdt34A+smwcw3d51iklxaYe5Wwewq5bcCzSetViAlrT+lpfyKtbLPa36hHsvRlNI7kWeCF/HqT89FD8rTVGFmS+QodE2CQjMxW+vVatmKqcKbE0zoKEXXtZjab1BViL2QcSbMUHao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722438577; c=relaxed/simple;
	bh=4+xcUcBY1SAwqGokAGAX9ag4OlFKDAo1lWaGTsEnSvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLT2Ynh2BYRwjZ9olrpNrPIyJ66b1dxr6acOz4j95/ibdKuC9zED2BLOMEN+ZxJenuMk+BtwcsrnfTvWVqdXpIqRw8qwrqSfdXP7RYcw1aYQs82F+s+bpDT1QsxCjEc0qHfoswGPE4QEEBxYOT+fNbumtpA/l4kofHrEVHIcLtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F2MaxPZu; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F2MaxPZu"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7ad02501c3so740813366b.2
        for <linux-serial@vger.kernel.org>; Wed, 31 Jul 2024 08:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722438573; x=1723043373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lhMpJFGGAW/mwUi5aHbvNr87SHSzddimCosWlZZ6Qfc=;
        b=F2MaxPZu+hHCZYc2Tsm0Sa9uGG0HbU/2gXxhp2p6CkeoFyuxEjz0k3vkt1lG187xtN
         yVnnvo3/QzSgxra5TPLZDXwqiz9rPmuSTRC8GMf1+5z1GpbLnmCSKjeo3RrRIvOOBQon
         bveFjvxZphx86+Gb9BGeNBJ9ouexGak9Kf+Vx4s0BNPjABzlkp7xFDgxrADrrIwZw3NV
         znTf9UiAhzx4OJ+2BTBqNA03jydRE+c699KR+jfeSzP26MKthP6Da9gImzH9x8opuUM0
         tkJjuXeSkwEgeXSL5G67/5+6kV7MIbWN63NkrAnLH7z4MclMGuoIo7xjEAiN6mvwQjAE
         yAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722438573; x=1723043373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhMpJFGGAW/mwUi5aHbvNr87SHSzddimCosWlZZ6Qfc=;
        b=M02Y6l+Rfzxi9sK74Z4YXzgbe/4PgzXer040o25bLLHLyzRhssD6muv+1+9gb+bDre
         m4idvL9p9WIEeNiQj9I/iKC4GsWZY82MQesxjF0xj44CzgoxUJcOumn59aYNhQH8RR9Q
         3WqL8MSVbtj7rb09zgXfzXGQLRVwDPXNn6Wy5nbCH5q91FQJLYpxsfkve2AUR61wr2jh
         /0M1PxFJEs0vAEl3g+LQlMV4s3T/TXRyI83gI+d2efQp91GT6kddtJ0XBmJIcucBpgQ/
         T8JJO4oyxIGjdit4Bw6jZEn7Bkh0HeMcVAA3NyHml6aUHX/wzBgOFQSRIfLVPHWkQtid
         Iq9w==
X-Forwarded-Encrypted: i=1; AJvYcCWc9aoVF9mKaObJLBku4vdN6P3bbjfLue+m92rHzI4s5UZcZFUqtaABUh1FYQdOLUnHMa3LVlKXHpZGDP/8WV9Y+Q4cI7oRurpcMxqW
X-Gm-Message-State: AOJu0Yzmw0efer5hwl3XGx2aY2kMJGCqtHM1URRRnP+lM0dkQ2Tww47D
	DG651vis0erDZJvsP7YfEBcbfE5AwaLGArysKgSL4vCdKIlqY4MO0XPp0YBcqLI=
X-Google-Smtp-Source: AGHT+IFoEQcYfHOmlHKfTJe1Tt40w3DhynNVaRgYGGilbdjWsNjjCKAYHasO59FcmOydt0z2HCXKJg==
X-Received: by 2002:a17:907:97d0:b0:a6f:c9c6:7219 with SMTP id a640c23a62f3a-a7d400dbfefmr1079382666b.47.1722438573433;
        Wed, 31 Jul 2024 08:09:33 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41b30sm775605866b.111.2024.07.31.08.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:09:33 -0700 (PDT)
Date: Wed, 31 Jul 2024 17:09:31 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v3 16/19] tty: sysfs: Add nbcon support for
 'active'
Message-ID: <ZqpTq19SsK7_uSes@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-17-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-17-john.ogness@linutronix.de>

On Mon 2024-07-22 19:25:36, John Ogness wrote:
> Allow the 'active' attribute to list nbcon consoles.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
