Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0013B71A6
	for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400047; cv=none; b=Mtjmasuo2yOoMTSXT4j67SO/jCjOoXr9Dqh8e9OUNf3Yld6PCIm7VMt5gDvuBAjlPi+nPFVAwhydMXLl5i/IQiJFUikXk3Gz6sesgzbnIQiOVnAltLePVwrgjPdJvcbt80JIouDHGnlUzg3WMbWo0H1lOBijZyuvXEyLVk2R/yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400047; c=relaxed/simple;
	bh=pwW/HHeZcEkraoLdRbDlR2cnbN4a866QfwOfBHCrZG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shG9NPHNVmgGw4UT7pckplGOx5AFC0RJsIRwVFHTVX2DRaqaTCYXdIAO3M1bNOYqVL9iiaahltmsPMicF5YX88s9e9ENjIj6NJ9sBwIKZkRwpV+O7BVE+SnQ2eCBgZ+ukgK8YigvBegyGjEa37OJaatonAGdyE/h1nG4COK7Pw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QvWi4+fe; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QvWi4+fe"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f904e80eeso1548852f8f.1
        for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 01:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785400040; x=1786004840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KmzU97//bt/RgXYEt4zQpFpox6tHLxvze+7qfkerEFg=;
        b=QvWi4+feV5TZFSt8zvTeqUgShdK/CIhQ2RnvwtlS4snWwpwrJKBtkNLEBg/7pb1+Yn
         RcpbfraqhLQPZBj9rUGphx8GI/qCuLsiw6v0Trdb0+byXzRu8bHnX06Xw2wTNXsZN2PI
         Vdqusmcp+n7nmuCrdemybwhxgZuP72jDxi90/fVZDF57mkJpdOQjx/TInoua4DlobmuC
         30fftAHycEFucMJqm/nbWRfrIWV9FXqkXesvlbddBDJdw/H1OfWKBvJkgkmCe8T6lRJI
         jvNYX1s3/V9U6vpaOC4RE3fLXA1kATCH2gLzDCLzSXQbHDbw/Yi352cvboec43qGYa5d
         kg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785400040; x=1786004840;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KmzU97//bt/RgXYEt4zQpFpox6tHLxvze+7qfkerEFg=;
        b=YmtN+/ZwANsrjD2z0ymVm246pb0Qm/0jcD0mt0eMGshprW8BkblQsXsO58/rKrt5uS
         5dnD5poZBmtSuobaxCnnaYVf/tk0YSk8athYpQsmuqD2VSHuHC9M76mAI8/LDKvUok1b
         V/dLy7J5MGgpYAehUtU9PAxVBv/ox38SeC6kPmuS/qkEHTMUkxRE+3LDmUTqfGTsHk8m
         vz2eXn441FnEYDcNnn8KEz6TArdxzS+IU30eXXny1Fabxr92FWmrx4i38jirdIrO8kaU
         mwrb2XGSDQDpp0pyMTYivkpwoGQjmAURzX3iI52EWyWl1ffAxSLKbmDrOgDXSCYMyMZ2
         WSuw==
X-Forwarded-Encrypted: i=1; AHgh+RooQA8GBHsm9FOD+VPeWxUiZX3dqZitGn0LI8y2HboQOMCRCrJsV0C3/SQQgRaRb+Zu/QIapxhHse9QWTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd6uxTtPirVPtnnWCYxq4lJDBQO3XWEuegMMej57i/hYs6OE2b
	qFVWaDLTTcKZhsuUa6e+OJ0AEontxe3Av0bI/bQziSCi6YP1X6z0ZmyIBiTakjjmUxA=
X-Gm-Gg: AR+sD10hzgNv9aJ1cg0o2OYB/3NZbqOa5rPYIa/8mM8/ZJd24oX6/duOUtcRzav5rbE
	yBpLfYT1Zb+6ISKaXCDQy/HHiLqTrWNC6TMJq4uTmdU+Jvp3epBAJRlp2MFcwDxutWh3EMtRrck
	A3BveO+cEBs2DI4kzHkTpINMZRaU+K3JcprohtvnrMfeNseix2SBw9uyPsrkQiZFm3W2Qis70G7
	l3o6jyhUcSPAJTwwHuJ4Qpf2RheA+Q3aJlweqlbABljgD4+eZfT1ge4GqHMsRtx5o/yYMrRBQnV
	F6szGMaR6gUojj0jQWJUlmWUEsHKHkpVlj7U7rdnm+s8jpdlQeTNQecNmSCnyH4QfFesSqR6Fve
	sVw52DD5ZwckTNb5t8oqw2kcvTBQSoHLW+FGsvEoQPpOfkq/GkrxqsWgG6UeLCnNmFd85/9IcVT
	UuKb34x4okdryl4H+zvLUyFtEI0Yp++X4RWPPmECCGNTYgdeoa2V20NTvQKrR08E4=
