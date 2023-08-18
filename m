Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CA0EE4984
	for <linux-serial@archiver.kernel.org>; Fri, 18 Aug 2023 17:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358229AbjHRRnH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Aug 2023 13:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379226AbjHRRnG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Aug 2023 13:43:06 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB223A9C;
        Fri, 18 Aug 2023 10:42:57 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 04DA56A2;
        Fri, 18 Aug 2023 17:42:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 04DA56A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1692380577; bh=GOuZkOaYIcVm6G5DEklRZvb7DKKG5wAQcJ+DPXnRRbA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YMaqL3Lk+U21d07jlrub/zazBd3wDGcTo4E5P9/izR9IFqS91TodVHcdzoBCCxGJb
         9e0067X410G+SJICzdwMF1OPfx2rzZ2qWmrg99BNun1IiMtaeTyKP29uu6VzCwdrOs
         10rgzquTvWiT6s7AU+MsTFAefnba1pACEwrAq5RCLicUipMuqjNxEvP9hd9n2aY54H
         Wp4PLiWT8CujuTH3PUdos73w+kIC6u860ZTvOVikB44ne3R53rGytbA63lZ+wF5gKp
         AwA579/iPF+4rYJWKiDZMRrdxCRljLaUT+7PRSEd9cJy1kRT2v/KpJ2/33mDw8j4pT
         b6EO0ubSI8YoA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-serial@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] Documentation: devices.txt: Remove ttyIOC*
In-Reply-To: <b5deb1222eb92017f0efe5b5cae127ac11983b3d.1691992627.git.christophe.leroy@csgroup.eu>
References: <b5deb1222eb92017f0efe5b5cae127ac11983b3d.1691992627.git.christophe.leroy@csgroup.eu>
Date:   Fri, 18 Aug 2023 11:42:56 -0600
Message-ID: <87il9cl00v.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> IOC4 serial driver was removed, remove associated devices
> from documentation.
>
> Fixes: a017ef17cfd8 ("tty/serial: remove the ioc4_serial driver")
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  Documentation/admin-guide/devices.txt | 9 ---------
>  1 file changed, 9 deletions(-)

This doesn't apply to docs-next, seemingly as the result of a change
that went through Greg's tree, so these should follow the same path,
methinks.

Thanks,

jon
