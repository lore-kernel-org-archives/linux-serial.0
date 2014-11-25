From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/2] tty: serial: 8250: omap: line is unsigned, don't
 check < 0
Date: Tue, 25 Nov 2014 19:08:02 +0100
Message-ID: <5474C582.7080507@linutronix.de>
References: <20141112084807.GB13955@mwanda> <1415784514-26649-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47027 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbaKYSIG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Nov 2014 13:08:06 -0500
In-Reply-To: <1415784514-26649-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: dan.carpenter@oracle.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 11/12/2014 10:28 AM, Sebastian Andrzej Siewior wrote:
> Dan Carpenter reported:
> |drivers/tty/serial/8250/8250_omap.c:1025 omap8250_probe()
> |warn: unsigned 'up.port.line' is never less than zero.
> |1025          if (up.port.line < 0) {
> 
> I (wrongly) assumed that line is an int and compiler didn't complain nor
> did sparse. Since of_alias_get_id() and pdev->id can get negative I
> check for the error via ret variable.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Greg, did those two slip through or do you wait for something until you
apply them?

Sebastian
