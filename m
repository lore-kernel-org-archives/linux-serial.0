From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] serial_core: Update buffer overrun statistics.
Date: Mon, 21 May 2012 17:05:53 +0100
Message-ID: <20120521170553.7822c01c@pyramind.ukuu.org.uk>
References: <1336152910-5276-1-git-send-email-corbin.atkinson@ni.com>
	<20120515165339.6b142cd2@pyramind.ukuu.org.uk>
	<20120515155833.GA24878@kroah.com>
	<CAA0x6_-6tAHspcjFmD9Gz7NV4dUwP6St-UtivXTTQiANfBcX7A@mail.gmail.com>
	<20120515172710.0d0ce47b@pyramind.ukuu.org.uk>
	<CAA0x6_9dTE6zFaJOAqsrj2OcehARKG9KgicQPdf1yv2RjDbZwA@mail.gmail.com>
	<20120515220831.11f04213@bob.linux.org.uk>
	<CAA0x6_8mPs_JLxnjrzNYc4qej-c0kkhbVyuJPsaPg8xBvmThqQ@mail.gmail.com>
	<OF12D97EE0.DCA5956B-ON86257A05.00532260-86257A05.00537F9F@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53601 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797Ab2EUQDG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 May 2012 12:03:06 -0400
In-Reply-To: <OF12D97EE0.DCA5956B-ON86257A05.00532260-86257A05.00537F9F@ni.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jason Smith <jason.smith@ni.com>
Cc: Corbin <corbinat@gmail.com>, Alan Cox <alan@linux.intel.com>, Corbin Atkinson <corbin.atkinson@ni.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

> Has anyone had a chance to think about this anymore? We would really like 
> the capability to recognize that data has been discarded, even if it is 
> because no flow control is used and the user is ignoring the port. There 
> are cases, such as with RS-485, where there is no real flow control 
> mechanism is available, so we should not depend on flow-control as always 
> being an option. As Corbin mentioned, there are some other drivers using 
> buf_overrun (as opposed to overrun, which indicates FIFO overruns) for 
> this purpose, but we don't know if this was the original intention of this 
> field.

I was hopng Jiri would chip in.

If you think its important and want to argue for it, I'm not going to
fight against it.

Alan
