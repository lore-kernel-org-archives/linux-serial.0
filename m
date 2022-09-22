Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AEBC54EE9
	for <linux-serial@archiver.kernel.org>; Thu, 22 Sep 2022 14:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiIVOEM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiIVOEL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Sep 2022 10:04:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FED52E4C;
        Thu, 22 Sep 2022 07:04:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7E7DB836D3;
        Thu, 22 Sep 2022 14:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB18C433D7;
        Thu, 22 Sep 2022 14:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663855446;
        bh=qNQTFLmwOP1RRzA8DFXzk/Jc6/Pois2Xp3rygn6GqHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w41XGg1rBfQtFY8+GVvW4VPQo/eXPp4t9HMFKt4QJWWQj9NUk+bTvsvII5jrjvYk0
         Xdtx9y//uU1i/Lf/SIG8J6jJ2Ivgey2Qx+H2MNqKDZbfhWLNvng5rJufr+7qeCeRBR
         Y+p0wNcPh2gZp3oQPs2JG2IRukHN+nQJsr0PeeMI=
Date:   Thu, 22 Sep 2022 16:04:03 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] tty: n_gsm: add enumeration for gsm encodings
Message-ID: <YyxrUyGGebUb6uxE@kroah.com>
References: <DB9PR10MB588158E9108FAE41061B4790E04F9@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR10MB588158E9108FAE41061B4790E04F9@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Sep 21, 2022 at 11:03:44AM +0000, Starke, Daniel wrote:
> Is there any remaining issue with this patch series which prevents
> a commit to the kernel tree?

I was hoping others would review them too...

I'll go do so now.

greg k-h
