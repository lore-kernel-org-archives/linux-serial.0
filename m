From: Grant Edwards <grante@visi.com>
Subject: Re: Interface for setting half-duplex transmitter mode
Date: Wed, 6 Aug 2008 21:38:02 +0000 (UTC)
Message-ID: <g7d5jq$jtt$1@ger.gmane.org>
References: <20080806192519.GB21558@fan.ossfans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:52045 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202AbYHFViV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Aug 2008 17:38:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KQqhz-0002z8-Ga
	for linux-serial@vger.kernel.org; Wed, 06 Aug 2008 21:38:15 +0000
Received: from c-76-17-159-23.hsd1.mn.comcast.net ([76.17.159.23])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 06 Aug 2008 21:38:15 +0000
Received: from grante by c-76-17-159-23.hsd1.mn.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 06 Aug 2008 21:38:15 +0000
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2008-08-06, Sergey Lapin <slapin@ossfans.org> wrote:

> Is there any interface API for userspace, which I could use to
> set RS-485 mode on UART (which suports it via hardware, by
> setting 1 bit in configuration), which means half-duplex mode
> with RTS line toggling. Now I have it hard-coded for
> appropriate UART, and seen patch which sets this from platform
> data, but is there some API to do it dynamically?

You do realize that there is currently an actyive thread
discussing this, right?

> I know I could implement this by ioctl mechanism, but I need
> some non-standard ioctl number for that. Is there some sane
> way to accomplish my goals? I mean one which be accepted to
> mainline?

You should read the thread where this is being discussed, but
the short answer is that no, there is no standard way to do
this.

-- 
Grant Edwards                   grante             Yow! I have a VISION!  It's
                                  at               a RANCID double-FISHWICH on
                               visi.com            an ENRICHED BUN!!

