From: Stanislav Kozina <skozina@redhat.com>
Subject: Re: [PATCH V2] [tty] Fix possible race in n_tty_read()
Date: Thu, 09 Aug 2012 13:24:42 +0200
Message-ID: <50239DFA.1090004@redhat.com>
References: <4FE886C6.7090606@redhat.com> <20120626152159.2a34dcaf@pyramind.ukuu.org.uk> <50094C8E.5010308@redhat.com> <20120720161123.58fc9703@pyramind.ukuu.org.uk> <50221C30.20607@redhat.com> <20120808100019.6ca011a9@pyramind.ukuu.org.uk> <502256E8.5040300@redhat.com> <5022779F.8060309@redhat.com> <20120808162725.713e7a61@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51362 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758023Ab2HILYw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 9 Aug 2012 07:24:52 -0400
In-Reply-To: <20120808162725.713e7a61@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Stanislaw Gruszka <sgruszka@redhat.com>

I believe that BUG_ON is different issue.

I'm not sure what's the correct locking scheme for tty->read_buf. I 
guess that it's allocated as part of tty initialization, and only 
removed during n_tty_close(), correct? So we should not need any lock there.
Perhaps we should change that BUG_ON(!tty->read_buf); to just return 
-EAGAIN, as e.g. n_tty_receive_buf does?

         if (!tty->read_buf)
                 return;

I will submit a separate patch changing the BUG_ON to return, I believe 
it's still better to drop a n_tty_read() rather than panic whole system.
But I still don't understand how this can happen - that we have a tty 
operational without a buffer allocated. There still must be some other race.

-Stanislav

> Should this also be removing the BUG_ON check you noted in the other
> email was not valid now ?
>
> Alan

