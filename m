From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v4] tty: Add driver unthrottle in ioctl(...,TCFLSH,..).
Date: Tue, 27 Nov 2012 19:32:08 +0000
Message-ID: <20121127193208.331673ae@pyramind.ukuu.org.uk>
References: <50B45A49.2040104@ilyx.ru>
	<20121127172406.GE24592@kroah.com>
	<50B50AA0.7070603@ilyx.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:42854 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab2K0T1A (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Nov 2012 14:27:00 -0500
In-Reply-To: <50B50AA0.7070603@ilyx.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ilya Zykov <ilya@ilyx.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org


> No, if only you will accept:
> [PATCH]tty: Incorrect use tty_ldisc_flush() in TTY drivers.
> 
> It can be done another way, simple revert:
> 'tty: fix "IRQ45: nobody cared"'
> commit 7b292b4bf9a9d6098440d85616d6ca4c608b8304

NAK that revert - that swaps a minor glitch you've discovered that does
want fixing for a nasty bug.
