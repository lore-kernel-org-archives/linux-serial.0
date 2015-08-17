From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCHv4 2/4] serial: imx: add runtime pm support
Date: Mon, 17 Aug 2015 17:40:59 +0200
Message-ID: <2095117.mcCCLIRizo@amdc1976>
References: <1439613468-22366-1-git-send-email-edubezval@gmail.com>
 <1439613468-22366-3-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-reply-to: <1439613468-22366-3-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Linux PM <linux-pm@vger.kernel.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


Hi,

On Friday, August 14, 2015 09:37:46 PM Eduardo Valentin wrote:
> This change introduces the runtime pm support on imx serial
> driver. The objective is to be able to idle the uart
> port whenever it is not in use while still being able
> to wake it up when needed. The key changes in this patch are:
> 1. Move the clock handling to runtime pm. Both, ipg and per,
> are now handled in the suspend and resume callbacks. Only
> enabling and disabling the clocks are handled in runtime
> suspend and resume, so we are able to use runtime pm
> in IRQ context.
> 2. Clocks are prepared in probe and unprepared in remove,
> so we do not need to prepare (may sleep) in runtime pm.
> 3. We mark the device activity based on uart and console
> callbacks. Whenever the device is needed and we want to
> access registers, we runtime_pm_get and then mark its
> last usage when we are done. This is done also across
> IRQs and DMA callbacks.
> 4. We reuse the infrastructure in place for suspend and
> resume, so we do not need to redo wakeup configuration,
> or context save and restore.
> 
> After this change, the clocks are still sane, in the sense
> of having balanced clock prepare and enable.

The clock changes in this patch seem to make this driver
non-functional with CONFIG_PM=n.  Have you tested your
changes with CONFIG_PM=n?

Generally the driver should not depend on PM support to
enable its clocks.  We had this issue in few Exynos-specific
drivers not that long time ago..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

