Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9640CC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 10 Mar 2022 19:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241617AbiCJTCO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Mar 2022 14:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiCJTCO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Mar 2022 14:02:14 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC04BCEA05
        for <linux-serial@vger.kernel.org>; Thu, 10 Mar 2022 11:01:12 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 02742100003;
        Thu, 10 Mar 2022 19:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646938866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ONlybgDBnhJ3zqRDbczF5Bw/mRATqhD5AsOrxYRctYY=;
        b=cAUV+dTEj4CtwewJmwj744v6LYk0rcuKjXWGxOXNp5NZ5KQK7Faa0i4nNakqjRFsvM9qR/
        /FDhMXIEL74zr3pj66InYiy1LkmwXab2Y3YETkDR6F95EekvBVPfG+w9bnb9GVlBxPswN0
        +Hah2QwWkw5n3IxOYlmD8b2e/f+Ciiezz/KmanDCrD+PcOA/6aM7n//73jLWaYfmJsKHCt
        uw2lavv57ZlnvvTsElDMR4Jixb3u4BmOPG8xmOW6QDdpi8K+x8QU1aLcfDo1wEnXxsXFRQ
        /yL1khisgYAUwlEtVSE+LJnKzyo/NbGWl4FrAqfMvk03QTeVUFebC6tOz402Tg==
Date:   Thu, 10 Mar 2022 20:01:01 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>
Subject: Re: [PATCH 3/7] serial: 8250_dw: Use a fallback CPR value if not
 synthesized
Message-ID: <20220310200101.13233016@xps13>
In-Reply-To: <Yio9QcFqqhjiAcMT@smile.fi.intel.com>
References: <20220310161650.289387-1-miquel.raynal@bootlin.com>
 <20220310161650.289387-4-miquel.raynal@bootlin.com>
 <Yio9QcFqqhjiAcMT@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Andy,

andriy.shevchenko@linux.intel.com wrote on Thu, 10 Mar 2022 20:02:41
+0200:

> On Thu, Mar 10, 2022 at 05:16:46PM +0100, Miquel Raynal wrote:
> > From: Phil Edworthy <phil.edworthy@renesas.com>
> >=20
> > This UART controller can be synthesized without the CPR register.
> > In that case, let's use the platform information to provide a CPR value=
. =20
>=20
> ...
>=20
> > +#include <linux/of_device.h> =20
>=20
> > +	const struct dw8250_platform_data *plat =3D of_device_get_match_data(=
up->port.dev); =20
>=20
> No. Please use device property APIs.

Are you suggesting the use of CPR DT property? If yes, what is the
point if there is one CPR per SoC? I would argue that DT description is
already quite complex and supporting one or another register is up to
the OS as long as we can map CPR registers to SoCs?

TBH Phil initially introduced a DT property which I turned into a pdata
entry because when I can avoid playing with the bindings, I generally
do so.

Thanks,
Miqu=C3=A8l
