From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH V2] [tty] Fix possible race in n_tty_read()
Date: Thu, 9 Aug 2012 13:35:57 +0100
Message-ID: <20120809133557.7c9665e6@pyramind.ukuu.org.uk>
References: <4FE886C6.7090606@redhat.com>
	<20120626152159.2a34dcaf@pyramind.ukuu.org.uk>
	<50094C8E.5010308@redhat.com>
	<20120720161123.58fc9703@pyramind.ukuu.org.uk>
	<50221C30.20607@redhat.com>
	<20120808100019.6ca011a9@pyramind.ukuu.org.uk>
	<502256E8.5040300@redhat.com>
	<5022779F.8060309@redhat.com>
	<20120808162725.713e7a61@pyramind.ukuu.org.uk>
	<50239DFA.1090004@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:38840 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932262Ab2HIMb0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 9 Aug 2012 08:31:26 -0400
In-Reply-To: <50239DFA.1090004@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stanislav Kozina <skozina@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Stanislaw Gruszka <sgruszka@redhat.com>

On Thu, 09 Aug 2012 13:24:42 +0200
Stanislav Kozina <skozina@redhat.com> wrote:

> I believe that BUG_ON is different issue.

Ok thats what I was thinking.. I was a bit confused about that.

> I will submit a separate patch changing the BUG_ON to return, I believe 
> it's still better to drop a n_tty_read() rather than panic whole system.
> But I still don't understand how this can happen - that we have a tty 
> operational without a buffer allocated. There still must be some other race.

Nor me - a WARN_ON and return would be better perhaps - it will at least
then spew an error into the logs

Alan
