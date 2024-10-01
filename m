Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5EC1CB50B;
	Tue,  1 Oct 2024 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800893; cv=none; b=thNcMRa9Dj/HPW2FUfuXhDl9s6js4X0/Ua9+cB5OFNlLnJ628fyqzRfEBTEY0nyrDVPpGruzcfRdv+0SV2FrVbyme5o2aHlKEycfH4bf4kf4zl3aadWKNjla9cjY6li12v1U/9iGYaHoaUWBWjbTu8/y0op3GyUfdjv7nJUO2hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800893; c=relaxed/simple;
	bh=Dzt0aMplnStpO5JTFwbs9k4xSMn1funkeq7337H/hQo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rpXwT57pekQAeXiXpQIRS9AiBurnBTGICPvcZKAbbEQGP1PlsZj6PCFVBwwYPUTYk7PNfPfsJBr2hBuzJeRUrJuCu7x4p2imaQ1AoqHWLGZ3QJWs6+iuRM0nl5QKdx2Jrf3cr/o9nqqd4ioPKouoqHxR4ECoaHRHYOVfIeR7WK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 5535192009C; Tue,  1 Oct 2024 18:41:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 4F38492009B;
	Tue,  1 Oct 2024 17:41:23 +0100 (BST)
Date: Tue, 1 Oct 2024 17:41:23 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Niklas Schnelle <schnelle@linux.ibm.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    linux-serial@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>, 
    Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
In-Reply-To: <ef2912910d006c573324bcf063cb76e843dc8267.camel@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.2410011707550.45128@angie.orcam.me.uk>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>  <20240405152924.252598-2-schnelle@linux.ibm.com>  <alpine.DEB.2.21.2405230244140.1257@angie.orcam.me.uk> <ef2912910d006c573324bcf063cb76e843dc8267.camel@linux.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Niklas,

> With 2 more HAS_IOPORT patches having gone into v6.12-rc1 I'm looking
> at what's left and we're down to 4 prerequisite patches[0] before being
> able to compile-time disable inb()/outb()/…. This one being by far the
> largest of these. Looking at your suggestion it seems that to compile
> 8250_pci.c without HAS_IOPORT I'll have to add #ifdef CONFIG_HAS_IOPORT
> around the MOXI section as that uses I/O ports unconditionally. The
> rest seems fine and I guess would theoretically work on a system with
> !HAS_IOPORT. I'll send a v2 with that included. 

 I've skimmed over and I agree, though I'd place some of the #ifdefs 
differently, e.g. above #define QPCR_TEST_FOR1.  Overall I think it would 
make sense to reorder code and group stuff that depends on port I/O such 
as to minimise the number of #ifdefs.

 Ideally we could come with a slightly user-friendlier change that would 
report the inability to handle port I/O devices as they are discovered 
rather than just silently ignoring them.

> Note however that even though your POWER9 system does not have I/O port
> support in hardware we still have HAS_IOPORT enabled for arch/powerpc
> if PCI is enabed so even with this patch as is your POWER9 system
> should not be affected.

 I think we need to get this right regardless.  And also while I run a 
generic distribution kernel on my POWER9 as a production system, I'd love 
to see an option to build a tailored configuration that would indeed 
remove support for port I/O from the kernel side for systems like mine 
that have no provision for port I/O in hardware, knowing that such a 
kernel will only ever run on such hardware and discarding compiled code 
that won't ever be used.

  Maciej
