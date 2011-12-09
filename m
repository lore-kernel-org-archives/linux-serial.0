From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH RESEND 3/8] serial: 8250: save rs485_flags per instance
Date: Fri, 9 Dec 2011 19:10:32 +0000
Message-ID: <20111209191032.76bff8e8@pyramind.ukuu.org.uk>
References: <1323450440-414-1-git-send-email-w.sang@pengutronix.de>
	<1323450440-414-4-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36282 "EHLO
	pyramind.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752153Ab1LITKX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 9 Dec 2011 14:10:23 -0500
In-Reply-To: <1323450440-414-4-git-send-email-w.sang@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Claudio Scordino <claudio@evidence.eu.com>

On Fri,  9 Dec 2011 18:07:15 +0100
Wolfram Sang <w.sang@pengutronix.de> wrote:

> When set, save RS485 related flags in the private struct. This avoids
> mangling with chip registers when reading back the RS485 config. Also,
> features can check their configuration at runtime which will be needed
> for a later patch.

Ok thats what I get for reading in order - so the #2 problem is ok when
its folded together
