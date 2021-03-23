Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038B9C433DB
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 12:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE4C60C3D
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 12:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhCWM3U (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Mar 2021 08:29:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231201AbhCWM3I (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Mar 2021 08:29:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FA2D61931;
        Tue, 23 Mar 2021 12:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616502547;
        bh=afEw5y8ZIUORMbnuRr1rExjsMs7f6XInz5bFs4zNxZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YMw+OIF5fnt72yaWF4Y9ZxmaCZRLKiNAH8AAXM8pgi9dpWgmDQU9y8ZWeehCjTiaL
         0NApS562xcXw1HD7XqpImblhiINdsFZftUM3bPqC3IiMvp5EsarDNkMPXa0+7W3SYz
         NaL7V0oSqREsxOYZDRKTFMtktVRgxZ1UTTyO0oiM=
Date:   Tue, 23 Mar 2021 13:29:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     caizhichao <tomstomsczc@163.com>
Cc:     matthias.bgg@gmail.com, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        caizhichao <caizhichao@yulong.com>
Subject: Re: [PATCH v3] tty:serial: fix spelling typo of values
Message-ID: <YFnfEaaM8R5vlUhy@kroah.com>
References: <20210323115327.1199-1-tomstomsczc@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323115327.1199-1-tomstomsczc@163.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 23, 2021 at 07:53:27PM +0800, caizhichao wrote:
> From: caizhichao <caizhichao@yulong.com>
> 
> vaules -> values
> 
> Signed-off-by: Zhichao Cai <caizhichao@yulong.com>
> ---
> v3: use full name and capitalize personal name.

But now your From: and Signed-off-by: lines do not match :(

Trivial patches are best learned in the drivers/staging/ area, please
try working there before going out into the "real" part of the kernel.

thanks,

greg k-h
