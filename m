Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A240CC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 29 Mar 2022 16:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239307AbiC2QMK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Mar 2022 12:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239297AbiC2QMH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Mar 2022 12:12:07 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90DE13A1DC;
        Tue, 29 Mar 2022 09:10:21 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F358C60007;
        Tue, 29 Mar 2022 16:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648570220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3+i21hElDRAACMVQWT2R9ABQjlgS//mdpmw0fQFDHP8=;
        b=hGBUBFgGLkxnI0a7dY193shNZMqEJ56PS8zLq113l3T6C4+XpB8QM0l01iXjgcO7Zz7C7c
        fN5E7Jo5wfFINaonHOyBQqt3XoL7f0pGonBXRKdunJ1dsuc8Hgj06HUMZd6Ug7ffwAId0x
        vy8bwFON1Zhs8zOxInGMrHbCt4K8ZYAbIdTvf6+aG3RFCx2Gp1DlZymQVQwyIn3aPCX6cb
        wmNsdcdeP3B4eAgnQ/fjW/STzLFOEbjnocfMc+rJNkC2Qx10mwUP5Wp3NXG13YbAmYkdqj
        iLxBB6v+k2h/R3y/vzvjKvMnptyrV6+7g4BeDseXegOSIB/ow3lBPkCZeeAu1g==
Date:   Tue, 29 Mar 2022 18:10:17 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>
Subject: Re: [PATCH v3 00/10] serial: 8250: dw: RZN1 DMA support
Message-ID: <20220329181017.44d35989@xps13>
In-Reply-To: <YkMtShbk3rcFhm+p@smile.fi.intel.com>
References: <20220329152430.756947-1-miquel.raynal@bootlin.com>
        <YkMtShbk3rcFhm+p@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Andy,

andriy.shevchenko@linux.intel.com wrote on Tue, 29 Mar 2022 19:01:14
+0300:

> On Tue, Mar 29, 2022 at 05:24:20PM +0200, Miquel Raynal wrote:
> > Hello,
> >=20
> > Support for the RZN1 DMA engine allows us adapt a little bit the 8250 DW
> > UART driver with to bring DMA support for this SoC.
> >=20
> > This short series applies on top of the series bringing RZN1 DMA
> > support, currently on its v5, see [1]. Technically speaking, only the DT
> > patch needs to be applied after [1]. The other patches can come in at
> > any moment, because if no "dmas" property is provided in the DT, DMA
> > support will simply be ignored.
> >=20
> > [1] https://lore.kernel.org/dmaengine/20220315191255.221473-1-miquel.ra=
ynal@bootlin.com/T/#m0ef3323abce3eec961e142bf2fb35e95b9045fc5 =20
>=20
> Thanks for a new version!
>=20
> It becomes definitely closer to the good enough state.
> Since I have comments and we still in the middle of the merge window
> we have time to address them.

Yes sure, thanks for your quick feedback. I'll propose an updated
version with:
- Empty pdata structures for all the compatibles (only one will remain
  at the end) in order to avoid the "if (pdata)" checks.
- Save the pdata pointer once for all and use derive it directly
  everywhere else.

BTW, you may probably send your Reviewed-by to the DMA series which was
sent a couple of weeks back if you don't have more comments on it?

Thanks,
Miqu=C3=A8l
