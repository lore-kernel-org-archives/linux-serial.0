Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71F9C43334
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jul 2022 12:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiGLMLQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Jul 2022 08:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbiGLMLP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Jul 2022 08:11:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4475A2D5
        for <linux-serial@vger.kernel.org>; Tue, 12 Jul 2022 05:11:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3706FB817D2
        for <linux-serial@vger.kernel.org>; Tue, 12 Jul 2022 12:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BF6C3411C;
        Tue, 12 Jul 2022 12:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657627872;
        bh=VnlQRqsZnHVjfpAsg5GC6/cWxkdR6Ss6n2spBoZ7mM0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tNWSfpblY9dvxi6PTgvqcGrn2IS+HAjTQUJwovMlob5U5H/sk1t4j9YJUV5NLRKFw
         VMD0LcdvBoialIOVaWPmoUoOmSNJO2VAkbUgZRSkgxtKV052QwQYZuTUzuwvJfOHpR
         Pdaou7T0tf+Cumb2XBT+3gU7ATyhLAynCreV5UIYeFZQ22/eVQQe97u4UpsKXHluoj
         ieLDRam8KxcAp9oXnSsJRJTHPszxDINkzQSJYIPCnv5q3PfhTUtTSNKYSTAAgTygVV
         Nvvv2+nwGpIvIAZyh1pSvXK685c3d3MoLiyEzSo2OcIqaamGpitJvxaRWuDk2Zg/xj
         5gms+V3gfFZCQ==
Date:   Tue, 12 Jul 2022 14:11:07 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Subject: Re: [PATCH 4/7] USB: serial: ftdi_sio: Do not reset baudrate to
 9600 on error
Message-ID: <20220712141107.24b3f44d@thinkpad>
In-Reply-To: <CAHp75VdamVbTZ2--GXLY6u_O9QmqN5GXTyZQ-NLfWWaEX6bBBw@mail.gmail.com>
References: <20220707145354.29705-1-kabel@kernel.org>
        <20220707145354.29705-5-kabel@kernel.org>
        <CAHp75VdamVbTZ2--GXLY6u_O9QmqN5GXTyZQ-NLfWWaEX6bBBw@mail.gmail.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I forgot to look at your comments before sending v2, ouch :(

On Fri, 8 Jul 2022 17:51:00 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Jul 7, 2022 at 4:57 PM Marek Beh=C3=BAn <kabel@kernel.org> wrote:
> >
> > From: Pali Roh=C3=A1r <pali@kernel.org>
> >
> > On failure to set new baudrate, reset baudrate to the previous value =20
>=20
> a new
> baud rate
>=20
> > (as is done by other serial drivers) instead of resetting to 9600. =20
>=20
> ...
>=20
> > +                       baud =3D old_baud ? old_baud : 9600; =20
>=20
> Can be written as
>=20
>   baud =3D old_baud ?: 9600;
>=20
> ...
>=20
> > +                       if (div_value =3D=3D (u32)-1) { =20
>=20
> Oh, unsigned -1? Can you define it with a meaningful name and depends
> on the semantics use U32_MAX or GENMASK()?
>=20
> > +                               baud =3D 9600;
> > +                               div_value =3D ftdi_sio_baud_to_divisor(=
baud);
> > +                       } =20
>=20
> ...
>=20
> > +                       baud =3D (old_baud >=3D 183 && old_baud <=3D 30=
00000) ? old_baud : 9600; =20
>=20
> These repetitive magics are error prone (easy to make a mistake or
> off-by-one error). Can you create a simple helper for this?
>=20

