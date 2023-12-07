Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fHo5Dh73"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D1D10FE;
	Thu,  7 Dec 2023 01:32:56 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB1B71C0002;
	Thu,  7 Dec 2023 09:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701941574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CPXqvcpSDGijTuXmKfvNe4MeIOYSS9zKCWi8Uhthpns=;
	b=fHo5Dh73Mzh1Pm2/88up58zS4l2hX9fOh1nl8V1DJsh+uf9+kWUWNs4HIcAoTDnFZWZpvs
	y0bjRPT+zUvFsxCmCnHs5itRxufoce7mtieNa9sDAISX4qnQWxiAyoVp3fIbhuptUKIuO5
	xaxlezFPR5W0PUDaWCwFcR1YpvcNw3+YkV+irPgNZ3jRq9waFaosOI/sy5T4KXfSf9Cqgn
	+mtM2tn9oG52789MZUB9/tNOuV9SRa73g991kSnRml96MT35PNk0tYnCNP98eu6Ff9QP3h
	T45FgTlBwH7eIRzXHsCQ/SKD08TxQcMVqOTdQ4lSL/NHUaFGAOm5lrPSJe5TUA==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Dec 2023 10:32:53 +0100
Message-Id: <CXHZXP7XVD0T.24N3YDLX7I929@bootlin.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v5 2/9] tty: serial: amba: Use linux/{bits,bitfield}.h
 macros
Cc: "Russell King" <linux@armlinux.org.uk>, "Jiri Slaby"
 <jirislaby@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-serial@vger.kernel.org>, "Linus Walleij" <linus.walleij@linaro.org>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
X-Mailer: aerc 0.15.2
References: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com>
 <20231130-mbly-uart-v5-2-6566703a04b5@bootlin.com>
 <2023120742-argue-slighting-6120@gregkh>
In-Reply-To: <2023120742-argue-slighting-6120@gregkh>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Dec 7, 2023 at 2:37 AM CET, Greg Kroah-Hartman wrote:
> On Thu, Nov 30, 2023 at 03:07:14PM +0100, Th=C3=A9o Lebrun wrote:
> > The driver uses bit shifts and hexadecimal expressions to declare
> > constants. Replace that with the BIT(), GENMASK() & FIELD_PREP_CONST()
> > macros to clarify intent.
> >=20
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  include/linux/amba/serial.h | 248 +++++++++++++++++++++++-------------=
--------
> >  1 file changed, 127 insertions(+), 121 deletions(-)
>
> As 0-day had a problem with this patch, I've applied only patch 1 of
> this series.  Can you fix it up and rebase and resend the rest again
> (while adding the collected reviewed-by that some patches in this series
> had)?

So the issue is this: the header file gets included in
arch/arm/include/debug/pl01x.S that gets included in arch/arm/kernel/debug.=
S
(see #include CONFIG_DEBUG_LL_INCLUDE).

I don't see any easy way out of this, so I guess it means the patch must be
dropped. If someone confirms that there are indeed no solution to have BIT(=
),
GENMASK() & FIELD_PREP_CONST() accessible from assembly, I'll send the next
version.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
