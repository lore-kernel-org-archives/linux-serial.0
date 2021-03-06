Return-Path: <SRS0=gEyB=IE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DAAC433DB
	for <linux-serial@archiver.kernel.org>; Sat,  6 Mar 2021 19:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A72E7650CC
	for <linux-serial@archiver.kernel.org>; Sat,  6 Mar 2021 19:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhCFTYH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Mar 2021 14:24:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230449AbhCFTXt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Mar 2021 14:23:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 813AB64E0F;
        Sat,  6 Mar 2021 19:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615058629;
        bh=cTnXEc/F4W5azx4fPkGRWkSBUH6CHrJ93Qn3flShYsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xdU0jKfvhBBnrl7a+pwDiUlnXJVbuBJT0ZBRK57ZNgBWZKcxfpDjerLzn4TuqFa4b
         8p7p3SNgdzG/gzhE8E65D+l4AeN0wE37I+dtB2J1rM3H/ftKqsj0zk2ciQbfZGpRFQ
         U55CHCRKETy0MXekjLnApTi3abggfVLSTgRFNyts=
Date:   Sat, 6 Mar 2021 20:23:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Timur Tabi <timur@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 2/3] tty: serial: ucc_uart: replace qe_io{read,write}*
 wrappers by generic io{read,write}*
Message-ID: <YEPWwpxMFRwyI8w5@kroah.com>
References: <cover.1615053848.git.christophe.leroy@csgroup.eu>
 <479e57158ed85c041e4c32ef17b55024f8a784ce.1615053848.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <479e57158ed85c041e4c32ef17b55024f8a784ce.1615053848.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Mar 06, 2021 at 06:09:30PM +0000, Christophe Leroy wrote:
> Commit 6ac9b61786cc ("soc: fsl: qe: introduce qe_io{read,write}*
> wrappers") added specific I/O accessors for qe because at that
> time ioread/iowrite functions were sub-optimal on powerpc/32
> compared to the architecture specific in_/out_ IO accessors.
> 
> But as ioread/iowrite accessors are now equivalent since
> commit 894fa235eb4c ("powerpc: inline iomap accessors"),
> use them in order to allow removal of the qe specific ones.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/tty/serial/ucc_uart.c | 124 +++++++++++++++++-----------------
>  1 file changed, 62 insertions(+), 62 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
