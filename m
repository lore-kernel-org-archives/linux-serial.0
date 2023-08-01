Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831A9C0015E
	for <linux-serial@archiver.kernel.org>; Tue,  1 Aug 2023 13:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjHANCZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Aug 2023 09:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjHANCY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Aug 2023 09:02:24 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D890D3;
        Tue,  1 Aug 2023 06:02:23 -0700 (PDT)
Received: from quatroqueijos.cascardo.eti.br (201-43-195-14.dsl.telesp.net.br [201.43.195.14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 588853F7B7;
        Tue,  1 Aug 2023 13:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690894940;
        bh=B3pJgstQ03Vg9nlPhSI380gWXGG5YWbwHMBFEXxPt0M=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=iW0jeeErAIbkL4qdMiK5n+kc8PzMx5amc0Tss6fnYCg1+cZ1FPGOYJL9vB4upj9nb
         jMtSAb2bVkaHiqu/AnfXGSeLFDgJs4NaQvqWjsf8x6gYxh+AM0E+EpbY3EJ3dbuwg3
         +ckFSdv6lzWtGqT1ltNv+7Os9tRP84iSH2vMLg/yRTQwtp6zEYyzWysNt+a1jrGGQ+
         0ncxcwhfgZLDkFYyKr7A2jAAPNv2PtCzGrDA9kalFlHGr1B1Z+9Z8jdEgyTdgDWWkA
         lAbtBkNIrAgSlM27wV1Q3ZOF2hPGC2Ir1MD9Gt/u5wkk/Rqt8tTp/LPd9EWWngIgvj
         Za6ub5QpSHvJg==
Date:   Tue, 1 Aug 2023 10:02:16 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] tty: n_gsm: require CAP_NET_ADMIN to attach N_GSM0710
 ldisc
Message-ID: <ZMkCWL4r9Z35j3hC@quatroqueijos.cascardo.eti.br>
References: <20230731185942.279611-1-cascardo@canonical.com>
 <2023080111-lucid-stiffness-ccfa@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023080111-lucid-stiffness-ccfa@gregkh>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 01, 2023 at 06:53:30AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 31, 2023 at 03:59:42PM -0300, Thadeu Lima de Souza Cascardo wrote:
> > Any unprivileged user can attach N_GSM0710 ldisc, but it requires
> > CAP_NET_ADMIN to create a GSM network anyway.
> > 
> > Require initial namespace CAP_NET_ADMIN to do that.
> > 
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> 
> What commit id does this fix?  Or has this always been a problem?
> 
> thanks,
> 
> greg k-h

This has always been like this. It is not really fixing a specific commit, but
introducing further restriction on access.

Cascardo.
