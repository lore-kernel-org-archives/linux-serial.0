From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v6] serial: spi: add spi-uart driver for Maxim 3110
Date: Thu, 11 Mar 2010 16:32:08 +0800
Message-ID: <20100311163208.03702414@feng-i7>
References: <20100304152524.56055828@feng-i7>
	<fa686aa41003072030xc63dcfemd4a43140a9e05310@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4297 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910Ab0CKI3X (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Mar 2010 03:29:23 -0500
In-Reply-To: <fa686aa41003072030xc63dcfemd4a43140a9e05310@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Mon, 8 Mar 2010 12:30:13 +0800
Grant Likely <grant.likely@secretlab.ca> wrote:

> Hi Feng,
> 
> I'm really concerned with this driver.  I think it needs a lot more
> work before it is ready for prime-time.  Again, you might want to
> consider asking Greg to add it to the staging tree while you clean
> stuff up and coordinate with the max3100 driver author.
> 
> Comments below.

Hi Grant,

Thanks for the comments, will address them in future submission.

For your suggestion about merging with max3100.c, I did tried but failed
as the basic working model differ a lot, anyway I will recheck that.

- Feng 
