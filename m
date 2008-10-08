From: Grant Edwards <grante@visi.com>
Subject: Re: Help:Serial / Parallel Port Control Under Linux
Date: Wed, 8 Oct 2008 10:05:02 +0000 (UTC)
Message-ID: <gci0ke$a64$1@ger.gmane.org>
References: <709406A39EA948FCB5AE537FF0873FAD@johnny> <gc5a30$lup$1@ger.gmane.org> <4C87D88DE2D24B98846B72330EAE7229@johnny> <48E9D682.3030204@fela.ch> <C524BFB0588A46AFA3D2DCEF28D7FB4B@johnny>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:38425 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257AbYJHKFQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Oct 2008 06:05:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KnVup-00044h-S1
	for linux-serial@vger.kernel.org; Wed, 08 Oct 2008 10:05:12 +0000
Received: from 67-220-10-21.usiwireless.com ([67.220.10.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 08 Oct 2008 10:05:11 +0000
Received: from grante by 67-220-10-21.usiwireless.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 08 Oct 2008 10:05:11 +0000
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2008-10-08, johnny <johnny@pan-tone.com.sg> wrote:

> If I want to run this small program continuously and detect
> the changes of the input pins all the time, can I simply use
> an infinite loop to do that?

Yes.  Though you may want to sleep a little between polls to
allow other things to run.  Unfortunately, there are no "block
until modem status change" semantics in the Unix tty driver
(one of a number of useful things that the Unix tty driver is
missing).

> Does it anything wrong to the serial port?

No.

-- 
Grant


