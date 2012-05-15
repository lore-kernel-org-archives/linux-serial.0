From: Corbin <corbinat@gmail.com>
Subject: Re: [PATCH 1/1] serial_core: Update buffer overrun statistics.
Date: Tue, 15 May 2012 17:46:32 -0500
Message-ID: <CAA0x6_8mPs_JLxnjrzNYc4qej-c0kkhbVyuJPsaPg8xBvmThqQ@mail.gmail.com>
References: <1336152910-5276-1-git-send-email-corbin.atkinson@ni.com>
 <20120515165339.6b142cd2@pyramind.ukuu.org.uk> <20120515155833.GA24878@kroah.com>
 <CAA0x6_-6tAHspcjFmD9Gz7NV4dUwP6St-UtivXTTQiANfBcX7A@mail.gmail.com>
 <20120515172710.0d0ce47b@pyramind.ukuu.org.uk> <CAA0x6_9dTE6zFaJOAqsrj2OcehARKG9KgicQPdf1yv2RjDbZwA@mail.gmail.com>
 <20120515220831.11f04213@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:36136 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966392Ab2EOWqx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 May 2012 18:46:53 -0400
Received: by vbbff1 with SMTP id ff1so127607vbb.19
        for <linux-serial@vger.kernel.org>; Tue, 15 May 2012 15:46:52 -0700 (PDT)
In-Reply-To: <20120515220831.11f04213@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Corbin Atkinson <corbin.atkinson@ni.com>

On Tue, May 15, 2012 at 4:08 PM, Alan Cox <alan@linux.intel.com> wrote:
>> it appears that the software buffer is actually artificially limited
>> to 65536 bytes in the tty_buffer_alloc function in tty_buffer.c. I
>
> Yes although you shouldn't be able to hit this with flow control
> enabled. Without flow control we didn't overrun at that level.
>
> it's really a semantics question - do we count stuff dumped
> intentionally without flow control as an overrun.
>
> I'm not fundamentally opposed to the idea but it is a change of meaning.
>
> Other views ?
>
> Alan

While I agree on normal use cases this won't be hit due to flow
control, I think it is still important to somehow know data was lost
in the case where flow control isn't used. Calling it a buffer overrun
was the way I thought was most fitting. I'm not sure what the
alternatives would be.

On a side note, If this isn't considered a buffer overrun I'm also not
too sure what the buf_overrun field of the port's icount struct is
for. While the "overrun" field is incremented in most drivers to
indicate a hardware overrun, the "buf_overrun" field isn't really
used. It appears that at least one of the few drivers using
buf_overrun (cyclades.c) is interpreting it in the same way that I am,
incrementing it when tty_buffer_request_room returns 0.

Thanks again,

Corbin
