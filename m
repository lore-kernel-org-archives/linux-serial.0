From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: tty_flip_buffer() from atomic context when low_latency==1
Date: Fri, 19 Aug 2011 21:24:48 +0000 (UTC)
Message-ID: <j2mkav$bat$1@dough.gmane.org>
References: <j2med6$q2r$1@dough.gmane.org>
 <20110819212416.6f626852@lxorguk.ukuu.org.uk>
 <j2mhva$nmv$1@dough.gmane.org>
 <20110819220644.3166083d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:56023 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753973Ab1HSVZA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Aug 2011 17:25:00 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1QuWYl-0004jg-4V
	for linux-serial@vger.kernel.org; Fri, 19 Aug 2011 23:24:59 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 19 Aug 2011 23:24:59 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 19 Aug 2011 23:24:59 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2011-08-19, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Fri, 19 Aug 2011 20:44:26 +0000 (UTC)
> Grant Edwards <grant.b.edwards@gmail.com> wrote:
>
>> On 2011-08-19, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> 
>> >> But, many drivers appear to call tty_flip_buffer_push() from an atomic
>> >> context. If that is done with tty->low_latency==1 it turns into a call
>> >> to flush_to_ldisc(), which then calls disc->ops->receive_buf(), which
>> >> must not be called from an atomic context.
>> >
>> > It's covered under "So don't do that then".
>> 
>> I don't do that, and wasn't asking if I should.
>> 
>> My point was that most of the drivers in the linux kernels sources
>> _do_ appear to do that, and I don't see how they avoid problems.
>> 
>> For exaple, 8250.c calls tty_flip_buffer_push() from receive_chars(),
>> calld from serial8250_handle_port(), called from
>> serial8250_interrupt().
>> 
>> How are problems avoided when tty->low_latency is set?
>> 
>> Is tty->low_latency never allowed to be set for the 8250 driver?
>
> Several drivers certainly allow someone with superuser privileges to
> misconfigure them.

You don't need to be root to set the low_latency flag on a tty device.
Normal users are allowed to do that:

./linux/serial_core.h:361

#define UPF_USR_MASK  ((__force upf_t) (UPF_SPD_MASK|UPF_LOW_LATENCY))

> I've never worried about chasing all those down.

To me, it looks like anybody with permission for the serial port can
set the low latency flag and potentially cause a "scheduling while
atomic" crash.

I've gotten it to happen with other drivers that call
tty_flip_buffer_push() with tty->low_latency==1, but haven't been able
to make it happen with the 8250 driver -- I don't know why.  I've
verified that a normal user doing "setserial /dev/ttyS0 low_latency"
sets the low_latency flag, and it's 1 immediately before and after the
call to tty_flip_buffer_push().  Maybe I just haven't run it long
enough...

> It might actually be worth supporting a tty->low_latency mode which
> uses a tty layer private workqueue that is set to real time priority
> rather than the system work queue.

I don't understand why the low_latency flag even exists when setting
it apparently breaks most all of the serial drivers.

-- 
Grant Edwards               grant.b.edwards        Yow! You should all JUMP
                                  at               UP AND DOWN for TWO HOURS
                              gmail.com            while I decide on a NEW
                                                   CAREER!!

