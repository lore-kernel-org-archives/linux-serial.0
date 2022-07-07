Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6421CC433EF
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 15:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiGGPlK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 11:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiGGPlJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 11:41:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CB520BCA
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 08:41:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07060B82266
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 15:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A09C3411E;
        Thu,  7 Jul 2022 15:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657208466;
        bh=aDQ+NZc3mJHbMcgEtkPiTfsQUOrqszXbEpx7feWs/CE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UniczTbF+niql6xZtYxjqPUoZ0X3PI6dekOdwLNIJNO9d71IZldFwboltQbuIyZSm
         E+5rCgZLQSoIpm2/Zl5Y4RvkQFR2zQe6wRpppaUsTrtQIkNqbwnLMMzDC9WI5Z2rpy
         vbepV74hFkdjWXpsZEMLvBH3e8akMQMJ701xRRLlYk7CtR/LUbzBewbqg7hdMwazKP
         TmD9vrFtv8iMJv9cAOkN3txc+5nw+eOXzu+9OzLpnEEYNB8bXjzjuWELhnMy9B5bo+
         QFuBvaMkk2Vw3qEIteM2omovva1RxdgNQHxzEb2fwZfmGg3d/oZ6079AEvWYPsn7/O
         tgMDc6OJfo6+g==
Date:   Thu, 7 Jul 2022 17:41:03 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Subject: Re: [PATCH 3/7] USB: serial: ftdi_sio: Extract SIO divisor code to
 function
Message-ID: <20220707174103.1b59d3b8@dellmb>
In-Reply-To: <Ysb2Z7zrZBTduXfx@kroah.com>
References: <20220707145354.29705-1-kabel@kernel.org>
        <20220707145354.29705-4-kabel@kernel.org>
        <Ysb2Z7zrZBTduXfx@kroah.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 7 Jul 2022 17:06:15 +0200
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
> > Tested-by: Marek Beh=C3=BAn <kabel@kernel.org> =20
>=20
> If you forward on patches from someone else, you too need to sign off on
> them.  Please read the documentation for the details as to what that all
> means.
>=20
> We can't take these as-is without that, for obvious reasons.

Sorry, forgot about that. Will do.

Marek
