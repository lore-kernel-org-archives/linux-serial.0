From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 4/4] TTY: ircomm: fix DTR being raised on hang up
Date: Fri, 12 Apr 2013 13:23:14 -0400 (EDT)
Message-ID: <20130412.132314.1519520714787939726.davem@davemloft.net>
References: <1365755551-17824-1-git-send-email-jhovold@gmail.com>
	<1365755551-17824-5-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:51114 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304Ab3DLRXP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 12 Apr 2013 13:23:15 -0400
In-Reply-To: <1365755551-17824-5-git-send-email-jhovold@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: jhovold@gmail.com
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, peter@hurleysoftware.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

From: Johan Hovold <jhovold@gmail.com>
Date: Fri, 12 Apr 2013 10:32:31 +0200

> Make sure to check ASYNC_INITIALISED before raising DTR when waking up
> from blocked open in ircomm_tty_block_til_ready.
> 
> Currently DTR could get raised at hang up as a blocked process would
> raise DTR unconditionally before checking for hang up and returning.
> 
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Johan Hovold <jhovold@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
