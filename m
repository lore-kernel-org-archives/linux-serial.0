From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Re: Re: Re: Re: [PATCH 11/18] pcmcia: do not use io_req_t when
 calling pcmcia_request_io()
Date: Fri, 17 Sep 2010 20:52:12 +0200
Message-ID: <20100917185212.GA26258@comet.dominikbrodowski.net>
References: <20100913195353.GA6999@comet.dominikbrodowski.net>
 <20100904174334.GA955@isilmar-3.linta.de>
 <20100904105415.GC16589@isilmar-3.linta.de>
 <20100830062724.GA2387@comet.dominikbrodowski.net>
 <13928942.191731283256326809.komurojun-mbn@nifty.com>
 <29547163.98341283601820252.komurojun-mbn@nifty.com>
 <8520532.194511283862270702.komurojun-mbn@nifty.com>
 <31800273.194401284728811871.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from isilmar-3.linta.de ([188.40.101.200]:40420 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754475Ab0IQSxY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Sep 2010 14:53:24 -0400
Content-Disposition: inline
In-Reply-To: <31800273.194401284728811871.komurojun-mbn@nifty.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Komuro <komurojun-mbn@nifty.com>
Cc: linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org

Dear Komuro,

On Fri, Sep 17, 2010 at 10:06:51PM +0900, Komuro wrote:
> Xircom multi-function card still does not work.

Huh, that is indeed surprising, as the dmesg has all the usual config
descriptions:

eth0: Xircom: port 0x300, irq 18, hwaddr 00:10:a4:f3:db:02
...
0.1: ttyS3 at I/O 0x2e8 (irq = 18) is a 16550A

Are these lines different from what you see on a working kernel?

Best,
	Dominik
