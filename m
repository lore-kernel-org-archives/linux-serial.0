From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: serial_cs bug (serial subsystem, not pcmcia subsystem)
Date: Sun, 19 Sep 2010 10:54:50 +0200
Message-ID: <20100919085450.GA24278@isilmar-3.linta.de>
References: <20100904105415.GC16589@isilmar-3.linta.de> <20100830062724.GA2387@comet.dominikbrodowski.net> <13928942.191731283256326809.komurojun-mbn@nifty.com> <29547163.98341283601820252.komurojun-mbn@nifty.com> <8520532.194511283862270702.komurojun-mbn@nifty.com> <31800273.194401284728811871.komurojun-mbn@nifty.com> <22642468.38071284778112791.komurojun-mbn@nifty.com> <6075501.91281284805231417.komurojun-mbn@nifty.com> <14067525.113201284814231692.komurojun-mbn@nifty.com> <32784617.54791284881963911.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from isilmar-3.linta.de ([188.40.101.200]:48903 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751654Ab0ISIyz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 19 Sep 2010 04:54:55 -0400
Content-Disposition: inline
In-Reply-To: <32784617.54791284881963911.komurojun-mbn@nifty.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Komuro <komurojun-mbn@nifty.com>, linux-serial@vger.kernel.org
Cc: linux-pcmcia@lists.infradead.org, pavel@ucw.cz

Hey,

On Sun, Sep 19, 2010 at 04:39:23PM +0900, Komuro wrote:
> Hi,
> 
> >	http://userweb.kernel.org/~brodo/pcmcia-2.6.35.diff
> 
> Serial part of Xircom card works with pcmcia-2.6.35.diff.

thanks for testing. This means that some non-PCMCIA change since 2.6.35
broke the serial part of Xircom cards -- using serial_cs... To the
linux-serial list: any idea of what might have changed? Pavel: any news from
your side?

Best,
	Dominik
