Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6EA50A98
	for <linux-serial@vger.kernel.org>; Thu, 22 Feb 2024 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609743; cv=none; b=e2av1nHxHbwHOELkfIyKHoaVDTaHuKrg0bx/iCQQaTK0PaC0aKiUOnVJy+TWdw2xDQcT/Y5nMPFFYnNI8lYUALvv1IYLrS7yvwIUkVh7VmBmJ16OT7ydW3xNVumQQOZW/VkwI+RoHjTKd7SceFu8FDcHEhBiy6aAY+xJ9ijlVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609743; c=relaxed/simple;
	bh=dgZsJm7uByRNfxMMtDbX4WJFJ73AthIJb5A2+iWbWp4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=G7J7dBrfrOdq9hlH7qK292ln8nuhb/Df+uAOXJBQCRRnILiXbJyRR/Pla/z/iHMgFDULHpmVPT/CQjvNJmL1QNJTD5A2QlGxDKEhANb3hToFlLo0Wk1Mu/mF3zZ+pwMJ9sKBktltE3X83teMeXeq088hgASLCBW19CxVI3qjWSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ql432YWo; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ql432YWo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708609742; x=1740145742;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dgZsJm7uByRNfxMMtDbX4WJFJ73AthIJb5A2+iWbWp4=;
  b=Ql432YWoIsS19FM2sxtlyLeO07RL9h2pg5uR7kf2E3CXZF327IVXM+16
   zyHLT0En5VtUcEQ4mkD4UA69czAmopviv2hRsphBTcQgpK3GcZg+OxEhm
   L5jQAwLMPwFHqEJ3H004qpqLlUXrpHkdYxLG2SP9hw6ZfrIPm3c7Q/9Nw
   JX9fyj1VcSG8HVzb/yTEul9aaGZR2DaM7y3eTSZQQiVlYMrQnHmcRNKD8
   y0bR2UrduFc9x+++uRWbEnnQqnfjhRtuRmUXyqCxQ1VuAS3v+z5K0eLP9
   8GTspUw06k520uz+VLgxi2+wEwwAjaqteqeix5s0jJUXhkLrZR2wXD3u1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="20267483"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="20267483"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:49:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="36331154"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.249.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:49:00 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 22 Feb 2024 15:48:48 +0200 (EET)
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: 8250_dw: Emit an error message if getting the
 baudclk failed
In-Reply-To: <rxbnydqttxdduseprrnugirdvndznbfpi3q2nxctxdelhoc6t6@7aj4jmzvorv4>
Message-ID: <3dca13d5-6ee4-e417-577f-79a5b16eb469@linux.intel.com>
References: <20240222111922.2016122-2-u.kleine-koenig@pengutronix.de> <786cecc3-4723-4b96-679e-1ea9736d3f6b@linux.intel.com> <rxbnydqttxdduseprrnugirdvndznbfpi3q2nxctxdelhoc6t6@7aj4jmzvorv4>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1411230698-1708609728=:1961"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1411230698-1708609728=:1961
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 22 Feb 2024, Uwe Kleine-K=F6nig wrote:
> On Thu, Feb 22, 2024 at 01:50:40PM +0200, Ilpo J=E4rvinen wrote:
> > On Thu, 22 Feb 2024, Uwe Kleine-K=F6nig wrote:
> >=20
> > > Instead of silently giving up, at least tell what the problem is.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/tty/serial/8250/8250_dw.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8=
250/8250_dw.c
> > > index 2d1f350a4bea..94aa3dddb71e 100644
> > > --- a/drivers/tty/serial/8250/8250_dw.c
> > > +++ b/drivers/tty/serial/8250/8250_dw.c
> > > @@ -597,7 +597,8 @@ static int dw8250_probe(struct platform_device *p=
dev)
> > >  =09if (data->clk =3D=3D NULL)
> > >  =09=09data->clk =3D devm_clk_get_optional_enabled(dev, NULL);
> > >  =09if (IS_ERR(data->clk))
> > > -=09=09return PTR_ERR(data->clk);
> > > +=09=09return dev_err_probe(dev, PTR_ERR(data->clk),
> > > +=09=09=09=09     "failed to get baudclk\n");
> >=20
> > Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> Thanks. Is the expectation now with your tag that Greg (added to Cc:)
> picks up this patch?=20

Yes, Greg handles applying serial patches. There's just too low volume of=
=20
patches for it be useful for me to setup some an intermediate tree for=20
8250_dw/lpss only.

--=20
 i.

--8323328-1411230698-1708609728=:1961--
