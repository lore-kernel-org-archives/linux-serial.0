From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [ patch 4/7] drivers/serial/jsm: new serial device driver
Date: Mon, 28 Feb 2005 03:21:01 +0000
Message-ID: <20050228032101.GA5300@infradead.org>
References: <42225A47.3060206@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from pentafluge.infradead.org ([213.146.154.40]:33501 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261539AbVB1DVD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 27 Feb 2005 22:21:03 -0500
Content-Disposition: inline
In-Reply-To: <42225A47.3060206@us.ltcfwd.linux.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wen Xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Sun, Feb 27, 2005 at 06:39:51PM -0500, Wen Xiong wrote:
> This patch is for jsm_proc.c and includes the functions relating to 
> /proc/jsm entry.

please don't put in more procfs driver interfaces.
