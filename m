From: Benjamin Krill <ben@codiert.org>
Subject: Re: [PATCH] Add support for the nwp serial device
Date: Fri, 21 Nov 2008 08:21:02 +0100
Message-ID: <20081121072101.GP24487@codiert.org>
References: <200811201501.24000.arnd@arndb.de> <20081121003545.GC13049@yookeroo.seuss>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cursor.subgra.de ([78.46.252.50]:48001 "EHLO cursor.subgra.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbYKUHVI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Nov 2008 02:21:08 -0500
Content-Disposition: inline
In-Reply-To: <20081121003545.GC13049@yookeroo.seuss>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org, linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>

* David Gibson | 2008-11-21 11:35:45 [+1100]:

>
>Uh.. registers as port number 84??  What's this random number about?
>
It's just the next free number in serial_core.h.

 Ben
