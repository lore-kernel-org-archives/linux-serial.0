Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DB8383;
	Tue,  5 Nov 2024 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842554; cv=none; b=GbW5qw9mkwpWRb273SM/f70/tlQGwKGo547nH91zXqL+7FI7IlRpNtWv0PdEuETNnNFwFfo3e+V0wgm4WP7s/zQe1kzXJhyyX33ueRngKUquL3oR8rCxp+/KHOetYCIdkyhfwZaRSOPciUi7m5TKf+nkC+vbHuyI4BeqnTfaoQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842554; c=relaxed/simple;
	bh=Q2KDAiJa3I9XrITTKwg6HBUHPSP2qB1QFFTPpNahj3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IR/r6AChxKAmjPMEY2VAfKH5f+Hga0BvO5AQ/cJ3laUABvgLXuCocV8yDM1uXhozIU9mMh4z+F5Jh9OTQ8jGz+enZV4wjOCnIim67/gz1InEZg6ZAotXu2WKExl1j3wWY/wMXfYtmNueieSRLV8U3wE2ttP9FOtqBmXfosM9VbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bjpe6xvz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+nOaciL3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bjpe6xvz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+nOaciL3"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730842550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2KDAiJa3I9XrITTKwg6HBUHPSP2qB1QFFTPpNahj3g=;
	b=bjpe6xvz67lQVjPtVIEqPoSiqK7VSAXobl4vmpFR6ixKKdyyQpXR0s7qdkfivwqkknfHXs
	FT0UdaYDgXxQii75ejCzUttqkrlb8qZJWFwomA1ojljfW+N1UBiIa8N6PCUYC+SLf43CH7
	e04tYS8bVwwGjA3BUvX2EXjZNFOJJYA0wFjDUSDY84QARudsvc7Ftp7nYPNxR5RUqeOddv
	jkXbxWwjpH5wgWvUwO0ALjU8sLrdkc8df9DteydRSgC/VeVg4foe/fb2syslE4D/QTaPks
	JZV5ksz1xhRBNUqNyKRlZMFkOPo0LKmhPHHHUWDOqmRKphxOh8hSB/CDV+J3EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730842550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2KDAiJa3I9XrITTKwg6HBUHPSP2qB1QFFTPpNahj3g=;
	b=+nOaciL3nRAYzwYLNtA4AjbDZ5ecc4gp+gcQ6FmmMNWgxZLlycPSXKfsXVM5oeupbmAPA4
	+X2cY6ud6re1qKAQ==
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Marcos Paulo
 de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH v2 2/2] tty: sysrq: Use printk_force_console context on
 __handle_sysrq
In-Reply-To: <20241105-printk-loud-con-v2-2-bd3ecdf7b0e4@suse.com>
References: <20241105-printk-loud-con-v2-0-bd3ecdf7b0e4@suse.com>
 <20241105-printk-loud-con-v2-2-bd3ecdf7b0e4@suse.com>
Date: Tue, 05 Nov 2024 22:41:50 +0106
Message-ID: <84pln9e53d.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-11-05, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> By using the printk_force_console the loglevel workaround can be removed.
> The workaround existed to always send the sysrq header message to all
> consoles not matter what was the current loglevel, but it won't work for
> deferred messages, since the loglevel can be restore before the message
> is printed, suppressing the message that wasn't supposed to be
> suppressed by the workaround.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
