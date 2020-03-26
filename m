Return-Path: <SRS0=p7su=5L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E144FC2D0E8
	for <linux-serial@archiver.kernel.org>; Thu, 26 Mar 2020 14:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC4F20714
	for <linux-serial@archiver.kernel.org>; Thu, 26 Mar 2020 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585233652;
	bh=MOnEnYddK+XScumwwsKscvn2cN/H7Hri0z/LQ4SmDUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eaglEch5sG1f9oXTFlvTzrJcgrEDJdDzjZVI+Mv3sdWENvKrzo9jlpDzmUGzKWL4U
	 PLZL6jq5FBMApLKZAnQejsGAB36HDhDW4AGOxlwVnyM7G8zpvf5invyaWx0NYcoGlI
	 sdGBHQA3I7EYDYsqr29fdYMhgkRMdE5Bdrd1KTn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgCZOkv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgCZOkv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Mar 2020 10:40:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49825206F8;
        Thu, 26 Mar 2020 14:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585233649;
        bh=MOnEnYddK+XScumwwsKscvn2cN/H7Hri0z/LQ4SmDUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JUgcZ6kDDtjb2Be2dPK4bYTKnDcnuMWd6gfZSGTt07lRtvaC5Iu4RgtpudCdSfs25
         kq8+0xQWgKfkDNlVZrp5JUIycvDMfbPm5TnvJKisZ2OBlFMjKCN5bmIooBeWegEG/y
         Q4wbQSy4tzMor1PH5rmcOyzjK9sQ0qyqQpwbRc+c=
Date:   Thu, 26 Mar 2020 15:40:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jiri Slaby <jslaby@suse.com>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Heiko Schocher <hs@denx.de>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Stefan Wahren <wahrenst@gmx.net>,
        Martin Sperl <kernel@martin.sperl.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-serial@vger.kernel.org
Subject: Re: [PATCH tty-next 1/2] serial: 8250: Fix rs485 delay after console
 write
Message-ID: <20200326144047.GA1403361@kroah.com>
References: <b420d9c3b1c8b0492db55cc6f62076bfd9968b2f.1585224378.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b420d9c3b1c8b0492db55cc6f62076bfd9968b2f.1585224378.git.lukas@wunner.de>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 26, 2020 at 01:20:15PM +0100, Lukas Wunner wrote:
> Due to a silly copy-paste mistake, commit 6194c38fc20d ("serial: 8250:
> Support console on software emulated rs485 ports") erroneously pauses
> for the duration of delay_rts_before_send after writing to the console,
> instead of delay_rts_after_send.  Mea culpa.
> 
> Fixes: 6194c38fc20d ("serial: 8250: Support console on software emulated rs485 ports")

Where did this commit id come from?

Don't you mean 7f9803072ff6 ("serial: 8250: Support console on software
emulated rs485 ports")?

If so, can you please fix this up and resend the series?

thanks,

greg k-h
