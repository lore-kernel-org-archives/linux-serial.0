Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ED5EE49A5
	for <linux-serial@archiver.kernel.org>; Fri, 25 Aug 2023 15:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjHYPeh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Aug 2023 11:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237044AbjHYPeg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Aug 2023 11:34:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C472134;
        Fri, 25 Aug 2023 08:34:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD7D064890;
        Fri, 25 Aug 2023 15:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25F3C433C8;
        Fri, 25 Aug 2023 15:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692977674;
        bh=iRLOoCwRJElGcZjOp6rXISnCKlfpriO8DTj22vK8d9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e9FPPQJoLvxgfGjW2R7HSeQ2wlEV+BM1j9M8pOK0xRXIVIp3xRU3p/L5pAKn1irNv
         dgeo9Bh0pVFwJ98Miag6EF6y+1zG366MPHvGGO4xl3ROqxq5i7kXmRL0P1pCdNv+k3
         517aoT4/lYz4nj+YkFELwQYKCf9SIYAXVtJjp2zo=
Date:   Fri, 25 Aug 2023 17:34:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] tty: shrink the size of struct tty_struct by 40 bytes
Message-ID: <2023082531-daylight-vitally-fcb3@gregkh>
References: <2023082519-cobbler-unholy-8d1f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023082519-cobbler-unholy-8d1f@gregkh>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 25, 2023 at 05:28:20PM +0200, Greg Kroah-Hartman wrote:
>  	bool hw_stopped;
> -	unsigned int receive_room;
> +	bool closing;
>  	int flow_change;

Note, "flow_change" really only has 2 values, 1 or 2, so it could be a
boolean, or a u8 at the worse (both take the same amount of space).  But
changing that here doesn't affect the overall size of the structure,
just increases the hole at this location in the structure, so it's not a
big deal at this point in time.

thanks,

greg k-h
