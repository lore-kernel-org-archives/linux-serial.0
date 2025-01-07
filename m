Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7A545027
	for <linux-serial@vger.kernel.org>; Tue,  7 Jan 2025 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274059; cv=none; b=RiGIxNNb8G0FzsU/CfI9B1c16m9Q6qgTBkDErLROcDZJTI2mrH5Mx2Z9wzobNDKwD0LChwdMgaugd1kV7ZAjluCjBNlPUplp0nBMzTE7j5nR/d/INVkroNg5Wb2+h8vlqr2Kb2BOQFlpyjnmeHMbPNdztFtfcLPyA5o2S6IOlJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274059; c=relaxed/simple;
	bh=rIQm6seoWasL+7DlaroNga2E9yjmM3daYT368JuYESU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxLviGrpOYdFvEHHxmhxBcL/GQNJdpmXwMjTBQv3DwLbdZYHDTGVva/OeT22MajIqKehN643UOAax4XgPWYfw6qSxmpdkO+OvjueSqkaa96XWD8KEIMpTZllJAk1xUAzeptPdRbzKxauPcaw3ImJIXVXxm6vpsObJYsdh2iDGmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0O/ZFUcF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0O/ZFUcF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DA3C4CEDD;
	Tue,  7 Jan 2025 18:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736274059;
	bh=rIQm6seoWasL+7DlaroNga2E9yjmM3daYT368JuYESU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0O/ZFUcFwk0BvGnlcATrupKBiewxropBAMGfZH8YAgF9BwCVF1DZtCIGfXIu8/Ztz
	 XNEypVQZj6XmKs4UEgNMCXGqY1+QsH1eMVlXFyxeSubfEBWU250lVXfWOstniku7Jv
	 QqNeyc5TsQzFXYzUkmkzf4fx77uUpKctYTtxH8Lw=
Date: Tue, 7 Jan 2025 19:20:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Cc: linux-serial@vger.kernel.org
Subject: Re: Precise timing in ldisc? tty_put_char() in hrtimer context?
Message-ID: <2025010732-creation-confound-d3fa@gregkh>
References: <CAH2-hcJVhxubEsRciMSrp2x4WyDrmmYNe0Db9-LzXkiRpBQ0iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2-hcJVhxubEsRciMSrp2x4WyDrmmYNe0Db9-LzXkiRpBQ0iQ@mail.gmail.com>

On Tue, Jan 07, 2025 at 07:07:42PM +0100, Tomáš Mudruňka wrote:
> Hello,
> i am implementing niche rs485-based serial protocol as a tty line
> discipline linux module. Requirement is to hit transmission window
> with precision in low hundreds of microseconds (eg. +-200 uS).
> Transmit window starts 500 uS after message is received.
> 
> It seems that hardware driver calls tty_receive_buf2() with sufficient
> latency, so my idea was to start hrtimer using hrtimer_start() inside
> of tty_receive_buf2(). And then in hrtimer handler call
> for(...){tty_put_char(tty,...)} or tty->ops->write(), but it seems not
> to be a good practice according to my online research. They say it's
> recommended to call tty_put_char() from workqueue, but documentation
> also says that calling a workqueue might introduce latency of couple
> milliseconds, since it's scheduled thread context.
> 
> What would you suggest to handle such a strict timing requirements
> between RX and TX data?

Use a different protocol or hardware implementation as having to be
forced to ensure that UART flows actually work that fast is going to be
very difficult for you to guarantee.  Just think, how do you know that
once the UART gets your byte, that it will not just sit around and wait
before it actually sends it out (hint, there is no such guarantee).

good luck!

greg k-h
