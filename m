From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] serial: Make wakeup_capable a flag to reduce boot
 time
Date: Tue, 17 Jan 2012 20:09:42 +0000
Message-ID: <20120117200942.7e7adf09@pyramind.ukuu.org.uk>
References: <1326826563-32215-1-git-send-email-sjg@chromium.org>
	<1326826563-32215-2-git-send-email-sjg@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:50844 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab2AQUIZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Jan 2012 15:08:25 -0500
In-Reply-To: <1326826563-32215-2-git-send-email-sjg@chromium.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Simon Glass <sjg@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org

On Tue, 17 Jan 2012 10:56:02 -0800
Simon Glass <sjg@chromium.org> wrote:

> The synchronize_rcu() call resulting from making every serial driver
> wake-up capable (commit b3b708fa) slows boot down by 600ms on my Tegra2x
> system (with CONFIG_PREEMPT disabled).
> 
> Waking up the machine from a serial port seems to be an unlikely
> requirement, so make serial_core default to not using the behaviour.

Its quite normal on x86, and very very common on embedded. Sorry someone
needs to fix the root cause not hack the driver.

The other question would be whether in PC space you can deduce the wake
up situation from ACPI data ? One for Len ?

Alan