X-Received: by 2002:a05:6000:22ca:b0:47f:921f:3a37 with SMTP id ffacd0b85a97d-47fc81f5222mr2189848f8f.35.1785400040403;
        Thu, 30 Jul 2026 01:27:20 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e3c73sm4426665f8f.10.2026.07.30.01.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 01:27:19 -0700 (PDT)
Date: Thu, 30 Jul 2026 10:27:17 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Fushuai Wang <wangfushuai@baidu.com>, Kees Cook <kees@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v9 1/2] serial: 8250: Switch to nbcon console, take 2
Message-ID: <amsK5UPlzthyZJqD@pathway.suse.cz>
References: <20260724103654.133654-1-john.ogness@linutronix.de>
 <20260724103654.133654-2-john.ogness@linutronix.de>
 <87o6fwms02.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6fwms02.fsf@jogness.linutronix.de>

On Fri 2026-07-24 15:39:49, John Ogness wrote:
> On 2026-07-24, Sashiko wrote:
> >> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> >> index 8c241ec7f4f29..855a7aa48c2d2 100644
> >> --- a/drivers/tty/serial/8250/8250_port.c
> >> +++ b/drivers/tty/serial/8250/8250_port.c
> >> @@ -3198,13 +3218,28 @@ void serial8250_set_defaults(struct uart_8250_port *up)
> >>  }
> >>  EXPORT_SYMBOL_GPL(serial8250_set_defaults);
> >>  
> >> -void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up, unsigned int count)
> >> +void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up,
> >> +				       struct nbcon_write_context *wctxt,
> >> +				       unsigned int count)
> >>  {
> >>  	unsigned int i;
> >>  
> >> +	/*
> >> +	 * For console writing, enter/exit an unsafe section for each byte
> >> +	 * in order to pass the ownership as quickly as possible if a higher
> >> +	 * priority context wants ownership. Otherwise, an attempt to take
> >> +	 * over the ownership might timeout. The new owner will wait for
> >> +	 * UART_LSR_THRE before reusing the fifo.
> >> +	 */
> >>  	for (i = 0; i < count; i++) {
> >> +		if (wctxt && !nbcon_enter_unsafe(wctxt))
> >> +			return;
> >> +
> >>  		if (wait_for_lsr(up, UART_LSR_THRE))
> >>  			return;
> >
> > Does this early return on success bypass the cleanup of the unsafe
> > section?
> >
> > If wait_for_lsr() returns true, wouldn't
> > serial8250_fifo_wait_for_lsr_thre() return immediately without calling
> > nbcon_exit_unsafe(wctxt)?
> >
> > Could this resource leak of the nbcon unsafe state prevent other
> > contexts from taking over ownership?
> 
> It simply has the effect of joining this unsafe section with the next
> one. In this case it really wouldn't matter. But still, it was not my
> intention. I will fix this for v10.
> 
> How I plan for it to look for v10:
> 
> 	for (i = 0; i < count; i++) {
> 		bool tx_ready;
> 
> 		if (wctxt && !nbcon_enter_unsafe(wctxt))
> 			return;
> 
> 		tx_ready = wait_for_lsr(up, UART_LSR_THRE);
> 
> 		if (wctxt)
> 			nbcon_exit_unsafe(wctxt);
> 
> 		if (tx_ready)
> 			break;
> 	}
> 
> I am wondering if we should add a WARN_ON_ONCE() to nbcon_enter_unsafe()
> if the context is already unsafe. It is a simple one-liner. That would
> at least catch these kinds of mistakes during runtime. (I would do that
> in a separate printk patch, not in this series.)

Yup, makes sense.

Best Regards,
Petr
