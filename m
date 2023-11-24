Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="ju3QMJlQ"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36FFD6C
	for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 21:37:51 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 0F85260B1C;
	Fri, 24 Nov 2023 05:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1700804270;
	bh=4ppk+YEhzs9h0xg0LKz2d3DT24ELcLb2X0cy7NsFrnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ju3QMJlQY+adTHE2rnCWTK5E42OQSUG5hEDogj/4tVFkxDBzPZRu6dsc39Eijltvt
	 uKPbmmyy6ongePUKA8CHXYweYOCZpjAE0xiTEJtzUvOIzoVKqT53X+5cw7+d9cERp6
	 CNGbkocWnqWQAiVOCdP5eaPWZhAX96vS5eXruF5RraGi8lUQRM+axjFyPQIwUtBxaw
	 0sFrAz/zdcpEY7yRxZl1Fr5kqLEEoYyBQQ8MLZ+Vtb5if/rPjfmvU6cfjyw7x8sgNt
	 ndH9gorJ/DNxQ3A4iFBttfISotvUD5THLTRlxukd6wIcakAUVqhJcd/x1hrWY4RZrz
	 dq8nal966S5hA==
Date: Fri, 24 Nov 2023 07:37:27 +0200
From: Tony Lindgren <tony@atomide.com>
To: =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: Kevin Hilman <khilman@kernel.org>,
	Thomas Richard <thomas.richard@bootlin.com>,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-serial@vger.kernel.org, gregory.clement@bootlin.com,
	u-kumar1@ti.com, d-gole@ti.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if no
 console suspend
Message-ID: <20231124053727.GU5166@atomide.com>
References: <20231017130540.1149721-1-thomas.richard@bootlin.com>
 <7hfs213u0r.fsf@baylibre.com>
 <20231024045109.GT27774@atomide.com>
 <7hjzrbj29t.fsf@baylibre.com>
 <20231025064131.GZ27774@atomide.com>
 <75b6cda8-c809-409b-8be9-ad8a4db63c14@bootlin.com>
 <20231031105247.GC57044@atomide.com>
 <7h34xqitl0.fsf@baylibre.com>
 <CX5F88JLWFUW.Z36KQB2PX554@tleb-bootlin-xps13-01>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CX5F88JLWFUW.Z36KQB2PX554@tleb-bootlin-xps13-01>

* Théo Lebrun <theo.lebrun@bootlin.com> [231122 14:47]:
> Hi Kevin Hilman, Tony Lindgren & Thomas Richard,
> 
> On Tue Oct 31, 2023 at 6:34 PM CET, Kevin Hilman wrote:
> > Tony Lindgren <tony@atomide.com> writes:
> > > * Thomas Richard <thomas.richard@bootlin.com> [231031 10:15]:
> > >> Please find below the logs of the test you asked me.
> > >
> > > OK great thanks!
> > >
> > >> I added the call of pm_runtime_get_usage_count at the end of the suspend
> > >> function.
> > >> The console is attached on 2800000.serial, it has usage_count=4.
> > >> Other serial has usage_count=3.
> > >
> > > So as suspected, it seems the power domain gets force suspended
> > > somewhere despite the usage_count.
> >
> > I think the only way this could happen (excluding any bugs, of course)
> > would be for pm_runtime_force_suspend() to be getting called somewhere,
> > but I thought the earlier patch made that call conditional, so maybe
> > there is another path where that is getting called?
> 
> I'm coming back on this topic as the upstream fix is less than ideal, as
> everyone here was agreeing.

Thanks for looking into it.

> I've had a look at the genpd code & power-domains get powered-off at
> suspend_noirq without caring about runtime PM refcounting. See
> genpd_suspend_noirq & genpd_finish_suspend.
> 
> Behavior is:
> 
>  - In all cases, call suspend_noirq on the underlying device.
>  - Stop now if device is in wakeup path & PD has the
>    GENPD_FLAG_ACTIVE_WAKEUP flag.
>  - If the PD has start & stop callbacks & is not runtime suspended, call
>    the stop callback on the device.
>  - Increment the count of suspended devices on this PD.
>  - If PD is already off or always on, stop.
>  - If this is the last device on this PD (and some other checks), then
>    do the PD power off (and maybe parent PDs).
> 
> The current patch sets the PD as always on at suspend. That would not
> work if our PD driver registered start/stop callbacks as those would
> get called.
> 
> The right solution to avoid getting the PD cut would be to mark the
> serials we want to keep alive as on the wakeup path using
> device_set_wakeup_path(dev) at suspend. That also requires the PD to be
> marked using the GENPD_FLAG_ACTIVE_WAKEUP flag, which is currently not
> the case.

Not sure if we unconditionally want to set GENPD_FLAG_ACTIVE_WAKEUP as
the pm_domain.h describes it with "Instructs genpd to keep the PM domain
powered". The power domain should not force suspend automatically if there
are active runtime PM users even without that flag..

> That last aspect is what I'm unsure of: should we add this flag to all
> power-domains created by ti_sci_pm_domains? Should we pass something
> from devicetree? I don't see the reason for not enabling this behavior
> by default?

To me this still seems like a workaround because of the active runtime
PM usage count in the consumer driver :)

And GENPD_FLAG_ACTIVE_WAKEUP should not need to be configured separately
from the runtime PM usage count in this case. Sure there may be other
cases where GENPD_FLAG_ACTIVE_WAKEUP needs to be set dynamically, but
we should understand why the power domain code thinks it's OK to shut
down the domain if it has active users.

Regards,

Tony
