From: Komuro <komurojun-mbn@nifty.com>
Subject: [BUG]  [PATCH 11/18] pcmcia: do not use io_req_t when calling pcmcia_request_io()
Date: Sat, 28 Aug 2010 07:41:30 +0900 (JST)
Message-ID: <24146021.7121282948890588.komurojun-mbn@nifty.com>
References: <13709715.48251282365242982.komurojun-mbn@nifty.com>
 <3446357.27821282355344343.komurojun-mbn@nifty.com>
 <1281046014-7585-11-git-send-email-linux@dominikbrodowski.net>
	<20100805220511.GA7040@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nfmsa302g.nifmail.jp ([210.131.2.174]:39306 "EHLO
	nfmsa302g.nifmail.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753812Ab0H0WmR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Aug 2010 18:42:17 -0400
In-Reply-To: <13709715.48251282365242982.komurojun-mbn@nifty.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org


Hi,

Something is strange in pcmcia_request_configuration? at kernel 2.6.36-rc1?

serial part of multi-function card does not work at 2.6.36-rc1.


output of /proc/ioports

[2.6.36-rc1]
02e8-02ef : pcmcia_socket0
   02e8-02ef : pcmcia0.0
     02e8-02ef : serial
0300-030f : pcmcia_socket0
   0300-0008 : pcmcia0.0        <== Strange!!


[2.6.35]
02e8-02ef : pcmcia_socket0
    02e8-02ef : serial
0300-030f : pcmcia_socket0

