From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] tty: serial: 8250: omap: line is unsigned, don't
 check < 0
Date: Tue, 25 Nov 2014 11:27:45 -0800
Message-ID: <20141125192745.GA5929@kroah.com>
References: <20141112084807.GB13955@mwanda>
 <1415784514-26649-1-git-send-email-bigeasy@linutronix.de>
 <5474C582.7080507@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:49206 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbaKYT1q (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Nov 2014 14:27:46 -0500
Content-Disposition: inline
In-Reply-To: <5474C582.7080507@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, dan.carpenter@oracle.com

On Tue, Nov 25, 2014 at 07:08:02PM +0100, Sebastian Andrzej Siewior wrote:
> On 11/12/2014 10:28 AM, Sebastian Andrzej Siewior wrote:
> > Dan Carpenter reported:
> > |drivers/tty/serial/8250/8250_omap.c:1025 omap8250_probe()
> > |warn: unsigned 'up.port.line' is never less than zero.
> > |1025          if (up.port.line < 0) {
> > 
> > I (wrongly) assumed that line is an int and compiler didn't complain nor
> > did sparse. Since of_alias_get_id() and pdev->id can get negative I
> > check for the error via ret variable.
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Greg, did those two slip through or do you wait for something until you
> apply them?

I'm still working on catching up with my tty/serial patches, this is in
the queue...
