From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty/n_gsm: fix bug in tiocmset
Date: Fri, 23 Sep 2011 11:05:20 +0100
Message-ID: <20110923110520.1119aeb9@lxorguk.ukuu.org.uk>
References: <CAJnFFh3XRFEC49yFvjstreqqkeraA9GA1_AL-s9rj87HksdgBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55497 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752053Ab1IWKGu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 Sep 2011 06:06:50 -0400
In-Reply-To: <CAJnFFh3XRFEC49yFvjstreqqkeraA9GA1_AL-s9rj87HksdgBg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Nikola Diklic-Perin <diklic.perin.nikola@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, greg@kroah.com

On Fri, 23 Sep 2011 10:59:43 +0200
Nikola Diklic-Perin <diklic.perin.nikola@gmail.com> wrote:

> From: Nikola Diklic-Perin <diklic.perin.nikola@gmail.com>
> 
> Clear bitmask was not inverted before masking modem_tx.
> 
> Calling ioctl(fd, TIOCMBIC, TIOCM_RTS) results in:
> 
> [  197.430000] pre_modem_tx:	0x00000006
> [  197.430000] clear:			0x00000004
> [  197.430000] set:			0x00000000
> [  197.440000] post_modem_tx:	0x00000004
> 
> which is wrong.
> 
> Signed-off-by: Nikola Diklic-Perin <diklic.perin.nikola@gmail.com>

Acked-by: Alan Cox <alan@linx.intel.com>
