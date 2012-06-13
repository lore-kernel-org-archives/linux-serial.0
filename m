From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 1/2] serial: sh-sci: Fix probe error paths
Date: Wed, 13 Jun 2012 10:36:52 +0900
Message-ID: <20120613013652.GK10170@linux-sh.org>
References: <1339540104-25003-2-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from linux-sh.org ([111.68.239.195]:33817 "EHLO linux-sh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918Ab2FMBg5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 12 Jun 2012 21:36:57 -0400
Content-Disposition: inline
In-Reply-To: <1339540104-25003-2-git-send-email-laurent.pinchart@ideasonboard.com>
 <1339540104-25003-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, Jun 13, 2012 at 12:28:23AM +0200, Laurent Pinchart wrote:
> When probing fails, the driver must not try to cleanup resources that
> have not been initialized. Fix this.

On Wed, Jun 13, 2012 at 12:28:24AM +0200, Laurent Pinchart wrote:
> The driver supports a maximum number of ports configurable at compile
> time. Make sure the probe() method fails when registering a port that
> exceeds the maximum instead of returning success without registering the
> port.
> 
> This fixes a crash at system suspend time, when the driver tried to
> suspend a non-registered port using the UART core.

Both applied, thanks.
