Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CE738757A;
	Wed, 13 May 2026 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778674352; cv=none; b=mp2URQYJXvtUZu0APrZw95wGgRUf7b0ervXKBUJvIUjvkOBjyad3Tm9btXxjYcJT/L613cfW4Enu5qUCsbT93s59V+2nh8a4+i2sOnGWAGL9DrUIOAPXtnPICpYy2JNO68DPbnI09qamSad/RCi/G2n8xNMK8qTagY3RvWfPT9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778674352; c=relaxed/simple;
	bh=r2Dj6pgb05sGqy8+CBz+pNVOM3RfODC5fFqrnDg+k5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AxEyxyeo+HyTV0wKOWLQOjNSL7DjWIU2kjejTJqSKf0xZg9deZRusvH22u0QFbKlL3KXEm/aciQ6bJzUFUepIzIEazTWP2rmyKWpm5Xo2GOxcvecXSVVf+4QojC5TlMILJ2v46Pur/1zz2jvtLiaAghAbNrDK2qM/3VkPLitCzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Oh+JspMl; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Oh+JspMl"
Received: from Gigabyte.tail209581.ts.net (unknown [IPv6:2a02:8428:7df0:ac01:62d2:7d04:a603:94c1])
	(Authenticated sender: jnilo@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 9C2B27803A2;
	Wed, 13 May 2026 14:12:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1778674348;
	bh=r2Dj6pgb05sGqy8+CBz+pNVOM3RfODC5fFqrnDg+k5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oh+JspMlyAHNuXMXogHIjbqAIxX1q51TowE43kHrmCLsQuI2ICWoFoXf2Oe3zZ+8A
	 B4iEFpl7+q9u6P7uYyE2SxDbNWqjuuNvNeLXz7fsigSIhfdKaTLdCTpkKWiIikTAdv
	 UuhGGLrtGwQodiLYIknrazD75Ek6TKvDk2u5J9XGjJIogbmZBsR17/9anNHt/RPYxI
	 Jxdva4cjXnQvdKwXeXWGOGXZErvUU/gWbcQgHIx7r7dR9nVOCLTkAgT4UaevcxnOg6
	 jpZ5eSEjFbt0OXWOB7AqbuujNuW/AbY48rxVLlPnjWfXC69Dyqfft76nhEbyhHwf+x
	 b27C7R0JKV8Xg==
From: Jacques Nilo <jnilo@free.fr>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jacques Nilo <jnilo@free.fr>
Subject: Re: [PATCH 1/3] serial: core: introduce guard(uart_port_lock_sysrq_irqsave)
Date: Wed, 13 May 2026 14:10:56 +0200
Message-ID: <20260513121205.45921-1-jnilo@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3439217b-90b5-5d21-e777-d238b3ffc1a0@linux.intel.com>
References: <b65b5237542c1c1c694a20e9d8fd0e18434a82b9.1778592805.git.jnilo@free.fr> <3439217b-90b5-5d21-e777-d238b3ffc1a0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 13 May 2026, Ilpo Järvinen wrote:

> > +DEFINE_LOCK_GUARD_1(uart_port_lock_sysrq_irqsave, struct uart_port,
>
> I suppose the "check" in the name is kind of important detail so maybe
> it shouldn't be dropped from the guard name.

Quick clarification before I respin: do you want this renamed in v2?

I dropped the "check_" segment because the existing
guard(uart_port_lock_irqsave) doesn't mirror its destructor's name
either (it expands to uart_port_unlock_irqrestore, not
uart_port_lock_irqsave_and_unlock_irqrestore), and the longer
uart_port_lock_check_sysrq_irqsave starts to feel verbose. But I see
the symmetry argument with uart_unlock_and_check_sysrq_irqrestore() and
I have no strong attachment to the shorter name.

If you'd like the rename, I'll do it for v2. If you're fine either
way, I'll keep the current name -- patches 2/3 and 3/3 already have
your Reviewed-by trailers on the call sites and I'd rather not
invalidate those over a naming choice.

The other points (commit-message reflow, Cc: stable on 1/3,
single-line destructor formatting) are unambiguous and will land in
v2 regardless.

Thanks for the review.

--
Jacques
