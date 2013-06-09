From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2] serial: imx: enable the clocks for console
Date: Sun, 9 Jun 2013 16:34:11 +0800
Message-ID: <20130609083409.GA32485@S2101-09.ap.freescale.net>
References: <CAOMZO5A4SPFv1NopdGrN9nX-XSpZy5Cw1CLp3E95mRP8O=rhLQ@mail.gmail.com>
 <1370743279-15941-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:47129
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752645Ab3FIId6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 9 Jun 2013 04:33:58 -0400
Content-Disposition: inline
In-Reply-To: <1370743279-15941-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, festevam@gmail.com, shc_work@mail.ru

On Sun, Jun 09, 2013 at 10:01:19AM +0800, Huang Shijie wrote:
> The console's clocks are disabled after the uart driver is probed.
> It makes that we can see less log from the console now
> (though we still can get all the log by the `dmesg`).
> 
> So enable the clocks for console, and we can see all the log again.
> 
> This patch also disables the sport->clk_per when we fail to enable
> the sport->clk_ipg;
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Tested-by: Shawn Guo <shawn.guo@linaro.org>

