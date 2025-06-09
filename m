Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7694A1FE44D
	for <linux-serial@vger.kernel.org>; Mon,  9 Jun 2025 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749482006; cv=none; b=F2INTrJZEErXrnvOa9o+RkGdkrM4UR8QX636YVfxKZ497zMWsPzfe6qfKNwIBi0h0pScdO68L3Q2hTjvIoHj7cVyYqP8DT8AQtA7dJQtm5HXkYeolDcgi9PuGS63U9sQ6ORMaoRGwrJ8uQo05k2+gvOdTHqfX9HVZhH+b9zZ1cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749482006; c=relaxed/simple;
	bh=5YqNGf/cGlymW3XgUoEw7B3PohtEOnJMscJX1o7OaT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SswK8VW1Jfc529EUr8hBpwLV4o7CxcdKjDNKJ4uf0Cm0amzPbhXHL4qUsW/RVuF6vNcNoFvyZkGDO6YE/SbtxR6u0g5eljkE9XxRCSu1ENCcxaoJrRu6YF7qxr0moB5u/+kpi+rX1eeKJ/+uFc0n9GIKG86LaXfI6NluoShiYfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NjN6NKk9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NjN6NKk9"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a3798794d3so3758211f8f.1
        for <linux-serial@vger.kernel.org>; Mon, 09 Jun 2025 08:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749482002; x=1750086802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=115U0atOdCsNHTutWzQlIOaInHOFsxVptLCsxbc7wOA=;
        b=NjN6NKk94cDeEa3LBQKKVEEXGuCOpWa0T27BnTfl6+w3dN8OBcNx2fFey9PULuiZwx
         tSCb3iMt2VT5HD4kKrYSR2vRYKKocG5lD2nsCDiqJpSN+fy3DGw6O/PnsmCkKod7KaO5
         AJKwmoK6nBzAQxSqvNjNdN9o/Ahd1Q1CHLhJXInLWnlkSBQ9Lc+UjHOikSyhaIureGyG
         Od/54TzapP6Wo/Wt+lgzYhMB0XRb1NTyR2s2VCU8dnAYB6XqKrbFHNHRjKdYsu7obzgn
         J4ELBKwd890vI1/xXU2UuzkhonL+IGEbYelK3EGPjz9i9vWZkO4aHw5/EmW9r+z0Zo5X
         scGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749482002; x=1750086802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=115U0atOdCsNHTutWzQlIOaInHOFsxVptLCsxbc7wOA=;
        b=Btn40viD8fJJ/cbs+wy3ichC8hOMmma6e4f/w1bYMwiqMBUCpIe8oC47j00P3qQFZs
         ODRbZ4EDm4aP6Yuz49V8Ocu7JR7OSSAGGWkGHbQ/VEuvwt/Hlxsn5JxNqycr4dtSzJNm
         UGxmZtzx/9taBF9P0zKj0djo3/g6WWs3icsI5mG1pRQ5SXlJNsvPvA9nvLw5g1SUjqgH
         YXdu8NTsC1wxWO9IzIDNvyTGZr8yQwYvghq7e1TXWJ2ajmKfsSAm9exmrGYFbCCtlRDX
         fGX9J6SMueYTSrPm0qlfz4yXSpLSTDub9PJ5C93Q82POBoxY3U/wHFjffIiDoWKRml8r
         KwvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlW7Wys5iPIzn/sghtFM/riyz5C4GfCWDmNuIz8Hrl8WdZsKPSNrS3UIGpP026+8910n3C1Y3vmACMDkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6sjA/jC2LZe/0ms/klaLVhkgzWGSEVceZ0ys3EYHLW8w0g+An
	e9f9LHPezLS34D3Yom9Ma2W9PQHZhETnsvMWaCJy0d9iybFMF/06pyct96xJ0ov8008=
X-Gm-Gg: ASbGnctkCGxC5DEHm2bTabewwFwirTybeS0uvf/06MEhDRU/8IR+cNUjdWL+yG/UUio
	xEzrM9iCGOq//I1Un+5e0kv/GLnkpDeEXWP6SlEl922FYQmCvqs53N9PXmt/lwguRzC7N7/1iCw
	hoVlIOj1wk711qst7Ctx5RCG3cnCDhXaBXw0VwXv3iYLo+iTATJl3j6BTWkRgKbj5xWETKDKhaK
	gzzjlWFCrqhQRHWg3wLIW5KkuR7FhGDta3nylFFi9OkVgCNnuKiQfe1kKk/2k/LR8curKEPzsXp
	RN7qAhkb7lNORx3HazdeXWazbmvtmRQqnJMTFyCQg+nQNB3y3SGOC39BXCm9fGrV
X-Google-Smtp-Source: AGHT+IEFprjPP+DiCCV17LSIzeABJVh1gE0I30CjfTegeTleM6Q9xGeiwJ5QQBZWcD4HJvcatAT/OA==
X-Received: by 2002:a05:6000:310e:b0:3a4:e480:b5df with SMTP id ffacd0b85a97d-3a531cdcf1bmr11774546f8f.44.1749482001785;
        Mon, 09 Jun 2025 08:13:21 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0c5f73sm5804250b3a.126.2025.06.09.08.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 08:13:21 -0700 (PDT)
Date: Mon, 9 Jun 2025 17:12:57 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Michael Cobb <mcobb@thegoodpenguin.co.uk>, rostedt@goodmis.org,
	senozhatsky@chromium.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Allow to use the printk kthread immediately even
 for 1st nbcon
Message-ID: <aEb5-fzIPobOEfHW@pathway.suse.cz>
References: <20250604142045.253301-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604142045.253301-1-pmladek@suse.com>

On Wed 2025-06-04 16:20:45, Petr Mladek wrote:
> The kthreads for nbcon consoles are created by nbcon_alloc() at
> the beginning of the console registration. But it currently works
> only for the 2nd or later nbcon console because the code checks
> @printk_kthreads_running.
> 
> The kthread for the 1st registered nbcon console is created at the very
> end of register_console() by printk_kthreads_check_locked(). As a result,
> the entire log is replayed synchronously when the "enabled" message
> gets printed. It might block the boot for a long time with a slow serial
> console.
> 
> Prevent the synchronous flush by creating the kthread even for the 1st
> nbcon console when it is safe (kthreads ready and no boot consoles).
> 
> Also inform printk() to use the kthread by setting
> @printk_kthreads_running. Note that the kthreads already must be
> running when it is safe and this is not the 1st nbcon console.
> 
> Symmetrically, clear @printk_kthreads_running when the last nbcon
> console was unregistered by nbcon_free(). This requires updating
> @have_nbcon_console before nbcon_free() gets called.
> 
> Note that there is _no_ problem when the 1st nbcon console replaces boot
> consoles. In this case, the kthread will be started at the end
> of registration after the boot consoles are removed. But the console
> does not reply the entire log buffer in this case. Note that
> the flag CON_PRINTBUFFER is always cleared when the boot consoles are
> removed and vice versa.
> 
> Closes: https://lore.kernel.org/r/20250514173514.2117832-1-mcobb@thegoodpenguin.co.uk
> Signed-off-by: Petr Mladek <pmladek@suse.com>

JFYI, the patch has been committed into printk/linux.git,
branch rework/optimizations.

Best Regards,
Petr
