From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 1/1] serial_core: Update buffer overrun statistics.
Date: Tue, 15 May 2012 22:08:31 +0100
Message-ID: <20120515220831.11f04213@bob.linux.org.uk>
References: <1336152910-5276-1-git-send-email-corbin.atkinson@ni.com>
	<20120515165339.6b142cd2@pyramind.ukuu.org.uk>
	<20120515155833.GA24878@kroah.com>
	<CAA0x6_-6tAHspcjFmD9Gz7NV4dUwP6St-UtivXTTQiANfBcX7A@mail.gmail.com>
	<20120515172710.0d0ce47b@pyramind.ukuu.org.uk>
	<CAA0x6_9dTE6zFaJOAqsrj2OcehARKG9KgicQPdf1yv2RjDbZwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54699 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932848Ab2EOUxF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 May 2012 16:53:05 -0400
In-Reply-To: <CAA0x6_9dTE6zFaJOAqsrj2OcehARKG9KgicQPdf1yv2RjDbZwA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Corbin <corbinat@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Corbin Atkinson <corbin.atkinson@ni.com>

> it appears that the software buffer is actually artificially limited
> to 65536 bytes in the tty_buffer_alloc function in tty_buffer.c. I

Yes although you shouldn't be able to hit this with flow control
enabled. Without flow control we didn't overrun at that level.

it's really a semantics question - do we count stuff dumped
intentionally without flow control as an overrun.

I'm not fundamentally opposed to the idea but it is a change of meaning.

Other views ?

Alan
