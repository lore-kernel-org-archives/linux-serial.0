From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Patch for panic in n_tty_read()
Date: Fri, 20 Jul 2012 16:11:23 +0100
Message-ID: <20120720161123.58fc9703@pyramind.ukuu.org.uk>
References: <4FE886C6.7090606@redhat.com>
	<20120626152159.2a34dcaf@pyramind.ukuu.org.uk>
	<50094C8E.5010308@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:42066 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab2GTPHn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 20 Jul 2012 11:07:43 -0400
In-Reply-To: <50094C8E.5010308@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stanislav Kozina <skozina@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

> You mean call to tty_put_user(), correct? Thanks for this catch.
> So what about to unlock the lock for this time? Because we need to hold 
> the lock while checking tty->read_cnt in the while loop condition, correct?

I think you are right on that yes.

Alan
