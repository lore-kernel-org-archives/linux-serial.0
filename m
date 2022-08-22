Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9294DC28D13
	for <linux-serial@archiver.kernel.org>; Mon, 22 Aug 2022 12:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbiHVMWV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Aug 2022 08:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiHVMWV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Aug 2022 08:22:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862BF33A36;
        Mon, 22 Aug 2022 05:22:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32D0AB8111D;
        Mon, 22 Aug 2022 12:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B99DC433C1;
        Mon, 22 Aug 2022 12:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661170937;
        bh=cl8fqtYrphFOIesFGSYEpKcE6152RkUrrsNuag/jMtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NoG36rX5BwLyeLdBeD1AkOhwT724FtuV0KSC8tYjjZB0rOG0674DdVQ2waq+oEyfv
         BW6oSqxzm0PdF2vkgXMetgIbXX5+3HQpkXoLyMN8iae4+UsL7GTW2ukWuSjPJXTecq
         uur44fsK9bu+R5hmgi7XmMpvy/DKeFCraEapo8Tc=
Date:   Mon, 22 Aug 2022 14:22:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     jirislaby@kernel.org, colin.king@intel.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial/jsm: fix repeated words in comments
Message-ID: <YwN09jVOF4WKw4yZ@kroah.com>
References: <20220822121457.21004-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822121457.21004-1-yuanjilin@cdjrlc.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Aug 22, 2022 at 08:14:57PM +0800, Jilin Yuan wrote:
>  Delete the redundant word 'way'.

Again, not redundant.
