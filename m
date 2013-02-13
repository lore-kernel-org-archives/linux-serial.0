From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC 0/4] tty: port hangup and close issues
Date: Wed, 13 Feb 2013 17:36:30 +0000
Message-ID: <20130213173630.63e29b47@www.etchedpixels.co.uk>
References: <20130213142513.GA21078@localhost>
	<1360776446-31371-1-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:52402 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759980Ab3BMRhG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Feb 2013 12:37:06 -0500
In-Reply-To: <1360776446-31371-1-git-send-email-jhovold@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Chris Ruehl <chris.ruehl@gtsys.com.hk>, Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

> [ Note that this closing of an uninitialised port seems to be a bug in
>   itself, which these patches aim to fix. ]

You don't want to be cc'ing me on these - not my problem any more.

(but you might want to fix the fact you reference port->tty without the
lock or refcounts 8))

Alan
