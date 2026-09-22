Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662C8329E79
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790063092; cv=none; b=PmKzUEoDNeMhS1SKD/LYEsZ0QS8jCKGyC1+hupjfURCjDhU76FtNQa+oAqIKnBZ0ogv0UkyrSsiGDiNlK1XSGjg3MakHCdBMnKRIbXZbD4Y6JsrBEHvQfLibrsaCONbSTjF8qI1w5TRztU5wq5GRfoQfQtOBkzpBodk9eQKHy5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790063092; c=relaxed/simple;
	bh=jvDfXM7tVJjTooSsT/SJTYLHJsj3NkXVSvdQ0KYDPus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtVgtZ2kRXsxbVX6uEaUyt3lrl04LN9OS2nHN0/jISxm60OcvAHGzrEy15RT9p9FfxAKN3v+A1KuATuC0syniWV41ivj2jAVTrCVBok/imFxSiirmn4GPiFGreyF2JKEh/sUEY6xTBw5WfOO1H2kD+gu1A8lvTjfeZtUJmf5iYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A+Px+H1T; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A+Px+H1T"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so22295795e9.2
        for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 00:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790063087; x=1790667887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IDcjrXi200c9VpHrcwV8VwvteD2Tjmxxgo/eDK9i/nk=;
        b=A+Px+H1Tn7vCk1816k1ip7YqClRJlKuGbgiATTE07N8gO57MQB/XywUKTn07dHRyKB
         E7eGquj2JwhVqnVFiYlvWCNsWz3TdoHGPmDuQncpvHbab5r8PNdu9k+mN+ZVi/PADHbU
         B08vp3cvYOva/HJeomIQuVeS+TXx6Q38ptunB6A7zOHBqRsuCBX4LtLGScVT7cuPzYRS
         +3EGatLaZM7mH65r1TAMnLyJu6G1F19J3Tr89FZrDIgObm45hdERVJyAbF0kn3tYI32o
         mH6bylho+Dgm+ATHH7fOw2r8J9WpcEUrlBemQRX7621BYHlaFvisZMolizmxwS3AEeK9
         rHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790063087; x=1790667887;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IDcjrXi200c9VpHrcwV8VwvteD2Tjmxxgo/eDK9i/nk=;
        b=kCvFItaCS3C0JwyvGfFfbjBqzB5N0d6UIBlOn9roPs3L04Xt9fc8fNmIxYuzL1awBi
         udm7jRXuypLTmxx12CI7A0R+Se/YcS8Tspl6XBar0NmLJaP2fXBk2LOhoMhBwWTHS8lm
         nVZ2lVOvJr7Gzp770FU+CkLXBJGbHoTequiuCkw4lezxE3a7QsYywHPWlLtCPkLvJz+c
         zu/0S9yfKJrIaQWnyj+Lll8eHjkl8gX9aF2yb7+9UsplcEJ3n8B5vrJp9vCMTwc3bWgc
         yO0ynpifx4PEIFIHD+W9Gbi4pdAwoZ7tfOOHNFzoDOP9sINdtLoMbtdVtuy4LRh+WPaj
         UvYA==
X-Forwarded-Encrypted: i=1; AKwUvBzm1N56OzNjZ8+rSH/XeKwpt5IdwMiA8F9HcCxSq7tZjQYiC4ZgHJA2SfKPaYhn6BruTvE+W11ClfV8tbI=@vger.kernel.org
X-Gm-Message-State: AFuF++mtYaPolwofQHcmBrfl6uyn75bRP+ulfQaIvBzESvAYUqhR9oMY
	qBuEehu75xki3R5jY9rg5nDvftX308hwGv1P+Vw2O7P5crzro5Puoy7N9Ay6nCeWobk=
X-Gm-Gg: AYBFou0w3Iu/9anF9NyAqu4WQgqL5zghY7NGBlADLi3cfte0rwo/CfjCNxFJAboGiP1
	sJDE0On3eU8dFMJlrkpOwR+BAVli/Q9Qt9ONZpYVUQKxlk1cW9Ko6MHrMS3STN/1LnMc29XPLyL
	oIu5REnHaO+2eO9OJEyWLDYSWqj4Ql/vj6WOX3zxZeLyw4TESaX4DJMvKEr5lAzMB5fMUhVs22u
	jc2KuuQXNjeD1wlICdU/3xpQTsNLw+5K6MBksYgcL6+7kEdGNazq+xIFbDVWSdAVtY88zACtpIu
	2CGI6r3WcAlBZ5KKg/BNPAkDs+1FbyjG8SEhj6GAixfeRyoOD1yzaABjnfKGDsEzZp3Ci6+1Csp
	8Nro1MjdHa9cmruQ1VsenIW+c5YmzSU9utJe6MLRaIR01EkUSeXqArSLrN+yayNhlvlG+wb/5wI
	/Q1Lk8hunYj2EcglBcfglO8CtgENz4uWWkO8JO4F++A2EBgnlKoY801OktQeiGMkBWB1hUpF79
X-Received: by 2002:a05:600c:3b09:b0:49f:ce78:356c with SMTP id 5b1f17b1804b1-49fce7836c8mr122173455e9.29.1790063087040;
        Tue, 22 Sep 2026 00:44:47 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8cf1c85sm61366675e9.15.2026.09.22.00.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:44:46 -0700 (PDT)
Date: Tue, 22 Sep 2026 09:44:44 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v2] serial: 8250: Change console_msr_work to
 IRQ_WORK_LAZY
Message-ID: <arIx7IJRcLmMpEFP@pathway.suse.cz>
References: <20260921143939.170314-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921143939.170314-1-john.ogness@linutronix.de>

On Mon 2026-09-21 16:45:36, John Ogness wrote:
> Change console_msr_work (defers MSR handling) to be IRQ_WORK_LAZY,
> thus not raising an IRQ upon irq_work queueing. The irq_work is then
> handled on the next kernel tick. This additional delay is acceptable
> because any pending MSR handling is also performed in the interrupt
> handler, if mctrl is queried, and during console resume. Using
> IRQ_WORK_LAZY has the benefit of not needing to raise an IRQ for
> each line of atomic console printing when modem control is active.
> 
> On a side note, the Tegra20 and Tegra30 platforms can hang if an
> irq_work IRQ is raised while entering cpuidle states. This problem
> was reproducible by performing atomic printing while entering cpuidle.
> So this change also provides a workaround for these platforms (as
> long as they are not running tickless). The discussion on this topic
> is linked below.
> 
> Link: https://lore.kernel.org/lkml/f3757a75-0ba1-4558-bf57-f19ab7e59a4c@nvidia.com
> Fixes: d3539347022a ("serial: 8250: Switch to nbcon console, take 2")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

We did the same change also for the nbcon_irq_work which is used
to wakeup printk kthreads in a safe context, see the commit
560f4deda32785e ("printk/nbcon: Change nbcon_irq_work to
IRQ_WORK_LAZY").

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
