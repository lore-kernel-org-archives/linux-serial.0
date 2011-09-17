From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: SERIAL_MRST_MAX3110 should depend on X86_MRST
Date: Sat, 17 Sep 2011 12:28:43 +0100
Message-ID: <20110917122843.38d7ba22@lxorguk.ukuu.org.uk>
References: <201109162240.16874.jdelvare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35585 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751260Ab1IQL3W (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 17 Sep 2011 07:29:22 -0400
In-Reply-To: <201109162240.16874.jdelvare@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

On Fri, 16 Sep 2011 22:40:16 +0200
Jean Delvare <jdelvare@suse.de> wrote:

> As I understand it, driver mrst_max3110 is only useful on Moorestown
> systems, so it should depend on X86_MRST.

Not so simple. There are various things that need dependancies. Some I've
sorted in my tree, some not, but it's all shelved until kernel.org is
back as I've switched to working on other projects for the moment rather
than waste time chasing trees around the internet.

> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Alan Cox <alan@linux.intel.com>
> ---
> There are a few other drivers in a similar situation
> (i2c/busses/i2c-intel-mid, gpio/langwell_gpio, tty/serial/mfd,
> staging/sep) for which I suspect the same should be done,
> assuming that X86_MRST is for both Moorestown and Medfield.

Not with the latest patches.

Alan
