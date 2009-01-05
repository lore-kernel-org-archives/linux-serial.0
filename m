From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 72/75] tty: Fix an ircomm warning and note another bug
Date: Mon, 5 Jan 2009 18:01:42 +0000
Message-ID: <20090105180142.5e2154ff@lxorguk.ukuu.org.uk>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
	<20090102135012.13472.40889.stgit@localhost.localdomain>
	<20090105174237.GA5675@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41142 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750778AbZAESBd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Jan 2009 13:01:33 -0500
In-Reply-To: <20090105174237.GA5675@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: torvalds@osdl.org, linux-serial@vger.kernel.org

> > +		 * Note this is completely usafe and doesn't work properly
> 
> Do you mean "unsafe"?
> 

Yes - I'll fix that later - well spotted
