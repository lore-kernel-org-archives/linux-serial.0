From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 0/2] tty: serial: imx: fix lockup and garbage on SMP
Date: Tue, 28 Aug 2012 06:31:35 +0800
Message-ID: <20120827223134.GD2281@r65073-Latitude-D630>
References: <1346053012-25686-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63740 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322Ab2H0Wbj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Aug 2012 18:31:39 -0400
Received: by pbbrr13 with SMTP id rr13so8207281pbb.19
        for <linux-serial@vger.kernel.org>; Mon, 27 Aug 2012 15:31:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1346053012-25686-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, Alan Cox <alan@linux.intel.com>

On Mon, Aug 27, 2012 at 09:36:50AM +0200, Dirk Behme wrote:
> Both issues are gone applying these two patches.
> 
> Note: If these patches are fine, they should go to stable, too.
> 
Then you should have Cc: <stable@vger.kernel.org> tag on these patches.

-- 
Regards,
Shawn
