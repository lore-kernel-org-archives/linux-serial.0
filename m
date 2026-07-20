Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAA13B2FDF;
	Mon, 20 Jul 2026 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556197; cv=none; b=oB7tmou/W85fPRuV4gCTsPF7qjiBCbCgXU6uXHKvXCOPpe0+WOWifyNwzrqxBfkI5BmdYy7xvDeC/K0fwC3/zBdXxfPYwp32tTY2QJU7xX3rO9wcQLHSH+I5BC0/T579dRm4bMGbQGDYRjxKbpPhjYJ8IizffnGGzPipaehqIeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556197; c=relaxed/simple;
	bh=wmjrl+3XO+U+WANJWn8E6DX6wWRUrxrdC4VRHhKCwx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhAcHUBLflWTcHb7OxGqxLXDhXC5anjFp+DMSfH+4OTGLVx4LxnFCbn4NA4Sa9S3MzyQ4X2Ts9mE1kqqTq0jN/CDfzcm3+xGy5AKwhDEREu7Im7bhA4AMk7cuhI2C6saHRXGW5coF9svksCL/mz2A1eJ+5b3AYuKLYTGsz74v0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lVoMux+n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IBz6kCrl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lVoMux+n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IBz6kCrl"
Date: Mon, 20 Jul 2026 16:03:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784556193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TO4XUXBcX9jugDI7rdMgy8/Ll6V9/50yI0xjJ5KWHI8=;
	b=lVoMux+nbjf+FNqppOdfLTBmFm+rJNNeMQs48QUWk6GaswFq8opWFq4E9meb6hBozrlteE
	eSvPb1xTdr0lTnw64SN1Hjhd0ifISSjkw6Hban4BS4p6IvxSi20p43KkcxW+6fRIQXGHr3
	uHLKWs2Kv8Z08rhA3nCk7tLG3F3OKWc6l/y/ujDm9+DMXvtIdQYRYxmSTLnriF0lj8qO82
	yxNa84CDvTan2a0r6oWqne8WR2iNDaLKdilZv3ijOLJDPsyhrLX4G5uqvJzcl7PlxYOIS3
	2GZJLXua+out5aqX1TSl2AwsiD5CFNb9g5lo6Inp3QkyGJjeQ5YegGZpiNkzIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784556193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TO4XUXBcX9jugDI7rdMgy8/Ll6V9/50yI0xjJ5KWHI8=;
	b=IBz6kCrl/pzIAOd93cUBQ9LDQBomSitPj51NZIkPDU8LhoNhx3vLzVRp7vOe4bBX8uzgya
	hXkPMDASrKiXEdDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jacques Nilo <jnilo@free.fr>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v7 2/2] serial: 8250: Revert "drop lockdep annotation
 from serial8250_clear_IER()"
Message-ID: <20260720140312.M_LGafRy@linutronix.de>
References: <20260720135407.3925-1-john.ogness@linutronix.de>
 <20260720135407.3925-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720135407.3925-3-john.ogness@linutronix.de>

On 2026-07-20 16:00:04 [+0206], John Ogness wrote:
> The 8250 driver no longer depends on @oops_in_progress and
> will no longer violate the port->lock locking constraints.
> 
> This reverts commit 3d9e6f556e235ddcdc9f73600fdd46fe1736b090.

If needed, could this be please replaced with
  3d9e6f556e235 ("serial: 8250: drop lockdep annotation from serial8250_clear_IER()")

instead the bare number, please?

> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Sebastian
