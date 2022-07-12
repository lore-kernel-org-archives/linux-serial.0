Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B21EC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jul 2022 12:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiGLMJd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Jul 2022 08:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiGLMJc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Jul 2022 08:09:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93D425E87
        for <linux-serial@vger.kernel.org>; Tue, 12 Jul 2022 05:09:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65A3D615CF
        for <linux-serial@vger.kernel.org>; Tue, 12 Jul 2022 12:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4591DC3411C;
        Tue, 12 Jul 2022 12:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657627770;
        bh=DwgRnopJw/EbrZD1Tr6CgEIADlBGnXISMHaX1hQnucs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cq+1FbNvzJ9WIihV21ehXjiQZYYqwD4VhxIV2lqdJM/h16+Y9TyOqtl/k9kbD+K4y
         qTCT2BVYBQReyg5AlPY98xEFF51mEqnchmlP3/ulpr0cEr2PPwQbtyUMGrA2OjKl1g
         /1vVtF6wqKbmxMhUtJlRzgg/5W371J2RC7fSWwLJf7pXGfci1lQP1x2a9BtcU0Ecc4
         iJPsb8Zf7Tt0DSJnrq1WVtmzScPV5LPkDUXzbg+/Y55qASXpB+t92b0oUZJhrKLS3Q
         NygQeqTdzfB+lam1hN2UHxqxXWw0JtnXfnMTvUcIkbgcdhqfxO8nguu9T74VxN4C1A
         1v2LYL4slZOyg==
Date:   Tue, 12 Jul 2022 14:09:25 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     m.brock@vanmierlo.com
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Subject: Re: [PATCH 4/7] USB: serial: ftdi_sio: Do not reset baudrate to
 9600 on error
Message-ID: <20220712140925.68f7f3c8@thinkpad>
In-Reply-To: <f94731a7bc103f153bea7a405b4fd9fc@vanmierlo.com>
References: <20220707145354.29705-1-kabel@kernel.org>
        <20220707145354.29705-5-kabel@kernel.org>
        <CAHp75VdamVbTZ2--GXLY6u_O9QmqN5GXTyZQ-NLfWWaEX6bBBw@mail.gmail.com>
        <f94731a7bc103f153bea7a405b4fd9fc@vanmierlo.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 12 Jul 2022 13:28:17 +0200
m.brock@vanmierlo.com wrote:

> Andy Shevchenko schreef op 2022-07-08 17:51:
> >> +                       baud = old_baud ? old_baud : 9600;  
> > 
> > Can be written as
> > 
> >   baud = old_baud ?: 9600;  
> 
> That is invalid C !
> This is a GCC extension.

Kernel is saturated with usage of GCC extensions.
