From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git master
Date: Thu, 15 Feb 2007 17:10:35 -0800
Message-ID: <20070215171035.83918aae.akpm@linux-foundation.org>
References: <200702151926.l1FJQT2o020816@pasqua.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:41950 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751836AbXBPBN5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Feb 2007 20:13:57 -0500
In-Reply-To: <200702151926.l1FJQT2o020816@pasqua.pmc-sierra.bc.ca>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Marc St-Jean <stjeanma@pmc-sierra.com>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org

On Thu, 15 Feb 2007 13:26:29 -0600
Marc St-Jean <stjeanma@pmc-sierra.com> wrote:

> +			status = *(volatile u32 *)up->port.private_data;

It distresses me that this patch uses a variable which this patch
doesn't initialise anywhere.  It isn't complete.

The sub-driver code whch sets up this field shuld be included in the
patch, no?
