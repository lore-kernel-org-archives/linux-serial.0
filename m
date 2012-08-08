From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH V2] [tty] Fix possible race in n_tty_read()
Date: Wed, 8 Aug 2012 16:27:25 +0100
Message-ID: <20120808162725.713e7a61@pyramind.ukuu.org.uk>
References: <4FE886C6.7090606@redhat.com>
	<20120626152159.2a34dcaf@pyramind.ukuu.org.uk>
	<50094C8E.5010308@redhat.com>
	<20120720161123.58fc9703@pyramind.ukuu.org.uk>
	<50221C30.20607@redhat.com>
	<20120808100019.6ca011a9@pyramind.ukuu.org.uk>
	<502256E8.5040300@redhat.com>
	<5022779F.8060309@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:37559 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758763Ab2HHPWw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Aug 2012 11:22:52 -0400
In-Reply-To: <5022779F.8060309@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stanislav Kozina <skozina@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Stanislaw Gruszka <sgruszka@redhat.com>

On Wed, 08 Aug 2012 16:28:47 +0200
Stanislav Kozina <skozina@redhat.com> wrote:

> Fix possible panic caused by unlocked access to tty->read_cnt in 
> while-loop condition in n_tty_read().

Should this also be removing the BUG_ON check you noted in the other
email was not valid now ?

Alan
