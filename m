Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165952BCF5D;
	Tue, 17 Feb 2026 07:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771312079; cv=none; b=erEDHM4ymX0UWj/SfmaHO80MYcD6J4wWw7U9ZtN145VIdgUq2xe7VfyNKJl7V2ew/MjZM7dRuJ/pKPUpgxYz27l7DjRPOqSwNEmXehriU9ksQeDta+p9X2l5dDnzJusC4q/i7g71SThUwqK5uGVO0B3M2k9hHNcMZtPWZUvrL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771312079; c=relaxed/simple;
	bh=4pRFY6G60I0r+UOtFLu3ntd6y7DabgtdX73gpV9QRpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdceE2qOCxlRrFuBlRElwGFCykc9d2iC59YNluwDrFQIrku64tVCeOuLK7WR0AVV0AxYMYDJjlvxKSAVx0xemvinNm5Bmsz5r2goanTzpQHFkQvZO90TkU5jJbGJtXozKYM15MkZZTXt1YOTCTfwJGfjH40O5jHM8IYtcaZ6kO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NAAYlrD/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IvE3jiB/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NAAYlrD/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IvE3jiB/"
Date: Tue, 17 Feb 2026 08:07:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771312076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4pRFY6G60I0r+UOtFLu3ntd6y7DabgtdX73gpV9QRpU=;
	b=NAAYlrD/Rae99xXpUzk0gHDQV6J4m0jotKlUIElrsFSDc9NvihK+LGMyk5xkQn+P/y2fnu
	gtFmsT+sZVh/mbifvboKS6wynSTLbZ7KrnONLTrRxU5u+Um/oh0paw9E6I42PI5LefKVsC
	/VkYQ+m5MCOnlT4fyGDjrS9mU9EjF4jXUp46k8uIgruiMpik/RmVNcXBJZUvey2mKfsRjm
	+eIRTlftkI1zqH5zXTWpbrEznE48+w8LDzFIFEQ1An7nskgdqSL7giK/LbZSnftn1oF5oz
	NiQGrcbKJLoeyk2Vku0Oq62bCgqQoSzW6sunlsnMy2tAR1pMKe1t1GO1t9AwPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771312076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4pRFY6G60I0r+UOtFLu3ntd6y7DabgtdX73gpV9QRpU=;
	b=IvE3jiB/J2UiyTGawTyvPv8uMfY+bRg/qy9GtG9wOwdR+MNtLibli8ruFdImvVfwQtzA5u
	zMhzL44n0xoulPDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	Calixte Pernot <calixte.pernot@grenoble-inp.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Clark Williams <clrkwllms@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: printk, vt: sleep from invalid context bug
Message-ID: <20260217070754.Y4BolmnM@linutronix.de>
References: <87v7fwdsln.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v7fwdsln.fsf@yellow.woof>

On 2026-02-17 09:14:12 [+0700], Nam Cao wrote:
> Hi,

Hi,

> Since commit 1bc9a28f076f ("printk: Use console_flush_one_record for
> legacy printer kthread"), I see this warning:

https://lore.kernel.org/all/20260126180836.SNCdMW2f@linutronix.de/T/#u

Sebastian
