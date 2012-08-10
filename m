From: Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH] Remove BUG_ON from n_tty_read()
Date: Fri, 10 Aug 2012 14:29:36 +0200
Message-ID: <20120810122935.GA2410@redhat.com>
References: <20120626152159.2a34dcaf@pyramind.ukuu.org.uk>
 <50094C8E.5010308@redhat.com>
 <20120720161123.58fc9703@pyramind.ukuu.org.uk>
 <50221C30.20607@redhat.com>
 <20120808100019.6ca011a9@pyramind.ukuu.org.uk>
 <502256E8.5040300@redhat.com>
 <5022779F.8060309@redhat.com>
 <20120808162725.713e7a61@pyramind.ukuu.org.uk>
 <50239DFA.1090004@redhat.com>
 <5024E7B2.4030205@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31065 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044Ab2HJM3t (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Aug 2012 08:29:49 -0400
Content-Disposition: inline
In-Reply-To: <5024E7B2.4030205@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stanislav Kozina <skozina@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

On Fri, Aug 10, 2012 at 12:51:30PM +0200, Stanislav Kozina wrote:
> Change the BUG_ON to WARN_ON and return in case of tty->read_buf==NULL

A few small nitpicks.

Subject should include "tty:" prefix.

> -	BUG_ON(!tty->read_buf);
> +	if (!tty->read_buf) {
> +		WARN_ON(!tty->read_buf);
> +		return -EAGAIN;
> +	}

This usually is done in two lines:

if (WARN_ON())
	return;

Additionally, second BUG_ON(!tty->read_buf) in n_tty_read() should be
probably replaced too.

Thanks
Stanislaw
