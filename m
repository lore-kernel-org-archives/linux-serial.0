From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Is tty->receive_room no longer usable w/ SMP?
Date: Wed, 12 Feb 2014 20:04:20 -0500
Message-ID: <52FC1A14.5080004@hurleysoftware.com>
References: <ldgte5$kp1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:50489 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751076AbaBMBEW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Feb 2014 20:04:22 -0500
In-Reply-To: <ldgte5$kp1$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>, linux-serial@vger.kernel.org

On 02/12/2014 05:43 PM, Grant Edwards wrote:
> A couple serial drivers I maintain check the value of tty->receive_room
> to decide the max number of bytes to pull out of the UART's receive
> FIFO and shove into a flip buffer.

tty->receive_room is not part of the driver<->tty core interface.

> After checking tty->receive room to decide how many bytes to read, one
> of the drivers uses this sequence:
>
>   tty_prepare_flip_string_flags(...)
       ^^^^^^^^^^^^
This was removed for 3.14.

>   <fill up char buffer and flag buffer>
>   tty_flip_buffer_push(...)
>
> The other uses
>
>   for (i=0; i<count; ++i)
>     uart_insert_char(...);
>   tty_flip_buffer_push(...);
>
> But, starting with kernel 3.12.0, whenSMP is enabled, tty->receive_room
> is always 0 and never changes.  With SMP disabled, it seems to work the
> way it always has.

Starting with 3.12, receive_room is only used for line disciplines that
don't use flow control between the tty core and the line discipline
receive_buf (only N_TTY uses flow control).

This is because the N_TTY flow-controlled interface is lockless and
tty->receive_room is not supportable locklessly.

> Is use of tty->receive room no longer supported for SMP kernels?

The use of tty->receive_room by drivers is not supported on any kernel.

> How _should_ a serial driver decide how many rx characters there are
> room for?

All of the flip buffer functions that reserve/use buffer space return
the space reserved/consumed. Is rx overflowing the flip buffers before
you can throttle the sender?

Regards,
Peter Hurley

