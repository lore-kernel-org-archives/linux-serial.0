Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A04DC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 22 Apr 2022 15:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449561AbiDVPzT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Apr 2022 11:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449529AbiDVPzS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Apr 2022 11:55:18 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31D11B786;
        Fri, 22 Apr 2022 08:52:23 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3497C1C0008;
        Fri, 22 Apr 2022 15:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650642741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BNm/kV5lP/NqXyJ/4Wl3+B1GvvJqQJP0zcwUcw3hNyI=;
        b=nXDDU4Fwr+B1qGnRRbP9QHP1Y3mOXTVwR9xh4Un2TtnlqUs5B5dFXdF1bOul/p8Vw8Gt9d
        8heXy2fOrsttfQ+C0TDHzrnFfHZZuBS7D4c0HFxFc/kwcRvM6m8AK5C4ol1REyXRBfw4ja
        UYDp3WR05CgpsRYJTpICpUPzFCyJvk5jpK1/7F00dv1kv/qMNqESxokmbLPMvfmYiBLNe+
        DdLVwGyZj80a1lD6gYSveHoiG3XS6eAg8iMF7TusnWtU3gvOorcofDAhJ8Ca5TFSN+QybE
        uV5LOWGLKhEOp+JRpM78+xfY0Jpxh5uaxwBHOQsWLNlTrAalowsyzYOo5w3jFQ==
Date:   Fri, 22 Apr 2022 17:52:18 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v6 11/12] bestla: Enable DMA, UART3 and UART4
Message-ID: <20220422175218.281f83ee@xps13>
In-Reply-To: <CAMuHMdVZ+X2y8sid736nwOoSshJXp7C3Oc5AuObyhHdnU7uGFg@mail.gmail.com>
References: <20220421095323.101811-1-miquel.raynal@bootlin.com>
        <20220421095323.101811-12-miquel.raynal@bootlin.com>
        <20220421122143.7526d676@xps13>
        <YmK19DPzjJxBZHHm@kroah.com>
        <CAMuHMdVZ+X2y8sid736nwOoSshJXp7C3Oc5AuObyhHdnU7uGFg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg & Geert,

geert@linux-m68k.org wrote on Fri, 22 Apr 2022 16:26:05 +0200:

> Hi Miquel,
>=20
> On Fri, Apr 22, 2022 at 4:04 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Thu, Apr 21, 2022 at 12:21:43PM +0200, Miquel Raynal wrote: =20
> > > miquel.raynal@bootlin.com wrote on Thu, 21 Apr 2022 11:53:22 +0200: =
=20
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
> > >
> > > Please ignore these two dts patches, they were meant for testing
> > > purposes only, sorry for the noise. =20
> >
> > I can't do that, please resend a new version of the series as our tools
> > take all of the patches in a series. =20
>=20
> While at it, please drop patch 10/12 from the reposted series, too,
> as it should go in through the renesas-arm-dt and soc trees.

Sure, no problem.

Thanks,
Miqu=C3=A8l
