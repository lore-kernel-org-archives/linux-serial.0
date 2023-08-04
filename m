Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10468C001DB
	for <linux-serial@archiver.kernel.org>; Fri,  4 Aug 2023 13:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjHDNFp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Aug 2023 09:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjHDNFo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Aug 2023 09:05:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F8546BD;
        Fri,  4 Aug 2023 06:05:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED21F61FE5;
        Fri,  4 Aug 2023 13:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31FCC433C8;
        Fri,  4 Aug 2023 13:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691154336;
        bh=CMmrQBOMwR0aByOYeSTrPYxAkxl+tK2+Yy4ucbFVepY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D1Ep/aX1YfrLsVLG16EHNKOMgzJDmwOS7a3oXTfVP4t5UZ98vesrovc3AqG/nV+ua
         zkRweltGyiyd5druyJ+Cydf/yV+EcdLmBC6exbz0mqYMM5OGXGBwCgiADB1WA88qtm
         fucdckWGxZF46V/XbPfI42XaT5T1/9q/XTwinVI8=
Date:   Fri, 4 Aug 2023 15:05:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valentin Caron <valentin.caron@foss.st.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] serial: stm32: synchronize RX DMA channel in shutdown
Message-ID: <2023080414-props-senior-c40a@gregkh>
References: <20230803130134.155355-1-valentin.caron@foss.st.com>
 <20230803130134.155355-7-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803130134.155355-7-valentin.caron@foss.st.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 03, 2023 at 03:01:34PM +0200, Valentin Caron wrote:
> From: Amelie Delaunay <amelie.delaunay@foss.st.com>
> 
> In shutdown, RX DMA channel is terminated. If the DMA RX callback is
> scheduled but not yet executed, while a new RX DMA transfer is started, the
> callback can be executed, and then disturb the ongoing RX DMA transfer.
> To avoid such a case, call dmaengine_synchronize in shutdown, after the
> DMA RX channel is terminated.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---

You can't forward on a patch from someone else and not sign-off on it
yourself :(

Please fix up and resend the series.

thanks,

greg k-h
