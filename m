Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93C7CCA479
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 16:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbiGGQI2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 12:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbiGGQI1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 12:08:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAFCEA
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 09:08:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02862623CE
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 16:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C84C341C0;
        Thu,  7 Jul 2022 16:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657210102;
        bh=wy4qJ7zgsqNwfIFddVBAYBc3OzAoi3JjuhLhx+5Xln8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P8bZGyJ2ZgJVJvo8q/XrvhVY2QE5g2K0r7vzKhNogNYX4N33L35cf/R82414AfZSk
         c1G4Abm3YDLZ7K8ZarcJw0qZ3ehDMS6KXGB4VnbC5yVrNZYNl2iZVKERj6VVBwbN1O
         j4BnznWLOo675n6R9narrPIPbMS7NlfHCPyYNlWjO8MPaB8JiDsfQYw4zaSvyel0bE
         W6I1zu1+HS2PpdYSnV24fLyA367vUnL8aOKNvYuuzurjCHBkSB5nCET/is1qwyu86H
         Y5cJp562nqfpmiWfKc3IxhUxgMp6j4zkm24POPpLacZJnsm04hvL3tPHM/q1suhwyc
         iYdfn5Tbunk0Q==
Date:   Thu, 7 Jul 2022 18:08:18 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Subject: Re: [PATCH 5/7] USB: serial: ftdi_sio: Fix baudrate rounding for
 ASYNC_SPD_CUST
Message-ID: <20220707180818.53b7e79a@dellmb>
In-Reply-To: <Ysb3hNJ6wPRe+oxo@kroah.com>
References: <20220707145354.29705-1-kabel@kernel.org>
        <20220707145354.29705-6-kabel@kernel.org>
        <Ysb3hNJ6wPRe+oxo@kroah.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 7 Jul 2022 17:11:00 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Jul 07, 2022 at 04:53:52PM +0200, Marek Beh=C3=BAn wrote:
> > From: Pali Roh=C3=A1r <pali@kernel.org>
> >=20
> > Use DIV_ROUND_CLOSEST() for more accurate baudrate calculation for
> > ASYNC_SPD_CUST instead of rounding it just down. =20
>=20
> Why?  What does this change or fix?

To compute more accurate baudrate when given custom divisor.

User requests a baudrate B.
Application uses old API, so it computes divisor D for baudrate B.
The driver then tries to compute back the requested baudrate B. To
compute it back more accurately, rounding to closes value should be
used.

Marek

