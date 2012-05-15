From: Corbin <corbinat@gmail.com>
Subject: Re: [PATCH 1/1] serial_core: Update buffer overrun statistics.
Date: Tue, 15 May 2012 13:41:44 -0500
Message-ID: <CAA0x6_9dTE6zFaJOAqsrj2OcehARKG9KgicQPdf1yv2RjDbZwA@mail.gmail.com>
References: <1336152910-5276-1-git-send-email-corbin.atkinson@ni.com>
 <20120515165339.6b142cd2@pyramind.ukuu.org.uk> <20120515155833.GA24878@kroah.com>
 <CAA0x6_-6tAHspcjFmD9Gz7NV4dUwP6St-UtivXTTQiANfBcX7A@mail.gmail.com> <20120515172710.0d0ce47b@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:63334 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419Ab2EOSmF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 May 2012 14:42:05 -0400
Received: by vbbff1 with SMTP id ff1so6343071vbb.19
        for <linux-serial@vger.kernel.org>; Tue, 15 May 2012 11:42:04 -0700 (PDT)
In-Reply-To: <20120515172710.0d0ce47b@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, Corbin Atkinson <corbin.atkinson@ni.com>

Maybe I don't have a complete understanding of what is happening, but
it appears that the software buffer is actually artificially limited
to 65536 bytes in the tty_buffer_alloc function in tty_buffer.c. I
wrote a quick application to test this. The test opens two 8250 ports
on my computer and sends 69632 (68Kib) of data from one port to the
other. After the write, the test performs a read from the other port,
which only receives 69376 bytes. I believe the extra space over 64KiB
is coming from the line discipline (n_tty.c), but the test still shows
data being lost. Neither the overrun or buf_overrun field in the
port's icount structure were incremented during the test.

Here is the section of code I'm referencing from tty_buffer.c. This
code was pulled from linux-next.
static struct tty_buffer *tty_buffer_alloc(struct tty_struct *tty, size_t size)
{
	struct tty_buffer *p;

	if (tty->buf.memory_used + size > 65536)
		return NULL;
	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
	if (p == NULL)
		return NULL;
	p->used = 0;
	p->size = size;
	p->next = NULL;
	p->commit = 0;
	p->read = 0;
	p->char_buf_ptr = (char *)(p->data);
	p->flag_buf_ptr = (unsigned char *)p->char_buf_ptr + size;
	tty->buf.memory_used += size;
	return p;
}

Corbin


On Tue, May 15, 2012 at 11:27 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Tue, 15 May 2012 11:20:19 -0500
> Corbin <corbinat@gmail.com> wrote:
>
>> I agree that losing bytes in the software layer wouldn't happen under
>> normal circumstances, but it is still important to know when it
>> happens. My understanding was that the overrun field in the port's
>> icount was for logging hardware overruns, while the buf_overrun field
>> should be used for software overruns. If this is not the case then is
>> there another method for determining when the software layer is losing
>> bytes?
>
> It'll occur when the machine cannot even allocate a free page of memory.
> So you'll get GFP spews in the kernel log to go with it.
>
> Alan
