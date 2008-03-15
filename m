From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
Date: Sat, 15 Mar 2008 11:38:51 +0000
Message-ID: <20080315113851.6f86acff@the-village.bc.nu>
References: <200803120221.25044.technoboy85@gmail.com>
	<200803130138.55582.technoboy85@gmail.com>
	<20080313084526.GA6012@alpha.franken.de>
	<200803141646.09645.technoboy85@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53278 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751750AbYCOMAh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 15 Mar 2008 08:00:37 -0400
In-Reply-To: <200803141646.09645.technoboy85@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matteo Croce <technoboy85@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>, Felix Fietkau <nbd@openwrt.org>, Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

> This is a bit better

NAK - especially as there has been a specific response about how to do
this without ifdef hacks in core code.

Alan
