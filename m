Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4594C43334
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 15:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiGGPiB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 11:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbiGGPiA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 11:38:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA2031389
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 08:37:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FD3DB8210F
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 15:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234E5C3411E;
        Thu,  7 Jul 2022 15:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657208276;
        bh=S2AJvXEzkkt8cwUh7gHIs88+M0e7RWr14zLqFFavSvg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AK8kGSp0yEXLbxKcW7d1wGYbYo4MHdEjJ9GRU/5Q+xZeM+yRNHXiASC+T+UGr7Ngy
         kRVwdbR4Gw2KZifJcSlUmtm89N4c+P6KvUrgy6hlGZdEpYENoYZAfQfuiyYvDSC7Fu
         AMtRaOwo4mq4ncTst2HlSxHy+SauuJUlDNDa15VOYHy00njGu174cvSLzJcCEwDmkK
         4WE0mWetYLWa2juT4JNuhkvaA+pJcZ3ufrIKWXRLonZAEdxUIlqSh6RQNxstIpBwu7
         0Gg4KcMT0DD+AHA/OkkuEfSEgXD7G7j5Yxzyz9R96p8E/GIQcrQAloFxbTCf9ko52A
         aj4OZiZ39XjYQ==
Date:   Thu, 7 Jul 2022 17:37:53 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Subject: Re: [PATCH 1/7] USB: serial: ftdi_sio: Fix divisor overflow
Message-ID: <20220707173753.7d321cac@dellmb>
In-Reply-To: <Ysb2ybllKsZ4/81Y@kroah.com>
References: <20220707145354.29705-1-kabel@kernel.org>
        <20220707145354.29705-2-kabel@kernel.org>
        <Ysb2ybllKsZ4/81Y@kroah.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 7 Jul 2022 17:07:53 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Jul 07, 2022 at 04:53:48PM +0200, Marek Beh=C3=BAn wrote:
> > From: Pali Roh=C3=A1r <pali@kernel.org>
> >=20
> > Divisor in the register is a 17-bit wide number.
> > Therefore we need to clamp it on overflow. =20
>=20
> Why, what is wrong with it overflowing, what will happen if it does?

The divisor register is 17-bits wide (14 bits integer part, 3 bits
fractional). So suppose that we compute divisor 0x20001. Writing to
the register puts 0x00001 there, cause the 17th bit gets discarded
(since the register is 17-bits wide). Which will result in dividing by
1.

The best thing we can do if we overflow is put the maximum value to the
divisor, to get the lowest baudrate possible.

>=20
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > Tested-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > ---
> >  drivers/usb/serial/ftdi_sio.c | 6 ++++++
> >  1 file changed, 6 insertions(+) =20
>=20
> What commit does this fix?  Is it a bugfix?  Can this ever happen in a
> device?  Should it be backported?.

It is a bugfix; it can happen (happened to Pali when he was trying some
low baudrates); it should be backported.

But it was first introduced in the commit
  1da177e4c3f4 ("Linux-2.6.12-rc2")
which is the very first commit in git :)

Marek
