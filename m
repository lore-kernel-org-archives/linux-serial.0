From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [ patch 6/7] drivers/serial/jsm: new serial device driver
Date: Mon, 28 Feb 2005 03:22:20 +0000
Message-ID: <20050228032220.GB5300@infradead.org>
References: <42225A64.6070904@us.ltcfwd.linux.ibm.com> <42226A3E.6000707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from pentafluge.infradead.org ([213.146.154.40]:34781 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261540AbVB1DW1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 27 Feb 2005 22:22:27 -0500
Content-Disposition: inline
In-Reply-To: <42226A3E.6000707@pobox.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Wen Xiong <wendyx@us.ibm.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>

On Sun, Feb 27, 2005 at 07:47:58PM -0500, Jeff Garzik wrote:
> >+struct shrink_buf_struct {
> >+	unsigned int	shrink_buf_vaddr;	/* Virtual address of board 
> >*/
> >+	unsigned int	shrink_buf_phys;	/* Physical address of board 
> >*/
> 
> Major bug.  These should be unsigned long.

not sure what they actually mean, but a virtual address should be
a void * and drivers shouldn't ever mess with physical addresses.

