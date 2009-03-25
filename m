From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/30] disallow SERIAL_8250_PNP with
 SERIAL_8250_CONSOLE
Date: Wed, 25 Mar 2009 10:02:24 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0903251001340.3032@localhost.localdomain>
References: <20090324213416.GA29507@srcf.ucam.org> <20090324213841.59d6b299@lxorguk.ukuu.org.uk> <20090324214321.GA29671@srcf.ucam.org> <20090324221816.50e7ccc2@lxorguk.ukuu.org.uk> <20090324222934.GA30503@srcf.ucam.org> <20090324223632.66680ebd@lxorguk.ukuu.org.uk>
 <20090324225812.GA30827@srcf.ucam.org> <20090325092203.139bb144@torg> <20090325101831.1322b00f@torg> <20090325153235.1b9eaaa2@lxorguk.ukuu.org.uk> <20090325153857.GA17045@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51198 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752739AbZCYRHE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Mar 2009 13:07:04 -0400
In-Reply-To: <20090325153857.GA17045@srcf.ucam.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Clark Williams <williams@redhat.com>, Andrey Panin <pazke@donpac.ru>, linux-serial@vger.kernel.org



On Wed, 25 Mar 2009, Matthew Garrett wrote:
> 
> It's still fixing one configuration by breaking another. There's no harm 
> in maintaining the status quo.

I do agree. We do _not_ fix a problem by making another one. We're better 
off with the old problem than with a new one.

			Linus
