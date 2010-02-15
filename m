From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH  00/12] Serial : sc26xx - generalize and support SC2892
Date: Mon, 15 Feb 2010 18:09:58 +0100
Message-ID: <20100215170958.GA13994@alpha.franken.de>
References: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from elvis.franken.de ([193.175.24.41]:41983 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756287Ab0BOUFk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Feb 2010 15:05:40 -0500
Content-Disposition: inline
In-Reply-To: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Martin Fuzzey <mfuzzey@gmail.com>
Cc: linux-serial@vger.kernel.org

On Sat, Feb 13, 2010 at 05:09:48PM +0100, Martin Fuzzey wrote:
> The driver should probably be renamed (sc2xxx ??) but what about the device
> name? Changing it could break existing userspace apps.

there shouldn't be many users of this driver, it's probably just me...
So changing names is ok for me.

> Unfortunately not having SC2692 hardware I haven't been able
> to regression test this.

I'm fine with pushing your changes, if there are regression for
RM system I'll take care later.

Just add my Acked-By: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
to your patches.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
