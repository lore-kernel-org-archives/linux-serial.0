Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB81C32774
	for <linux-serial@archiver.kernel.org>; Tue, 23 Aug 2022 06:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239296AbiHWGWK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Aug 2022 02:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbiHWGWJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Aug 2022 02:22:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225704B0DE;
        Mon, 22 Aug 2022 23:22:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D801AB816BF;
        Tue, 23 Aug 2022 06:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F17BC433C1;
        Tue, 23 Aug 2022 06:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661235726;
        bh=aGhwHLFCPyXlbGMjDTQLolc0eTz1F05VuSaLLqTjayg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J2weGI5tHBAlVRTBCsIZlHSXtkLBb+UPjKkvzn1y7nzwyd2yGxDW5BeiGdjGNqKkM
         fD8c/wJlSGQJeDlyJXmLZeN1SeJ59HbPWhydRw3O19Afii1mauhFMXjSOGb8bB25u7
         ipPggOwCfkgU2U9MZizd5jnfYCGhdFLkMuSBS46c=
Date:   Tue, 23 Aug 2022 08:22:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     lily <floridsleeves@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org
Subject: Re: [PATCH v1] drivers/tty/serial: check the return value of
 uart_port_check()
Message-ID: <YwRyC93rC/BAjR23@kroah.com>
References: <20220823055739.1451419-1-floridsleeves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823055739.1451419-1-floridsleeves@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Aug 22, 2022 at 10:57:39PM -0700, lily wrote:
> uart_port_check() can return NULL pointer. Check its return value
> before dereference it.

Also, how did you find this issue?

> 
> Signed-off-by: Li Zhong <floridsleeves@gmail.com>

Also, your From: name does not match this one, so I can't take the patch
even if it is ok :(

Please do initial kernel work in drivers/staging/ to get issues like
this fixed up before moving to other portions of the kernel so that
basic email problems do not bother other subsystem maintainers.

thanks,

greg k-h


