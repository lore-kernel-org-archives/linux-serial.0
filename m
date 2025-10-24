Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E13303A37;
	Fri, 24 Oct 2025 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294080; cv=none; b=QRUQwWFKSoW/BAP9/bz/HgzGa42WBcPiznTcmph/xPIuk4/sCZxSZOZoQBuuG0Bb9cuE0lUsrLrbhbU80gOQnObkI7DXPI5uVuLafVqROp0JRoJqxxky62OB4ol+0wnDKTvJ8pDphLNrUBulgC1zt8Em9rrMSlLKWAv5lKq58xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294080; c=relaxed/simple;
	bh=nSqNxCaJHsZSPEfjyOXsCi7jJUvfJtQt2MMZR8gYTpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CP3oYmN6AWbYBh5kH+PHKP8MKbDK2kmOnPJ+V/KMowvXW1ejc3laQpvsPwDA8Fvk0EECXmkqes7PW1S9EFaly66DlmCIFC+vfMGJFcgc4BT2HboZejAP9D5xENq+3eA+pZx13Aud74I2OXnt+6m0dJ0GsN7jX7g31wNFzlvEdEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SATOMonn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SATOMonn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4168C4CEF1;
	Fri, 24 Oct 2025 08:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761294079;
	bh=nSqNxCaJHsZSPEfjyOXsCi7jJUvfJtQt2MMZR8gYTpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SATOMonnxf5NK8ZXK3kVofBZjOxTN0ueoBsUlrsnXNWXqNRR6ytKr/k23rrGttUgZ
	 caqge7qdDNVQaGpBY1F/uA23ftbytKcpJRzqzOse0M27sMVhfVV8xZOeXkHonXE75v
	 nyYz2CJXUUtpV48wbmrTPrFIltSTpfSU0V0TUZ+GYVg+xxIEqF705qq8UzFHqpOcNR
	 4cHOslhjE/+jeXSWDEcLzNrckikPUaRZ0R4+faQUoqjOB50Q4bU1yiBWm3XOr1SJ/x
	 N9+wy6fgwHgu70PDFOzms1o6z95X++3N9glTTiEgpZrmN7iBuUjMMm9pV+kgeTU4Im
	 lCpMBXdfj556w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vCD37-0000000011S-1i6p;
	Fri, 24 Oct 2025 10:21:26 +0200
Date: Fri, 24 Oct 2025 10:21:25 +0200
From: Johan Hovold <johan@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] USB-Serial serdev support
Message-ID: <aPs3BX9-og6wJIWR@hovoldconsulting.com>
References: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
 <Zt7kCxawoszunWq3@hovoldconsulting.com>
 <20240917044948.i2eog4ondf7vna7q@pengutronix.de>
 <Z8_wcASfJ8SeAQ8l@hovoldconsulting.com>
 <20250313194044.t2t3c7j6ktvshjhs@pengutronix.de>
 <aPogbAozezmqSMuU@hovoldconsulting.com>
 <20251023134828.2dzq2rhtjplqyyaj@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023134828.2dzq2rhtjplqyyaj@pengutronix.de>

On Thu, Oct 23, 2025 at 03:48:28PM +0200, Marco Felsch wrote:
> On 25-10-23, Johan Hovold wrote:
> > On Thu, Mar 13, 2025 at 08:40:44PM +0100, Marco Felsch wrote:
> > > On 25-03-11, Johan Hovold wrote:
> > > > On Tue, Sep 17, 2024 at 06:49:48AM +0200, Marco Felsch wrote:
> > > > > On 24-09-09, Johan Hovold wrote:

> > > > > > First, as the commit message you refer to below explain, we need some
> > > > > > way to describe multiport controllers. Just dropping the 'serial' node
> > > > > > does not make that issue go away.

> > There are other USB serial devices that support multiple ports over a
> > single USB interface. The DT bindings need to account for that case as
> > well, and that probably means we should not be describing the interfaces
> > at all but rather the physical ports.
> 
> Ah okay, I wasn't even aware that this possible too. However this is DT
> description and another topic.

It's still one of the issues that need to addressed.
 
> > > > > > Second, and more importantly, you do not address the main obstacle for
> > > > > > enabling serdev for USB serial which is that the serdev cannot handle
> > > > > > hotplugging.

> > You will also see the following kind of warnings in the logs:
> > 
> > ttyUSB ttyUSB0: tty_hangup: tty->count(1) != (#fd's(0) + #kopen's(0))
> > ttyUSB ttyUSB0: tty_port_close_start: tty->count = 1 port count = 0
> > 
> > which are due to the fact that serdev does not support hangups which are
> > used during teardown of USB serial ports.
> 
> IIRC I added the following patch to solve this:
> 
>  - [PATCH 1/3] serdev: ttyport: make use of tty_kopen_exclusive
> 
> Sorry for not remembering the details since this conversation/patchset
> is quite old but still one of our top prios.

That suppresses the first warning but doesn't address the underlying
issue (that hangups are built around file handles which serdev does not
use). And you will still see the second one when the serdev driver tries
to close the already hung up port during deregistration.

Also, that commit message needs to more work since you don't really
motivate why you think it's needed (e.g. as serdev ports can't be shared
with user space).

If it's just about suppressing the warning you could possibly just have
set that new flag.

Johan
