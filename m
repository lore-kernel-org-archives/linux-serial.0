From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 0/2] tty: serial: imx: fix lockup and garbage on SMP
Date: Tue, 28 Aug 2012 07:37:59 +0800
Message-ID: <20120827233756.GH2281@r65073-Latitude-D630>
References: <1346053012-25686-1-git-send-email-dirk.behme@de.bosch.com>
 <20120827223134.GD2281@r65073-Latitude-D630>
 <20120827225142.GA11302@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38093 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322Ab2H0XiD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Aug 2012 19:38:03 -0400
Received: by pbbrr13 with SMTP id rr13so8283451pbb.19
        for <linux-serial@vger.kernel.org>; Mon, 27 Aug 2012 16:38:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120827225142.GA11302@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, kernel@pengutronix.de, Alan Cox <alan@linux.intel.com>

On Mon, Aug 27, 2012 at 03:51:42PM -0700, Greg Kroah-Hartman wrote:
> On both of them?  I can do that if needed.  How far back should they go?
> 
It should be okay to apply on 3.4 and 3.5.  But patch #2 is still in
question.  I do not like the #ifdef.

-- 
Regards,
Shawn
