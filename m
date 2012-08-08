From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Patch for panic in n_tty_read()
Date: Wed, 8 Aug 2012 10:00:19 +0100
Message-ID: <20120808100019.6ca011a9@pyramind.ukuu.org.uk>
References: <4FE886C6.7090606@redhat.com>
	<20120626152159.2a34dcaf@pyramind.ukuu.org.uk>
	<50094C8E.5010308@redhat.com>
	<20120720161123.58fc9703@pyramind.ukuu.org.uk>
	<50221C30.20607@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:36933 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419Ab2HHIzs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Aug 2012 04:55:48 -0400
In-Reply-To: <50221C30.20607@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stanislav Kozina <skozina@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

On Wed, 08 Aug 2012 09:58:40 +0200
Stanislav Kozina <skozina@redhat.com> wrote:

> Alan,
> 
> I am not sure if you got my last email, so I'm resending it now:
> 
>  > I am very sorry, but I don't see it. We didn't held the lock while 
> calling tty_audit_push() before, and we don't hold it after the patch 
> neither.
>  > So what's the locking scheme change here? Is there some binding 
> between n_tty_read() and tty_audit_push() I just don't see?
> 

No - looking at it again you are right, the lock is still dropped during
the audit call.

Alan
