Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD03F39D6F2;
	Wed, 14 Oct 2026 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989665; cv=none; b=RllpYKTkFoZp5Cq+qdya1Z4+jWUyaNeqFlGtakAJiBPCr2m13iXVwf8EbrRj8EO3XcITA5rM9bnGVxEou7KRbL2XV03jjRl+2O/FmIJxXDNSerlq2+p6gA6ht18nezZvJS0iN5v5RG0rikN6nSW0jjoZllM1UZahTsvBv8Y5NYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989665; c=relaxed/simple;
	bh=of+/0F7QnsOAptux7v+51+Ik1lHlWCcTTXUn6ic0H9o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MZ6tK7zFWJZfPY85KttmWZDY10r6/MpZYexGV5Q/5g0OiEuaVJO54MftdyY+XW1oFcEUeK7V6gXWbswh5TwYTkF5VGKf7NW5jyiTg8LIyk63jNbDzCgcad7sQu9fVxv4Im88K7/evoH7fpW3FpuaA5MQam0cxBWo6YGjhJHDCoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mHU6XLTZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PW9/mCG1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mHU6XLTZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PW9/mCG1"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791989650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=of+/0F7QnsOAptux7v+51+Ik1lHlWCcTTXUn6ic0H9o=;
	b=mHU6XLTZGBqSmwhYauS/ybcJd3XeevOLq2tS7lHlvscIuj13cvlSFHMgC4TgvnifLcuzNO
	8jv6FT5DYKdFkoiOG0O1Aq7SswhwuB9v1sKuMktKvPUP56YnWKbCeJcHWIblBGdT/UHHxx
	oDjafj0WIesvtXZ92UeRhfLQP63az0Kt7hSU4nbL88ta403hvjR3HVOvLj6eTiwV0oSRCo
	qk+18k6bOqgPIoEBlqQJhaelZrJcfuX3hSew+l9ItK4aZHQzMKNEO7SG0Y4Rei2gVnE+4V
	ocUyY3l3hdHVTdiukxdOfQ11s7nM81rDXtCsW4nddSPGZBUrHcnIpm1Ft34VEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791989650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=of+/0F7QnsOAptux7v+51+Ik1lHlWCcTTXUn6ic0H9o=;
	b=PW9/mCG1IMA8qx7Mufswiccqj9R3TUxmURx6OIwT3Mv1P7b5PO24+0DFKhdeffu4w1O34i
	r2IOJCPueBLhD9Bg==
To: Thorsten Blum <blum@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Hugo
 Villeneuve <hvilleneuve@dimonoff.com>, Johan Hovold <johan@kernel.org>,
 Karl Mehltretter <kmehltretter@gmail.com>, =?utf-8?Q?Uwe_Kleine-K=C3=B6ni?=
 =?utf-8?Q?g_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Thorsten Blum <blum@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: core: Use isdigit() in uart_parse_options()
In-Reply-To: <20261014143034.104950-3-blum@kernel.org>
References: <20261014143034.104950-3-blum@kernel.org>
Date: Wed, 14 Oct 2026 17:00:10 +0206
Message-ID: <87qzhswcx9.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-14, Thorsten Blum <blum@kernel.org> wrote:
> Use isdigit() to replace the open-coded implementation.
>
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
