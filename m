Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24E1EE4993
	for <linux-serial@archiver.kernel.org>; Tue, 22 Aug 2023 13:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbjHVNBT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Aug 2023 09:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbjHVNBT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Aug 2023 09:01:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC4BCE3
        for <linux-serial@vger.kernel.org>; Tue, 22 Aug 2023 06:01:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1964864C83
        for <linux-serial@vger.kernel.org>; Tue, 22 Aug 2023 13:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC388C433C8;
        Tue, 22 Aug 2023 13:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692709275;
        bh=vKWyaeSwrDUfjFnikNmsmrAECXjxC8IRE9WzeZe7kXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vcoqow/Pt96PUfSXvJR6rn5S/VUS+3+V5vyxJDDuFAMU8NCNKxgHvz1TrVg3OtUzt
         wsWhKcTg8lOfxkns7HKHD46bGRO810w2bv9l4Jg2V1zl26SbjE6TtZpjQleiwO7y3L
         w10gH4KQIOe0RL6HA+fdtaRRvPxDZX2Y3W6oo5yU=
Date:   Tue, 22 Aug 2023 15:01:06 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     Yi Yang <yiyang13@huawei.com>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "hedonistsmith@gmail.com" <hedonistsmith@gmail.com>,
        "zhangqiumiao1@huawei.com" <zhangqiumiao1@huawei.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] tty: n_gsm: fix the UAF caused by race condition in
 gsm_cleanup_mux
Message-ID: <2023082254-art-reclusive-5b60@gregkh>
References: <20230811031121.153237-1-yiyang13@huawei.com>
 <DB9PR10MB58811F2D087B85CC426F4FBEE01BA@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR10MB58811F2D087B85CC426F4FBEE01BA@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 18, 2023 at 05:19:10AM +0000, Starke, Daniel wrote:
> Looks logical and plausible to me.
> Tests on our side did not show any side effect.
> 
> Reviewed-by: Daniel Starke <daniel.starke@siemens.com>

Thanks for the review, but this is alreay in the tree.

greg k-h
