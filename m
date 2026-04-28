Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D0340FDA4;
	Tue, 28 Apr 2026 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777384202; cv=none; b=dzdQmrTNs2sIrIAXSmc7YrYgkD7aHOvF9rsP1o1isV9X18XmpDjYpsIM4S1U6avNWldeEdbYGg0fcxmRhK9q8k47E6yKjLfwl+4mDf3PH1apEd9w3+zrwUI5kzyYB1EyTjp5+NTjNGXtRqf3WSTHRFRFQ9Vub6EyZ3IiX+KDulk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777384202; c=relaxed/simple;
	bh=Yul00JZr3xk9/sL+/4OeGpEpvQSal9RZ2J5klF+bOxs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cQ6LWNa/szbnuShVNnquTIdT3DC6ifnwo9nx/uyjQJi+Q+dE2stTfZDXyQPckMeHtCDMngwq4wpIG5//9tW2ofEVEshbk5OH1WRlIwrDbIJ1YBNknUXu2sneUaHMN3swrUUBAS4C0xtOE/OyynP25NyFrQiatA9vsxVUE/ugqiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id CFF3A9200B4; Tue, 28 Apr 2026 15:49:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id C98D292009D;
	Tue, 28 Apr 2026 14:49:51 +0100 (BST)
Date: Tue, 28 Apr 2026 14:49:51 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: linux-mips@vger.kernel.org, linux-serial@vger.kernel.org, 
    linux-serial@vger.kernel.org
Subject: Re: [PATCH 6/8] serial: zs: Convert to use a platform device
In-Reply-To: <alpine.DEB.2.21.2604110034160.29980@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2604281415030.38805@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2604102250060.29980@angie.orcam.me.uk> <alpine.DEB.2.21.2604110034160.29980@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 13 Apr 2026, Maciej W. Rozycki wrote:

> An unfortunate consequence of the switch to a platform device is we now
> hand the console over from the bootconsole much later in the bootstrap.
> The firmware console handler appears good enough though to work so late
> and in particular with interrupts enabled.

 Additional verification revealed actual fallout from this postponement of 
console switching, where the kernel hangs in the 64-bit configuration at:

pid_max: default: 32768 minimum: 301

or somewhat later, but always before:

cblist_init_generic: Setting adjustable number of callback queues.

I have tracked down the cause to be the initial console output handler now 
being called from other kernel threads beyond the initial one, and unlike 
the latter they have their stack allocated in 64-bit XKPHYS segment rather 
than 32-bit compatibility CKSEG0 segment.

 Consequently the stack pointer is no longer a 32-bit value and when the 
firmware console output handler being called uses 32-bit ALU operations to 
manipulate the stack pointer, the calculated result is incorrect (in fact 
in the 64-bit MIPS ISA it is UB for almost all 32-bit ALU operations to 
execute on 64-bit data) and control goes astray.

 We already have code in the generic call_o32() 32-bit firmware call stub 
for 64-bit code to do optional stack switching, so all that has to be done 
is making the platform supply the stub with a pointer to an alternative 
stack located in CKSEG0, such as to a chunk of initdata space.  This will 
be straightforward to implement; I'll yet think whether to arrange for the 
stack to be switched every time or only when the incoming stack pointer is 
outside the 32-bit space.

 In any case I'll respin the series shortly so as to include the platform 
update required and prevent an unnecessary maintenance complication from 
happening that a standalone fix would cause.

 The other driver never runs on 64-bit hardware, so it causes no issue.

  Maciej
