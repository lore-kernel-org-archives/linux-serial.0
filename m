From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Patch for panic in n_tty_read()
Date: Fri, 27 Jul 2012 13:50:44 +0100
Message-ID: <20120727135044.356823f4@pyramind.ukuu.org.uk>
References: <4FE886C6.7090606@redhat.com>
	<20120626152159.2a34dcaf@pyramind.ukuu.org.uk>
	<50094C8E.5010308@redhat.com>
	<20120720161123.58fc9703@pyramind.ukuu.org.uk>
	<501283FC.8070409@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:50330 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab2G0Mq5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Jul 2012 08:46:57 -0400
In-Reply-To: <501283FC.8070409@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stanislav Kozina <skozina@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

On Fri, 27 Jul 2012 14:05:16 +0200
Stanislav Kozina <skozina@redhat.com> wrote:

> Alan,
> 
> Thank you, updated fix (tested on bits based on commit 
> bdc0077af574800d24318b6945cf2344e8dbb050) is attached.
> Is this correct now?

Looks good to me. However it changes the locking rules on
tty_audit_push() so please check the audit folks are ok with it. I don't
think that causes any problems.

Alan
