From: Stanislav Kozina <skozina@redhat.com>
Subject: Re: Patch for panic in n_tty_read()
Date: Mon, 30 Jul 2012 13:58:52 +0200
Message-ID: <501676FC.6020103@redhat.com>
References: <4FE886C6.7090606@redhat.com> <20120626152159.2a34dcaf@pyramind.ukuu.org.uk> <50094C8E.5010308@redhat.com> <20120720161123.58fc9703@pyramind.ukuu.org.uk> <501283FC.8070409@redhat.com> <20120727135044.356823f4@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15824 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456Ab2G3L7D (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 30 Jul 2012 07:59:03 -0400
In-Reply-To: <20120727135044.356823f4@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

Alan,

I am very sorry, but I don't see it. We didn't held the lock while 
calling tty_audit_push() before, and we don't hold it after the patch 
neither.
So what's the locking scheme change here? Is there some binding between 
n_tty_read() and tty_audit_push() I just don't see?

Thank you,
-Stanislav

> Looks good to me. However it changes the locking rules on
> tty_audit_push() so please check the audit folks are ok with it. I don't
> think that causes any problems.
>
> Alan

