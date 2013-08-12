From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Buffer overflow concerns when TTY_THRESHOLD_THROTTLE <= Uart
 FIFO size of the sending side
Date: Mon, 12 Aug 2013 07:30:01 -0400
Message-ID: <5208C739.1020801@hurleysoftware.com>
References: <CAES2cWzqgKmCT7Uy-4dqrgNeq1W0LeBH5A=y7D+OX8cnBuM-rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:41698 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752123Ab3HLLaE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Aug 2013 07:30:04 -0400
In-Reply-To: <CAES2cWzqgKmCT7Uy-4dqrgNeq1W0LeBH5A=y7D+OX8cnBuM-rw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Karthik Manamcheri <karthik.manamcheri@gmail.com>
Cc: linux-serial@vger.kernel.org

On 08/09/2013 05:08 PM, Karthik Manamcheri wrote:
> When using software-level RTS/CTS flow control (or Xon/Xoff), we could
> leak at most the UART FIFO size of bytes after getting the flow
> control signal. This is because the bytes might be loaded in the FIFO
> when the flow control signal comes through and the UART will send them
> out the wire.
>
> Consider a case where I have a UART with a 128 byte FIFO. The
> TTY_THRESHOLD_THROTTLE is set at 128 bytes in n_tty.c. So, isn't it
> possible that potentially we lose bytes when moving data to the TTY
> line discipline buffer? If the line discipline buffer is almost full
> (say the receiving room is 120 bytes), it calls throttle and even if
> the other end gets the throttle in time, it could potentially send 128
> bytes (but there is only 120 bytes of space in the buffer). So when we
> are flushing to ldisc, we will transfer only the receive_room amount
> of data and discard the rest? Is there any way of avoiding this?

Up to 64Kb of received data is buffered, so even if there is significant
delay throttling the sender, an overflow should not occur unless the bit
rate is in excess of 20Mbits/sec or so.

The receive buffer code is in drivers/tty/tty_buffer.c
The commonly used driver-side interface is tty_insert_flip_string() and
tty_flip_buffer_push(). flush_to_ldisc() is the work thread routine
which pushes this received data to the line discipline.

As far as I'm aware, only the synclink* drivers use the line discipline
interface directly (rather than the tty buffer interface) but perform
their own rx buffering.

Regards,
Peter Hurley
