Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0952837A;
	Fri,  1 Nov 2024 01:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424302; cv=none; b=DXl+pgxhVv5+z/KXyAYj49ti+/SjEYCmYYlhyfgYg6g0S9dMNu2HD5o4RV/oHr3SEu/Djqn4gSLKQ35YGnqdBwJPrpYRJmoYyw2GnBciIJRNcM+30SVpkFAabvhavSFxBecMCFLftNv+FwxB8B48af4MFQa/JjYDQbmaxsnqEAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424302; c=relaxed/simple;
	bh=yONwKUo0FegqYXaDGUV1hJvt/V+QPQFVfsrZJo5ADY8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W9OO3lk4waMbUW/5CoFpUyz8FQ9vFHlRzCc3jR1vC4v+RASs6AeF7YYQI6uMDoSrriezyrVnyywfiHTsXfm6YnX9h/jlU7tFL0/KVR+FXj88V+V+2fkrg6SwdQxVzhQoq5mY2SphjmE0ION0KFKzeUyQ5LDB7YQccI1u4lh5ePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 3102E92009C; Fri,  1 Nov 2024 02:24:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 29A0D92009B;
	Fri,  1 Nov 2024 01:24:53 +0000 (GMT)
Date: Fri, 1 Nov 2024 01:24:53 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: John Ogness <john.ogness@linutronix.de>
cc: Jiri Slaby <jirislaby@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Petr Mladek <pmladek@suse.com>, 
    Sergey Senozhatsky <senozhatsky@chromium.org>, 
    Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, 
    Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Rengarajan S <rengarajan.s@microchip.com>, 
    Jeff Johnson <quic_jjohnson@quicinc.com>, 
    Serge Semin <fancer.lancer@gmail.com>, 
    Lino Sanfilippo <l.sanfilippo@kunbus.com>, 
    Wander Lairson Costa <wander@redhat.com>
Subject: Re: [PATCH tty-next v3 1/6] serial: 8250: Adjust the timeout for
 FIFO mode
In-Reply-To: <84sesclkqx.fsf@jogness.linutronix.de>
Message-ID: <alpine.DEB.2.21.2411010102150.40463@angie.orcam.me.uk>
References: <20241025105728.602310-1-john.ogness@linutronix.de> <20241025105728.602310-2-john.ogness@linutronix.de> <837a7ecd-be29-4865-9543-cb6f7e7e46e7@kernel.org> <alpine.DEB.2.21.2410310349450.40463@angie.orcam.me.uk>
 <84sesclkqx.fsf@jogness.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 31 Oct 2024, John Ogness wrote:

> >> THRE only signals there is a space for one character.
> >
> >  Nope[1]:
> >
> > "In the FIFO mode, THRE is set when the transmit FIFO is empty; it is 
> > cleared when at least one byte is written to the transmit FIFO."
> >
> > It seems common enough a misconception that once I actually had to fix the 
> > bad interpretation of THRE in an unpublished platform driver to get decent 
> > performance out of it at higher rates such as 230400bps, as it only pushed 
> > one byte at a time to the FIFO while it had it all available once THRE has 
> > been set.
> 
> I do not know if this is true for all 8250-variants. If there is some
> variant where it functions as Jiri expected, then it would mean
> significant text loss during longer messages. But that would already be
> a problem in the current mainline driver.

 Or rather in my case it would prevent communication from working at all; 
I actually had to fix the issue for networking over a serial line rather 
than just exchanging text messages, and hence a particular need to make it 
run fast.

 I don't expect any 550 clone to work in a different manner, but I find 
the TI manual particularly unambiguous and well-written, and also old 
enough for the 550 to be the state of the art rather than just legacy.

  Maciej
