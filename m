From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 05/14] usb: serial: Remove unused tty->hw_stopped
Date: Tue, 23 Sep 2014 17:33:30 +0200
Message-ID: <20140923153330.GA4524@localhost>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
 <1410375996-4693-1-git-send-email-peter@hurleysoftware.com>
 <1410375996-4693-6-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:57557 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbaIWPgE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Sep 2014 11:36:04 -0400
Content-Disposition: inline
In-Reply-To: <1410375996-4693-6-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Johan Hovold <johan@kernel.org>

On Wed, Sep 10, 2014 at 03:06:27PM -0400, Peter Hurley wrote:
> The tty core does not test tty->hw_stopped; remove from drivers
> which don't test it themselves.
> 
> cc: Johan Hovold <johan@kernel.org>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>

Acked-by: Johan Hovold <johan@kernel.org>
