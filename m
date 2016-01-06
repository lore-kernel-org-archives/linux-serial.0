From: Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: [PATCH 1/2] [v2] tty: amba-pl011: fix earlycon register offsets
Date: Tue, 5 Jan 2016 18:43:38 -0800
Message-ID: <20160106024338.GA20633@kroah.com>
References: <1451943462-27818-1-git-send-email-timur@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1451943462-27818-1-git-send-email-timur@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, andre.przywara@arm.com, Linus Walleij <linus.walleij@linaro.org>, jslaby@suse.com, jun.nie@linaro.org, shijie.huang@arm.com, peter@hurleysoftware.com, andrew.jackson@arm.com, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 04, 2016 at 03:37:41PM -0600, Timur Tabi wrote:
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> The REG_x macros are indices into a table, not register offsets.  Since earlycon
> does not have access to the vendor data, we can currently only support standard
> ARM PL011 devices.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Tested-by: Huang Shijie <shijie.huang@arm.com>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---
>  drivers/tty/serial/amba-pl011.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

What changed in v2?

thanks,

greg k-h
