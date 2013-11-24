From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH tty-next 7/7] n_tty: trace input/read flow control
Date: Sun, 24 Nov 2013 00:25:13 +0000
Message-ID: <20131124002513.0a806665@alan.etchedpixels.co.uk>
References: <1385135965-4235-1-git-send-email-peter@hurleysoftware.com>
	<1385135965-4235-8-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:41057 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756380Ab3KXAZX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 23 Nov 2013 19:25:23 -0500
In-Reply-To: <1385135965-4235-8-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Fri, 22 Nov 2013 10:59:25 -0500
Peter Hurley <peter@hurleysoftware.com> wrote:

> Instrument .receive_buf() and read() paths with trace_printk's
> to aid in debugging flow control changes.

tty devices have a device, we have a dev_dbg() layer. The old tty trace
predates this but there isn't really any excuse for not using it now that
I can see ?

Alan
