Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B500D257AC1;
	Mon, 12 May 2025 08:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747037815; cv=none; b=h9yUZyYDzrumPF7hxhOjopEjDJMTVEk9P+aBTl+G1Bx0VDnWXQ6Pyug5jXXgS/e1nlLLB3Vbb2TJAC/VolxBuoXHIaXaBbVJZkzErT5kPIpOcU0gRIjLk1v63JRqXCctePM2/t3wxejWRF+VinqlD0ODzyqqbOhQk0cfVVyJ4yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747037815; c=relaxed/simple;
	bh=q4w3eBjkO7lMqBHv8ON/jKqYt8Hnt5phY3/R+rnronI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tVhPKYrcFn3vZgjfF+ec9idl+l4E7NolBnEVxCZCLUmR+V5+sE723N4mkDfIGBn5I6E3gM9M3ERdrerqueD/hIuuOwl7bwLIu3M4gsqVr20kKm9abjripZkSZJw2gPppovBxGmNeGekzvQCo6G/vufbKGs8Htg8AjeLC+QIIrTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C+BXnjje; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IFenqYez; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C+BXnjje";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IFenqYez"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747037806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q4w3eBjkO7lMqBHv8ON/jKqYt8Hnt5phY3/R+rnronI=;
	b=C+BXnjjejSQgYxEim2M6EDHXWpz+YM+ilvDVzOmEB4J/FntSTlni8iTh1VTecAM4U6y0JM
	kmojFpxOgwy5q/KzNCPzajfBYscIP9q8Sv/cu84wxRrpGYSefE90IsJw0KLSgGrm9F3FS+
	oO4qHg1uYjNnSiSyhvSKmyfql9TIH2n4UWGIY86t3tAjxEX1RxrCeongDVxtBar54uVsXe
	5W86ZDZGDjg7Ij8JN8rqo89gYI3fNkX610Ih02MmNI9YuNQADIX+Dx4xeyyanoGJUhtldh
	u+4GfgiJq8fNEoTRdPkAWGcRjnTkGZCGnSiN5e/LKd7qvwHnkJtsSg1BwWCMdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747037806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q4w3eBjkO7lMqBHv8ON/jKqYt8Hnt5phY3/R+rnronI=;
	b=IFenqYez2nPuyazIehIImpPUvF7gw9Vmv5/vzvuiiu7dl/J9yOFWSxjyzUbYGK8BuQGVGI
	pIVdAAt9oxmd8+Cw==
To: Ryo Takakura <ryotkkr98@gmail.com>, pmladek@suse.com
Cc: Jason@zx2c4.com, gregkh@linuxfoundation.org,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com,
 oe-lkp@lists.linux.dev, oliver.sang@intel.com, ryotkkr98@gmail.com
Subject: Re: [PATCH] rslib: Add scheduling points during the test
In-Reply-To: <20250510013515.69636-1-ryotkkr98@gmail.com>
References: <20250510013515.69636-1-ryotkkr98@gmail.com>
Date: Mon, 12 May 2025 10:22:45 +0206
Message-ID: <84ldr2xmz6.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-05-10, Ryo Takakura <ryotkkr98@gmail.com> wrote:
> The test has been prone to softlockup but stayed unnoticed because
> of the printk calls during the test resets the soflockup watchdog by
> calling touch_nmi_watchdog(). With the commit b63e6f60eab4 ("serial:
> 8250: Switch to nbcon console"), the printk calls no longer suppress
> the softlockup and warnings can be observed more evidently that shows
> the test needs more scheduling points.
>
> Provide scheduling points by adding cond_resched() for each test
> iteration on their up to/beyond error correction capacity.
>
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>

FWIW:

Reviewed-by: John Ogness <john.ogness@linutronix.de>

Thanks for getting to the bottom of this.
