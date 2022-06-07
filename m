Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4A0C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jun 2022 13:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244476AbiFGNME (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jun 2022 09:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242518AbiFGNMD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jun 2022 09:12:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671EBC9673;
        Tue,  7 Jun 2022 06:12:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E426E61336;
        Tue,  7 Jun 2022 13:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD7FC385A5;
        Tue,  7 Jun 2022 13:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654607520;
        bh=qLFCZi5FqIaZoW8Ve3g1LOJBOjIgUuU0HTWMlLjXUfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JxZgBf6aAHi5/PpVhYbFSHyrnR6IyqcIB7AuCM+VQ2HjrYoonzkTCV/huH0CPuKga
         dnNSHPBfTm3JS1JXWZn73brDJlNd/AVrVwfzuzpzLDmUgajLQC4Pt4REuArl30uD5C
         dylVaVuAZZRcAynxJDyCU9Oxzw80VJA9o7loYrC8=
Date:   Tue, 7 Jun 2022 15:11:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     jirislaby@kernel.org, nm@ti.com, tony@atomide.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_omap: Fix syntax errors in comments
Message-ID: <Yp9OmqgOMbG4fQOI@kroah.com>
References: <20220606144124.29691-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606144124.29691-1-wangxiang@cdjrlc.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jun 06, 2022 at 10:41:24PM +0800, Xiang wangx wrote:
> Delete the redundant word 'have'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
> 
> Changes since v1
> *Change commit log

No you did not, it's identical :(
