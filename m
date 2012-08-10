From: Stanislav Kozina <skozina@redhat.com>
Subject: Re: [PATCH] Remove BUG_ON from n_tty_read()
Date: Fri, 10 Aug 2012 16:53:59 +0200
Message-ID: <50252087.6020607@redhat.com>
References: <20120626152159.2a34dcaf@pyramind.ukuu.org.uk> <50094C8E.5010308@redhat.com> <20120720161123.58fc9703@pyramind.ukuu.org.uk> <50221C30.20607@redhat.com> <20120808100019.6ca011a9@pyramind.ukuu.org.uk> <502256E8.5040300@redhat.com> <5022779F.8060309@redhat.com> <20120808162725.713e7a61@pyramind.ukuu.org.uk> <50239DFA.1090004@redhat.com> <5024E7B2.4030205@redhat.com> <20120810122935.GA2410@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7974 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759205Ab2HJOyK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Aug 2012 10:54:10 -0400
In-Reply-To: <20120810122935.GA2410@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org


> Subject should include "tty:" prefix.

Sorry, just forgot about it for the second time;-/
Can I force git format-patch to add it somehow?

> This usually is done in two lines:
>
> if (WARN_ON())
> 	return;

Thanks, good point, new patch sent.

> Additionally, second BUG_ON(!tty->read_buf) in n_tty_read() should be
> probably replaced too.

I don't think so.
In the first case, we are not running, so there might be no operation on 
tty running. We still don't understand how it can happen that someone 
closes the tty, and then read operation is called, however at least 
there is no (known) running operation.
In the other case, we have just be rescheduled - so we are definitely in 
operation, and if tty is closed while we are just sleeping, I would 
still keep BUG_ON() there. Despite we haven't seen any panics on that 
place, have we?

Thanks,
-Stanislav
