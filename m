Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104244;
	b=qcM+Kkvg34j2eWvH86rFmJeBXnrZx3Ff1QGOc/6rjvgevaHdoggckx5V0aAoi9SgtyBm
	 qV+dmUdpcm1BajS7GKvhNPNW8AghmYPYbRyTGMAIuLju0oz49ZtOOaB7LkSRWe2hRaher
	 wTHzlhveMN5LCc4zvQ/b0+muEvSJiGMLtUBXcEGCAOO5CpHHvgfetEdPKX5INdzLLlQsM
	 F5EMd2KzG7+uOySiGlP53IVIGqOyN7KfYnP/qKImDlpYUutbOdNEEKD5AOTKPa2BBWIjT
	 bF7nDkIFKZ/q3n4XPT2Jge+B0O/atUJa9uatOij1iRkfREBDgkQU2itZUcJDuPLwsxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104244;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=jeOAK0qL7KS5vBLa/82puk+xiTdntPxc3H2Ku7R6y9s=;
	b=Bi40KfToyk8QL9o9gMn7BiLEY4A3H60Kp3YGfKUscdYu5zo7kyyr1cGplNOnf1DmP5sN
	 mZt0AqUArJx0S473EbbkSHJEbD5dQGbJyuS7syACez6Mp8Q9SfocIgzJVSD84kSiczDvd
	 xDIx3mYiY+McT1lsFf65UkiOZ4jmRNiNtkOODGHFAqOFf8bngIlv4wjNRZwTZeIX9fE/j
	 bMaOnz02zN6Exgz6UsO0t8rOtRfyOK/SK9hHQDbCPpnqJAG8Xwj1KXluJdxrC40OzcnwB
	 VTNdxBIkq8uGvYESAxqXQzYinQicYftKbSNVShMHeyNiLVUhE+tgh0o/y9AjjAub6JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="d6pfAR/F";
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59324606A323;
	Tue, 27 Oct 2026 12:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59324606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d6pfAR/F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793104243; x=1824640243;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ngASlz/7h38M2U0kU8XwKk3WWzIoZLykAudCG8vRh0g=;
  b=d6pfAR/FNoPGcynbji9ssCT4lsPmj2NtPU0VInfV0KaSBUYhpZUcaC14
   oBfrP8m8S1no7XsQPq5Ykr+V1Kex3WxPQaMmKTdmdQN13heWI5QR5mTVL
   Z8cTDfUwZDg4HR2fpdCC5tTp1eU8Pd9jh9fav0kjY0TCfA12VAhyQ2xVj
   vMXcZYu1zdQaZGzKB2hVUhg4DMM5ibXaWZ2MMDpQV3OIJbasc+tUszgSR
   sN6SYTxACYeYzZ6pzwzduvpXT3zhZJ4CerRPstvor0r+NZGZnOqekiBKr
   Oehh6QpH/BguX2WZA+OJB9dqQbcxh9lt00hyA07XRw9WJLgYHzQ5fE+rE
   Q==;
X-CSE-ConnectionGUID: Qh049iFnSkCPZ3OBzonW0w==
X-CSE-MsgGUID: k3iqh915RUm7q849g9RLJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1810091"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1810091"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:30:42 -0700
X-CSE-ConnectionGUID: 3XeK4fruSayPauUHoPlaVw==
X-CSE-MsgGUID: arSiFKhLTliz1bsO13VJtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4437197"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:30:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Oct 2026 14:30:27 +0200 (EET)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>, 
    Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
    Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>, 
    Florian Fainelli <f.fainelli@gmail.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Peter Hurley <peter@hurleysoftware.com>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Crescent Hsieh <crescentcy.hsieh@moxa.com>, Frank Li <Frank.Li@nxp.com>, 
    Sherry Sun <sherry.sun@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
    Pengutronix Kernel Team <kernel@pengutronix.de>, 
    Fabio Estevam <festevam@gmail.com>, 
    Manivannan Sadhasivam <mani@kernel.org>, Olof Johansson <olof@lixom.net>, 
    =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>, 
    Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
    Peter Griffin <peter.griffin@linaro.org>, 
    Alim Akhtar <alim.akhtar@samsung.com>, 
    Robert Baldyga <r.baldyga@samsung.com>, 
    Thomas Abraham <thomas.abraham@linaro.org>, 
    Kukjin Kim <kgene.kim@samsung.com>, 
    Patrice Chotard <patrice.chotard@foss.st.com>, 
    Srinivas Kandagatla <srini@kernel.org>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Andy Shevchenko <andy.shevchenko@gmail.com>, 
    Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, 
    Al Cooper <alcooperx@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
    Danilo Krummrich <dakr@kernel.org>, stable <stable@kernel.org>
