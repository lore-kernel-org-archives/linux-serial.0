From: Komuro <komurojun-mbn@nifty.com>
Subject: Re: Re: Re: Re: Re: Re: [PATCH 11/18] pcmcia: do not use io_req_t when calling pcmcia_request_io()
Date: Sat, 18 Sep 2010 10:45:04 +0900 (JST)
Message-ID: <12823052.28741284774304299.komurojun-mbn@nifty.com>
References: <20100917185212.GA26258@comet.dominikbrodowski.net>
 <20100913195353.GA6999@comet.dominikbrodowski.net>
 <20100904174334.GA955@isilmar-3.linta.de>
 <20100904105415.GC16589@isilmar-3.linta.de>
 <20100830062724.GA2387@comet.dominikbrodowski.net>
 <13928942.191731283256326809.komurojun-mbn@nifty.com>
 <29547163.98341283601820252.komurojun-mbn@nifty.com>
 <8520532.194511283862270702.komurojun-mbn@nifty.com>
 <31800273.194401284728811871.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nfmsa303g.nifmail.jp ([210.131.2.172]:63609 "EHLO
	nfmsa303g.nifmail.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157Ab0IRBpW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Sep 2010 21:45:22 -0400
In-Reply-To: <20100917185212.GA26258@comet.dominikbrodowski.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org

Hi,

>Are these lines different from what you see on a working kernel?

dmesg is same between working kernel and 2.6.36-rc3.

but 2.6.36-rc3(+patch) , the serial part still does not work.


----- Original Message -----
>Date: Fri, 17 Sep 2010 20:52:12 +0200
>From: Dominik Brodowski <linux@dominikbrodowski.net>
>To: Komuro <komurojun-mbn@nifty.com>
>Cc: linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org
>Subject: Re: Re: Re: Re: Re: [PATCH 11/18] pcmcia: do not use io_req_t when
> calling pcmcia_request_io()
>
>
>Dear Komuro,
>
>On Fri, Sep 17, 2010 at 10:06:51PM +0900, Komuro wrote:
>> Xircom multi-function card still does not work.
>
>Huh, that is indeed surprising, as the dmesg has all the usual config
>descriptions:
>
>eth0: Xircom: port 0x300, irq 18, hwaddr 00:10:a4:f3:db:02
>...
>0.1: ttyS3 at I/O 0x2e8 (irq = 18) is a 16550A
>
>Are these lines different from what you see on a working kernel?
>
>Best,
>	Dominik

