Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3042AC0015E
	for <linux-serial@archiver.kernel.org>; Tue,  1 Aug 2023 04:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjHAExf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Aug 2023 00:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHAExe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Aug 2023 00:53:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCAA10F0;
        Mon, 31 Jul 2023 21:53:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8891561382;
        Tue,  1 Aug 2023 04:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3EEC433C8;
        Tue,  1 Aug 2023 04:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690865613;
        bh=2ydpwuL/JD2cVB8xEE9az4qgOh2kfdZ9oeuFCmF97zY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PKAlOzy426j5pUqqLZl6QH0/dLaSxitrnYm9TDL1lcwPfp/xta5+34yb2BI1bhJRA
         dPlwjTnnsGbTDGWuGk4U5zbver9RN+q8MoUcFqhdopHT0TDQRGqkbGJPqabzEumZwR
         9AZifmS1u7/w+Ymu3zG5jkBNd+9UERK849sb17fQ=
Date:   Tue, 1 Aug 2023 06:53:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] tty: n_gsm: require CAP_NET_ADMIN to attach N_GSM0710
 ldisc
Message-ID: <2023080111-lucid-stiffness-ccfa@gregkh>
References: <20230731185942.279611-1-cascardo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731185942.279611-1-cascardo@canonical.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jul 31, 2023 at 03:59:42PM -0300, Thadeu Lima de Souza Cascardo wrote:
> Any unprivileged user can attach N_GSM0710 ldisc, but it requires
> CAP_NET_ADMIN to create a GSM network anyway.
> 
> Require initial namespace CAP_NET_ADMIN to do that.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

What commit id does this fix?  Or has this always been a problem?

thanks,

greg k-h