Subject: Re: [PATCH 13/24] serial: 8250: dfl: validate MMIO resource size
 and regshift
In-Reply-To: <20261027-tty-llm-v1-13-99b0202ae546@linuxfoundation.org>
Message-ID: <c9921b1f-bb1b-7320-0713-7265de32868c@linux.intel.com>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org> <20261027-tty-llm-v1-13-99b0202ae546@linuxfoundation.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-667830429-1793104227=:1182"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-667830429-1793104227=:1182
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 27 Oct 2026, Greg Kroah-Hartman wrote:

> From: Joshua Rogers <linux@joshua.hu>
>=20
> The driver passes the DFL feature's raw MMIO resource to the 8250 core
> without verifying that the resource covers the full UART register
> window.  Add a regshift sanity check and validate that the MMIO resource
> is large enough for 8250 register accesses up to register 7 at the
> configured register spacing and access width.
>=20
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Joshua Rogers <linux@joshua.hu>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Uwe Kleine-K=C3=B6nig (The Capable Hub)" <u.kleine-koenig@baylibre.c=
om>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: stable <stable@kernel.org>
> Signed-off-by: Joshua Rogers <linux@joshua.hu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/8250/8250_dfl.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/tty/serial/8250/8250_dfl.c b/drivers/tty/serial/8250=
/8250_dfl.c
> index 72938990ea81..e9329935bc47 100644
> --- a/drivers/tty/serial/8250/8250_dfl.c
> +++ b/drivers/tty/serial/8250/8250_dfl.c
> @@ -110,6 +110,7 @@ static int dfl_uart_probe(struct dfl_device *dfl_dev)
>  {
>  =09struct device *dev =3D &dfl_dev->dev;
>  =09struct uart_8250_port uart =3D { };
> +=09resource_size_t min_size;
>  =09int ret;
> =20
>  =09uart.port.flags =3D UPF_IOREMAP;
> @@ -120,6 +121,17 @@ static int dfl_uart_probe(struct dfl_device *dfl_dev=
)
>  =09if (ret < 0)
>  =09=09return dev_err_probe(dev, ret, "failed uart feature walk\n");
> =20
> +=09if (uart.port.regshift > 3)
> +=09=09return dev_err_probe(dev, -EINVAL,
> +=09=09=09=09     "unsupported regshift %u\n",
> +=09=09=09=09     uart.port.regshift);
> +
> +=09min_size =3D (7 << uart.port.regshift) +

Shouldn't this be based on a named register UART_xx?

> +=09=09   ((uart.port.iotype =3D=3D UPIO_MEM32) ? 4 : 2);
> +=09if (uart.port.mapsize < min_size)
> +=09=09return dev_err_probe(dev, -EINVAL,
> +=09=09=09=09     "MMIO resource too small for register layout\n");
> +
>  =09if (dfl_dev->num_irqs =3D=3D 1)
>  =09=09uart.port.irq =3D dfl_dev->irqs[0];
> =20
>=20
>=20

--=20
 i.

--8323328-667830429-1793104227=:1182--
