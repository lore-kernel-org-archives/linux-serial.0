Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11595288C18;
	Tue, 24 Jun 2025 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762839; cv=none; b=rPCz6xZblUQtpAwoykEOrEGSI/1+nfaHswGj/S8aqsxxLsQABQeg5giTBC42JSw6XjVNfbuPmaLKoNcK8HPIPHPIHTOu3lveO5u6DSIzXUejrsdoVdX+ZJmKT0U7cQV7vOuVw1nz5lW+2uVy/p8/GW0qasVixa4Jal74FL0wFl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762839; c=relaxed/simple;
	bh=4lLnp/IXNyE09zyiTjqD67fRc62ECfdr4B1UG0KapV0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qVuEx9jijBJa+aqr0meCbfEcYhZxurwn/ezXXbwF4J2nrDICx9dlMN5B67q2Zhcj0DyYQ0LyBgE1uieCAoLXAv5Wl6f70THRl1+cOSyRNdu/4U0lqSbLm5i+N6gSkhbCc+PGY9kbeeVIeC/rA+XJq4LWTaQXPxM3aWdyxkFPgnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TTSEWekK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TTSEWekK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750762838; x=1782298838;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4lLnp/IXNyE09zyiTjqD67fRc62ECfdr4B1UG0KapV0=;
  b=TTSEWekKpSjERS23sCmzt7MBy6Kez4253dChH3q7ONCFQqhn+Se1gDVi
   f1wIYvuU+ZrWQaiWS4eJ8I9dvzYkGvzLS9z92gwDcvKXGZkrA5gu3/e6F
   tHjFcRDbbY5e9ST2juNY1vwiSNB1aRaLyLLIJ0rIza7wB5kykn0DyJf+l
   A5uarzLSIRg3IyEKAtpofMn6uxwE5lZVqGFmODYFG1xquHGoi+C34nEoz
   qnbtvwspnzBkzd3wm1hDSDraegbLDb5gDVCUUasMjbDZsUFtoKlj34UO4
   Jpj/UVVdcE2wvYmII3QfBbni6ASTSsi59KmXjB5SGy8VSandr/k/9CR0I
   Q==;
X-CSE-ConnectionGUID: kE7KyfSzTBiIVCaIl4tpog==
X-CSE-MsgGUID: jbjD/rvzQd2LQ3UBhyL1CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52965015"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="52965015"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:00:37 -0700
X-CSE-ConnectionGUID: 9I9mPZzEQe6wtCVPsZYBYQ==
X-CSE-MsgGUID: VR0J+emwQCaAozgzwuhpLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="182766271"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:00:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 24 Jun 2025 14:00:30 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
    linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 5/5] tty: fix tty_port_tty_*hangup() kernel-doc
In-Reply-To: <20250624080641.509959-6-jirislaby@kernel.org>
Message-ID: <1c4b6fc9-bdce-31c0-87eb-b7aa34758877@linux.intel.com>
References: <20250624080641.509959-1-jirislaby@kernel.org> <20250624080641.509959-6-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1387142005-1750762830=:943"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1387142005-1750762830=:943
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 24 Jun 2025, Jiri Slaby (SUSE) wrote:

> The commit below added a new helper, but omitted to move (and add) the
> corressponding kernel-doc. Do it now.

corresponding

With that fixed, Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel=
=2Ecom>

--=20
 i.


> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Fixes: 2b5eac0f8c6e ("tty: introduce and use tty_port_tty_vhangup() helpe=
r")
> Link: https://lore.kernel.org/all/b23d566c-09dc-7374-cc87-0ad4660e8b2e@li=
nux.intel.com/
> Reported-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/driver-api/tty/tty_port.rst | 5 +++--
>  drivers/tty/tty_port.c                    | 5 -----
>  include/linux/tty_port.h                  | 9 +++++++++
>  3 files changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/driver-api/tty/tty_port.rst b/Documentation/dr=
iver-api/tty/tty_port.rst
> index 5cb90e954fcf..504a353f2682 100644
> --- a/Documentation/driver-api/tty/tty_port.rst
> +++ b/Documentation/driver-api/tty/tty_port.rst
> @@ -42,9 +42,10 @@ TTY Refcounting
>  TTY Helpers
>  -----------
> =20
> +.. kernel-doc::  include/linux/tty_port.h
> +   :identifiers: tty_port_tty_hangup tty_port_tty_vhangup
>  .. kernel-doc::  drivers/tty/tty_port.c
> -   :identifiers: tty_port_tty_hangup tty_port_tty_wakeup
> -
> +   :identifiers: tty_port_tty_wakeup
> =20
>  Modem Signals
>  -------------
> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index 903eebdbe12d..5b4d5fb99a59 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -391,11 +391,6 @@ void tty_port_hangup(struct tty_port *port)
>  }
>  EXPORT_SYMBOL(tty_port_hangup);
> =20
> -/**
> - * tty_port_tty_hangup - helper to hang up a tty
> - * @port: tty port
> - * @check_clocal: hang only ttys with %CLOCAL unset?
> - */
>  void __tty_port_tty_hangup(struct tty_port *port, bool check_clocal, boo=
l async)
>  {
>  =09struct tty_struct *tty =3D tty_port_tty_get(port);
> diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
> index 021f9a8415c0..332ddb93603e 100644
> --- a/include/linux/tty_port.h
> +++ b/include/linux/tty_port.h
> @@ -251,11 +251,20 @@ static inline int tty_port_users(struct tty_port *p=
ort)
>  =09return port->count + port->blocked_open;
>  }
> =20
> +/**
> + * tty_port_tty_hangup - helper to hang up a tty asynchronously
> + * @port: tty port
> + * @check_clocal: hang only ttys with %CLOCAL unset?
> + */
>  static inline void tty_port_tty_hangup(struct tty_port *port, bool check=
_clocal)
>  {
>  =09__tty_port_tty_hangup(port, check_clocal, true);
>  }
> =20
> +/**
> + * tty_port_tty_vhangup - helper to hang up a tty synchronously
> + * @port: tty port
> + */
>  static inline void tty_port_tty_vhangup(struct tty_port *port)
>  {
>  =09__tty_port_tty_hangup(port, false, false);
>=20

--8323328-1387142005-1750762830=:943--
