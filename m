Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204DA16D4DE
	for <linux-serial@vger.kernel.org>; Mon,  1 Jul 2024 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849021; cv=none; b=IggN8jlquF+f3POthrV4ZBnEJnFMJP1/J8XrsVPF1mmD21n8jHqSN1FpvIe3CJ12zdieabfIXaIntdeexL8FtaMPddKBs+QvK1sMeq9WxqMKNzyj+3FyShzwIaVHN2zI/ht3qOcFzwaQN55/SB2DAx2wbZU7Vg1pOychOqRjjCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849021; c=relaxed/simple;
	bh=Qk8oUFF+A4W1ahD6THSI/ajDbhSQB7YK+eadVO8mj2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB6q/45n0gsCZ9q9jZGfVCB4v4QMO3uWupWf3e18iEGZ2BGkZru6Zo7RPkE0Z7oDeT0UdcxFTTkLyk7pVkDuafxV2GoyrEZfG943c+w/tbBDsiRgspgRVzMt6zHEjXttIOt5HlcrRTJgiWIJcngWudwz87CN6cc/MWVGb/4g9Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B/uYVcS2; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B/uYVcS2"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec002caeb3so37930781fa.2
        for <linux-serial@vger.kernel.org>; Mon, 01 Jul 2024 08:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719849017; x=1720453817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1DNku0/oWyFaFP/Y9JNMp4HONNLih0gP4BElhknkFCs=;
        b=B/uYVcS2VgUTe6VXURqm3Efqr85ns5tWkWoMqZP0Az+RKFSAT+/9V5hUS7pvMKIxHD
         bGN9XuYCSpUlr9DIsDGEPbXIr2WnUXdbev1GchFdIAxzwgPz93OH0X7JFS1jMeXRKYB/
         qO/9XstBjthJ5nXJMPRlCmHUzZExPoSrXrk0ItiMvCSi0bgl6V/daDRo1zGxGiUh6GVT
         49AdCGkMkAMiXEdpEVZmt1o4k1Xw+UFOrmpWLYmIC7YRdH4dcDm8xb9ZCvXezBOtHEJY
         WoDiqXdQ7e2fdGRX1MbpfyaSYUel35r7UqU9yvEjVEsGgNrSvfEBT5dz3ZYn1xjIdrAJ
         W11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719849017; x=1720453817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DNku0/oWyFaFP/Y9JNMp4HONNLih0gP4BElhknkFCs=;
        b=TFeBcTBL8lI6zRAsKZDPU82RgXfAcXH5kb7omFxBd6bmfoiDHaanfJwz2nqYCqx6P6
         Qu1MSi2onvUqYxv00JbcyViDKcvKm8UsgirMkgNx7uvRkP9nHXuircy9cqktp8za+i+E
         dAB0Ev2SUDLknI1g39+LbeyVbajtM43V+rEGYEj2Wzdt56gCES3+QhY+PuK4arfkyi/5
         DBeAwwUAvl+8Rxvj7A5LZ2tT0GmZWVPRXFt8VuPJhXSZP57wGjK/u8ZoMidkxU3Rk+k0
         n/X5ghXXyYPVbfkRt7Xq5vy/WMlS1HOtFj+QE9v31NeyaQFHtqiM5WWPnKMu1MI+1MqV
         PW2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRzAG3qlxo+o5ShV5KTdRL7RTa2ElMA1oenZZP8nq/6G6xKCU3pd6PjGRPUtImILBtTqQw50gUWtbGDMdg5UvKpBL6Z+Yrhlhq0z7v
X-Gm-Message-State: AOJu0YwxK+nchP5XapwKY15E+ksM9Xhd+qZ95KsDKEtM5pY4hZQTeQFe
	eSzWfiLnWZf2dSfIkyeM+Op0SxnTnM4jL07tsd6H9AKSjx15x0ebua8xA3QDeWdVw3zQeS9P2Uu
	R
X-Google-Smtp-Source: AGHT+IH0ZVnB39TMB6oazNb4dsuEITV59qCGirhuXUBkT4kEZEs1fXv/9Fdu/JEanJrzEidB5JsXJA==
X-Received: by 2002:a2e:bcc1:0:b0:2ee:6a72:f006 with SMTP id 38308e7fff4ca-2ee6a72f0e6mr27541801fa.21.1719849017311;
        Mon, 01 Jul 2024 08:50:17 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac11d9685sm66381265ad.111.2024.07.01.08.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:50:16 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:50:07 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v2 15/18] tty: sysfs: Add nbcon support for
 'active'
Message-ID: <ZoLQL6rdDM7Iv0Dk@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-16-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603232453.33992-16-john.ogness@linutronix.de>

On Tue 2024-06-04 01:30:50, John Ogness wrote:
> Allow the 'active' attribute to list nbcon consoles.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
