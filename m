Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.120.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794519235;
	b=TPlUiDip3nNKgnA7rK9uc65qQ/vRgg3vO65PslSfUH74q2/xNHjwQGKuuYyVl7VKxpvc
	 HGUzaapCgYxDGXJRt6u67ymQ5XSa8SxmGeQp3X/V6xkFjfobgGz1xPegKWPEWZDoacFiD
	 wu7jvn+waUPx/OmXRWCe0WQMtVpeWdra+SI1rP5OrkWEXOELMnngS9o240Pq4hNjmlRYY
	 IQgIgGVyip9D7IfiNwkTcJZipUQbAMS7/AgTlMxD11/b3R1aJaBlTWhqSLucOOPAQU+Tb
	 a0LpeK9s1it8rjNyCVwa7cJWppcctVqoqKfJ/uoVyrImXtMdTtKTCqfz3c6hEoUWxwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794519235;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-Id:In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam_score:X-Spam_bar;
	bh=ZkfjOcGD68zvM8CNOAYZXKLRmL3LY6QqhMS04Y1mQno=;
	b=2Py4WhMHG++5WEBSSHyzX7gWALY5Nt5nXncZ8JNCUUljXylqZNe7iU3+LvuksO5mxyZm
	 Y1YifTvnHEpWxtMg6AlCCThoYke9iJcqKkmBWgaGRoOK/8ZuREZQP4mfmzjMwXsFCt0X1
	 PwzQ1i4FajblRRrxW8Ccw08WXOlPSm5ceuAJjGMY0t+0b0V9Ykdv0YtaIoS1Z+m+g51Zg
	 S8DcNR0/gTE2y2lRczOyvaXLGiGE/bC/20jdU55jQQNZgRfUqiYrnd+eE9MVJYd2xnm/O
	 2ZNIp2kxy5GXvDFAfqJhtn3o851LX9Z23fVyNfsZdK0hnFVsz171Kw+MOTVAWd92G/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hugovil.com;
	spf=pass smtp.mailfrom=hugovil.com;
	dkim=pass header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=PxoNfaly;
	arc=none smtp.remote-ip=162.243.120.170
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C876606A31C;
	Thu, 12 Nov 2026 21:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C876606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=PxoNfaly
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=ZkfjOcGD68zvM8CNOAYZXKLRmL3LY6QqhMS04Y1mQno=; b=PxoNfalynU4ZZB4aayfBSVr8DH
	Z+NzPDpsjQAY/QYdz8pLk10uEg0pdR0nH5mXewEwAGs926bUQ0kVyosrxKRAP1dhyCwZyG5f0G/ta
	mqGCWhP3L4RMlUxyEZ9xByiztQzwTCDIfLNPrPzOm0oJEu3psTEMrvMmyJs0ZNJ5vzCw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xRcQU-000000001UY-24MA;
	Thu, 12 Nov 2026 16:33:46 -0500
Date: Thu, 12 Nov 2026 16:33:45 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: sc16is7xx: Fix clock leak on invalid clock
 frequency
Message-Id: <20261112163345.a88ea8ac42f58d1a38c3e069@hugovil.com>
In-Reply-To: <20261112021335.1774-1-laixiangwu@cmss.chinamobile.com>
References: <2026111106-drowsily-dexterity-bddd@gregkh>
	<20261112021335.1774-1-laixiangwu@cmss.chinamobile.com>
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

Hi,

On Thu, 12 Nov 2026 10:13:34 +0800
Xiangwu Lai <laixiangwu@cmss.chinamobile.com> wrote:

> Hi Greg,
> 
> sorry for the missing context.  The patch I was pinging is:
> 
>   serial: sc16is7xx: Fix clock leak on invalid clock frequency
>   https://lore.kernel.org/all/20261030085508.1882-1-laixiangwu@cmss.chinamobile.com/
> 
> sc16is7xx_probe() enables the clock with clk_prepare_enable() early
> in the probe path.  If the clock frequency cannot be determined
> (neither from the clock itself, nor from the "clock-frequency"
> property or platform data), the driver bails out with -EINVAL
> without disabling the clock again, while the later error paths of
> the probe already jump to the out_clk label.  The patch makes this
> error path jump to out_clk as well, so the clock is disabled like
> on the other error paths.

It is better to simply reply to the original email, to have the full
context, without having to click on a link to see the original message.

> 
> It was submitted on Oct 30.  Is there anything blocking it, or does
> it just need more time?

I'll reply in the original email...

-- 
Hugo Villeneuve
