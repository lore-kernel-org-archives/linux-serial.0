From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] serial: bfin-sport-uart: Request CTS GPIO PIN when
 the sport emulated serial device starts up.
Date: Tue, 6 Dec 2011 11:36:20 +0000
Message-ID: <20111206113620.4f3fe5ae@lxorguk.ukuu.org.uk>
References: <1323155794-14696-1-git-send-email-sonic.adi@gmail.com>
	<1323155794-14696-2-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49551 "EHLO
	earthlight.etchedpixels.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933199Ab1LFLfS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 6 Dec 2011 06:35:18 -0500
In-Reply-To: <1323155794-14696-2-git-send-email-sonic.adi@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

On Tue, 6 Dec 2011 15:16:34 +0800
Sonic Zhang <sonic.adi@gmail.com> wrote:

> From: Sonic Zhang <sonic.zhang@analog.com>
> 
> This patch is similar to that for bfin-uart hardware flow control.
> Sport emulated serial device may be probed earlier before GPIOLIB is initialized.
> Requesting and configuring CTS GPIO PIN fails in that early stage.
> 
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>

Acked-by: Alan Cox <alan@linux.intel.com>
