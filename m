From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty_ioctl: Fix the baud_table check in encode_baud_rate
Date: Wed, 17 Oct 2007 11:43:58 +0100
Message-ID: <20071017114358.3d2b166f@the-village.bc.nu>
References: <Pine.LNX.4.64N.0710161857280.22596@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42263 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757190AbXJQKk2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Oct 2007 06:40:28 -0400
In-Reply-To: <Pine.LNX.4.64N.0710161857280.22596@blysk.ds.pg.gda.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 16 Oct 2007 19:12:11 +0100 (BST)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

>  The tty_termios_encode_baud_rate() function as defined by tty_ioctl.c has 
> a problem with the baud_table within.  The comparison operators are 
> reversed and as a result this table's entries never match and BOTHER is 
> always used.

Oops. I thought I'd fixed that one. Bit bothersome its been in -mm that
long before anyone noticed. 

ACK the first bit.

>  Additionally this function's prototype is not exported unlike the 
> function itself.

That bit seems out of date and a prototype was added later in -mm

