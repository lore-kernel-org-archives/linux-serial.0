Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE395215C7E
	for <linux-serial@vger.kernel.org>; Thu,  7 Nov 2024 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995064; cv=none; b=dT3w58H3usVJEG65VzrfLYWYRZ/Ca7G58vzwx74nYIGnQSM0DHKTl7pJartx83LKHmLetaUBLhFCoy9WSGWxXDeegu+SWdWGNAq94AMKJcRzEL3MljQVZVi/fuX+i+ullXIKFuLsPI2rkMqeBd6BA/MxZIwDDrIYaKvTJANVHHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995064; c=relaxed/simple;
	bh=l+DObQasvi/6Xq2khmhmb4dZWgP734wHYsM7eTH33dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBi7SWy02+8Yn7oyNPO1rzXwNSlCdHWIs5+cBDFe6QT8qYzSXrd0IOrx/YwMTzlXn6DCzQy7JNUFpl6td+9pRIp7D0uzWlUFUbjgsui9fghSXgfORoZWZgkz5bmFEUdZQqMe3OnIJlCNUGcQ9mEN4EzJ2b/E7YJv24IXvuF1yMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LUTFAnTN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LUTFAnTN"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4316cce103dso13114725e9.3
        for <linux-serial@vger.kernel.org>; Thu, 07 Nov 2024 07:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730995060; x=1731599860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYaS5I93b6CHSzPlC1ZkED66zJbctl9+EXrmhFffef4=;
        b=LUTFAnTN7nR3i16CP4F+/6UCkiBJc84BPHmTVIUkMwU1gmpv2/0SgJkHP303FYjO3Z
         xwquHTEs6evXEaG4KD7M8yhT8awRsJyQn21v2BYJ8qlE9JvGwSS2eLyCF9irC4dY/uWx
         vUcYpEKYLBx545iIBdogPnV+mPEPr6mNfqBOl/cMLFlRDLkYJobCRQ7jE7rQqcP8YeAy
         6Yi3sppXqJshgVpTyNm89fBYV4PieyQTyF4thOi5tXS11inqngD/FpKXVyWx0ZmMMSZG
         icIsINxoZmYEjZTdgiyAkmlq4vzW8G9PwUpMI+aB3yMEX3CNszA1ekwhMMFoYfBabFm+
         N+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730995060; x=1731599860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYaS5I93b6CHSzPlC1ZkED66zJbctl9+EXrmhFffef4=;
        b=XHnNj4Qe3IWd2rO+PrBOxfS9NMYhOhzjlNoGWTuqfzFQ6Bz8eeEwjoO4WhsBKdGDIc
         lHkkdfu57l/hkFHVi9a6XWIMqISNsRLKLF+J7eGio3+fuVuGFrCYo8oqUQlR7BUSrB9n
         f5ZjSrEJGabUK6P65iLvt0BXs7PdVaG7LQm/hzNN5htoTtV+hlpAqGd6Wwu04/9E8Hoz
         JjYILJgdUEXpnImhNZnLnBXfV/fD3dsjnxq1GDfAKLYIsyXNFQ/1ysBoscGGYLy6FP++
         niHpFBsUcwE2pRJYm+ACQwEUmpe7JNFBVbkhT0PUY6xh+3e1/EWz7IyQ96ns258Ff0qK
         Hsdg==
X-Forwarded-Encrypted: i=1; AJvYcCVH/neAQRWahdZ3fx5TBKdoyrB013eMhknhDVV0kwL/2PPjJC/AL8rZX0Hutv8UKAqDwSPDKDRl9J6O5VA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFzGw6xMCy4HqsNhd6dZ/2tRRUI1BrIEVr9Bp5Bxa9h2pmIYve
	EfrB7D2ML4NwSniMr1oqLntwPGdnnxsonL2Zu46qhri50dDTXGgnMxkEwexScNs=
X-Google-Smtp-Source: AGHT+IH16H440EzuwjvLQ01EZNJRi+gf45PSJTUyeL/cdhOUV+eoPSl0kyjyS2/6msX16cFMoq4JXA==
X-Received: by 2002:a5d:6d0f:0:b0:37d:9565:4db2 with SMTP id ffacd0b85a97d-381c7a469cemr26773698f8f.6.1730995060329;
        Thu, 07 Nov 2024 07:57:40 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5e8dsm69230765e9.6.2024.11.07.07.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 07:57:38 -0800 (PST)
Date: Thu, 7 Nov 2024 16:57:36 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 0/2] printk: Add force_con printk flag to not suppress
 sysrq header msgs
Message-ID: <ZyzjcLF-wleMTpoY@pathway.suse.cz>
References: <20241105-printk-loud-con-v2-0-bd3ecdf7b0e4@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105-printk-loud-con-v2-0-bd3ecdf7b0e4@suse.com>

On Tue 2024-11-05 16:45:07, Marcos Paulo de Souza wrote:
> Hello,
> 
> This is the second version of the patchset. It now addresses comments
> from John and Petr, while also mentioning that the current work solves
> one issue on handle_sysrq when the printk messages are deferred.
> 
> The original cover-letter in is the v1.
> 
> Please review!
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> Changes in v2:
> - Mentioned that it fixes a bug related to loglevel= dance (suggested by John)
> - Changed to loud_con to FORCE_CON (John, Petr)
> - Don't skip printk delay if FORCE_CON is specified (John)
> - Set FORCE_CON when LOG_CONT is handled (John)
> - Changed force_con from a per-CPU variable to a global variable because
>   we can't disable migration on the callsites. (John, Petr)
> - Used is_printk_force_console() on boot_delay_msec(), since it's used
>   when the message is stored, instead of setting is as an argument.
> - Link to v1: https://lore.kernel.org/r/20241016-printk-loud-con-v1-0-065e4dad6632@suse.com
> ---
> Marcos Paulo de Souza (2):
>       printk: Introduce FORCE_CON flag
>       tty: sysrq: Use printk_force_console context on __handle_sysrq

The patchset looks ready for linux-next from my POV. I am going to
push it there tomorrow or on Monday unless anyone complains.

There was some bike-shedding about the code style in the reviews.
But the proposals did not look like a big win. I think that it
is not worth a respin.

Best Regards,
Petr
