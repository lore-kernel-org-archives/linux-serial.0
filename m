Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F116BC001E0
	for <linux-serial@archiver.kernel.org>; Wed, 16 Aug 2023 11:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjHPLUs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Aug 2023 07:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244507AbjHPLUf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Aug 2023 07:20:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EE42112;
        Wed, 16 Aug 2023 04:20:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AF6C60C7E;
        Wed, 16 Aug 2023 11:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B80BC433C7;
        Wed, 16 Aug 2023 11:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692184832;
        bh=7PKd8VailiTG+UcQPQzzVSV0JwGb9yH8OHJSaPVa+e8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a2Wi6WJORBB/BYftBKtLHHDNb0y0zBdaV39QWOIaHGy0uqrbKbRhH8vrSQouH9zut
         ubgkwIaT7VUDWye2z5rz3MPZ7pCSrgCsVqDWY/BaAxPt4mbLnOBe+zYV38EW8q4984
         xaSkneNxcl8sfMG+m0i3SByD3vFAz2gbAmq71CNk=
Date:   Wed, 16 Aug 2023 13:20:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] tty: n_tty: cleanup
Message-ID: <2023081610-define-reason-2e99@gregkh>
References: <20230816105822.3685-1-jirislaby@kernel.org>
 <1882495c-b16b-10f0-2acf-ee86cf4e031b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1882495c-b16b-10f0-2acf-ee86cf4e031b@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 16, 2023 at 01:02:11PM +0200, Jiri Slaby wrote:
> Bah, this series intermixed with old patches in one dir.
> 
> Patches 1/4 2/4 3/4 4/4 are to be ignored.
> 
> OTOH, 01/14 ... 04/14 are a correct part of this series.
> 
> Do you want me to resend?

Please resend, b4 will try to pick up all the patches in this series and
get confused :(

thanks,

greg k-h
