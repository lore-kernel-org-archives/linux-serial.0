Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A96C7EE29
	for <linux-serial@archiver.kernel.org>; Thu, 25 May 2023 13:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241356AbjEYNpQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 May 2023 09:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjEYNpP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 May 2023 09:45:15 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A949F186;
        Thu, 25 May 2023 06:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lab8uV6Uad5CeYxT9BC8u1kKhysJLzzYp8wyjAQA9a8=; b=cveGaPMW4bzWesf+afiVBeA8W+
        g2Zx3flpdZfa29mFg7VT5kbHvqycQTGyJqU8Pb/Eseis9OeW7EeVXThtxIdarhcjnRKV4M3IBUp8/
        OLdCcG3isRaG6MaP/KJ6hUY9JKG7XGnclrOLqAW8qSCl0rrAAZZN9Zl/wtYiAsMwf5Gg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:44290 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q2BH9-0007uR-BN; Thu, 25 May 2023 09:45:08 -0400
Date:   Thu, 25 May 2023 09:45:06 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        jringle@gridpoint.com, tomasz.mon@camlingroup.com,
        l.perczak@camlintechnologies.com,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230525094506.21aea1930d2d2a89d18ff7af@hugovil.com>
In-Reply-To: <751bc02d-d06f-55cb-cb7a-a39871a0775d@linux.intel.com>
References: <20230525040324.3773741-1-hugo@hugovil.com>
        <20230525040324.3773741-4-hugo@hugovil.com>
        <751bc02d-d06f-55cb-cb7a-a39871a0775d@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: Re: [PATCH v3 03/11] serial: sc16is7xx: mark IOCONTROL register as
 volatile
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 25 May 2023 14:02:19 +0300 (EEST)
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Thu, 25 May 2023, Hugo Villeneuve wrote:
>=20
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >=20
> > Bit SRESET (3) is cleared when a reset operation is completed. Having
> > the IOCONTROL register as non-volatile will always read SRESET as 1.
> > Therefore mark IOCONTROL register as a volatile register.
> >=20
> > Fixes: dfeae619d781 ("serial: sc16is7xx")
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>=20
> What is the impact of this problem? That is, what doesn't work? I only se=
e=20
> writes to SC16IS7XX_IOCONTROL_REG. If there are no concrete problems=20
> fixed, don't put Fixes tag.

Hi,
there is a concrete problem when dumping the registers as the value read fo=
r bit SRESET is incorrect, but it doesn't impact running code.

I can remove the Fixes.

Hugo.


> > ---
> >  drivers/tty/serial/sc16is7xx.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is=
7xx.c
> > index 00054bb49780..a7c4da3cfd2b 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -488,6 +488,7 @@ static bool sc16is7xx_regmap_volatile(struct device=
 *dev, unsigned int reg)
> >  	case SC16IS7XX_TXLVL_REG:
> >  	case SC16IS7XX_RXLVL_REG:
> >  	case SC16IS7XX_IOSTATE_REG:
> > +	case SC16IS7XX_IOCONTROL_REG:
> >  		return true;
> >  	default:
> >  		break;
> >=20
>=20
