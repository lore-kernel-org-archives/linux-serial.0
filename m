Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A83AC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 16 Feb 2022 08:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiBPIxW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Feb 2022 03:53:22 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiBPIxW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Feb 2022 03:53:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84459B7C59;
        Wed, 16 Feb 2022 00:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eFy0XITB5jrqbQtM85ouo5CQsg6JHaE+XplJwfAzX7g=; b=4pksmgTvMD2OGe9uMbtj0E9wgt
        9LNdNQfzk65+6Bb09aN0dRiqNjMEDfpP21UF6e28lsNk3Bryv4ost5p9t4kB7ZlEMLinFfQklTWjL
        2wJxxm/Sy7gMgdxp8plXVZjSOowZXKgHW6UQJsWQONTG/10XIs4lut0oZgYLdxmgcxGuSkkY0oGeH
        xb0V6ah90jmLvs+BACPxmdyt2rH/Pt5LONO96ndO8Y7WiZbtTMjZQMCq1wlnRe4J7aF8vT/drh6wV
        ZbrlSK/ijZESHli0X0Ivc+Sbu/DIm25UfH5Qw9LscbyqgQ2ihSmuMHytboKNRVHeH9vUXp+cpD3lS
        7g5daq1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKG3g-006BPe-2F; Wed, 16 Feb 2022 08:53:08 +0000
Date:   Wed, 16 Feb 2022 00:53:08 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 2/2] serial: 8250_lpss: Switch to pcim_iomap() instead
 of pci_ioremap_bar()
Message-ID: <Ygy7dNqFLZF9XYiH@infradead.org>
References: <20220215134359.78169-1-andriy.shevchenko@linux.intel.com>
 <20220215134359.78169-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215134359.78169-2-andriy.shevchenko@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Feb 15, 2022 at 03:43:59PM +0200, Andy Shevchenko wrote:
> The pci_iounmap() doesn't cover all the cases where resource should
> be unmapped. Instead of spreading it more, replace the pci_ioremap_bar()
> with pcim_iomap() which uses managed resource approach.

pcim_iomap requires the use of ioreadX/iowriteX and thus runtime
overhead.  So in doubt please add a pcim_ioremap_bar instead of forcing
the legacy iomap/ioread/iowrite API onto modern drivers tht can't
support legacy port I/O.
