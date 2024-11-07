Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A67212D31
	for <linux-serial@vger.kernel.org>; Thu,  7 Nov 2024 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992962; cv=none; b=Lfn4gWhqobv9ZAF2+WEG5K74VbCmfdcTebQlf1pbwsqVx+Cbb74kBeprqCY2nRo0580mTYRzHW/dt0suF+iVwWrtfEtijdpCZO9/wSES3Gih5jy5KJJRUEEmybQ+Ij54sY7FiI+YXNVs7sBXXboAVD5qYcDHz2fUTRXUA5QkZCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992962; c=relaxed/simple;
	bh=yZzPj+S3u5gvcmdJRGOLPng8XXYaZ8nHj1Jpw34CFY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ug5F4FgS9j99Ct2RPkyE9QprGmoEUJRTXqXUUxa5LWk3YeMMQtM+lVk8CDPstSgiI2FTa+9sgJX+gSncgyg+kiUjEqlCP/NybxdrI1HqWLUoNeeU7LKQzwtF2rK/TO62KSSv5M9kTMfelU2HoLQsiBnsZgy4BlGRs2ZDK+njF7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a1PxrKQT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a1PxrKQT"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so9470965e9.3
        for <linux-serial@vger.kernel.org>; Thu, 07 Nov 2024 07:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730992958; x=1731597758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rCAcCQ6qsmbrV6y2QMruXJGY8kO9+Qk1uO7BP3FUMLE=;
        b=a1PxrKQTF7S1PoinnaWYM1VpR1nQ+wKBs6AoqorP78NaFrIf9HuGFYOw90iilpyzK2
         yRjMFLv2j+RJTTWa71ieMS0KjFpmFTF/9cOPKqfIkyAlmbJmK/wAStXJFna9FgqEvNJo
         29GKhQi3hhS0ZYqIYnGm4SsAetTS/wd4jUOEFnY0lIn1bFMIIydu0xtgMiJmmNBpYDk4
         resVSXA314gN8DuDTzQxBgYsyYCSZE/PmCtjaWgmzdNx5/2H/rXTordgSIRiq+dZHghY
         HM+G1V+QwidGkbKpTQD/fSsXzSC07OYSS0yVHRH927vKlrI56hkDYmOcJ16Nm0ashmJQ
         VfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730992958; x=1731597758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCAcCQ6qsmbrV6y2QMruXJGY8kO9+Qk1uO7BP3FUMLE=;
        b=Xgrx1DjREXSEjo5KQlTp1MFEnLnMRyL/clfL9Cnc+M8suyhCtUHBuqe7ZHu3f4SN61
         9LeoSQIeJaBJszSmvyA2Dy7ImFvldLo64B35swvtrL75+kmrV3iNUONC7Z6QEa27b7Rb
         5c7Xc9XBRwp7RbboR7+AJ2X03L6goyFhAl4wrIuLS2MLXJutALwcKFHdjlIMvA+4jSsF
         /WTrBjftqTweSVTlnyEt3u0GOGZScCZTDOI2nElMKFBFcamoq47ywSGo/hJIwQ5IT194
         /beIycWIhqfqEuv49mccZWtLvHEjYCn+99LiGVeEL7bzPQd5ObThX0tvIQi2e0brTf+M
         SWgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxRPVZpkhBd5YbN4/pKy08Stuwl8t0iUbDVCXX94OQVbnL56rBZ3UONX1FvEf3Tsyw8mWXx8HosxM5ypg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj59XCU6tRA5ke7iTDqwie3MQt0HoQSIJFHupYbouTMFqvo86z
	Qm94jPAMOBai44BafvWOg26wjvYQ0o4cbxGcrz/cG3bHsr6o86oUrbF+/X5CkcM=
X-Google-Smtp-Source: AGHT+IEI95bLI86Nm8Fgyp7vcjEB4yzdUf4zU2Dc3Ql8nKqgrC3xz3DrVC2UDxTmz9fy9a7hdd2qPA==
X-Received: by 2002:a5d:59ae:0:b0:37d:4436:4505 with SMTP id ffacd0b85a97d-381c7a6da29mr21197696f8f.32.1730992958277;
        Thu, 07 Nov 2024 07:22:38 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea4ebsm2005865f8f.69.2024.11.07.07.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 07:22:38 -0800 (PST)
Date: Thu, 7 Nov 2024 16:22:35 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 1/2] printk: Introduce FORCE_CON flag
Message-ID: <ZyzbO5StIhsLv_EP@pathway.suse.cz>
References: <20241105-printk-loud-con-v2-0-bd3ecdf7b0e4@suse.com>
 <20241105-printk-loud-con-v2-1-bd3ecdf7b0e4@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105-printk-loud-con-v2-1-bd3ecdf7b0e4@suse.com>

On Tue 2024-11-05 16:45:08, Marcos Paulo de Souza wrote:
> Introduce FORCE_CON flag to printk. The new flag will make it possible to
> create a context where printk messages will never be suppressed.
> 
> This mechanism will be used in the next patch to create a force_con
> context on sysrq handling, removing an existing workaround on the
> loglevel global variable. The workaround existed to make sure that sysrq
> header messages were sent to all consoles, but this doesn't work with
> deferred messages because the loglevel might be restored to its original
> value before a console flushes the messages.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Looks good:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Just a nit below.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1319,11 +1319,11 @@ static void boot_delay_msec(int level)
>  {
>  	unsigned long long k;
>  	unsigned long timeout;
> +	bool suppress = !is_printk_force_console() &&
> +			suppress_message_printing(level);
>  
> -	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
> -		|| suppress_message_printing(level)) {
> +	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING) || suppress)
>  		return;

These spaghetti conditions are hard to follow. I would personally
prefer:

	if ((boot_delay == 0)
		return;

	if (system_state >= SYSTEM_RUNNING)
		return;

	if (suppress_message_printing(level) &&	!is_printk_force_console())
		return;

But I do not resist on it.


Best Regards,
Petr
