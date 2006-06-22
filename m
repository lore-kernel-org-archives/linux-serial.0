From: Sergei Organov <osv@javad.com>
Subject: Re: [Q] New tty flip interface doubt.
Date: Thu, 22 Jun 2006 11:33:15 +0400
Message-ID: <87irmt63wk.fsf@javad.com>
References: <87hd2epuu6.fsf@javad.com>
	<20060621134208.GA12884@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from javad.com ([216.122.176.236]:6929 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S932825AbWFVHdd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Jun 2006 03:33:33 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: linux-serial@vger.kernel.org

Alan Cox <alan@redhat.com> writes:
> On Wed, Jun 21, 2006 at 04:16:33PM +0400, Sergei Organov wrote:
>>   tty_insert_flip_string(tty, data, length);
>> 
>> instead has slightly more chances to transfer 'length' chars as
>> tty_insert_flip_string(), unlike tty_buffer_request_room(), loops to
>> find the memory.
>> 
>> Overall, what's the canonical way to transfer 'length' chars from a
>> buffer 'buf' to the tty layer?
>
> tty_insert_flip_string called by itself will try to do the right thing. The
> tty_insert_flip_char interface can benefit a lot from you knowing the ideal
> buffer size to use so its very useful in the case of 
>
> 	int bytes = inw(port->fifo);
> 	int count = tty_buffer_request_room(tty, bytes);
>
> 	while(...) {
> 		tty_insert_flip_char ..
>
> It is also useful if you want a linear buffer for ease of copying.
>
> In the USB case it may be helpful as it will try and allocate blocks
> of memory reflecting the size of the blocks to be pushed to the user
> rather than guessing. As you suggest for most cases it probably makes
> no real difference

Thanks, -- that's the answer I've more or less expected.

One more question, if I get memory for N bytes with
tty_prepare_flip_string() then store M (M <= N) bytes into the buffer,
how do I tell tty layer that only M bytes are in fact stored?

[I'm thinking about eliminating buffers allocation for urbs as well as
data copy when transferring data from USB subsystem to flip buffers of
the tty subsystem. Currently the flow is:

- allocate data buffer for urb.
- submit the urb to USB subsystem.
- copy received data from the buffer to tty (possibly allocating more
  buffers in tty)
- deallocate the data buffer
- flip (possibly deallocating some buffers in tty)

and it seems that using tty buffers directly is a better idea:

- allocate N-bytes data buffer from tty and use it for urb
- submit the urb to USB subsystem
- flip M-bytes of data (M <= N) in USB receive callback.
]

-- 
Sergei.
