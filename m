Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.120.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793808405;
	b=CMo1PUx5dU+gzBoRTrzEmj+iIUmy7G6ZUyCeackud4EL7MC/oL2vLBIHLD+fE8RgF03O
	 gwWz8n+hfbSaJIa5VHK21XvanLDs4EnnwonKyhfA5GO8mPQ2UQgRF2tqjJMDuOyqr1Zce
	 XwkGgoIV9wEtL1gj3p8UliNnueOS3RR+HIGx/Eg+ZKdjQ++XcvKXLdlITykTHvim+vGWr
	 q1wPZeOa+tiE7/Lo6JY7vmn0VyyRoNojOOdYMUKbxjGjYeyJeC6KVcy5Wlv55/SXSW/sc
	 CR5kpVz2b6bPpO3jmKcYVVOpfCSl4URPwCtymki64bOjzNVRbk7ESW8GJBjKsMt2oXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808405;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-Id:In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam_score:X-Spam_bar;
	bh=50NH5IHTeSDxkKdlgbYJAePpnzusNm5cVJrN9C4ccN8=;
	b=xLNzlkYPURiLDVb0x7fOySIqyx5w8LZxnqV36UezanTLP77uKtEext+QvBDT8JcE+arg
	 QA+XV1WzhziJQKO/TaauaZ76Gyyci7BlxB1FAl9WQQh2CZtqstmODiAZyUDAYjXA1aAIA
	 vpdxSIvKPPC6IOUVno4MVRgvudCqLm4ukNgTDiYpEYUgfO57JpZ54/FM734/BqjTyPfCy
	 Dc+WN/8iKxjWO5KOEOLCfsRiPBK9Q9XkHwyzaLoXOOuefQtqnJuZLoxkcKj5ApjpjSHSL
	 wwE6Y0pjhg+vv93zi/J/bDRowZ/HvpOqQ3g3s22KLg01CPYaCUvwhRB2K6Bnnvq5o5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hugovil.com;
	spf=pass smtp.mailfrom=hugovil.com;
	dkim=pass header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=nmPweLDU;
	arc=none smtp.remote-ip=162.243.120.170
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDD3606A31B;
	Wed,  4 Nov 2026 16:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EDD3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=nmPweLDU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=50NH5IHTeSDxkKdlgbYJAePpnzusNm5cVJrN9C4ccN8=; b=nmPweLDUyJiQES6k0BU0JSGbdD
	MyDrrQnEbhpck2sZ2fAWdJqVeefsl9x6Djd9a2L1VPrOkcn/20emhGkF98OkIqYLubVk4MyLUfKVP
	QKOzRA/sYyCsAOKSA0KI4WBlMegjv7NYSUs3wwC60r7QlWuAB3PtY6xZARLpidHtilmw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xOdVT-000000001dN-0OgR;
	Wed, 04 Nov 2026 11:06:35 -0500
Date: Wed, 4 Nov 2026 11:06:34 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, alan@linux.intel.com,
 gregkh@suse.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, "Maciej W. Rozycki"
 <macro@orcam.me.uk>
Subject: Re: [PATCH 0/5] serial: core: fixes and improvements to
 uart_get_baud_rate()
Message-Id: <20261104110634.fa87be2fd8953cee05056690@hugovil.com>
In-Reply-To: <20261020184131.2893575-1-hugo@hugovil.com>
References: <20261020184131.2893575-1-hugo@hugovil.com>
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

On Tue, 20 Oct 2026 14:41:16 -0400
Hugo Villeneuve <hugo@hugovil.com> wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> serial: core: fixes and improvements to uart_get_baud_rate()
> 
> Hello,
> this patch series brings fixes and improvements to uart_get_baud_rate()
> 
> This is in part based on discussions following Hui patches submission [1]
> to fix a divide by zero fault originating from uart_get_baud_rate().
> 
> Patch 1 is the fix for the above mentioned bug, as suggested by Hui
> but with much improved comments, bug report and reproduce steps so that is is
> easier to follow and understand. In original discussion, it was suggested by
> Ilpo and me that when rate gets lowered, it should alter the termios to prevent
> what is here seem as "old" having an invalid value. This is not handled by this
> series at the moment, as this may be more complex than anticipated.
> 
> Patch 2 is another fix for a potential divide by zero scenario.
> 
> Patch 3 removes any possibility for the function to return zero baud rate
> if the loop exits without a valid baud rate. History has shown that for
> this function, there was often unforeseen or unanticipated conditions
> that made the loop exit unexpectedly with a zero baud rate.
> 
> Patch 4 is a small improvement in readability to avoid a redundant baud
> assignment without any UPF_SPD_* flags. It could be merged with the refactor
> patch if deemed appropriate.
> 
> Patch 5 is a refactoring of uart_get_baud_rate() to make it easier to
> understand and analyze, and more linear, as with the current loop is is
> sometimes not easy to fully grasp what is happening. But in the end, I
> am not sure it is worth it as the loop makes things more efficient and
> simpler. I include the patch for discussion, but it may be removed from
> this series.
> 
> Tested the changes on a custom board with imx uart and two SC16IS752 DUART
> over a SPI interface using a Variscite IMX6 SOM.
> 
> Link: https://lore.kernel.org/all/20260930125901.778868-1-benquike@gmail.com/ [1]
> 
> Thank you.
> 
> Hugo Villeneuve (5):
>   serial: core: fix division by zero if old termios is present but has
>     invalid rate
>   serial: core: clip out-of-range baud rate to min/max, not min+1/max-1
>   serial: core: always return in-range baud rate even in case of failure
>   serial: core: avoid redundant baud assignment without any UPF_SPD_*
>     flags
>   serial: core: refactor uart_get_baud_rate() for readability
> 
>  drivers/tty/serial/serial_core.c | 113 ++++++++++++++++++-------------
>  1 file changed, 65 insertions(+), 48 deletions(-)

Hi,
I think this series has some implications for Maciej series "Don't 
clobber the baud rate on hangup via B0" [1], so this is a small
ping...

https://lore.kernel.org/all/alpine.DEB.2.21.2611030057510.15685@angie.orcam.me.uk/raw
[1]


-- 
Hugo Villeneuve
