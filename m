Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103521;
	b=g4zr51NfWN5Rl9B9ekElB8ujwr0Ynav8QoSjmxhOSf2w4q93PB9TZ9faadUKvE0R6D7H
	 e+xF+2fG1wRwKE1+HyGhGwP8Q6AqDoh/YtxJPFso/cF8Ge+c2jhBdx0TVcuEi0CsGse9f
	 5pQW1DLS10rCp0b7StI3qWB0eoU8UL8zmxDMSRvqUe4Q5p7+LJiYMA7drxiapdhr96y8S
	 hxvYOJ/4/DlSwkVQj64cbqY6574ThYTzY+Mvy1soa1QjWdWGIOlVUKja+uhx27rCQdfyx
	 8ZeUpjMKan2JjT5WTaSU4KxyxoHMS7WrYqsgjMW2Q+Nx60zPanWKlGBPhn9ZPktHeJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103521;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=DzCwZvkcLfqHWoI21xc5lzHJo5SMX3ZYwTKHsqRbRnE=;
	b=kX11+xJ+SCh3pVe049z2AERPJrALKqBd85I01WgEbAKLDTtEbqIdZe2yUYIy9uOa/Dol
	 N/ems61AZXdNakKf7fpQFaLG6NMl4oWZWJnOoc7+IE2ayZAzb/fzXwzBfJLTLEKtzD2js
	 uVQak5HAhMmAKJg4g3Sdg5kggvXMsgBK3GxHOm54a/OG7Jkw4M3QccOqEkr02xxMukCam
	 SxbcoG6sgRRVc+WJOTeyDpP/swD06/2K1V0MbTJ0qysBdA+oFdQH2O5ejJsV7/MeC2laY
	 UBkpXN+j2EWih2IVdlnpUCQOKreAfPm2FfwF3UahssIopjZMWsBePD569hMOhWPPEKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="X5R0/3XT";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEFA606A32A;
	Tue, 27 Oct 2026 12:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBEFA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X5R0/3XT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793103521; x=1824639521;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fF6s5/jC++0dI1mWo4+V0r+Q4t0noWQYlk+PHjFdPqg=;
  b=X5R0/3XTigWXRRpFiXIRtRNigHus6HhZJP+bmIZaYNecPDPSBoygJuRd
   3bv+/OFhJauUsLmIP+c5ZGx6U4WkdzSCJcxKDk1612imCXxkuiHpm57SD
   4Y0rGElZXkWuW4FJLmjhhIl47FIuWardNL1JR7SSJq5Yy+V+o5NGtMzKl
   mxtSzp4JEyTB1BJAyniM8qaGSButhim9BYQlgDfDFf1A1gDk4BSzNx/3f
   kmqIMnMdcUFPxJla+LfumIXpba/H/XTTD9DaP4cei2q8FdPNwBY39OI9A
   xvSxRKMxTjm28S75yJA77X/gkOoAjay5Gpl+UXiuXP44K3N82ss1VHRTV
   A==;
X-CSE-ConnectionGUID: 84n5gxZ4T5mVRUIaOXJLfw==
X-CSE-MsgGUID: 7J2CGshJQiq0V6ipHBDSpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1685373"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1685373"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:18:39 -0700
X-CSE-ConnectionGUID: GFWnTKVEQgmpzpLI3xD0vQ==
X-CSE-MsgGUID: vQ9sdgpxSAWym7zhX8OKwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4911783"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:18:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Oct 2026 14:18:24 +0200 (EET)
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
    linux-serial <linux-serial@vger.kernel.org>, stable <stable@kernel.org>, 
    Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH 09/24] serial: 8250: 8250_bcm7271: fix DMA address
 truncation to 32 bits
In-Reply-To: <20261027-tty-llm-v1-9-99b0202ae546@linuxfoundation.org>
Message-ID: <f8867635-8f50-af88-dd81-4fba99f17e13@linux.intel.com>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org> <20261027-tty-llm-v1-9-99b0202ae546@linuxfoundation.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1814154233-1793103504=:1182"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1814154233-1793103504=:1182
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 27 Oct 2026, Greg Kroah-Hartman wrote:

> From: Joshua Rogers <linux@joshua.hu>
>=20
> The local variable daddr is declared as u32 but assigned from dma_addr_t
> fields (priv->rx_addr and priv->tx_addr), which are 64-bit on ARM64.
> This silently truncates the upper 32 bits, causing upper_32_bits(daddr)
> to always produce zero when programming the UART DMA descriptor high
> address registers.  Change the type to dma_addr_t to preserve the full
> DMA address.
>=20
> Cc: Al Cooper <alcooperx@gmail.com>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: stable <stable@kernel.org>
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadc=
om.com>
> Signed-off-by: Joshua Rogers <linux@joshua.hu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/8250/8250_bcm7271.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/=
8250/8250_bcm7271.c
> index 974d9af146a1..4fdd261e55f5 100644
> --- a/drivers/tty/serial/8250/8250_bcm7271.c
> +++ b/drivers/tty/serial/8250/8250_bcm7271.c
> @@ -315,7 +315,7 @@ static int brcmuart_arbitration(struct brcmuart_priv =
*priv, bool acquire)
> =20
>  static void brcmuart_init_dma_hardware(struct brcmuart_priv *priv)
>  {
> -=09u32 daddr;
> +=09dma_addr_t daddr;
>  =09u32 value;
>  =09int x;

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1814154233-1793103504=:1182--
