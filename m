From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: xuartps: Fix build when SYSRQ is disabled
Date: Tue, 17 Dec 2013 15:47:44 -0800
Message-ID: <20131217234744.GB21329@kroah.com>
References: <1387322858-5111-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:56365 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab3LQXrn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Dec 2013 18:47:43 -0500
Content-Disposition: inline
In-Reply-To: <1387322858-5111-1-git-send-email-broonie@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Soren Brinkmann <soren.brinkmann@xilinx.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

On Tue, Dec 17, 2013 at 11:27:38PM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> The sysrq field in struct uart_port is only defined when
> SERIAL_CORE_CONSOLE or SUPPORT_SYSRQ are selected but the driver uses
> the field unconditionally, causing build failures if they aren't (as
> happens when doing an arm64 allmodconfig).  Make the usage conditional
> as well.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 2 ++
>  1 file changed, 2 insertions(+)

Is this a 3.13-final fix, or can it wait for 3.14?

thanks,

greg k-h
