Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7971C453A4F
	for <linux-serial@vger.kernel.org>; Fri,  9 Oct 2026 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537420; cv=none; b=SaFm8wgXII4+IgCSUfPZsRAlhBOBCmPh5e/cUgNu/SP4FJXT2JaWrE3GTyRGnHh3lcDAHYme+x6jdYrhiwduyr7z5M1Vcay0vS85wGw7oaBEGJU8YiV4JHHyJQo14pwrqHhMMcNFoXiDNGMuMOt5esLJddeThtATaTPqXfeQiK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537420; c=relaxed/simple;
	bh=hjUeeF84zGQeCguNxWT1DSh/V288K62/667n4VCMYNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0APBGuFjzzYdXEhyC+9xy0R1ZYF+3gCXBRvgcP0vB6erywEoUPMIIKT9FSjqr9ysmln4I8u3elQoBdZpycrdedn7tWqp6vSw8FLFrBvfZFkJr3P8cCho9Rzunqbki/Yf1vg8NFebPZgOycKlrHHFqrKNxO89s4/n2rLDnsA0hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M8gtNqgh; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M8gtNqgh"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a168355946so35390945e9.0
        for <linux-serial@vger.kernel.org>; Fri, 09 Oct 2026 02:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791537415; x=1792142215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YtSEU7OloYM/ik260iA76jMOjTaXd/5ywnlmhTJRsTM=;
        b=M8gtNqghg13xJu/Cjxo5cFqD4V+WuiPvFAx9Dch4zp6MC6yg6TYexR3fWOhyas7jt3
         n6cHMGLjgVxcfZUl8MsEOqWvx0CW0IdOMaExWoJwuNA20VAvZU1S8iUJ3MxNGTZqnpA+
         PkpTI/Rss07wuVZFwvuJpetbw92hzUuqcGeX5oy8qaJSEVdEBY2jEppt8jtEaQ/8//yJ
         9E09UR0tbLrTYLfToB5yTLpleWRU9Ft1By6dGyJeihHnIy+cLZg7Ary9wq11NXG2Rz1b
         B6W4olC0E+lVhoILqIZ5LEXCDfGomp3A+t30BfHW4s4kQimxKwXoh+vb86zkB7x7Igix
         o+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791537415; x=1792142215;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YtSEU7OloYM/ik260iA76jMOjTaXd/5ywnlmhTJRsTM=;
        b=uCwjrgXkkeBrrS3oerfHdiXuK0ZgCreAQqzhnh8jrvmQHqw5cU/IjBDeWS7GKVfX2i
         zODOyhLzGhwylwQN1aDkzGaKJC4F/vQrYCb99EMcv65sBd8ypl4zSXVELOA3HM0vGhnd
         vHqUsn4beQNFY6dLl2oFBoVfC/VZaf2RMogRdhn1gtAwnm1qh/H++QL+0CjjoctBy9Gg
         Mq/hjazC6tNXgLETBC/AsXIdjCV1pBGI//s56FuCUrIyd8yRjtN+I1/kQGWQzQA4p4DP
         y9Fp/GwAHrKK6csi+MBeXndN381wCHqjc5b7gn9J1uWpYmz4Mclac3v82q6pGxD3qbip
         ajvQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6z5CQ3A4PAFiWTGdVaO5/mPOtFyIIWKF2SSMV9O3sM193p7xKEf757agEJg2CBy8Q07sHFtMmz9b2E6I=@vger.kernel.org
X-Gm-Message-State: AFuF++kQDd0ucAYQEmDn4kAz9+GHzNlX5yulGexDMFvLvE6+LywA4Dum
	qFe10rqQEPL1Eh2Za2hdiClH2NYcGMvESRoMPVo4qglvm2YZRHzoNEjR5WSXCQFsGfs=
