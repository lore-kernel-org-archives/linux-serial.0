From: Francesco Ruggeri <fruggeri@arista.com>
Subject: Re: [PATCH 1/1] tty: Fix pty master poll() after slave closes
Date: Thu, 9 Oct 2014 10:39:39 -0700
Message-ID: <CA+HUmGh_wVpVkvDuS-T8A+HdAC946XWuP7-CxrK+H+JEcJ2cyw@mail.gmail.com>
References: <20141008192746.5F9C8485A77@fruggeri-Arora18.sjc.aristanetworks.com>
	<5436B317.3060208@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:43046 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbaJIRjk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 9 Oct 2014 13:39:40 -0400
Received: by mail-oi0-f51.google.com with SMTP id h136so3760649oig.38
        for <linux-serial@vger.kernel.org>; Thu, 09 Oct 2014 10:39:39 -0700 (PDT)
In-Reply-To: <5436B317.3060208@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Francesco Ruggeri <fruggeri@aristanetworks.com>, jslaby@suse.cz, Greg Kroah-Hartmann <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Hi Peter,
thanks for your reply.

>>       poll_wait(file, &tty->read_wait, wait);
>>       poll_wait(file, &tty->write_wait, wait);
>> -     if (input_available_p(tty, 1))
>> -             mask |= POLLIN | POLLRDNORM;
>>       if (tty->packet && tty->link->ctrl_status)
>>               mask |= POLLPRI | POLLIN | POLLRDNORM;
>>       if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
>>               mask |= POLLHUP;
>>       if (tty_hung_up_p(file))
>>               mask |= POLLHUP;
>> +     if (mask & POLLHUP)
>> +             tty_flush_to_ldisc(tty);
>
> This isn't necessary for the tty_hung_up_p() case because, when the
> poll() is woken from hangup, the read buffer has already been flushed (ie.,
> cleared).
>
> Plus, this waits even if input_available_p() would already return true.
>

Let me work on a patch for stable along the lines you suggest.

Francesco
