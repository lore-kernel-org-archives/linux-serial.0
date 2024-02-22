Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A48C405D4
	for <linux-serial@vger.kernel.org>; Thu, 22 Feb 2024 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602660; cv=none; b=pX2FG5WHABy4dPrLE5vQRklaQJDKmN0apN9ObVNdG2EEfCDx46CVBfy80YKobT+/1W/6AZxnbjt8jAlenlqmuQL5aqwjDRDE7UowUpnIRs+z5jq8O+USgZVBKUlrT8UBpLI6P/tRdTwXbcyIdV/KM78Aejy3zIJjayQquKlEslo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602660; c=relaxed/simple;
	bh=qLlceQD+Oshb2W8mI2LctKIWi22jw8YBT0lMFC8oZQU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nH/GXUkwqIiG537dfVJ3fLQ0Ko8TV8Z2tx9fH6MQlz1yq7Tz0WOCGPTD9CDh/4LqAxSQGtUgyI90Uj6nffWiWOf3fxAMr5LdrrpBLAbfft7OwkE1rhZeksyVn9du6W/44XLtGmtDUfCH7SAG4+SL0syxl8geVFZaUt9YEXLP/uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j3GRDEol; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j3GRDEol"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708602659; x=1740138659;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qLlceQD+Oshb2W8mI2LctKIWi22jw8YBT0lMFC8oZQU=;
  b=j3GRDEolcK51MaB8xvdJd8y2RfQjY5gOXY/Hu1gtk27cPjUN4sjC/SGo
   bVIOg7Nooy86dF2eU29TF1bHYvn0c7FB8nSVxb5pN+mqVaADSNT7O25EM
   mt7oD3rkAefIxFctXZ60uLPzMrDSYEbc5C9bWCuwVRvS7EGyqeKRD0UVx
   zUuvedOKl8ulmUC7G5xoe2/a2h2JTMvn3Bf7ZRpr1WvxM37v45KJm6SVe
   Ggek/qYrdZPX62j6eSrCoaxDpX+ku7i0pwCD2s0nRVrOfF8hqSBvCfhXi
   HuXfrYQOMMqe8tU1qeqmpkcJbi4246Cu5khk/mHwIgU5whZMfhkuZXbTu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="3317879"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="3317879"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 03:50:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5448410"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.249.55])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 03:50:56 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 22 Feb 2024 13:50:40 +0200 (EET)
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_dw: Emit an error message if getting the
 baudclk failed
In-Reply-To: <20240222111922.2016122-2-u.kleine-koenig@pengutronix.de>
Message-ID: <786cecc3-4723-4b96-679e-1ea9736d3f6b@linux.intel.com>
References: <20240222111922.2016122-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-829560837-1708602640=:1961"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-829560837-1708602640=:1961
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 22 Feb 2024, Uwe Kleine-K=C3=B6nig wrote:

> Instead of silently giving up, at least tell what the problem is.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
> index 2d1f350a4bea..94aa3dddb71e 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -597,7 +597,8 @@ static int dw8250_probe(struct platform_device *pdev)
>  =09if (data->clk =3D=3D NULL)
>  =09=09data->clk =3D devm_clk_get_optional_enabled(dev, NULL);
>  =09if (IS_ERR(data->clk))
> -=09=09return PTR_ERR(data->clk);
> +=09=09return dev_err_probe(dev, PTR_ERR(data->clk),
> +=09=09=09=09     "failed to get baudclk\n");

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-829560837-1708602640=:1961--
