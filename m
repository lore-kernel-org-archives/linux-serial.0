Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC0CC04A94
	for <linux-serial@archiver.kernel.org>; Fri,  4 Aug 2023 10:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjHDKWY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Aug 2023 06:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjHDKWX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Aug 2023 06:22:23 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530F530F4;
        Fri,  4 Aug 2023 03:22:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A1F7D68AA6; Fri,  4 Aug 2023 12:22:18 +0200 (CEST)
Date:   Fri, 4 Aug 2023 12:22:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [linux-next:master] BUILD REGRESSION
 fb4327106e5250ee360d0d8b056c1eef7eeb9a98
Message-ID: <20230804102218.GD23274@lst.de>
References: <202308040141.gUjtZ32J-lkp@intel.com> <ZMwH1WuEb1JEtZ4o@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMwH1WuEb1JEtZ4o@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 03, 2023 at 09:02:29PM +0100, Matthew Wilcox wrote:
> I think something like this would fix it.  Jens?  Christoph?
> 
> +++ b/fs/romfs/Kconfig
> @@ -2,6 +2,7 @@
>  config ROMFS_FS
>         tristate "ROM file system support"
>         depends on BLOCK || MTD
> +       select BUFFER_HEAD
>         help
>           This is a very small read-only file system mainly intended for
>           initial ram disks of installation disks, but it could be used for
> 
> romfs has a few options and I spent no time looking at this closely;
> maybe not every version of romfs needs buffer heads.

It only needs buffer_heads for the block based path.  I'll send a patch
for it.
