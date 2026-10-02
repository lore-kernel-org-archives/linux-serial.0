Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779934E020E;
	Fri,  2 Oct 2026 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790953426; cv=none; b=Ly9mHdOi6j+3ODJikhbmnPFzotIzQX902nhb9ncjwg/9HDeOCBeSm0yjtQpvRqYCIZ0+A4rj74jc2eZpQ6ImCfisGMewmctvlumsdDBZ7pG5UoO8dxqBp4XtwzBv3mHymwc2EpHvb93DiFRTSgZnfsg7mbcD5ckqJPxdOQb3wEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790953426; c=relaxed/simple;
	bh=edlp9gjaiI+dggQ9l+PUBg/o+Da6vd6TMD+NUabWv7s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PIcfdtkmRbVYXerfKkx00P8mgAMqz823pkQ6r2+ZJ9BQyuTUowFIZ3DohGB2UOJWp+Kl4awL+yAw/+0lOFAXUCQ4i4LAtlW1ZcZUcSIiMqrb11cZWgWPpC1Sk+qHSSeErWjy/8bvypNCB4jOGAmjwXRM+ZkgRE3LgTZBQkscjEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=wMqBwND5; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="wMqBwND5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=XQJ3xMAdXNIxZzOJ1q8kCTLm9ui2ESiHGiMjC7MptW8=; b=wMqBwND5F+BN5laxXdRGU01XNl
	K3IopO7AoGvBA2iXOFjSXo4tzsYD6N/Qekm+D+bMkgtQPrmwBdptxJ9eFiav1Jpy6dHEtp3v7MLAF
	PtVecDAYZfcNqE7qn94j6ef8Iih3cOdYREdiXNjz7eT6rO1qT6BonHX0aNr9tVGH//HQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xCenV-000000007Z4-00wM;
	Fri, 02 Oct 2026 11:03:42 -0400
Date: Fri, 2 Oct 2026 11:03:41 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>
Subject: Re: [PATCH v5 1/8] serial: max310x: don't clobber the TX break bit
 in set_termios
Message-Id: <20261002110341.47799d87f9930a8e2a44e8f6@hugovil.com>
In-Reply-To: <453bc692-8979-4e5c-a504-0b735da595d6@vaisala.com>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
	<20260929-max310x-rs485-sw-delay-v5-1-ae46afa583f2@vaisala.com>
	<20260929094019.67a4d5e9f473134dbdd39d93@hugovil.com>
	<453bc692-8979-4e5c-a504-0b735da595d6@vaisala.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

On Fri, 2 Oct 2026 10:25:13 +0300
Tapio Reijonen <tapio.reijonen@vaisala.com> wrote:

> Hi Hugo,
> 
> On Tue, 29 Sep 2026 09:40:19 -0400, Hugo Villeneuve wrote:
> > > max310x_set_termios() writes the LCR register absolutely, but LCR
> > > also
> >
> > What do you mean by "absolutely"? I think you should rephrase that...
> 
> Agreed, that reads wrong. v6 says "unconditionally"/"unconditional"
> instead, in the commit message and in both code comments (the short
> one added here and the expanded one in the software-RTS patch).

Ok, so if I understand correctly you mean that max310x_set_termios()
overwrites the whole LCR register?



-- 
Hugo Villeneuve
