Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D240FC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 23 Feb 2022 11:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239974AbiBWLij (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Feb 2022 06:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240010AbiBWLij (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Feb 2022 06:38:39 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1808B92D37;
        Wed, 23 Feb 2022 03:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645616292; x=1677152292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=12JycTJlECTUq0lO/omhbnhyj0Dc1BQX7rKXfLcSDC8=;
  b=lB7KDa65fHyDIGcJZdhxH/yWHeitjIc4ittyAqOZ8HyxobOVKfBFpJ2f
   NY0FQ1UYNIPXV3QlL9NvViwSyBvAnNGG1OANILwx2Zwre1NGgmzyuO0Tk
   oRyy5qSC7lOvoJT4PzzqPu7EWUm3t7agNI4wLS2i4QtTqUxgfQkk/D+xh
   Dt7rSTZfekr7FO/n6cv8dBE4SmIyrXkj10R9TnZ59wUneiUqkqdA1INGe
   sksEhVTLhwBwbd1HJNRafGDZ7AWmNBTRW78oImp7x7Tfzyx7jqCJujFSJ
   7x+VjYT4DC4Pr+5JXwGWOrZSTuXyFsNQYlddIV+pVyeTEeJMQ2zQgM9Go
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="232565385"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="232565385"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 03:38:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="508403291"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 03:38:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nMpxO-007OWU-Tn;
        Wed, 23 Feb 2022 13:37:18 +0200
Date:   Wed, 23 Feb 2022 13:37:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: 8250_lpss: Switch to pcim_iomap() instead
 of pci_ioremap_bar()
Message-ID: <YhYcbrsDD2iagUL7@smile.fi.intel.com>
References: <20220215134359.78169-1-andriy.shevchenko@linux.intel.com>
 <20220215134359.78169-2-andriy.shevchenko@linux.intel.com>
 <Ygy7dNqFLZF9XYiH@infradead.org>
 <d8336f83-9f31-e168-1ed7-29e97189e233@kernel.org>
 <YhUJAl5JpCoXik7X@infradead.org>
 <YhYVl9YaoPDwAXO4@smile.fi.intel.com>
 <YhYWw/yEaYJFR1/y@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhYWw/yEaYJFR1/y@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Feb 23, 2022 at 12:13:07PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 23, 2022 at 01:08:07PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 22, 2022 at 08:02:10AM -0800, Christoph Hellwig wrote:
> > > On Tue, Feb 22, 2022 at 10:14:16AM +0100, Jiri Slaby wrote:
> > > > On 16. 02. 22, 9:53, Christoph Hellwig wrote:
> > > > > On Tue, Feb 15, 2022 at 03:43:59PM +0200, Andy Shevchenko wrote:
> > > > > > The pci_iounmap() doesn't cover all the cases where resource should
> > > > > > be unmapped. Instead of spreading it more, replace the pci_ioremap_bar()
> > > > > > with pcim_iomap() which uses managed resource approach.
> > > > > 
> > > > > pcim_iomap requires the use of ioreadX/iowriteX and thus runtime
> > > > > overhead.  So in doubt please add a pcim_ioremap_bar instead of forcing
> > > > > the legacy iomap/ioread/iowrite API onto modern drivers tht can't
> > > > > support legacy port I/O.
> > > > 
> > > > Hmm, the driver combines pci_ioremap_bar with pci_iounmap. pci_iounmap does
> > > > the right thing after all, but is that correct? And this driver is not
> > > > alone, this shows more:
> > > > git grep -E 'pci_iounmap|pci_ioremap_bar' `git grep -l pci_iounmap \`git
> > > > grep -l pci_ioremap_bar\``
> > > 
> > > I think it is wrong.  It is not actively harmful unlike the the
> > > combination of pci_iomap and then later use of accessors from the
> > > ioremap family, but still not exactly a good idea.
> > > 
> > > In a perfect world we'd have some different annotation from __iomem
> > > for the whole iomap family of functions.
> > 
> > So, what would be your suggestion for a) backportable change b) cleanup for
> > the current and future drivers?
> 
> Worry about getting it right first.  Only after that should you even
> consider stable tree backports.  There's usually no reason you can't
> just take the same change there as well.  And if not, we will work
> through it :)

Okay, so if I read this thread correctly Christoph suggests to introduce
pcim_ioremap_bar() and then use it. Am I right?

Christoph, since we are on the topic about pcim_*() APIs, can you chime in
the discussion [1] about IRQ vectors allocation?

[1]: https://lore.kernel.org/all/20210607153916.1021016-1-zhengdejin5@gmail.com/

-- 
With Best Regards,
Andy Shevchenko


