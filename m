Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AC7C43331
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 09:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889572073B
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 09:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585906340;
	bh=Iq/LhB8NAZ/CjwHGsRN10k3MzIs5p1MdtNZQUkxqs4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jfXJwQ10oVdZw4y/dEI8Nh7NjYaIM6N2L6UtPUdxMruVxxBzKjmjI9d6cBeWL2Nd4
	 2KERzUVxaoBASRCPydbGF31rj4cb5rEatHfC1PEiblm2nhN7WGfX94R5+6SNb+WaCW
	 0THONg5/LcQrJwRLYc+kGLUuc061qf7SxTskqWOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390608AbgDCJcU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:32:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbgDCJcU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 05:32:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F9A020737;
        Fri,  3 Apr 2020 09:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585906339;
        bh=Iq/LhB8NAZ/CjwHGsRN10k3MzIs5p1MdtNZQUkxqs4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ElY9O11j86clnxxepd/zkDjpHk399bUoJ91n5TjpNSTBzVzjjINNYaQemyG8U2iu+
         koq3A3erZmlzxzGiaG/rMNw4BE2G7V9bsk2s1qeIn4OP9TntcUk8gsCoaKmZAr7OFd
         yJA/xEsXAldPwCPAolO1B6hp+S2e0vBkhH0jjf2U=
Date:   Fri, 3 Apr 2020 11:32:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     johan@kernel.org, linux-kernel@vger.kernel.org, monstr@monstr.eu,
        git@xilinx.com, Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/7] serial: uartps: Revert dynamic port allocation
Message-ID: <20200403093216.GA3746303@kroah.com>
References: <cover.1585905873.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1585905873.git.michal.simek@xilinx.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 03, 2020 at 11:24:29AM +0200, Michal Simek wrote:
> Hi,
> 
> there were several changes done in past in uartps drivers which have been
> also done in uartlite driver.
> Here is the thread about it
> https://lore.kernel.org/linux-serial/20191203152738.GF10631@localhost/
> 
> This series reverts all patches which enabled dynamic port allocation and
> returning driver to the previous state. There were added some features in
> meantime which are not affected by this series.

Should this go into 5.7-final as it's causing problems now, and
backported as well?  Or can it wait until 5.8-rc1?

thanks,

greg k-h
