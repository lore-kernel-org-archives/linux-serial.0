Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAC4405C5A;
	Tue, 26 May 2026 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808106; cv=none; b=M+7Q4HQ5OtuHvc6PSguw9tZq8PvEzBcTfgOxOffeUZoVPSr4VUysdBrNEA74YbmgMJuWFUCA4t8q/iw+xhLDerQLHIP0zPJ7dblZwklXBTbVmnaLcYAoES9gvx2IeJKNc3yp79SDzUb7S1jF1R/+ifpdgDUc+6WEbWNKCtvT4UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808106; c=relaxed/simple;
	bh=18Ll05h93qLha5IN3xqHxu/pEtgz5qPO/pKnrGCMtuE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZWsc1qGyJv0eEVQET1BK8755zL2lriVpCWIlyPdEOTYOfvL6TQuLZ0p87Ov6aOhUancht3YOz8PK5NzhopevKV++JHEsUAUfCdoPylptJyi2ysQpASkU2TStUfOeo3TIOdISmeKjF+1hz5H7QJxDQd5xmEvzBk1/J3tqalqnAYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 2C75292009D; Tue, 26 May 2026 17:08:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 2630192009B;
	Tue, 26 May 2026 16:08:23 +0100 (BST)
Date: Tue, 26 May 2026 16:08:23 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, linux-mips@vger.kernel.org, 
    linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 00/10] MIPS: DEC: Fix serial device regressions + RTC
 cleanup
In-Reply-To: <ahWyuPUMe7XQ9fZp@alpha.franken.de>
Message-ID: <alpine.DEB.2.21.2605261604510.1450@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605062240290.46195@angie.orcam.me.uk> <alpine.DEB.2.21.2605221609220.1450@angie.orcam.me.uk> <ahWyuPUMe7XQ9fZp@alpha.franken.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 26 May 2026, Thomas Bogendoerfer wrote:

> >  Will you be able to get these two changes merged sometime soon now that 
> > Greg has queued changes 03/10 through 09/10, so that these prerequisites 
> > land ahead and there's no 64-bit regression in mainline?
> 
> I've applied 01/10 and 02/10. 10/10 doesn't apply to my tree, because it
> depends on the platform.c changes from dz/zs driver change not yet present
> in my tree. So either Greg takes it via his tree or I'll pick it up in
> a second pull request during the merge window

 Fine with me either way, thanks for taking care of this stuff!  I'm glad 
I was able to find time and momentum to get these issues finally sorted, 
as I was aware of them for quite a while now, but there's so much to pick 
from.  More to come.

  Maciej
