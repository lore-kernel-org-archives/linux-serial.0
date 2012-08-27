From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] tty: serial: imx: fix lockup and garbage on SMP
Date: Mon, 27 Aug 2012 15:51:42 -0700
Message-ID: <20120827225142.GA11302@kroah.com>
References: <1346053012-25686-1-git-send-email-dirk.behme@de.bosch.com>
 <20120827223134.GD2281@r65073-Latitude-D630>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39705 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652Ab2H0Wvr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Aug 2012 18:51:47 -0400
Received: by pbbrr13 with SMTP id rr13so8230969pbb.19
        for <linux-serial@vger.kernel.org>; Mon, 27 Aug 2012 15:51:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120827223134.GD2281@r65073-Latitude-D630>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, kernel@pengutronix.de, Alan Cox <alan@linux.intel.com>

On Tue, Aug 28, 2012 at 06:31:35AM +0800, Shawn Guo wrote:
> On Mon, Aug 27, 2012 at 09:36:50AM +0200, Dirk Behme wrote:
> > Both issues are gone applying these two patches.
> > 
> > Note: If these patches are fine, they should go to stable, too.
> > 
> Then you should have Cc: <stable@vger.kernel.org> tag on these patches.

On both of them?  I can do that if needed.  How far back should they go?

greg k-h
