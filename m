From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 4/6] ARM: dts: imx6q{dl}: fix the wrong RTS/CTS pad
 name
Date: Sat, 6 Jul 2013 13:08:05 +0800
Message-ID: <20130706050803.GC30164@S2101-09.ap.freescale.net>
References: <1373004752-21302-1-git-send-email-b32955@freescale.com>
 <1373004752-21302-5-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:54823
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751229Ab3GFFH0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 6 Jul 2013 01:07:26 -0400
Content-Disposition: inline
In-Reply-To: <1373004752-21302-5-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jul 05, 2013 at 02:12:30PM +0800, Huang Shijie wrote:
> There is something wrong with the RTS/CTS pads:
>   The RTS pad is assigned with the CTS's value;
>   while the CTS pad is assigned with the RTS's value.
> 

So basically, you are saying that select_input should be set up for CTS
rather than RTS.  It seems that the people who generated the macro got
the wrong input from developer.

So imx6sl-pinfunc.h also needs to be fixed up.

Shawn

> In order to fix it, this patch exchanges the RTS/CTS pad name.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/boot/dts/imx6dl-pinfunc.h |   88 ++++++++++++++++++------------------
>  arch/arm/boot/dts/imx6q-pinfunc.h  |   88 ++++++++++++++++++------------------
>  2 files changed, 88 insertions(+), 88 deletions(-)

