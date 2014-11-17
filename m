From: Loic Poulain <loic.poulain@intel.com>
Subject: Re: [PATCH] serial: 8250_dw: Handle no_console_suspend when uart
 loses state
Date: Mon, 17 Nov 2014 09:56:08 +0100
Message-ID: <5469B828.90401@intel.com>
References: <1416011556-23422-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53677 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625AbaKQIx2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Nov 2014 03:53:28 -0500
In-Reply-To: <1416011556-23422-1-git-send-email-dianders@chromium.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heiko Stuebner <heiko@sntech.de>, Jiri Slaby <jslaby@suse.cz>, Chris Zhong <zyw@rock-chips.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Andrew Bresticker <abrestic@chromium.org>, mika.westerberg@linux.intel.com, heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com, wens@csie.org, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> In certain suspend modes on certain boards the 8250 UART may lose
> state when the device goes to suspend.  If we're using
> no_console_suspend this can cause lots of problems during resume.
>
> Let's cache the basic UART config registers at suspend time and if we
> notice that the UART loses state (by looking at a canary stored in the
> scratch register) we'll restore it.

If I'm not wrong, it's already done in acpi_lpss suspend/resume (for 
8250_dw).
Commit c78b0830667a7e7c1f0ca65b76b33166a84806b3.

Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/
