Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B3F20102B
	for <linux-serial@vger.kernel.org>; Thu, 24 Apr 2025 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745485380; cv=none; b=YKANJvDf5tKsm3epgFmitKnQphuJ51rgTIIzla7Pek2tK5IrFUIjTx0ot3EqYwJZqRxbM/4hpjq7ovAgbHhl+LL9AcybhXFU5pM78JNcR7uNXXqp5YUOa0qhcr9p192Qz6+zu25aSisyBdxzTwYVqY2xzZt7HaMmGcCNCuboXgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745485380; c=relaxed/simple;
	bh=w54GuZQEv1bG1cyiJvNDE0F/k24RtaQcjLahg53aQCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnNZ66JhGffO6/XEqAEVEHaBjiCDA5aQrDo/ORR3XrAEAPHqHvZdjR5OggdszvicXHcm+td2wqxOVNJiA1A3uO+eP07HbuCugtOfJqdiPixVq95MPwnYzhcV0utJZy14qTSzYcbcENzOCEX4gvbqtODtJCtE5rlzQqnChnUJg6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LquMe2Oz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LquMe2Oz"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39bf44be22fso536034f8f.0
        for <linux-serial@vger.kernel.org>; Thu, 24 Apr 2025 02:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745485377; x=1746090177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iQ6P1Y14p2jfp2sUFZ/eBTnX2KLVjb5n8pxkhU3F8C0=;
        b=LquMe2Ozz6LwGWc+/DTxmVG2VrdZqDnYmGN5pBrkSDL7NhyZv4TPMKOpsJm7xXI8Bq
         K534U4V/wV7Q9E0Bm18c53WVNRLHC/49iYkG4DByymHQ8OPbMb30ybh0k6x9AQMrYNOh
         UorpeE166F6/b51FfNya8zu21hmkKiNxowr7YfsPUptX24BqQNMaJd0ZgB1zkJb96nWu
         zwoUN5aykXSi/gskkwzsiUkHBqR2G50/Uwfd52WfyXRhmJNBcFE+dQyK7pTjQ6+jFJIQ
         kXZ1P3qy/Y0Y8EgDn8B1Mqsb1VZqGBvwoJ8Ldnbv+x/e/KUrmoAOjy7/4t94Ee9fm9tk
         +iOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745485377; x=1746090177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQ6P1Y14p2jfp2sUFZ/eBTnX2KLVjb5n8pxkhU3F8C0=;
        b=OBFkOnyMZGHE7ivm79YVYdJWHZ2FKTmbl7+EyfoOw0+6xvpDQfYPJ7sFJrsx+YwJEQ
         cUXcZTBkPRBYnFJtfz9XUBvYognNS9DlguQSOrZsCGVOQu0lXRUPoaQNkIdKWyJP4aDi
         GJsklvFSu4GTkuc+ftntL6aY7JztGS6Jo99m52dj0ogzMsJRQFedx2oe7G9Z5512BsbY
         a7vKIy8qH4cF00260pjvu86TKTMJ22wPLzKm4fkrBzY2qxUi7YBxs/L7SWxyi8fjtbT0
         GjazqS7YR6qxsSK+mUFDk416y56x+P1/GDaw07yG7XzO7+tAxP2l5PRdKJMnYm/7ZsOP
         o/Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVMeAtyZtOVQVVyNzn6f1t+3yryjUCPB/T58HYXHCIaFmqDiv9y4mwQGigO4pIT8jK8EZU6vkwuvV0+Kr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynQJEkq7GY0HU/w2LMpKpv/dzsaC8DmKO/MPN2kj5qmRRGA9Gu
	A0sNe5+utsYkYYLSxbdRZ38G9ZIpE5lmjoKAHoFMT/h1Q28iwFQGjwp9jqapPPs=
X-Gm-Gg: ASbGnctjTgJpzzOA/woUo28ieReHI/1aLwpx+8O3DpKHs/gn3zgqe6Saowwc4JzU6Xu
	93Lb6Qaf7GKN0O0FcW1k7Dc7dBlPzxN8jyyZMhgRs5xJx9Z/IlZPdZD4AwssVfDAxC9VIa/7XXj
	tGKx1TwTIp8NUMhE4AM4L7Gq5WliP0c1HsT0eFL0Zj0hvfDzqXCGuIz2bECD95a7JU1w+GeAmMl
	hCExOoFZTYza/niYNDHoHmgfwkVG/xt7dachxUoaOhL4y0q4xe+gwEOv+niEgjykqwABlTtgmTL
	/PnGonmRifyDnKwouVUb3rBBNFDi5XgoNNbfdT3pICA=
