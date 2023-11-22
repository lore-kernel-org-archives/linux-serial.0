Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZfV+KUxs"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D47FC1
	for <linux-serial@vger.kernel.org>; Wed, 22 Nov 2023 06:47:19 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E7AB9C000C;
	Wed, 22 Nov 2023 14:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700664437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RChDF0hQ+fd2wEyvYztJ025TvP/Yb4lGLcnjoT4C4bc=;
	b=ZfV+KUxsuFNuSIsHwqhpPfokW24VcaNfDlzp53hqKNPP3Eb8C++QUk704IKOHvglTW7Oaw
	OgfR9+meIKaJ1GuE4GWZ03ENyA2tJuyVOSbYmkljygI5umYlKhEkaezoWS03LGdm/pN29b
	2n+FU1Upzyhkhz+nfOimw3XqXquTdeNTJ/EuEeyMGk+WCa4UCZ/bp36r+t4scZNwW0Vrgn
	EFiAUn3eczGyWR77BTvc4TMs9cIczf5MIBXp0aPqgbqNGPRmvrhSjyHdemTVprlG8T5bPx
	3WGsVU41eXGs4cJSYrISe5Agl2IAsJvlXIco8sKlx5bYrH3h9mMEjD7Oh/M1mw==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Nov 2023 15:47:16 +0100
Message-Id: <CX5F88JLWFUW.Z36KQB2PX554@tleb-bootlin-xps13-01>
Cc: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
 <linux-serial@vger.kernel.org>, <gregory.clement@bootlin.com>,
 <u-kumar1@ti.com>, <d-gole@ti.com>, <thomas.petazzoni@bootlin.com>
To: "Kevin Hilman" <khilman@kernel.org>, "Tony Lindgren" <tony@atomide.com>,
 "Thomas Richard" <thomas.richard@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if
 no console suspend
X-Mailer: aerc 0.15.2
References: <20231017130540.1149721-1-thomas.richard@bootlin.com>
 <7hfs213u0r.fsf@baylibre.com> <20231024045109.GT27774@atomide.com>
 <7hjzrbj29t.fsf@baylibre.com> <20231025064131.GZ27774@atomide.com>
 <75b6cda8-c809-409b-8be9-ad8a4db63c14@bootlin.com>
 <20231031105247.GC57044@atomide.com> <7h34xqitl0.fsf@baylibre.com>
In-Reply-To: <7h34xqitl0.fsf@baylibre.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hi Kevin Hilman, Tony Lindgren & Thomas Richard,

On Tue Oct 31, 2023 at 6:34 PM CET, Kevin Hilman wrote:
> Tony Lindgren <tony@atomide.com> writes:
> > * Thomas Richard <thomas.richard@bootlin.com> [231031 10:15]:
> >> Please find below the logs of the test you asked me.
> >
> > OK great thanks!
> >
> >> I added the call of pm_runtime_get_usage_count at the end of the suspe=
nd
> >> function.
> >> The console is attached on 2800000.serial, it has usage_count=3D4.
> >> Other serial has usage_count=3D3.
> >
> > So as suspected, it seems the power domain gets force suspended
> > somewhere despite the usage_count.
>
> I think the only way this could happen (excluding any bugs, of course)
> would be for pm_runtime_force_suspend() to be getting called somewhere,
> but I thought the earlier patch made that call conditional, so maybe
> there is another path where that is getting called?

I'm coming back on this topic as the upstream fix is less than ideal, as
everyone here was agreeing.

I've had a look at the genpd code & power-domains get powered-off at
suspend_noirq without caring about runtime PM refcounting. See
genpd_suspend_noirq & genpd_finish_suspend.

Behavior is:

 - In all cases, call suspend_noirq on the underlying device.
 - Stop now if device is in wakeup path & PD has the
   GENPD_FLAG_ACTIVE_WAKEUP flag.
 - If the PD has start & stop callbacks & is not runtime suspended, call
   the stop callback on the device.
 - Increment the count of suspended devices on this PD.
 - If PD is already off or always on, stop.
 - If this is the last device on this PD (and some other checks), then
   do the PD power off (and maybe parent PDs).

The current patch sets the PD as always on at suspend. That would not
work if our PD driver registered start/stop callbacks as those would
get called.

The right solution to avoid getting the PD cut would be to mark the
serials we want to keep alive as on the wakeup path using
device_set_wakeup_path(dev) at suspend. That also requires the PD to be
marked using the GENPD_FLAG_ACTIVE_WAKEUP flag, which is currently not
the case.

That last aspect is what I'm unsure of: should we add this flag to all
power-domains created by ti_sci_pm_domains? Should we pass something
from devicetree? I don't see the reason for not enabling this behavior
by default?

I've tested this approach & it works. See below for diff.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

8< -------------------------------

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/=
ti_sci_pm_domains.c
index c091d569ecd5..b0d473776278 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -168,6 +168,7 @@ static int ti_sci_pm_domain_probe(struct platform_devic=
e *pdev)

            pd->pd.power_off =3D ti_sci_pd_power_off;
            pd->pd.power_on =3D ti_sci_pd_power_on;
+           pd->pd.flags |=3D GENPD_FLAG_ACTIVE_WAKEUP;
            pd->idx =3D args.args[0];
            pd->parent =3D pd_provider;

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/=
8250_omap.c
index 4b33f4529aed..ab2f8b7927c3 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1633,8 +1633,12 @@ static int omap8250_suspend(struct device *dev)
   if (!device_may_wakeup(dev))
      priv->wer =3D 0;
   serial_out(up, UART_OMAP_WER, priv->wer);
-  if (uart_console(&up->port) && console_suspend_enabled)
-     err =3D pm_runtime_force_suspend(dev);
+  if (uart_console(&up->port)) {
+     if (console_suspend_enabled)
+        err =3D pm_runtime_force_suspend(dev);
+     else
+        device_set_wakeup_path(dev);
+  }
   flush_work(&priv->qos_work);

   return err;
