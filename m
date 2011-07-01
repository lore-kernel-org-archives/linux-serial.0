From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] tty/serial: change of_serial to use new of_property_read_u32() api
Date: Fri, 1 Jul 2011 18:32:40 +0200
Message-ID: <201107011832.40318.arnd@arndb.de>
References: <20110630185921.13784.3823.stgit@ponder>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55167 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756943Ab1GAQcn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Jul 2011 12:32:43 -0400
In-Reply-To: <20110630185921.13784.3823.stgit@ponder>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

On Thursday 30 June 2011, Grant Likely wrote:
> Simplifies the code a bit and drops a few lines.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Looks good to me, and Rob's comment makes sense as well.

Acked-by: Arnd Bergmann <arnd@arndb.de>
