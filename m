From: Jason Smith <jason.smith@ni.com>
Subject: Re: [PATCH 1/1] serial_core: Update buffer overrun statistics.
Date: Mon, 21 May 2012 10:12:01 -0500
Message-ID: <OF12D97EE0.DCA5956B-ON86257A05.00532260-86257A05.00537F9F@ni.com>
References: <1336152910-5276-1-git-send-email-corbin.atkinson@ni.com> <20120515165339.6b142cd2@pyramind.ukuu.org.uk> <20120515155833.GA24878@kroah.com> <CAA0x6_-6tAHspcjFmD9Gz7NV4dUwP6St-UtivXTTQiANfBcX7A@mail.gmail.com> <20120515172710.0d0ce47b@pyramind.ukuu.org.uk> <CAA0x6_9dTE6zFaJOAqsrj2OcehARKG9KgicQPdf1yv2RjDbZwA@mail.gmail.com> <20120515220831.11f04213@bob.linux.org.uk> <CAA0x6_8mPs_JLxnjrzNYc4qej-c0kkhbVyuJPsaPg8xBvmThqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailserver5.natinst.com ([130.164.80.5]:42712 "EHLO
	spamkiller05.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884Ab2EUPMM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 May 2012 11:12:12 -0400
In-Reply-To: <CAA0x6_8mPs_JLxnjrzNYc4qej-c0kkhbVyuJPsaPg8xBvmThqQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Corbin <corbinat@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>, Corbin Atkinson <corbin.atkinson@ni.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-serial-owner@vger.kernel.org

On Tue, May 15, 2012 at 5:46 PM, Corbin <corbinat@gmail.com> wrote:
> On Tue, May 15, 2012 at 4:08 PM, Alan Cox <alan@linux.intel.com> wrote:
>>> it appears that the software buffer is actually artificially limited
>>> to 65536 bytes in the tty_buffer_alloc function in tty_buffer.c. I
>>
>> Yes although you shouldn't be able to hit this with flow control
>> enabled. Without flow control we didn't overrun at that level.
>>
>> it's really a semantics question - do we count stuff dumped
>> intentionally without flow control as an overrun.
>>
>> I'm not fundamentally opposed to the idea but it is a change of 
meaning.
>>
>> Other views ?
>>
>> Alan
>
> While I agree on normal use cases this won't be hit due to flow
> control, I think it is still important to somehow know data was lost
> in the case where flow control isn't used. Calling it a buffer overrun
> was the way I thought was most fitting. I'm not sure what the
> alternatives would be.
>
> On a side note, If this isn't considered a buffer overrun I'm also not
> too sure what the buf_overrun field of the port's icount struct is
> for. While the "overrun" field is incremented in most drivers to
> indicate a hardware overrun, the "buf_overrun" field isn't really
> used. It appears that at least one of the few drivers using
> buf_overrun (cyclades.c) is interpreting it in the same way that I am,
> incrementing it when tty_buffer_request_room returns 0.


Has anyone had a chance to think about this anymore? We would really like 
the capability to recognize that data has been discarded, even if it is 
because no flow control is used and the user is ignoring the port. There 
are cases, such as with RS-485, where there is no real flow control 
mechanism is available, so we should not depend on flow-control as always 
being an option. As Corbin mentioned, there are some other drivers using 
buf_overrun (as opposed to overrun, which indicates FIFO overruns) for 
this purpose, but we don't know if this was the original intention of this 
field.

-Jason


