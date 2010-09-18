From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Re: Re: Re: Re: Re: [PATCH 11/18] pcmcia: do not use io_req_t
 when calling pcmcia_request_io()
Date: Sat, 18 Sep 2010 11:58:03 +0200
Message-ID: <20100918095803.GA6415@comet.dominikbrodowski.net>
References: <20100917185212.GA26258@comet.dominikbrodowski.net>
 <20100913195353.GA6999@comet.dominikbrodowski.net>
 <20100904174334.GA955@isilmar-3.linta.de>
 <20100904105415.GC16589@isilmar-3.linta.de>
 <20100830062724.GA2387@comet.dominikbrodowski.net>
 <13928942.191731283256326809.komurojun-mbn@nifty.com>
 <29547163.98341283601820252.komurojun-mbn@nifty.com>
 <8520532.194511283862270702.komurojun-mbn@nifty.com>
 <31800273.194401284728811871.komurojun-mbn@nifty.com>
 <12823052.28741284774304299.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from isilmar-3.linta.de ([188.40.101.200]:53473 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755458Ab0IRJ6O (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 18 Sep 2010 05:58:14 -0400
Content-Disposition: inline
In-Reply-To: <12823052.28741284774304299.komurojun-mbn@nifty.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Komuro <komurojun-mbn@nifty.com>
Cc: linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org

Hey,

with 2.6.36-rc4+ (as of today), I see a (similar?) issue: When inserting
a multifunction card after reboot for the first time, the serial part does
not work. After re-inserting the card, it works. Re-loading the PCMCIA
modules does not make the bug re-appear, so I presume the issue to be
related to the serial layer. Could you verify whether it also works on
2.6.36-rc4+ for you, at least if you re-insert the card?

Will try to investigate further as to the cause(s) of this bug.

Best,
	Dominik
