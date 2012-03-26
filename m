From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] serial: pl011: implement workaround for CTS clear event issue
Date: Mon, 26 Mar 2012 11:05:16 +0200
Message-ID: <CACRpkdZAc0yk6URPzQ7x8UGaVHBMV-3MB2r0gu-7muc3hsh6aA@mail.gmail.com>
References: <1332748868-10172-1-git-send-email-linus.walleij@stericsson.com>
	<20120326081756.GI5611@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44883 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254Ab2CZJFR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 26 Mar 2012 05:05:17 -0400
Received: by obbeh20 with SMTP id eh20so4948620obb.19
        for <linux-serial@vger.kernel.org>; Mon, 26 Mar 2012 02:05:16 -0700 (PDT)
In-Reply-To: <20120326081756.GI5611@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@stericsson.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Christophe Arnal <christophe.arnal@stericsson.com>, Guillaume Jaunet <guillaume.jaunet@stericsson.com>, Matthias Locher <Matthias.Locher@stericsson.com>, Chanho Min <chanho0207@gmail.com>, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>

On Mon, Mar 26, 2012 at 10:17 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Mar 26, 2012 at 10:01:08AM +0200, Linus Walleij wrote:
>> - =A0 =A0 unsigned int status, pass_counter =3D AMBA_ISR_PASS_LIMIT;
>> + =A0 =A0 unsigned int status;
>
> Why are you removing the pass counter and associated code, which was
> there before your work-around patch was applied?

Good point, I'll cook a v2 which restores that counter an break clause =
to
what it was before the workaround was added.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
