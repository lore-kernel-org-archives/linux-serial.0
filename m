From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: mfd: Add nmi_touch_watchdog() into the console
 write function
Date: Thu, 8 Nov 2012 10:54:55 +0000
Message-ID: <20121108105455.48af4824@pyramind.ukuu.org.uk>
References: <1352355053-30040-1-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:44074 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab2KHKtu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Nov 2012 05:49:50 -0500
In-Reply-To: <1352355053-30040-1-git-send-email-feng.tang@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com

On Thu,  8 Nov 2012 14:10:53 +0800
Feng Tang <feng.tang@intel.com> wrote:

> This is following what 8250 driver is doing in console write function,
> to avoid the hardware lockup case.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>

Looks fine to me.

Acked-by: Alan Cox <alan@linux.intel.com>
