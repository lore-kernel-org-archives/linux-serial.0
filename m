From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 2/4] serial: mxs-auart: use mctrl_gpio helpers for handling modem signals
Date: Fri, 7 Nov 2014 09:03:11 +0100
Message-ID: <201411070903.11645.marex@denx.de>
References: <1412960007-28159-1-git-send-email-j.uzycki@elproma.com.pl> <545B57D7.4070609@elproma.com.pl> <CAMiH66FKJm8hcgtR=-ZzzpCq+PQ8xkixbUnMzRPVd_cM_6VM1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:50142 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaKGIDS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Nov 2014 03:03:18 -0500
In-Reply-To: <CAMiH66FKJm8hcgtR=-ZzzpCq+PQ8xkixbUnMzRPVd_cM_6VM1w@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <shijie8@gmail.com>
Cc: Janusz =?utf-8?q?U=C5=BCycki?= <j.uzycki@elproma.com.pl>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, Fabio Estevam <festevam@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Friday, November 07, 2014 at 02:34:31 AM, Huang Shijie wrote:
> why change them to gpio?  If we change them to gpio.  Could the DMA still
> works fine?
> did you test the DMA with this patch?
> 
> Add Marek for this patch too.

I didn't look too deep into the patch, so here's just my experience:

1) The AUART block signals and GPIO block signals are not sychronised using the 
   same clock. Therefore, the latency between toggling of the AUART lines and
   the GPIO-driven pins will not be deterministic and will vary. There might be
   a way to approximate that, but that's definitelly not a reliable solution.

   This is very bad for example if you drive RS485 DIR line with the RTS pin as
   a GPIO ; the RTS pin will toggle at non-deterministic time compared to the
   end of UART transmission. This will trigger bit-loss on the RS485 line and
   you just don't want that.

2) Speaking of RS485, there's [1] and [2]. which I believe apply to any combo
   of UART+GPIO toggling.

So I hate to bring the bad news , but UART+GPIO combo toggling is really a bad
bad idea.

HTH

[1] http://comments.gmane.org/gmane.linux.serial/6770
[2] http://article.gmane.org/gmane.linux.serial/3619/

Best regards,
Marek Vasut
