Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F406C433B4
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 15:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49C38613C8
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 15:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhEMPHt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 May 2021 11:07:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232156AbhEMPHs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 May 2021 11:07:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D920D613BE;
        Thu, 13 May 2021 15:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620918398;
        bh=LTxcHphFTlqJQt+lsnqvkEsgQXgqYhiBsnchnFNNwwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+51qiWcX4gLSxcI4myBIYlmbfZBP5M+UNSOI/s4uiabzfSUl6HjRnsqGel7dL8sH
         EafQsbNP2fZJg5dHTuf6DaqQ8KrqwowZw+4iKjiqJ58YAwXsVwkqTvMtPJDcgMwPKG
         1D6NhovQAsyuWbLG7HmD9oUBpJ7Ryf9syrK8u//I=
Date:   Thu, 13 May 2021 17:06:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jay Fang <f.fangjian@huawei.com>
Cc:     linux-serial@vger.kernel.org, linuxarm@huawei.com,
        huangdaode@huawei.com, tangzihao1@hisilicon.com
Subject: Re: [PATCH 00/12] use <linux/io.h> instead of <linux/io.h>
Message-ID: <YJ1AfMOYRqnlYANQ@kroah.com>
References: <1620874904-39285-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620874904-39285-1-git-send-email-f.fangjian@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 13, 2021 at 11:01:32AM +0800, Jay Fang wrote:
> From: Zihao Tang <tangzihao1@hisilicon.com>
> 
> <linux/io.h> is the preferred header to include instead of <asm/io.h>,
> so use <linux/io.h> instead of <asm/io.h>.

That's good, but not what the subject line here said you were doing :)

Not a big deal, I'll go queue up the patches, as they were correct
there.

thanks,

greg k-h
