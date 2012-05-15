From: Jason Smith <jason.smith@ni.com>
Subject: Re: [PATCH 1/1] serial_core: Update buffer overrun statistics.
Date: Tue, 15 May 2012 14:34:42 -0500
Message-ID: <OFE08A1752.EBFB8DCA-ON862579FF.006B5BB4-862579FF.006B8CA8@ni.com>
References: <1336152910-5276-1-git-send-email-corbin.atkinson@ni.com> <20120515165339.6b142cd2@pyramind.ukuu.org.uk> <20120515155833.GA24878@kroah.com> <CAA0x6_-6tAHspcjFmD9Gz7NV4dUwP6St-UtivXTTQiANfBcX7A@mail.gmail.com> <20120515172710.0d0ce47b@pyramind.ukuu.org.uk> <CAA0x6_9dTE6zFaJOAqsrj2OcehARKG9KgicQPdf1yv2RjDbZwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailserver5.natinst.com ([130.164.80.5]:59766 "EHLO
	spamkiller05.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966750Ab2EOU5y (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 May 2012 16:57:54 -0400
In-Reply-To: <CAA0x6_9dTE6zFaJOAqsrj2OcehARKG9KgicQPdf1yv2RjDbZwA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Corbin <corbinat@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Corbin Atkinson <corbin.atkinson@ni.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-serial-owner@vger.kernel.org

On Tue, May 15, 2012 at 1:41 PM, Corbin <corbinat@gmail.com> wrote:
> Maybe I don't have a complete understanding of what is happening, but
> it appears that the software buffer is actually artificially limited
> to 65536 bytes in the tty_buffer_alloc function in tty_buffer.c. I

...

> On Tue, May 15, 2012 at 11:27 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> 
wrote:
>>
>> It'll occur when the machine cannot even allocate a free page of 
memory.
>> So you'll get GFP spews in the kernel log to go with it.

It seems to me that it would be undesirable to allow an ignored TTY device 
to consume all memory on the system.

It makes sense that the TTY layer would limit it to 64K, which is what 
Corbin observed in his test, but then there should be a mechanism to 
report that data had been discarded.

-Jason Smith
