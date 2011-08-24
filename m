From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] serial/imx: support to handle break character
Date: Wed, 24 Aug 2011 16:50:48 +0100
Message-ID: <20110824165048.07721783@bob.linux.org.uk>
References: <1314178907-20074-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:36614 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172Ab1HXPpv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Aug 2011 11:45:51 -0400
In-Reply-To: <1314178907-20074-1-git-send-email-jason77.wang@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Hui Wang <jason77.wang@gmail.com>
Cc: gregkh@suse.de, s.hauer@pengutronix.de, linux-serial@vger.kernel.org

On Wed, 24 Aug 2011 17:41:47 +0800
Hui Wang <jason77.wang@gmail.com> wrote:

> The imx UART hardware controller can identify BREAK character and the
> imx_set_termios() can accept BRKINT set by users, but current existing
> imx_rxint() can't pass BREAK character and TTY_BREAK to the tty layer
> as other serial drivers do (8250.c omap_serial.c).
> 
> Here add code to handle BREAK character and pass it to tty layer.
> 
> To detect error occurrence, i use URXD_ERR to replace (URXD_OVRRUN |
> URXD_FRMERR | ...) because any kind of error occurs, URXD_ERR will
> always be set to 1.
> 
> I put the URXD_BRK to the first place to check since when BREAK error
> occurs, not only URXD_BRK is set to 1, but also URXD_PRERR and
> URXD_FRMERR are all set to 1. This arrangement can filter out fake
> parity and frame errors when BREAK error occurs.
> 
> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Alan Cox <alan@linux.intel.com>

