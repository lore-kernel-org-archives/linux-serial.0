Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C64AC433EF
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 15:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbiGGPwk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 11:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbiGGPwk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 11:52:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A1725EB9
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 08:52:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 513C3623B8
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 15:52:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E178EC3411E;
        Thu,  7 Jul 2022 15:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657209158;
        bh=5rQkcEDAx4LvbNqEvvac8UoGkKA+YHRgtitX6UqVdHo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OEFLsTeHL8rxKtDv+NF0Y282gYNL3Ktxwj8QLFV3yP88iyUtYVvJ3zjY8y6cgnr2B
         0at1tdZPyW011ESZWz5yFcCRtcfd3hif25iCpr7LV2rl5UtDRn/7r5QnhnAs0AEHHi
         E8A1RowjJVNty//vYnswy7zGX/1JJZZYhcmJ6k0RRYTIh4d9DDD4Sz1WL2G6y+sZBg
         LnHCzVXfWuHeIC/ycnXo46syHAAslyd7jZnW/C2yikCAhur84G7FM0m3RGCOmllek8
         Cx131mSOaWIBz8BCKPCq3dpR+SebhK0YZupqRz76BqcMI+Hv4J6o8gr0TlnZnNJMSJ
         W4AoYqoMIBSFw==
Date:   Thu, 7 Jul 2022 17:52:35 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Subject: Re: [PATCH 4/7] USB: serial: ftdi_sio: Do not reset baudrate to
 9600 on error
Message-ID: <20220707175235.2cdb6f9a@dellmb>
In-Reply-To: <Ysb3cotx1FFyiaES@kroah.com>
References: <20220707145354.29705-1-kabel@kernel.org>
        <20220707145354.29705-5-kabel@kernel.org>
        <Ysb3cotx1FFyiaES@kroah.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 7 Jul 2022 17:10:42 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Jul 07, 2022 at 04:53:51PM +0200, Marek Beh=C3=BAn wrote:
> > From: Pali Roh=C3=A1r <pali@kernel.org>
> >=20
> > On failure to set new baudrate, reset baudrate to the previous value
> > (as is done by other serial drivers) instead of resetting to 9600. =20
>=20
> Where is it mandated that this is correct?  Why not keep the existing
> functionality?  Did you just break systems that tried to set invalid
> values and ended up with 9600 as a default?

Pali says all other drivers keep previous value on failure. He got
frustrated when working with FTDI devices because they behaved
differently.

> What changed to make this a new requirement?
>=20
> thanks,
>=20
> greg k-h

