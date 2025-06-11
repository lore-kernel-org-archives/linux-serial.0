Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B809E277011;
	Wed, 11 Jun 2025 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647407; cv=none; b=PCd4VDRH2dKlmiTpH7/DHP+cg68vU3yHXgOSiXPfk1FwYnftYrbvrp7qFWbb3XAsJhFdt4FabWuMgsIwjoS9j28MVUkUbpcNyKQMbemNbBFUYaJOxZHDJlapvRGI+jsXMcZDFfB+LvBV9infwlV2CeKwMKnqphi41MIXpD/RwqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647407; c=relaxed/simple;
	bh=6ox0Fk/Sr3NhlsQAO8IXJkB7DrxMqZN/M71D0NLKVUY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eQxHUFOGdRSIwOF3g687/K5ou3L4QuDc/cJxekr8k/HHNOltnPx2wmjIuBNh+esORCuxCfO50Lakc3Tsv/6B/HpX8WnS2J9znAfgzXsF1Yx+YT6Q1Rz56b/SBlwfjhwTgwcdIli1WZn4XYW7hXUFlHvFkYT5tst/QF/3HB2oBKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQD1XWd2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQD1XWd2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749647406; x=1781183406;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6ox0Fk/Sr3NhlsQAO8IXJkB7DrxMqZN/M71D0NLKVUY=;
  b=WQD1XWd28dZIDN7YlXFyGu0z60ea3XmQsX7pxW5HnlelXArCzOsB8te1
   ApSp5rpWVz/KGtQKyzB/J0k9obK9E6UEb/JodseeyxVjuKkU9sJptaSM+
   UFjjJjtWuOIAECuiXSGsTb0xSbpK8mSacdgkpmtMemMeVM4ZubPbOUF1z
   QzMNArjrGoydJjVO3K+V8A4osQ5ZzCzPXPhdE0HQw6SHOZh/McMP1dcWr
   1TMkGL8BHuI6E8CL80RbBqGO1+XJtTYGyX35+xQQCD18rXZwjwVHL/BC3
   a5gY+n2OqOLqQLTD86zZ3r+f9FwcLyA36KYZDsa/d38KEKU+EtITi0OA+
   Q==;
X-CSE-ConnectionGUID: 5mFI/cX4TSa87NTlJmJ0yA==
X-CSE-MsgGUID: CSJVc42MRbmV2KPNhxAddg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51889834"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="51889834"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 06:10:05 -0700
X-CSE-ConnectionGUID: Z1BiM4cnQwy01ZWsa2YOEA==
X-CSE-MsgGUID: WJTA6mI4TYuL7jG/tw4wLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="147105587"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 06:10:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 16:09:58 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 28/33] serial: 8250: remove debug prints from ISR
In-Reply-To: <20250611100319.186924-29-jirislaby@kernel.org>
Message-ID: <88b6f3d3-983c-1946-a56a-954c9792a4a9@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-29-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1299268160-1749647398=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1299268160-1749647398=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> These are useless, we have tracing nowadays.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_core.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/825=
0/8250_core.c
> index d42ceb6ffdc2..2bac9c7827de 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -71,8 +71,6 @@ static irqreturn_t serial8250_interrupt(int irq, void *=
dev_id)
>  =09struct list_head *l, *end =3D NULL;
>  =09int pass_counter =3D 0, handled =3D 0;
> =20
> -=09pr_debug("%s(%d): start\n", __func__, irq);
> -
>  =09spin_lock(&i->lock);
> =20
>  =09l =3D i->head;
> @@ -97,8 +95,6 @@ static irqreturn_t serial8250_interrupt(int irq, void *=
dev_id)
> =20
>  =09spin_unlock(&i->lock);
> =20
> -=09pr_debug("%s(%d): end\n", __func__, irq);
> -
>  =09return IRQ_RETVAL(handled);
>  }
> =20
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1299268160-1749647398=:957--
