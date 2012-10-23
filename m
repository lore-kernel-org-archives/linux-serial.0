From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New serial card development
Date: Tue, 23 Oct 2012 19:26:33 +0100
Message-ID: <20121023192633.18849645@pyramind.ukuu.org.uk>
References: <5074703E.408@commtech-fastcom.com>
	<20121014093704.GA6207@thunk.org>
	<CAJp1Oe6F+KiXoWdhb7JjbYmNBY4gxbtBzwNu0gWC7XzA_ZJxMg@mail.gmail.com>
	<20121016002608.64b33de5@pyramind.ukuu.org.uk>
	<20121016023226.GA17446@thunk.org>
	<CAJp1Oe4n-TtxDM8D82bFQxjBtx8rSAX8mWrFk0bSM6uGL9X=Eg@mail.gmail.com>
	<20121019212158.GB4721@thunk.org>
	<CAJp1Oe6ekkaZ29iwJ91VXwM_CSL6Z0_KEaqVQTa1XMzTB5niEQ@mail.gmail.com>
	<k66mc1$cml$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:50562 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756746Ab2JWSV1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Oct 2012 14:21:27 -0400
In-Reply-To: <k66mc1$cml$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

> Can it be guaranteed that it's going to be fast enough at high
> baud-rates to prevent any gap between the first byte and subsequent
> bytes?

Possibly not for some protocols (or worse yet 'almost always' for some
protocols).

It's something to look at once the basic bits are in.

> I now work for a company that has manufactured PC serial boards for
> 25+ years, and we still get regular requests for that feature (and our
> boards do support it -- though our Linux driver does not).

In which case when we get to addressing this it will be good to make
sure we cover your needs as well.

Alan
 
