Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E54C43334
	for <linux-serial@archiver.kernel.org>; Mon, 27 Jun 2022 12:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbiF0M2N (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Jun 2022 08:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiF0M2M (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Jun 2022 08:28:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63666159;
        Mon, 27 Jun 2022 05:28:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F69060B85;
        Mon, 27 Jun 2022 12:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22637C3411D;
        Mon, 27 Jun 2022 12:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656332890;
        bh=R8mRZlL4HYt6JNWbRIq6vO7SYQ0vmM/el9Zn2F37kuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OKG0YJI6l710KB0I7upmhVu65o37G9RVA9twNi+kz7lOWUSsMYEfwuSX0OAeKwoJh
         g/F7XbTCH+EYVnyney4AMyfv5+KjTnBMYh5mlDqt9tEDDsc5cdqXALDeIZJaIdEGhB
         lQ21Zc8xPINjGYAvzvVc+KxxcFFIVo9NU4r9K+ps=
Date:   Mon, 27 Jun 2022 14:06:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guo Mengqi <guomengqi3@huawei.com>
Cc:     jirislaby@kernel.org, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        nsaenz@kernel.org, athierry@redhat.com,
        linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xuqiang36@huawei.com
Subject: Re: [PATCH -next] drivers/tty/serial: Add missing
 clk_disable_unprepare()
Message-ID: <YrmdUKNEFyZcJxm9@kroah.com>
References: <20220617025827.130497-1-guomengqi3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617025827.130497-1-guomengqi3@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jun 17, 2022 at 10:58:27AM +0800, Guo Mengqi wrote:
> Add missing clk_disable_unprepare() when get clk rate fails.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>

How did the robot report it?

How was this tested?

You have read the documentation for how to correctly report problems
found and fixed by automated tools, right?  Please update the changelog
to include all of that information.

thanks,

greg k-h
