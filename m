Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365943EA64;
	Mon,  5 Aug 2024 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867914; cv=none; b=g10oOfVkx7lKrHOroktWFfzf6aA/sc6tU8Y8o9Sp5gZUpAeocYWgWJck5m9zTOAqjsG75PObBEK85HP7A14oK58c/nDm17/UPwVhNgewkpoeXsBH0zEI30zJYuiYtkFqBQdDAb4/yl/W5TQJrAtE0em/pbI7AaJcu8I1rTcTDl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867914; c=relaxed/simple;
	bh=zloyoov/nCUc6YZRpcaMArHyWBTyzMCFfjVZFTadpcc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=inF3H0Js6nrJYGCfudmWuAO3IQaZZrOUqWwGgJJ+J4cxUI+sUXMTeBjuXk0H13QMN6aqqUxHQEn3PbwO/u4/lCwuKQTT7ZzgWd2390NxBQnRE/uDNBtLlvreEQfd8Gv4uiZ1SVfci6PkA2d0xdVjAy6PCZdhV7ifIFTkIOwyvps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gvfxw4qG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvfxw4qG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722867912; x=1754403912;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zloyoov/nCUc6YZRpcaMArHyWBTyzMCFfjVZFTadpcc=;
  b=gvfxw4qG39QlQ1l5QXCDz3EUk+gLErd0Ya64PBnJyrFtTar19xy4eiQO
   +8+WKxIvi0bTDnLNBWcSw4INd7NDjH/P9+RCJ0Nd+BGTparEfG4eAHMTU
   rPptfV5R9aYTB/kA3/OTdaG25zduns3q2rwjofgqrIq3DOa01PrLa8EQt
   +5PenOlxe/S6b5kML/gMeWT+XJTY88JZFXDrD2H6HRzYLa0J3nzSyi/g/
   KaUPH7Sdgn3Q1oPdO7V/5cwOkB1xkRry1k+XPbTyCORP0e62Kx8PA6QOi
   51tscEoA069RxxQkifs71y16CxthotRa3Ct6Rozj/o+6IyUjHh1SA4tVY
   g==;
X-CSE-ConnectionGUID: TbFShSS2RAGFY2XAjNjIjw==
X-CSE-MsgGUID: 3HHMOs1oTkyW6fHFTHKLbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="31494954"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="31494954"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 07:25:12 -0700
X-CSE-ConnectionGUID: aE42ENqORYadcJBv5iEQcQ==
X-CSE-MsgGUID: fVg8b/3fR8KMA3xt4KPh2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="55851614"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 07:25:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 5 Aug 2024 17:25:06 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] tty: simplify tty_dev_name_to_number() using
 guard(mutex)
In-Reply-To: <20240805102046.307511-2-jirislaby@kernel.org>
Message-ID: <5bafde51-abaf-d367-eb9a-220c1339daca@linux.intel.com>
References: <20240805102046.307511-1-jirislaby@kernel.org> <20240805102046.307511-2-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1197721243-1722867906=:1238"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1197721243-1722867906=:1238
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 5 Aug 2024, Jiri Slaby (SUSE) wrote:

> In tty_dev_name_to_number(), a guard can help to make the code easier to
> follow. Especially how 0 is returned in the successful case. So use a
> guard there.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/tty_io.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index bc9aebcb873f..267682bcfea0 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -350,22 +350,19 @@ int tty_dev_name_to_number(const char *name, dev_t =
*number)
>  =09=09return ret;
> =20
>  =09prefix_length =3D str - name;
> -=09mutex_lock(&tty_mutex);
> +
> +=09guard(mutex)(&tty_mutex);
> =20
>  =09list_for_each_entry(p, &tty_drivers, tty_drivers)
>  =09=09if (prefix_length =3D=3D strlen(p->name) && strncmp(name,
>  =09=09=09=09=09p->name, prefix_length) =3D=3D 0) {
>  =09=09=09if (index < p->num) {
>  =09=09=09=09*number =3D MKDEV(p->major, p->minor_start + index);
> -=09=09=09=09goto out;
> +=09=09=09=09return 0;
>  =09=09=09}
>  =09=09}
> =20
> -=09/* if here then driver wasn't found */
> -=09ret =3D -ENODEV;
> -out:
> -=09mutex_unlock(&tty_mutex);
> -=09return ret;
> +=09return -ENODEV;
>  }
>  EXPORT_SYMBOL_GPL(tty_dev_name_to_number);

Should add also #include <linux/cleanup.h>. With that fixed:

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1197721243-1722867906=:1238--
