Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.120.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589107;
	b=mm5V9ygGxjk/qu67JenNoPTlt79wzSTPicknqCNgEkXokdzMfKAnkvPRcOFC1+UNV0I0
	 jIY1mkGPaB/s/UzBZcTsL/zyAPIGquhC/W4iTa1z/sfRlBrfyzviPrx40vMz04Fa2v6wA
	 aTSuCIigb4yrU4jq8j7UmMKNH2jhQBHCM/NdbeZBU+/I7vLYcOKJ20Kj4gqJJ1i5gw/qB
	 /MPCsjvKiqY7MRPbTYy35erQMuu3k/hoG3wFNA5EuzzjWDy5uwSNWTVywDju6zEwzQsiH
	 sYGpw9R6kYy3uecIHl/Dab3rumPPsNluRXGjiqrZKm5u/L89wwoS3K6iRjfC1o/igmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589107;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-Id:In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam_score:X-Spam_bar;
	bh=673kMR1s22yHaTq4PExkzsyhSKIG/6M6+SYEFKzCo4Q=;
	b=mfXQkPLKdeXm5XRR2U7DD2tUw49akerRMPW6Cgdr8klxv3LrN5gT9o8AGgckvHAiZE1F
	 zdu41t8BaDkM5Kmiv+p+Zih52H11YSH6q5N3qxbHZ2PN9aPSszIbomHer93/GUHnCmq3P
	 Mznm5+w/tTR8WfFPZJ3z6W2loMnsYIGTaGAi+0ybxwCUZ/mQ6EH2HkztGysEFjUuQCcTU
	 nKRILVs13mZzRsR+uWPDVnC1zLNl7WBZcbWh9iBYqujijklRHpMXSWDzR0zMPmh/QLEHI
	 KY6iEWKc7Pt1vG1k7usO37jPec/2Kul97kKVhpUFoIQ9jm7W13mDSrhbEgkEMIX5PMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hugovil.com;
	spf=pass smtp.mailfrom=hugovil.com;
	dkim=pass header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=yBgxpE1a;
	arc=none smtp.remote-ip=162.243.120.170
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B35606A327;
	Fri, 13 Nov 2026 16:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8B35606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=yBgxpE1a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=673kMR1s22yHaTq4PExkzsyhSKIG/6M6+SYEFKzCo4Q=; b=yBgxpE1apmvdsLZ0wXDmUwfPwy
	3vvFFPPkiwORSIPoIvyjEqhlau6390+La+1ty0mW875Hr7REkrpearB+H56Qmj1S23h5kmH2FyEtg
	agLTGr4A1FQyKn0glyKVBZIo3nXdVPcazMuZAUhzgl98V+I/y34oKifZN+ylvwObxyh0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xRubY-000000001Fz-1rTY;
	Fri, 13 Nov 2026 11:58:24 -0500
Date: Fri, 13 Nov 2026 11:58:23 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: sc16is7xx: Fix clock leak on invalid clock
 frequency
Message-Id: <20261113115823.68e12fc677c8e0f5f166e593@hugovil.com>
In-Reply-To: <20261113103755.2126-1-laixiangwu@cmss.chinamobile.com>
References: <20261112163916.00d07adafb3caad1d83a2d1c@hugovil.com>
	<20261113103755.2126-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi Xiangwu,

On Fri, 13 Nov 2026 18:37:54 +0800
Xiangwu Lai <laixiangwu@cmss.chinamobile.com> wrote:

> Hi Hugo,
> 
> thanks for the review!
> 
> Agreed, devm_clk_get_optional_enabled() is the cleaner way: the clock
> reference is dropped and the clock disabled automatically on probe
> failure and on remove, so the manual management, the out_clk label
> and the clk_disable_unprepare() in sc16is7xx_remove() all go away,
> and the -EINVAL path keeps its original plain return.
> 
> I've reworked the patch accordingly; v2 follows shortly.
> 
> Best regards,
> Xiangwu Lai

Great.

But once again, there is no context as you didn't reply to the original
email.

Please always reply to the original email.

-- 
Hugo Villeneuve
