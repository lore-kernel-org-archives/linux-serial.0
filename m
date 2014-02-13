From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Is tty->receive_room no longer usable w/ SMP?
Date: Thu, 13 Feb 2014 02:27:38 +0000 (UTC)
Message-ID: <ldhaiq$jg$1@ger.gmane.org>
References: <ldgte5$kp1$1@ger.gmane.org> <52FC1A14.5080004@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:41765 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbaBMC2E (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Feb 2014 21:28:04 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1WDm1x-00011b-PM
	for linux-serial@vger.kernel.org; Thu, 13 Feb 2014 03:28:01 +0100
Received: from c-24-118-110-103.hsd1.mn.comcast.net ([24.118.110.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 13 Feb 2014 03:28:01 +0100
Received: from grant.b.edwards by c-24-118-110-103.hsd1.mn.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 13 Feb 2014 03:28:01 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2014-02-13, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 02/12/2014 05:43 PM, Grant Edwards wrote:
>> A couple serial drivers I maintain check the value of tty->receive_room
>> to decide the max number of bytes to pull out of the UART's receive
>> FIFO and shove into a flip buffer.
>
> tty->receive_room is not part of the driver<->tty core interface.

OK, fair enough.  Where is the driver<->tty core interface documented?

>> After checking tty->receive room to decide how many bytes to read, one
>> of the drivers uses this sequence:
>>
>>   tty_prepare_flip_string_flags(...)
>        ^^^^^^^^^^^^
> This was removed for 3.14.

Why? 

What is the replacement?

> The use of tty->receive_room by drivers is not supported on any
> kernel.

Got it.

>> How _should_ a serial driver decide how many rx characters there are
>> room for?
>
> All of the flip buffer functions that reserve/use buffer space return
> the space reserved/consumed. Is rx overflowing the flip buffers
> before you can throttle the sender?

Well, it certainly didn't when I used tty->receive_room to decide how
much data to read from the UART's rx FIFO. :)

I _was_ planning on removing the code that checks tty->receive_room
and instead rely instead on the return value from
tty_prepare_flip_string_flags().  But, as you noted, that's gone now.

Is there any documentation explaining how one is supposed to handle rx
data in a serial driver?  The topic doesn't seem to be mentioned at
all in Documentation/serial/driver.

If you can assume all rx data is TTY_NORMAL, then it looks like this
is the right way to do it:

  n = tty_prepare_flip_string()
  <copy n data bytes>  
  tty_flip_buffer_push()
    
What do you do if you can't assume all rx data is going to have a flag
value of TTY_NORMAL?

According to the comments in tty_buffer.c you can't use
tty_buffer_space_avail(), instead you're supposed to use
tty_prepare_flip_string(), but you can't use that unless you can
assume all rx data will be TTY_NORMAL.

Now that tty_prepare_flip_string_flags() is gone, it looks like
tty_insert_flip_string_flags() is the only option for transferring 
blocks of data/flags.  For that you need to know ahead of time how
many bytes can be guaranteed to be transferred because once you've
read data from the UART's rx FIFO it's lost if it can't be
transferred.

AFAICT, tty_buffer_request_room() can't be used in the case where you
you're passing a flags buffer: it can only be used to request a buffer
where all data will be TTY_NORMAL.

I've tried transferring one byte/flag pair at a time, but there are
two problems with that approach:

  1) You still need to know ahead of time how many bytes you can read
     from the UART's rx FIFO.

  2) All those calls with a large number of of ports running at high
     baud rates sucks up a _lot_ of CPU time.
     
-- 
Grant



