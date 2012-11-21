From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty: Add driver unthrottle in ioctl(...,TCFLSH,..).
Date: Wed, 21 Nov 2012 21:30:37 +0000
Message-ID: <20121121213037.154306da@pyramind.ukuu.org.uk>
References: <50AD43DB.4030800@ilyx.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:36289 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755740Ab2KVSrF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Nov 2012 13:47:05 -0500
In-Reply-To: <50AD43DB.4030800@ilyx.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ilya Zykov <ilya@ilyx.ru>
Cc: Andrew McGregor <andrew.mcgregor@alliedtelesis.co.nz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

> Function reset_buffer_flags() also invoked during the
> ioctl(...,TCFLSH,..). At the time of request we can have full buffers
> and throttled driver too. If we don't unthrottle driver, we can get
> forever throttled driver, because after request, we will have
> empty buffers and throttled driver and there is no place to unthrottle driver.
> It simple reproduce with "pty" pair then one side sleep on tty->write_wait,
> and other side do ioctl(...,TCFLSH,..). Then there is no place to do writers wake up.


So instead of revertng it why not just fix it ? Just add an argument to
the reset_buffer_flags function to indicate if unthrottling is permitted.

Alan
