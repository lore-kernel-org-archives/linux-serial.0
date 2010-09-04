From: Komuro <komurojun-mbn@nifty.com>
Subject: Re: Re: Re: [PATCH 11/18] pcmcia: do not use io_req_t when calling pcmcia_request_io()
Date: Sat, 4 Sep 2010 21:03:40 +0900 (JST)
Message-ID: <29547163.98341283601820252.komurojun-mbn@nifty.com>
References: <20100904105415.GC16589@isilmar-3.linta.de>
 <20100830062724.GA2387@comet.dominikbrodowski.net> <13928942.191731283256326809.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nfmsa302g.nifmail.jp ([210.131.2.174]:16221 "EHLO
	nfmsa302g.nifmail.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab0IDMEQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 4 Sep 2010 08:04:16 -0400
In-Reply-To: <20100904105415.GC16589@isilmar-3.linta.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org

Hi,

>
>$ echo "module pcmcia +p" > /sys/kernel/debug/dynamic_debug/control
>

Which kernel .config option do I need to enable dynamic_debug?

My kernel does not have
/sys/kernel/debug/dynamic_debug/control.


