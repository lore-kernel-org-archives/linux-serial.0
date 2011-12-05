From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: bfin-uart: Request CTS GPIO PIN when the serial
 device starts up.
Date: Mon, 5 Dec 2011 11:32:38 +0000
Message-ID: <20111205113238.2e059f03@lxorguk.ukuu.org.uk>
References: <1323069170-5881-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46617 "EHLO
	earthlight.etchedpixels.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755912Ab1LELbi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Dec 2011 06:31:38 -0500
In-Reply-To: <1323069170-5881-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

On Mon, 5 Dec 2011 15:12:50 +0800
Sonic Zhang <sonic.adi@gmail.com> wrote:

> From: Sonic Zhang <sonic.zhang@analog.com>
> 
> Serial device may be probed earlier before GPIOLIB is initialized. Requesting and
> configuring CTS GPIO PIN fails in that early stage. Do it when the serial device
> really starts up.
> 
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>

Acked-by: Alan Cox <alan@linux.intel.com>
