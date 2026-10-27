Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103881;
	b=1QhFxoOWMvqRo/pmH3IjgQxY2uuVUKaEnAnYG4rFi15KTWmUjZkJJHIxhMi9Iaxe0RGu
	 FEBQNremOp9k0Pzfxbql+TG793bcWYGopMv0wTlfTz8/2oRWG0Gj2NCPaqTCR8HMyG7DC
	 E6evBvI3WxOK0yy2mEeUVH3s4MJaIMwHy79mi8NUdyW4B8N6WweMjSN8vJffHrIJXTF/M
	 GubybyIUkitpsGZ9k2d4+0GA4orMHmpdbyMcbmDMEhnYskT9Z9PEyyAjKTGXBw1nOzvFA
	 a1IAIOfIjx1KSXy3ofj8oenBz50RRZFvMBJG7XZ/vpfPXB0sYb4FphImjzcDEVXnGyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103881;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=ho39qNMcC6CxFL1GKYAAhv8NSEftsaAoZOXWxRCx/rc=;
	b=nI9MXZu1qwnIc9FGxbCAReekiaRGGQ4O1f3oKDsVFGQz5mDafc1U3+wVCRnZjqdx//pP
	 Q1HPHTFUwL91mAJFFHKlPQkLI6tTgOU2WohdhJPdYKvlMB14hGvzNjbQtM0/hHEh6cqzn
	 5wj8r8V5cZQC3qVm4Eu5qbeos/7aWEF8yJDmkGhRZff+kylHk4JVNRc21prrjnHXoEfkZ
	 Ic9ucMmwXsXC2x2wV+uR3AOKCk557VcH9ts7FUrrT7HODBHzPZefdjzEXG6GPGeSDRf1c
	 AGpJHCXZnDzMGRaxW8iqntQz5bPl4YnpvmGVYdgV662mio3r/rawOWfgELlW7BkQfQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZStS2jf1;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D377A606A322;
	Tue, 27 Oct 2026 12:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D377A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZStS2jf1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793103881; x=1824639881;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TWL5dN+mjyDzgMMQvDtI5ixkFxgDK/ODv4RJpZYzmtg=;
  b=ZStS2jf1IzSM/x4QDmL4AWGYRsQRMeXHots6ieErgJbalHvdjVUiKKNz
   4bLfzME2fwU5VroMBf33MWkdvRx6ffe6S2Pe44NDUOGMg8PPq5ZfT9mwx
   nNcBC+BhwDDH7CUmf6rNq++O8sZ1vzOmyu15hBHBbyiisD+3ONS9VkPrb
   IF1UBg1nM3vuzo26+1Cc6SjTB43Vm9tChupXLilJ/DA/luE0YmVr4XXaY
   cnwI8O20g3RXekalLNsfapmjjy+ZWCcai+9t7+4QmuWsPol99teYlkwPW
   bi4EY7vrgxgTIa6WgyrQ2N+jC4vU4M8p/9LiLceRp/Os6li8PCDqki64D
   A==;
X-CSE-ConnectionGUID: ZHMQuN/aTNWwF5sjzc98Ew==
X-CSE-MsgGUID: pyA7aC27ScOM4+yImO3OxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1809438"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1809438"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:24:39 -0700
X-CSE-ConnectionGUID: KQo5JrzDSxuNpo56U58jeA==
X-CSE-MsgGUID: 1P0QcvgdRL+cI+i1tXpdAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4436270"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:24:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Oct 2026 14:24:24 +0200 (EET)
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
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, 
    Marnix Rijnart <marnix.rijnart@iwell.eu>, stable <stable@kernel.org>
Subject: Re: [PATCH 11/24] serial: 8250: cap OxSemi Tornado UART count against
 BAR size
In-Reply-To: <20261027-tty-llm-v1-11-99b0202ae546@linuxfoundation.org>
Message-ID: <e407b362-1adc-b314-cd51-9fe2926411cf@linux.intel.com>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org> <20261027-tty-llm-v1-11-99b0202ae546@linuxfoundation.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-540446628-1793103864=:1182"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-540446628-1793103864=:1182
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 27 Oct 2026, Greg Kroah-Hartman wrote:

> From: Joshua Rogers <linux@joshua.hu>
>=20
> pci_oxsemi_tornado_init() reads the UART count from device-controlled
> BAR0 memory without validation, allowing a malicious device to report up
> to 255 ports. Cap the device-reported count against what actually fits
> in the BAR using the Tornado register layout.
>=20
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: "Uwe Kleine-K=C3=B6nig (The Capable Hub)" <u.kleine-koenig@baylibre.c=
om>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Marnix Rijnart <marnix.rijnart@iwell.eu>
> Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> Cc: stable <stable@kernel.org>
> Signed-off-by: Joshua Rogers <linux@joshua.hu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250=
/8250_pci.c
> index 1dda63be6b89..9919504334bb 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1083,6 +1083,7 @@ static int pci_oxsemi_tornado_init(struct pci_dev *=
dev)
>  =09u8 __iomem *p;
>  =09unsigned long deviceID;
>  =09unsigned int  number_uarts =3D 0;
> +=09resource_size_t bar_len;
> =20
>  =09if (!pci_oxsemi_tornado_p(dev))
>  =09=09return 0;
> @@ -1095,6 +1096,15 @@ static int pci_oxsemi_tornado_init(struct pci_dev =
*dev)
>  =09/* Tornado device */
>  =09if (deviceID =3D=3D 0x07000200) {
>  =09=09number_uarts =3D ioread8(p + 4);
> +
> +=09=09/* Cap against BAR0 size (Tornado layout: 0x1000 + n * 0x200) */
> +=09=09bar_len =3D pci_resource_len(dev, 0);
> +=09=09if (bar_len >=3D 0x1000)
> +=09=09=09number_uarts =3D min_t(unsigned int, number_uarts,
> +=09=09=09=09=09     (bar_len - 0x1000) / 0x200);

IMO, these literals would be better written as SZ_xx + make sure you've=20
the include for it if changing to that.

> +=09=09else
> +=09=09=09number_uarts =3D 0;
> +
>  =09=09pci_dbg(dev, "%d ports detected on %s PCI Express device\n",
>  =09=09=09number_uarts,
>  =09=09=09dev->vendor =3D=3D PCI_VENDOR_ID_ENDRUN ?
>=20
>=20

--=20
 i.

--8323328-540446628-1793103864=:1182--
