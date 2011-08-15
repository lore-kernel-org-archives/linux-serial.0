From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/5] Remove UPIO_DWAPB{,32} from 8250 driver
Date: Mon, 15 Aug 2011 10:34:03 +0100
Message-ID: <20110815103403.7c9bb993@lxorguk.ukuu.org.uk>
References: <1313399875-11006-1-git-send-email-jamie@jamieiles.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39356 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753153Ab1HOJag (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Aug 2011 05:30:36 -0400
In-Reply-To: <1313399875-11006-1-git-send-email-jamie@jamieiles.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-serial@vger.kernel.org, arnd@arndb.de

On Mon, 15 Aug 2011 10:17:50 +0100
Jamie Iles <jamie@jamieiles.com> wrote:

> This is just a repost of a series from a couple of months ago to remove
> the special DWAPB 8250 handling from the generic driver.
> 
> Arnd, I'd have a platform that needs some special handlers like these
> using the device tree and of_serial.  Once these are merged I plan on
> passing the serial_{in,out} and handle_irq callbacks through
> platform_data to of_serial.  Does this seem sensible?

Acked-by: Alan Cox <alan@linux.intel.com>
