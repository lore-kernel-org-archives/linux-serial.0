From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Newbie question: setting baudrate / managing FIFO.
Date: Fri, 18 Feb 2011 20:24:21 +0000 (UTC)
Message-ID: <ijmkhl$4r5$1@dough.gmane.org>
References: <AANLkTimdduXQaXJTuWPUKTFdQo9XOEYCkdNB_6RTVLFu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:41916 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732Ab1BRUYk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Feb 2011 15:24:40 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1PqWsY-0001n3-Ml
	for linux-serial@vger.kernel.org; Fri, 18 Feb 2011 21:24:38 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 18 Feb 2011 21:24:38 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 18 Feb 2011 21:24:38 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2011-02-16, Andrei Warkentin <andreiw@motorola.com> wrote:

> I looked about the archives, but maybe I skipped something... When I
> am handling set_termios, what assumptions can I make regarding the
> TX/RX state? I didn't take a look at all the serial drivers, but the
> ones I did look did not bother flushing FIFOs and ensuring nothing can
> be present in the TX FIFO while updating LCR and divisors. Should I do
> the equivalent of stop_tx inside set_termios? Is that already ensured?
> The hardware I am looking at needs to have FIFO cleared after setting
> baud rate, and I was getting concerned over potential data loss
> scenarios...

Somebody who changes baud rate while transmitting is going to lose
data no matter what you choose to do.

So, I wouldn't worry about it.  Change the baud rate when the ioctl()
tells you to, and if you have to clear the FIFO as part of that
operation then do so.

-- 
Grant Edwards               grant.b.edwards        Yow! I just went below the
                                  at               poverty line!
                              gmail.com            

