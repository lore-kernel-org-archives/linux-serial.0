Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AA0DDD2;
	Wed,  2 Oct 2024 22:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727909992; cv=none; b=XcPf+grR6U3fBNqeFcBivyC/XPT+pHXJoY1Gs885QOl048+aOjAetHnEcuTbFlJmHaBC2JTcaQyaIxDSYnqsCXyM7iRRxbB4l+7RJyBYjyRrLEcz1kj4rT4jvhFNskmap+HkEfUogGYqvu8VeOEUtcHCS8Qi2UxWGA8RLcix1Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727909992; c=relaxed/simple;
	bh=vUnDHQhPCZR3/5PFaWY/V+EEQ7SJ8JR4e/Ru6a70Yek=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GvonJy9fqTz9jLGZihg4rYrPKwVQsFYLfuT+/hU0zPFp+EeWFbxy5lY2RfuSkLUiWi7QKYUcVCMjucbvHMQ7V0sUV5TzWWVgcXiHOLIFxDMcGQWcls1aQzDgtHv3AFrQO9fQLjCJWzR7YCEQHJJrg0omsZboHgbpg7vMofaW2uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 3FEC292009C; Thu,  3 Oct 2024 00:59:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 38E6692009B;
	Wed,  2 Oct 2024 23:59:48 +0100 (BST)
Date: Wed, 2 Oct 2024 23:59:48 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Arnd Bergmann <arnd@kernel.org>
cc: Niklas Schnelle <schnelle@linux.ibm.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    linux-serial@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
In-Reply-To: <84bbda13-ded1-4ada-a765-9d012d3f4abd@app.fastmail.com>
Message-ID: <alpine.DEB.2.21.2410022305040.45128@angie.orcam.me.uk>
References: <20240405152924.252598-1-schnelle@linux.ibm.com> <20240405152924.252598-2-schnelle@linux.ibm.com> <alpine.DEB.2.21.2405230244140.1257@angie.orcam.me.uk> <ef2912910d006c573324bcf063cb76e843dc8267.camel@linux.ibm.com> <alpine.DEB.2.21.2410011707550.45128@angie.orcam.me.uk>
 <7bcec0eb88c3891d23f5c9f224e708e4a9bb8b89.camel@linux.ibm.com> <alpine.DEB.2.21.2410021632150.45128@angie.orcam.me.uk> <84bbda13-ded1-4ada-a765-9d012d3f4abd@app.fastmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 2 Oct 2024, Arnd Bergmann wrote:

> I agree that this shouldn't be hard to finish. The IS_ENABLED()
> check is not that easy to do as I think we need to keep calling
> inb()/outb() outside of an #ifdef a compile-time error.

 Can we just provide dummy prototypes with `__attribute__((error("...")))' 
instead?  This will surely prevent us from having to bend backwards so as 
to make sure the compiler won't see any spurious references to these 
inexistent functions or macros.  We already have a `__compiletime_error()' 
macro for this purpose even.

> Part of the problem that Niklas is trying to solve with the
> CONFIG_HAS_IOPORT annotations is to prevent an invalid inb()/outb()
> from turning into a NULL pointer dereference as it currently does
> on architectures that have no way to support PIO but get the
> default implementation from asm-generic/io.h.

 It can be worse than that.  Part of my confusion with the defxx driver 
trying to do port I/O with my POWER9 system came from the mapping actually 
resulting in non-NULL invalid pointers, dereferencing which caused a flood 
of obscure messages produced to the system console by the system firmware:

LPC[000]: Got SYNC no-response error. Error address reg: 0xd0010014
IPMI: dropping non severe PEL event
LPC[000]: Got SYNC no-response error. Error address reg: 0xd0010014
IPMI: dropping non severe PEL event
LPC[000]: Got SYNC no-response error. Error address reg: 0xd0010014
IPMI: dropping non severe PEL event
LPC[000]: Got SYNC no-response error. Error address reg: 0xd0010014
IPMI: dropping non severe PEL event
[...]

from which it was all but obvious that they were caused by an attempt to 
use PCI port I/O with a system lacking support for it.

> It's not clear if having a silently non-working driver or one
> that crashes makes it easier to debug for users. Having a clear
> warning message in the PCI probe code is probably the best
> we can hope for.

 I agree.  Enthusiastically.

> I think that anyone using hardware that relies on port I/O on
> non-x86 is at this point going to have a reasonable understanding
> of the system, so I'm not too worried here. ;-)

 Well, virtually all non-x86 systems continue supporting PCI/e port I/O 
via a suitably decoded CPU-side MMIO window, so I think coming across one 
that doesn't can still be a nasty surprise even in 2024.  For instance 
I've been happily using a PC parallel port PCIe option card, one of the 
very few interfaces if not the only one remaining that have not ever seen 
an MMIO variant, with my RISC-V hardware, newer than said POWER9 system.

 So far it's been the s390 and a couple of POWER system implementations 
that have support for PCI/e port I/O removed.  Have I missed anything?

  Maciej
