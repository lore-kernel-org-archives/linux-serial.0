Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352269;
	b=w7NdC/dEfspva/bBl9p9Feds3hdsjFwEYznRoskYNWtWb6Thl4LUVc9sK39omLuZVYYh
	 YmWUFRAdTSk3q3e/XlAceWp9LqcBuBff+GxEc2MaNgt+vC4TnOyhmosyZFHTyrYswy8xj
	 webaiLG4zqZ06BuUj9UhNdzrTqF1yjDlEscZniQ8tqHN8gdAVo8xK30J1slpocip0jFFW
	 Ymrky3yoXKFUOKouSursKi6FtlJn87FPintE4ICo4gNYKBVX/eTAM1k6ltPUJ03V28m15
	 4WbSVnx1KlFmF2oaZGHH9n5EJ2WyRYsIgbSNQXmqvw/tTmQ88UlRgfcgVcO+aKCzNqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352269;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:
	 Content-ID;
	bh=OmlzIQ4gereQGv/7b98RflWM5h/OCWSsbl/T77o569A=;
	b=wdxMsIYwnwoB9rVmgwq1fLBivAHJsnmR3ThxA4EvtdaachZKu21DS5ZTGs0vjSGVG/Ng
	 MrkHOEeuxJRGL6aZ/EYZa+BeICmPiXHMHl7ONgAgcMrD4FlqoFo2z6J08+rc3WjToRTqs
	 CiBqF2yEF+2iQN7JYJIH+NURbqQ0AhMR1RjqCYwCfcbFC7+EHVXBdlIxdCeGcpBM6pgUf
	 b5s93cAUJel1CjI8uR4lIURUoYagf+S+QxJ55YHtgexkTXy7TbUHKUSvz53OsaV8IT/R4
	 n8UeexHaPIBOWawK94UBvv5A41fIDUVvyVngmrinwjrdGA+yiKSQNv71cv38Z+i8a2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W1glEey8;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AB4606A31C;
	Fri, 30 Oct 2026 09:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9AB4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W1glEey8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793352267; x=1824888267;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=lOFIXcNCvbGYaeFWZl7MhNswXebfJEME1y4g8ZPVihU=;
  b=W1glEey8DF5OK+ZDBvr/Ge0XonQCQi4CxDuxABfxA68fnogdfWRxdfTf
   lZJ7Yexeu5bf41EFT+O2PFI4juMTztndqxzP1eI/PgxdM+6qpeozEuXG7
   19fOPQ/CPwF47mg0YfioDpBdhsSRoMnwefAhj6rQvC4WLEXho9o8/QOjt
   xL08ZZDABbrCNsjxO8dulO7gX7y/4alsHANQ5EWciPuDUuR0Len+FPUwS
   XxS5tfjHuJ3uzKINqd6IzZ60lHmi38atJ6M1sAOFe3/EPkVA0m8BTNAUf
   iK7VUpGEighClXX8y50I/6INbv/5U+pUN+A6lFREjqZu3p3y/txNhPkVj
   g==;
X-CSE-ConnectionGUID: bL8F92KMQQ24qKRQBZ+AdA==
X-CSE-MsgGUID: cW31C3d/SMisWzEa2Itahg==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1998330"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="1998330"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 02:24:27 -0700
X-CSE-ConnectionGUID: DJlFZSyxQha+0r4S5cq2/g==
X-CSE-MsgGUID: 1zAYwh/kRsmBB8GE0FLiqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5352871"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 02:24:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 30 Oct 2026 11:24:17 +0200 (EET)
To: James Hilliard <james.hilliard1@gmail.com>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
    Jernej Skrabec <jernej.skrabec@gmail.com>, 
    Samuel Holland <samuel@sholland.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v5 2/8] serial: 8250: share the RX trigger conversion
 helper
