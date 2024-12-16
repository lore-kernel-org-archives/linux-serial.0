Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3611428F1;
	Mon, 16 Dec 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362971; cv=none; b=MKAuice+lQZZPLTCujm5lYZkzPgruFjR0Hx2Ks/1wLwqjVFjI8jW0TKyO8uuITELl9fKNPFwfuMPQ30wLmf1aQjBuTrU7Bs9JhkHj8IUeorbVZ/JyiOJ20Q8EE/ukW+9lYXePvNvpZsj6M+6YleyREQJqWbeTKXnge4FVI0v058=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362971; c=relaxed/simple;
	bh=4jyxZIT7hjcGmYBbGvCunP4BvQnpd8I0TAlvuGu43Q8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KZcR0hYntksgyNAvNEidxs4v1ZT28kxXFZIoLQJ8H3lHtqEUf8neEeSfI8SmuhHyN5069vCjez8PcaARI4VSMdlogsbIi7zIIzD9aOz4oy3brT6Njm4bjfwM3KQPQF07W5bFh0g7QUNFkKnFfb671vCTXscnb6DbFil95TTTCkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=to0flyVG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+e/NOM79; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="to0flyVG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+e/NOM79"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734362967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4jyxZIT7hjcGmYBbGvCunP4BvQnpd8I0TAlvuGu43Q8=;
	b=to0flyVGfWlzOZWr3Z6Tb8o0KM9VZYaYTMoWk1PyFqyVqeIDLY8fObSndBOcgUfBXaKNeb
	vP2Vyq/J8Wj9JHL6+t0NUjA5f1fxGik9NFWG/kamlnAduJ9JV8pZoBNYwzexQzLNzsnieM
	TH3VEl9Pv4cqaNuW+V68OpMdrYo/gqY+CoYmVqO1n83UujpkpdXQBNC5ObnaQGJNilgXj5
	TQP7zRs3oW9N7zzjcQ3Nbj9dEJNNvdeXBlg5Iu6QiM5M00c9igDkpLJtsjciwmaz6WCVL1
	kkIKgRczHsF7Uuj3qYBNrXy24Gg1SvHB/HWWSLgj8XmIJsRiGG1tiLqm8xCflw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734362967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4jyxZIT7hjcGmYBbGvCunP4BvQnpd8I0TAlvuGu43Q8=;
	b=+e/NOM79ib7YYesHijkeiPijn+iT/nNF9l4lyNo83zLlfRsY57oIayxU55KSgHDNsmPEgr
	zFhHEOzAUjAx/mDA==
To: Ben Wolsieffer <ben.wolsieffer@hefring.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: Re: [PATCH] serial: stm32: use port lock wrappers for break control
In-Reply-To: <20241216145323.111612-1-ben.wolsieffer@hefring.com>
References: <20241216145323.111612-1-ben.wolsieffer@hefring.com>
Date: Mon, 16 Dec 2024 16:35:26 +0106
Message-ID: <84cyhrk5nt.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-12-16, Ben Wolsieffer <ben.wolsieffer@hefring.com> wrote:
> Commit 30e945861f3b ("serial: stm32: add support for break control")
> added another usage of the port lock, but was merged on the same day as
> c5d06662551c ("serial: stm32: Use port lock wrappers"), therefore the
> latter did not update this usage to use the port lock wrappers.
>
> Fixes: c5d06662551c ("serial: stm32: Use port lock wrappers")
> Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>

Thanks for catching this!

Reviewed-by: John Ogness <john.ogness@linutronix.de>
