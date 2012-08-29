From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: unrecognized multi io pci card
Date: Wed, 29 Aug 2012 14:28:15 +0100
Message-ID: <20120829142815.231d5fdf@pyramind.ukuu.org.uk>
References: <20120828122458.GB1258@server>
	<20120828135529.6a826b19@pyramind.ukuu.org.uk>
	<20120828135720.GA2803@server>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:36700 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337Ab2H2NXf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 29 Aug 2012 09:23:35 -0400
In-Reply-To: <20120828135720.GA2803@server>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gianluca <gianluca@sottospazio.it>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org

> I see, I missed the quirks in 8250_pci.c. I added a quirk for my card to set
> the options above and it works nicely thanks!
> 
> The new patch is attached.
> 
> Gianluca

This looks good to me - the only thing it needs to be applied is a
signed-off-by line as per Documentation/SubmittingPatches

Alan