In-Reply-To: <20261029-submit-h616-uart-fifo-v1-v5-2-53b433aebbf8@gmail.com>
Message-ID: <d8f88dfa-f372-f1c7-bdb3-131a26dbff46@linux.intel.com>
References: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com> <20261029-submit-h616-uart-fifo-v1-v5-2-53b433aebbf8@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-108683250-1793352038=:1187"
Content-ID: <ec465114-c4ae-bb9c-a649-969abb886178@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-108683250-1793352038=:1187
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <3b749261-4f91-a782-0e99-9be2a9a55095@linux.intel.com>

On Thu, 29 Oct 2026, James Hilliard wrote:

> Extract the receive-trigger threshold search into serial8250_bytes_to_fcr=
()
> so drivers with per-port threshold tables can use the same conversion as
> the generic 8250 implementation. Keep the implementation in 8250_port.c a=
nd
> export it for subdrivers.

To explain why we're doing this, the text could first mention that=20
inability to define these thresholds per driver have been one of the main=
=20
reasons why there has been the temptation to add new port types into=20
uart_config[] (that would be better left as a legacy way of defining=20
things).

> Include the unsupported-table check in the helper and preserve the existi=
ng
> nearest-lower selection and highest-encoding fallback.
>=20
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/tty/serial/8250/8250.h      |  2 ++
>  drivers/tty/serial/8250/8250_port.c | 21 +++++++++++++--------
>  2 files changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/825=
0.h
> index 21ed9c41b751..1600f2e45d76 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -73,6 +73,8 @@ struct serial8250_config {
>  =09unsigned int=09flags;
>  };
> =20
> +int serial8250_bytes_to_fcr(const unsigned char *rxtrig_bytes, unsigned =
char bytes);
> +
>  enum uart_port_type {
>  =09/* Internal 8250 only */
>  =09UART_PORT_AIROHA=09=09=3D 124,
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 36b2b0a2c05c..fc3987b5a70c 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3015,22 +3015,27 @@ static int fcr_get_rxtrig_bytes(struct uart_8250_=
port *up)
>  =09return bytes ? bytes : -EOPNOTSUPP;
>  }
> =20
> -static int bytes_to_fcr_rxtrig(struct uart_8250_port *up, unsigned char =
bytes)
> +int serial8250_bytes_to_fcr(const unsigned char *rxtrig_bytes, unsigned =
char bytes)
>  {
> -=09const struct serial8250_config *conf_type =3D &uart_config[up->port.t=
ype];
> -=09int i;
> -
> -=09if (!conf_type->rxtrig_bytes[UART_FCR_R_TRIG_BITS(UART_FCR_R_TRIG_00)=
])
> +=09if (!rxtrig_bytes[UART_FCR_R_TRIG_BITS(UART_FCR_R_TRIG_00)])
>  =09=09return -EOPNOTSUPP;
> =20
> -=09for (i =3D 1; i < UART_FCR_R_TRIG_MAX_STATE; i++) {
> -=09=09if (bytes < conf_type->rxtrig_bytes[i])
> +=09for (unsigned int i =3D 1; i < UART_FCR_R_TRIG_MAX_STATE; i++) {
> +=09=09if (bytes < rxtrig_bytes[i])
>  =09=09=09/* Use the nearest lower value */
> -=09=09=09return (--i) << UART_FCR_R_TRIG_SHIFT;
> +=09=09=09return (i - 1) << UART_FCR_R_TRIG_SHIFT;
>  =09}
> =20
>  =09return UART_FCR_R_TRIG_11;
>  }
> +EXPORT_SYMBOL_GPL(serial8250_bytes_to_fcr);

Put the export to namespace.

With that fixed,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

> +static int bytes_to_fcr_rxtrig(struct uart_8250_port *up, unsigned char =
bytes)
> +{
> +=09const struct serial8250_config *conf_type =3D &uart_config[up->port.t=
ype];
> +
> +=09return serial8250_bytes_to_fcr(conf_type->rxtrig_bytes, bytes);
> +}
> =20
>  static int do_get_rxtrig(struct tty_port *port)
>  {
>=20
>=20

--=20
 i.
--8323328-108683250-1793352038=:1187--
