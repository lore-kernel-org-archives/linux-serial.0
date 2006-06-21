From: Sergei Organov <osv@javad.com>
Subject: [Q] New tty flip interface doubt.
Date: Wed, 21 Jun 2006 16:16:33 +0400
Message-ID: <87hd2epuu6.fsf@javad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from javad.com ([216.122.176.236]:64272 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S1751404AbWFUMRG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Jun 2006 08:17:06 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: linux-serial@vger.kernel.org

Alan,

Could you please slightly clarify the intent and suggest the right way
to use the new interface routine tty_buffer_request_room() along with
tty_insert_flip_string() (see below)?

I'm looking into some drivers that use it and into your initial
description of the changes to the tty flip buffers, and I have a
doubt. Consider the code:

  tty_buffer_request_room(tty, urb->actual_length);
  tty_insert_flip_string(tty, data, urb->actual_length);
  tty_flip_buffer_push(tty);

For me it seems that in this case the call to tty_buffer_request_room()
is useless as the first thing tty_insert_flip_string() does is to call
tty_buffer_request_room() with exactly the same parameters anyway.

On the other hand, your explanations of the new interfaces talk about
tty_buffer_request_room() as something that lets kernel handle memory
better. I'm not sure I understand what it means in practice.

On yet another hand (or foot, should one has only two hands), some
drivers do call tty_buffer_request_room(), and others don't.

Yet another way of doing things I see in the kernel code is:

  int count = tty_buffer_request_room(tty, length);
  tty_insert_flip_string(tty, data, count);

this one is also doubtful as just calling

  tty_insert_flip_string(tty, data, length);

instead has slightly more chances to transfer 'length' chars as
tty_insert_flip_string(), unlike tty_buffer_request_room(), loops to
find the memory.

Overall, what's the canonical way to transfer 'length' chars from a
buffer 'buf' to the tty layer?

-- 
Sergei.
