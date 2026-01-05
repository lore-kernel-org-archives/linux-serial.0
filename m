Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1513C2F60A2;
	Mon,  5 Jan 2026 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625904; cv=none; b=kI9IKIUgjEh2JKpnBMe6lylEOfpAV2H5IbZJ96wNv7dkfCxkfIXAmZaQ8JZ4F0+ECTF1mqtsdDLVUJ6sSw5+Fz8JbW/UiyggiU7k7h7Hue3lkV+tkgFCb1/4+GQUZFZKo31oN7cKwZh7B4d/1dwJM3thatyWlnVkagc3u3DC67s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625904; c=relaxed/simple;
	bh=X7yZaTq6J3XeXDrYPjlj0n4zroCPIdpvxbxZXJdI2nk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Avq+r2CRjsqv95MEykFTFqvLqGAbNx5DPZmLWM0o59UOCW8v3/bQvpokXiXfBggwAGPRdvDeIK4SfvRz4kuScQls8+S7YarumNx4nvCXEwR05g7qoePVYsu8vZAzr4KkirwkxICfsjfK8mrW2b96+SdYrBakRWhSTqDUnfxQ/cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVTBed/D; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVTBed/D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767625901; x=1799161901;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=X7yZaTq6J3XeXDrYPjlj0n4zroCPIdpvxbxZXJdI2nk=;
  b=TVTBed/DBl/NUGc1QxisW8u3BMXW6B7LWfljHQlyse5AQBUZOXagWNMU
   Ij3A96LtLuiQMLr4Ws1LvebKwV3Eby92kCjwC9w8lof6gTa53o1gI7YgA
   OYzpdmyt+PgJ/mRLjeQkP2/RpQS1TAW4Is6OrzD8gGAk5UBAOMIlz3opS
   kosPKx+DKZsZzAaHetMeBckQuItddaC6jN8kEFk9WG7LUMl4RILP0KtrO
   ldn6cdMupTPYEnuwWsDF7A8NZSsJk7qZ7RKRTnbBFjOtHr99qmboJMqmC
   EhFBi4VXPpIfn9D9HHQlJwXb6GRpeYiHCpzd4g8xthE+UqnUL7zYvKBKu
   w==;
X-CSE-ConnectionGUID: OWDH6Fz/S2GSDzYNze2ilw==
X-CSE-MsgGUID: CEvofYRhQWK78ET2AS/cJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="79713883"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="79713883"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 07:11:39 -0800
X-CSE-ConnectionGUID: cNndLfefSWKe4fJUBINung==
X-CSE-MsgGUID: EKFgfNPeROC2VeQB34/l1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="202178673"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.202])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 07:11:37 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 5 Jan 2026 17:11:32 +0200 (EET)
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Rob Herring <robh@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>, 
    Hans de Goede <hansg@kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v1 4/4] platform/surface: Migrate to serdev specific
 shutdown function
In-Reply-To: <9682d206a1f375cd98e7dbfce4f1a83b4b345178.1765526117.git.u.kleine-koenig@baylibre.com>
Message-ID: <60578bea-2351-2a7d-bb24-2ee2ab5a7bf9@linux.intel.com>
References: <cover.1765526117.git.u.kleine-koenig@baylibre.com> <9682d206a1f375cd98e7dbfce4f1a83b4b345178.1765526117.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1052401463-1767625892=:980"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1052401463-1767625892=:980
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 12 Dec 2025, Uwe Kleine-K=C3=B6nig wrote:

> The motivation is stop using the callback .shutdown in
> qca_serdev_driver.driver to make it possible to drop that.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

In case somebody wants to take the entire series,

Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.


> ---
>  drivers/platform/surface/aggregator/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platfor=
m/surface/aggregator/core.c
> index c58e1fdd1a5f..860702c4266f 100644
> --- a/drivers/platform/surface/aggregator/core.c
> +++ b/drivers/platform/surface/aggregator/core.c
> @@ -380,9 +380,9 @@ static int ssam_serdev_setup(struct acpi_device *ssh,=
 struct serdev_device *serd
> =20
>  /* -- Power management. ------------------------------------------------=
----- */
> =20
> -static void ssam_serial_hub_shutdown(struct device *dev)
> +static void ssam_serial_hub_shutdown(struct serdev_device *serdev)
>  {
> -=09struct ssam_controller *c =3D dev_get_drvdata(dev);
> +=09struct ssam_controller *c =3D dev_get_drvdata(&serdev->dev);
>  =09int status;
> =20
>  =09/*
> @@ -834,12 +834,12 @@ MODULE_DEVICE_TABLE(of, ssam_serial_hub_of_match);
>  static struct serdev_device_driver ssam_serial_hub =3D {
>  =09.probe =3D ssam_serial_hub_probe,
>  =09.remove =3D ssam_serial_hub_remove,
> +=09.shutdown =3D ssam_serial_hub_shutdown,
>  =09.driver =3D {
>  =09=09.name =3D "surface_serial_hub",
>  =09=09.acpi_match_table =3D ACPI_PTR(ssam_serial_hub_acpi_match),
>  =09=09.of_match_table =3D of_match_ptr(ssam_serial_hub_of_match),
>  =09=09.pm =3D &ssam_serial_hub_pm_ops,
> -=09=09.shutdown =3D ssam_serial_hub_shutdown,
>  =09=09.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>  =09},
>  };
>=20

--8323328-1052401463-1767625892=:980--
