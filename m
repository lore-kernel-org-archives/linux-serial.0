From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Re: Re: [PATCH 11/18] pcmcia: do not use io_req_t when calling
	pcmcia_request_io()
Date: Sat, 4 Sep 2010 19:43:34 +0200
Message-ID: <20100904174334.GA955@isilmar-3.linta.de>
References: <20100904105415.GC16589@isilmar-3.linta.de> <20100830062724.GA2387@comet.dominikbrodowski.net> <13928942.191731283256326809.komurojun-mbn@nifty.com> <29547163.98341283601820252.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from isilmar-3.linta.de ([188.40.101.200]:58006 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754366Ab0IDRni (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 4 Sep 2010 13:43:38 -0400
Content-Disposition: inline
In-Reply-To: <29547163.98341283601820252.komurojun-mbn@nifty.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Komuro <komurojun-mbn@nifty.com>
Cc: linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org

Hey,

On Sat, Sep 04, 2010 at 09:03:40PM +0900, Komuro wrote:
> >$ echo "module pcmcia +p" > /sys/kernel/debug/dynamic_debug/control
> >
> 
> Which kernel .config option do I need to enable dynamic_debug?

CONFIG_DYNAMIC_DEBUG=y

Then mount debugfs to /sys/kernel/debug, if it isn't done automatically
anyway.

> My kernel does not have
> /sys/kernel/debug/dynamic_debug/control.

Thanks!

	Dominik
