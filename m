Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58388C433C1
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 09:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20E96619C0
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 09:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhCWJng (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Mar 2021 05:43:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhCWJne (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Mar 2021 05:43:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEB2B619B8;
        Tue, 23 Mar 2021 09:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616492614;
        bh=YCyCLhznKcFVXwLxds7wttaB7Svnmw1PkwCziewsozM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o2a9VUsupjNzqfsw3gmEkUo8Ktg/EgoJh4OX9VPreLt85XTrfJz6lYTReB0FZrzC7
         lKOJZbT+5z5DxcLOmteBGgfo6uFYAhx3/djEawNMAx1Q1lwR2O+shpuE77MbPONZYl
         o6jbvqKTMJnh6BciUk3m2SN0sw2K2NpZDiwKSCtg=
Date:   Tue, 23 Mar 2021 10:43:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     caizhichao <tomstomsczc@163.com>
Cc:     matthias.bgg@gmail.com, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        caizhichao <caizhichao@yulong.com>
Subject: Re: [PATCH] tty:serial: fix spelling typo of values
Message-ID: <YFm4Q4vej4nlg9Ab@kroah.com>
References: <20210323092846.819-1-tomstomsczc@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323092846.819-1-tomstomsczc@163.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 23, 2021 at 05:28:46PM +0800, caizhichao wrote:
> From: caizhichao <caizhichao@yulong.com>
> 
> vaules -> values
> 
> Signed-off-by: caizhichao <caizhichao@yulong.com>

Please use your "full" name here.

thanks,

greg k-h
