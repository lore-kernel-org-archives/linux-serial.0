Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C629C43334
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 16:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiGGQWH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 12:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbiGGQWG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 12:22:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E9B2A731
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 09:22:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F00F7623C3
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 16:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82119C3411E;
        Thu,  7 Jul 2022 16:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657210925;
        bh=P4Rk87dMVkVd/LitYkC/tKKzsxVZIwxVXacQm8OUuY4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nux4GDXz41tnIYvQQK54Q9iJK7Ki2KO5Ql/B29HUszMvJbfTJ1hPPohGjXzE/gDcr
         GWNw3rXR0zT7APqk3bBVMeGpsLRrYYTPhJZunJSC4Q5KD80pHTxL/P+GttYkS/644X
         D2zRM5zfMzLv9qNcU5EJKmGGVNYGgOjlOsH8ZpJ3nGZJLudSRN7whmOjoXC9NLOCXf
         lJuY6g0IRB4xKEtLqROqCWSqhr78rRD3VFXpRoGahkXZrn+Yna91GOQWgJxgcjAUX1
         E3oJEggHzHSeG/A/yTZ3SqQK88d8fyhZg6auwxl6H6qaGpSKzcanRhAZLhlx5a+Ler
         C0qlxDwOVPEvw==
Date:   Thu, 7 Jul 2022 18:22:01 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Subject: Re: [PATCH 2/7] USB: serial: ftdi_sio: Add missing baudrate
 validation
Message-ID: <20220707182201.145b84a7@dellmb>
In-Reply-To: <Ysb284QtPTvUge+F@kroah.com>
References: <20220707145354.29705-1-kabel@kernel.org>
        <20220707145354.29705-3-kabel@kernel.org>
        <Ysb284QtPTvUge+F@kroah.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 7 Jul 2022 17:08:35 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Jul 07, 2022 at 04:53:49PM +0200, Marek Beh=C3=BAn wrote:
> > From: Pali Roh=C3=A1r <pali@kernel.org>
> >=20
> > More FTDI variants limit the minimal baudrate value. Add lower bound
> > checks. =20
>=20
> Which variants limit it?  Did you just break existing devices and keep
> them from running at really low baud rates?

The variants for which the patch adds the checks. Does this need
to be listed it in commit message?

Marek
