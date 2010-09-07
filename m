From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Re: Re: Re: [PATCH 11/18] pcmcia: do not use io_req_t when
 calling pcmcia_request_io()
Date: Tue, 7 Sep 2010 19:41:10 +0200
Message-ID: <20100907174110.GA20934@comet.dominikbrodowski.net>
References: <20100904174334.GA955@isilmar-3.linta.de>
 <20100904105415.GC16589@isilmar-3.linta.de>
 <20100830062724.GA2387@comet.dominikbrodowski.net>
 <13928942.191731283256326809.komurojun-mbn@nifty.com>
 <29547163.98341283601820252.komurojun-mbn@nifty.com>
 <8520532.194511283862270702.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from isilmar-3.linta.de ([188.40.101.200]:50468 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932099Ab0IGRmE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 Sep 2010 13:42:04 -0400
Content-Disposition: inline
In-Reply-To: <8520532.194511283862270702.komurojun-mbn@nifty.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Komuro <komurojun-mbn@nifty.com>
Cc: linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org

Dear Komuro,

On Tue, Sep 07, 2010 at 09:24:30PM +0900, Komuro wrote:
> Attached file is the output of /sys/kernel/debug/dynamic_debug/control.

Could you issue

$ echo "module pcmcia +p" > /sys/kernel/debug/dynamic_debug/control

and (re-)insert the card, and then send the dmesg (probably 

$ dmesg -s 200000

to me? Thanks!

Best,
	Dominik
