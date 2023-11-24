Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZN3dThfj"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39441AE
	for <linux-serial@vger.kernel.org>; Fri, 24 Nov 2023 02:39:09 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D0791E0003;
	Fri, 24 Nov 2023 10:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700822348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=435VCEZZFNFae7GnKZxuus26Zn/+jvuEWowGAG/GuU4=;
	b=ZN3dThfjtz2rLPTcM2bfZ1MKHUPgfUnP/SemkwhmKrd9x7TaPX8NVQZDLp5Q+/VTQ9J+vR
	cjW4jJnGWmQZfr0gdTUgSyypLqq8u42+zKSbuKXFshfTYzGBztBZkVfaRuFEPeyPaw2XHk
	zd7TEB0oUawUYOxYKFSwmzGsiT+5ITSASaG9cM+2lhzg8dtz8Ps73sHc/f3ZjE61C1GIgx
	Vn0TjhYgJVtQgsMVoSYFSsU+dqzZX1MUWGFNfee3Au9Dh+oQXNUrapjK5QnGNlnKd+YueC
	W97zw5BnqdXqAp9Zi92RC8nKOPHUTJ3bQoUE/bE9boKACztXE3RlS1XuGg5wGg==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Nov 2023 11:39:07 +0100
Message-Id: <CX6Z7BRRRECO.3I32FB3Y8Z21G@tleb-bootlin-xps13-01>
To: "Tony Lindgren" <tony@atomide.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if
 no console suspend
Cc: "Kevin Hilman" <khilman@kernel.org>, "Thomas Richard"
 <thomas.richard@bootlin.com>, <gregkh@linuxfoundation.org>,
 <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
 <gregory.clement@bootlin.com>, <u-kumar1@ti.com>, <d-gole@ti.com>,
 <thomas.petazzoni@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20231017130540.1149721-1-thomas.richard@bootlin.com>
 <7hfs213u0r.fsf@baylibre.com> <20231024045109.GT27774@atomide.com>
 <7hjzrbj29t.fsf@baylibre.com> <20231025064131.GZ27774@atomide.com>
 <75b6cda8-c809-409b-8be9-ad8a4db63c14@bootlin.com>
 <20231031105247.GC57044@atomide.com> <7h34xqitl0.fsf@baylibre.com>
 <CX5F88JLWFUW.Z36KQB2PX554@tleb-bootlin-xps13-01>
 <20231124053727.GU5166@atomide.com>
In-Reply-To: <20231124053727.GU5166@atomide.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Fri Nov 24, 2023 at 6:37 AM CET, Tony Lindgren wrote:
> * Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> [231122 14:47]:
> > Hi Kevin Hilman, Tony Lindgren & Thomas Richard,
> >=20
> > On Tue Oct 31, 2023 at 6:34 PM CET, Kevin Hilman wrote:
> > > Tony Lindgren <tony@atomide.com> writes:
> > > > * Thomas Richard <thomas.richard@bootlin.com> [231031 10:15]:
> > > >> Please find below the logs of the test you asked me.
> > > >
> > > > OK great thanks!
> > > >
> > > >> I added the call of pm_runtime_get_usage_count at the end of the s=
uspend
> > > >> function.
> > > >> The console is attached on 2800000.serial, it has usage_count=3D4.
> > > >> Other serial has usage_count=3D3.
> > > >
> > > > So as suspected, it seems the power domain gets force suspended
> > > > somewhere despite the usage_count.
> > >
> > > I think the only way this could happen (excluding any bugs, of course=
)
> > > would be for pm_runtime_force_suspend() to be getting called somewher=
e,
> > > but I thought the earlier patch made that call conditional, so maybe
> > > there is another path where that is getting called?
> >=20
> > I'm coming back on this topic as the upstream fix is less than ideal, a=
s
> > everyone here was agreeing.
>
> Thanks for looking into it.
>
> > I've had a look at the genpd code & power-domains get powered-off at
> > suspend_noirq without caring about runtime PM refcounting. See
> > genpd_suspend_noirq & genpd_finish_suspend.
> >=20
> > Behavior is:
> >=20
> >  - In all cases, call suspend_noirq on the underlying device.
> >  - Stop now if device is in wakeup path & PD has the
> >    GENPD_FLAG_ACTIVE_WAKEUP flag.
> >  - If the PD has start & stop callbacks & is not runtime suspended, cal=
l
> >    the stop callback on the device.
> >  - Increment the count of suspended devices on this PD.
> >  - If PD is already off or always on, stop.
> >  - If this is the last device on this PD (and some other checks), then
> >    do the PD power off (and maybe parent PDs).
> >=20
> > The current patch sets the PD as always on at suspend. That would not
> > work if our PD driver registered start/stop callbacks as those would
> > get called.
> >=20
> > The right solution to avoid getting the PD cut would be to mark the
> > serials we want to keep alive as on the wakeup path using
> > device_set_wakeup_path(dev) at suspend. That also requires the PD to be
> > marked using the GENPD_FLAG_ACTIVE_WAKEUP flag, which is currently not
> > the case.
>
> Not sure if we unconditionally want to set GENPD_FLAG_ACTIVE_WAKEUP as
> the pm_domain.h describes it with "Instructs genpd to keep the PM domain
> powered". The power domain should not force suspend automatically if ther=
e
> are active runtime PM users even without that flag..

Hey don't forgot the important part!

> Instructs genpd to keep the PM domain powered on, in case any of its
> attached devices is used in the wakeup path to serve system wakeups.

Checking the code confirms this behavior. Grep for the macro
genpd_is_active_wakeup rather than GENPD_FLAG_ACTIVE_WAKEUP. It gets
used twice (suspend & resume), both in the same manner:

   if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd))

This means this flag won't have any impact on runtime PM handling of
power-domains. By the way, other users of the flag enable it at PD
registration & don't touch it afterwards.

> > That last aspect is what I'm unsure of: should we add this flag to all
> > power-domains created by ti_sci_pm_domains? Should we pass something
> > from devicetree? I don't see the reason for not enabling this behavior
> > by default?
>
> To me this still seems like a workaround because of the active runtime
> PM usage count in the consumer driver :)
>
> And GENPD_FLAG_ACTIVE_WAKEUP should not need to be configured separately
> from the runtime PM usage count in this case. Sure there may be other
> cases where GENPD_FLAG_ACTIVE_WAKEUP needs to be set dynamically, but
> we should understand why the power domain code thinks it's OK to shut
> down the domain if it has active users.

There is currently nothing that links the runtime PM refcount to whether
or not the power-domains get powered-off at suspend_noirq. Should that
change? Maybe, but it would be a big behavioral change.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