X-Google-Smtp-Source: AGHT+IE5NAuY4qR5YiFVNQhXPQVS5TC7fMz6BpBBJgWqjn21tuMPOH9u/dnlWEQCIWrzI/+4huk7RA==
X-Received: by 2002:a05:6000:2582:b0:39c:1f10:ba54 with SMTP id ffacd0b85a97d-3a06cf6c1b1mr1457736f8f.35.1745485376883;
        Thu, 24 Apr 2025 02:02:56 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d54f162sm1390896f8f.99.2025.04.24.02.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 02:02:56 -0700 (PDT)
Date: Thu, 24 Apr 2025 11:02:54 +0200
From: Petr Mladek <pmladek@suse.com>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: john.ogness@linutronix.de, Jason@zx2c4.com, gregkh@linuxfoundation.org,
	linux-serial@vger.kernel.org, lkp@intel.com, oe-lkp@lists.linux.dev,
	oliver.sang@intel.com
Subject: Re: [linux-next:master] [serial]  b63e6f60ea:
 BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]
Message-ID: <aAn-PkxRAz34tTPR@pathway.suse.cz>
References: <aAeIRZH_VD0mai0V@pathway.suse.cz>
 <20250424081101.110914-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424081101.110914-1-ryotkkr98@gmail.com>

On Thu 2025-04-24 17:11:01, Ryo Takakura wrote:
> Hi Petr and John!
> 
> On Tue, 22 Apr 2025 14:15:01 +0200, Petr Mladek wrote:
> >On Mon 2025-04-21 12:41:50, Ryo Takakura wrote:
> >> Hi!
> >> 
> >> I would like to follow up the last email that I sent.
> >> 
> >> First, I'm sorry that I later realized that I should have tested
> >> the rslib test as an inserted module, as how the robot does, by
> >> choosing CONFIG_REED_SOLOMON_TEST=m.
> >> Not as a boottime test by enabling CONFIG_REED_SOLOMON_TEST=y.
> >> 
> >> Running the rslib test as an inserted module without the John's series
> >> was less prone to softlockup. Without the John's series, softlockup shows
> >> up once in a test or not at all. With the John's series, softlockup can
> >> be observed constanly over the test.
> >
> >> >>Thanks Ryo for looking into this! I think we need to have a technical
> >> >>explanation/understanding of the problem so that it is clear how my
> >> >>series triggers or exaggerates the issue.
> >> 
> >> As mentioned earlier, I'm sorry that I should have run the test as
> >> inserted module... It seems the series does make the test more prone
> >> to softlockups.
> >
> >IMHO, the main difference is that the patch "serial: 8250: Switch to
> >nbcon console" removes touch_nmi_watchdog() from
> >serial8250_console_write().
> >
> >The touch_nmi_watchdog() resets the softlockup watchdog. It might
> >hide that the CPU did not schedule for a long time.
> >
> >The touch_nmi_watchdog() was there because the console_lock() owner,
> >used by the legacy loop, was responsible for flushing all pending
> >messages. And there might be many pending messages when new ones
> >were added by other CPUs in parallel. And the legacy loop
> >could not call cond_resched() when called from printk() because
> >printk() might be called in atomic context.
> 
> I see. Without the John's series, the cond_resched() in the mention
> code path should be called during the rslib test as it's not in atomic
> context in addition to the touch_nmi_watchdog().

Just to be sure. The right fix is to add cond_resched() to rslib test.
The code should allow scheduling and do not block the CPU for too
long.

touch_nmi_watchdog() just hides the problem. It was used in printk()
because there was no better solution.

> I used this kernel[1] which is for raspberry pi. Let me recheck
> with some other machine with Linus' master and linux-next to see
> if the behavior is raspberry pi specific.

John explained why the emergency context helped. I think that we have
a pretty good understating of what is going on there.

I believe that the problem will be the same in all code streams.
It might be enough to check one of them (Linus' tree or linux-next)
just to be sure that the fix applies and it has not been already
fixed.

Best Regards,
Petr
