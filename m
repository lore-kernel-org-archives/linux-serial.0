Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9FB156236;
	Fri, 26 Sep 2025 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897511; cv=none; b=XG2s88W/B3mbRBMB6c5Sgi1u1n7Agu9siRh6CwLNV2G6KFToXdqIOapRK6ujolkrrwySmAN4apFwBKIKc2OscHaSCo2+Am5tJPkgI91GCRKBMeFFfXG/KqH3EjCGUNqI7CXQia66ADsvDQ5KKp9Zmg+a5Y8X7wZruTuQOLkQfsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897511; c=relaxed/simple;
	bh=8+yCpMKlpBTAtIz0ulBakeZaG7wN7cBFFzOTX6tIae4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fXk2Z+gwREYL+RT1UaDqv1B/ovFDxU1pTzUy4LG1W4R5OsjLmjHcQnXEh7DGFcTPpQLEXSx8O0U+fq80J9RCLUKWraDomImWxDZJkKXd7zHSC7EZXrxn1bj+TcOfRul4aWLD35zPJQ59F8cbVTrsLuigveYDZQ/NB4e+cnE9JyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PCF8VCBX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xlVSkff9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PCF8VCBX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xlVSkff9"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758897508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+yCpMKlpBTAtIz0ulBakeZaG7wN7cBFFzOTX6tIae4=;
	b=PCF8VCBXg8RKTo9h3MbMG7dSt4Pn0UZNjHEO2zhqEIGnIpr4lmL6Q43kz+M8QyvZqcxRX1
	klX6kEE0aKpKIlC3bfLYMOcQM3ZFhjnFwnMMboBsjjLGZV37xR/EbAvvoQg7q/opNM6FZJ
	lEId3apo7hWdOxVjfdzhTGWeKMQaIvGhpo9ErU0YM+DoQmJzzIN56+JWC+ofUPs5lPor4X
	H+wkbhZavZctXrxV05H+ODMvdnsHhkhOhTwkhdpGIsy2aL5avZOss41AEd3ghY850NRTON
	pub3fWA3C0uBwykl3I8I5f1AM154KpsOCOuiWbz0TIJ9ePX0+EBVxN8vEBLhow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758897508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+yCpMKlpBTAtIz0ulBakeZaG7wN7cBFFzOTX6tIae4=;
	b=xlVSkff9BZyTvCIC48tJJplQpK5FeiMVNDuNJtVZ/N+2gyn+CYztcIehtUwdT651aDVDk4
	rL269/xcLZvF6mAw==
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner
 <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann
 <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Serge Semin <fancer.lancer@gmail.com>, Andrew
 Murray <amurray@thegoodpenguin.co.uk>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 2/3] printk/nbcon/panic: Allow printk kthread to sleep
 when the system is in panic
In-Reply-To: <20250926124912.243464-3-pmladek@suse.com>
References: <20250926124912.243464-1-pmladek@suse.com>
 <20250926124912.243464-3-pmladek@suse.com>
Date: Fri, 26 Sep 2025 16:44:27 +0206
Message-ID: <84y0q1gty4.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-26, Petr Mladek <pmladek@suse.com> wrote:
> The printk kthread might be running when there is a panic in progress.
> But it is not able to acquire the console ownership any longer.
>
> Prevent the desperate attempts to acquire the ownership and allow sleeping
> in panic. It would make it behave the same as when there is any CPU
> in an emergency context.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