X-Gm-Gg: AYBFou0H9nbZfBror1ho3+SCFb/CdgPWjq3gsBCQ8ZQAHbwSAdAUxvnk/7WiyusMFUB
	DCN/K/oA1Qv/U1BW1EET5T8VtNCg/JhvKceG+41nHUr7REv7K3UW10lDEP3jzw8VlthzIQYumLn
	5XupfN0Qwdi+JY7wARUye8GkE3ANHZJ/SUsLQA7wAXWap2X2PIpFh1v/VxmU8CvLmsHBe9qG2it
	8fqc6sKa25l0YZdnQl97G5JKN60myYOENseyyQNCL7MLXUq8sPG6nyq+NPzF8Y4gIc81U2Mflz2
	AkIZjiOZci2lcUMf6Aa2Qj91cOQqEt+/04bolUhbwkxWfd37zqxsMziL6lIwtnJqJuVWD2tvhlh
	3OTkLMXnE9YESkgiSg3uzXej5/RSBOfnjwwgfIYrGA4JJxS4SyhUz72vkMetSMJA3y5KEjwh5cs
	61nNvUKiX3XwyO219T4jXPS0I1vvSMMpQJ8Zt0IJHKxrZIgatrWqiMn2Gexr7d9u6dL/kc5cHdM
	A==
X-Received: by 2002:a05:600c:a00f:b0:4a1:6c0c:ab93 with SMTP id 5b1f17b1804b1-4a18e4e24c7mr24231075e9.28.1791537415265;
        Fri, 09 Oct 2026 02:16:55 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea1021sm42237545e9.10.2026.10.09.02.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 02:16:54 -0700 (PDT)
Date: Fri, 9 Oct 2026 11:16:51 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: bigeasy@linutronix.de, brauner@kernel.org, john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	lkp@intel.com, oe-lkp@lists.linux.dev, oleg@redhat.com,
	oliver.sang@intel.com, ptikhomirov@virtuozzo.com,
	rostedt@goodmis.org, senozhatsky@chromium.org
Subject: Re: [PATCH] nbcon/reboot: Flush nbcon consoles synchronously on
 reboot
Message-ID: <asixA20sG8QHH7hf@pathway.suse.cz>
References: <20261008150852.8286-1-pmladek@suse.com>
 <CD188453-7954-45B3-8501-FE9574D5FF1A@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CD188453-7954-45B3-8501-FE9574D5FF1A@mainlining.org>

On Thu 2026-10-08 16:19:03, Bradley Morgan wrote:
> On 8 October 2026 16:08:52 BST, Petr Mladek <pmladek@suse.com> wrote:
> >NBCON consoles emit messages in a dedicated kthreads when the system
> >is working properly. printk() tries to flush them synchronously in
> >explicitly marked emergency context and in panic().
> >
> >Another situation where printk() could not rely on kthreads are the
> >various
> >reboot and halt code paths. They can be detected by the `system_state`
> >variable.
> >
> >Let's default to NBCON_PRIO_EMERGENCY for the post-running states.
> >printk() will automatically try flushing the consoles synchronously.
> >Also do not rely on printk() and explicitly flush the consoles
> >after these states are set.
> >
> >Note that suspend code paths have already been handled, see
> >console_suspend_all() and console_suspend().
> >
> >Reported-by: kernel test robot <lkp@intel.com>
> >Closes: https://lore.kernel.org/all/202608061008.48a1e76e-lkp@intel.com/
> >Suggested-by: John Ogness <john.ogness@linutronix.de>
> 
> Hi, this looks good to me reboot.c ended! :)
> 
> Reviewed-by: Bradley Morgan <brads@mainlining.org>

Honestly, I am more or less ignoring Reviewed-by: Bradley Morgan.
I can't recall any problem reported by this person. And the excited,
AI-generated, acks do not add much value.

> >Signed-off-by: Petr Mladek <pmladek@suse.com>
> >---
> >Hi,
> >
> >ah, this somehow fallen through cracks.
> >I am sending it as a proper patch finally.
> >
> >I am sorry I have been somehow too busy before
> >the Plumbers conference.
> 
> That's ok :) I'm too unlucky as to not go to any conferences :c

I am not sure if there will be any conferences when robots will
be ready to attend them.

Best Regards,
Petr
