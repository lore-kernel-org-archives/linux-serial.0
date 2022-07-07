Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9A6C43334
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 15:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiGGPvE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 11:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiGGPvE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 11:51:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C1C20BC2
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 08:51:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E03CD62209
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 15:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9D2C3411E;
        Thu,  7 Jul 2022 15:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657209062;
        bh=rs/toSW+dR06ZuTdtW3qdBWMNdR8TOP8zPR7IgfqRIw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IBh/S8iu83+TBwMbRH+H1c5CilEN/2HbdjOamVjoa0r82eX3jNOvW3ZGKuOBtq80z
         5mLcRySD6j7rhl4GIC8fe6/bJ0MzKTEszqFUDsuysteufr0VDa4cnAiqMKyAj9TDN0
         GtWI8i1StNVfUVlsRSTPxZHyCAfif4yJ+IjIyB+zLwWkuOmOG4xFuqXALMnzbJ7cA8
         w10EIUSN/3YMcT+KNak5c5i+BcOWGu/+OM+JI21ZuSpRbvBopjctbQLM4jSy9IYjjH
         Mg+FRICnFPsok0mtaTYwa9lWbEL18cCHaTnhdx6E+447kBmHga0FL3IPsQf4JLU/4v
         TWPCET59UsA0w==
Date:   Thu, 7 Jul 2022 17:50:58 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Subject: Re: [PATCH 3/7] USB: serial: ftdi_sio: Extract SIO divisor code to
 function
Message-ID: <20220707175058.0b5e0b87@dellmb>
In-Reply-To: <Ysb3ORyUAPEOntqK@kroah.com>
References: <20220707145354.29705-1-kabel@kernel.org>
        <20220707145354.29705-4-kabel@kernel.org>
        <Ysb3ORyUAPEOntqK@kroah.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 7 Jul 2022 17:09:45 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Jul 07, 2022 at 04:53:50PM +0200, Marek Beh=C3=BAn wrote:
> > From: Pali Roh=C3=A1r <pali@kernel.org>
> >=20
> > As a code cleanup for future changes, extract divisor code for SIO chip
> > into new function ftdi_sio_baud_to_divisor().
> >=20
> > No functional change.
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > Tested-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > ---
> >  drivers/usb/serial/ftdi_sio.c | 34 ++++++++++++++++++++--------------
> >  1 file changed, 20 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_si=
o.c
> > index 717b97f4e094..45a4eeb1fc70 100644
> > --- a/drivers/usb/serial/ftdi_sio.c
> > +++ b/drivers/usb/serial/ftdi_sio.c
> > @@ -1150,6 +1150,23 @@ static struct usb_serial_driver * const serial_d=
rivers[] =3D {
> >   * *******************************************************************=
********
> >   */
> > =20
> > +static u32 ftdi_sio_baud_to_divisor(int baud)
> > +{
> > +	switch (baud) {
> > +	case 300: return ftdi_sio_b300;
> > +	case 600: return ftdi_sio_b600;
> > +	case 1200: return ftdi_sio_b1200;
> > +	case 2400: return ftdi_sio_b2400;
> > +	case 4800: return ftdi_sio_b4800;
> > +	case 9600: return ftdi_sio_b9600;
> > +	case 19200: return ftdi_sio_b19200;
> > +	case 38400: return ftdi_sio_b38400;
> > +	case 57600: return ftdi_sio_b57600;
> > +	case 115200: return ftdi_sio_b115200;
> > +	default: return -1; =20
>=20
> Why not just return 9600 as a default here like the original code did?

It keeps at 9600 as original code.
Before:
  div_value =3D ftdi_sio_b9600;
  baud =3D 9600;

After:
  baud =3D 9600;
  div_value =3D ftdi_sio_baud_to_divisor(baud);

The new function that converts between the enum values and real values
now indicates when conversion is not possible.

> And returning a negative number for a u32 is not a good idea for the
> obvious reasons you found when you tried to test for it...

Would s32 be ok?
