From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: About changing Line Discipline  from Kernel
Date: Wed, 22 Feb 2012 09:34:25 +0000
Message-ID: <20120222093425.2efcbca0@pyramind.ukuu.org.uk>
References: <4F4493AC.5010405@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:44186 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613Ab2BVJce (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Feb 2012 04:32:34 -0500
In-Reply-To: <4F4493AC.5010405@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mayank Rana <mrana@codeaurora.org>
Cc: linux-serial@vger.kernel.org

> 1. I understand that line discipline can be changed from user space 
> application by opening the device and doing ioctl with required Line 
> Discipline ID. Is it possible to do the same from kernel module who 
> would be communicating with that line discipline ?

Not currently. You need something to hold the tty open anyway if you do
this.

> 2. Is it way to set default line discipline for particular tty device
> to required Line Discipline instead of N_TTY one ?

No. All tty devices start in N_TTY and return to N_TTY when closed.
That's a design assumption in the ldisc handling and in in the tty setup
and teardown code paths.

There is no API/ABI reason for the assumption so if someone did the work
they could remove that assumption.

Alan
