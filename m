Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433E8392C34;
	Fri, 16 Oct 2026 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187159; cv=none; b=S3Zb7cTX0MYhjRbdmF3EnUOGi2YrmO5DfPhH1gfpRudO3xeahf2gcBbfP54tN8dJ4c/3q6EZqIv79O9t0mSj500AMJKpOfy/fA0aPSxawuGjxuPZcC/vbw8banUMcxjjHSgtBaBH7Gpz/DHqIAXqqGDj4rCt29LFtEpMZlp0zek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187159; c=relaxed/simple;
	bh=k6q9vKTq/EZAzHVTpeoDIlCOyyjz6a3JeFSXhywddIU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CyoIKHhjJgFlTXNwt9sU/9w6Zfi2R+kJGznVp3xPbrLimhGk9VkSl9bAjqgPA7lIqnvjb+lwHN+aMzhsjV56u8hmCpJ2im1xTPkNUDUj7ThjXDsk1NYJLRSX84kZ8I/28Ax2IZ0lqFehD2d0KXfQOGt5P5/8I4YfvZlyoV695Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 524C792009C; Fri, 16 Oct 2026 23:45:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 4D9FA92009B;
	Fri, 16 Oct 2026 22:45:54 +0100 (BST)
Date: Fri, 16 Oct 2026 22:45:54 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: John Ogness <john.ogness@linutronix.de>
cc: Imre Kaloz <kaloz@kernel.org>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org, 
    Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
    Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] MIPS: SGI-IP27: print the NMI dump on an nbcon console
In-Reply-To: <87bj9d8fm7.fsf@jogness.linutronix.de>
Message-ID: <alpine.DEB.2.21.2610162215580.22065@angie.orcam.me.uk>
References: <20261001155013.1694-1-kaloz@kernel.org> <87ece98je8.fsf@jogness.linutronix.de> <55083820-478c-e6a6-b129-467140f161db@kernel.org> <87bj9d8fm7.fsf@jogness.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 1 Oct 2026, John Ogness wrote:

> > nmi_dump() has no caller in Linux. install_cpu_nmi_handler() stores
> > its address in the per-CPU NMI vector the PROM keeps in low memory,
> > and the PROM jumps to it when the system controller asserts NMI on
> > the CPUs: the "nmi" command at the L1 (or the MMSC on an Origin
> > 2000), typically used to get a dump out of a hung machine.
> >
> > Every CPU that takes the NMI enters nmi_dump(). The first one to get
> > nmi_lock waits until all online CPUs have arrived, prints the saved
> > state of every CPU and ends with the NI_PORT_RESET write. The others
> > spin on nmi_lock, which is never released. No CPU goes back to the
> > interrupted context
> 
> Thanks for the explanation. I guess it should have been obvious, also
> because @nmi_lock is locked and never unlocked.

 Mind that NMI on MIPS is not recoverable in the general case, unlike with 
say x86.

 First the event takes the reset vector, which typically is handled by the 
machine firmware and while it can be told apart by software from other 
events causing execution to reach there, it requires a machine-specific 
protocol.

 The use of the error level for the exception handler switches off the MMU 
for KUSEG and lets the register context be dumped for later restoration 
using $zero register as the base pointer, but again it has to be there in 
the firmware and then not to clash with OS use of memory.  Alternatively 
scratch GPRs could be put aside for NMI handling in the ABI such as with 
the kernel $k0-$k1 registers, but that'd be an overkill wasting precious 
resources.

 Then nesting is not supported since obviously it would clobber the state 
of the outer NMI handler, so that'd have to be prevented from triggering 
by system circuitry until cleared by software.  There's no internal latch 
in the CPU such as with x86 that would prevent an NMI from retriggering.

 All in all we do not strive to recover and only dump available state for 
any post-mortem examination.  Some platforms can't even do that.

  Maciej
