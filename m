From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH RESEND 1/8] serial: 8250: replace hardcoded 0xbf with
 #define
Date: Fri, 9 Dec 2011 18:58:18 +0000
Message-ID: <20111209185818.589039f9@pyramind.ukuu.org.uk>
References: <1323450440-414-1-git-send-email-w.sang@pengutronix.de>
	<1323450440-414-2-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36264 "EHLO
	pyramind.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752518Ab1LIS5o (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 9 Dec 2011 13:57:44 -0500
In-Reply-To: <1323450440-414-2-git-send-email-w.sang@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Claudio Scordino <claudio@evidence.eu.com>

On Fri,  9 Dec 2011 18:07:13 +0100
Wolfram Sang <w.sang@pengutronix.de> wrote:

> Makes it easier to find all occurences requesting CONF_MODE_B.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Acked-by: Alan Cox <alan@linux.intel.com>

That should go in anyway
