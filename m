Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B04339768D
	for <linux-serial@vger.kernel.org>; Fri,  9 Oct 2026 11:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544327; cv=none; b=XTlcmjjgZT8UY/ew/eFg9qoAIQ5GMmkGZFEGiuGsVl1LVgHlS+psQMJT37jCjXtkEPpOmqttvzikKm1SpJ0Dsgd5KAOD5Ydzo5wbtG6TWdpkp/uSiF3wMXnyAFpT4j4JgORgHy+z3ktZI+CUijUIBx57miiswKPVHPnIa4I3hFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544327; c=relaxed/simple;
	bh=uCmnarb/qso5Zm62JTG5lKQG5AeMfw8PnLN6MX6NFTU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=e12WGES6iSY7E3COooKUVN0tuTUi6gnTt2+6H9JfCT0W+Jv7VrDd7DKYFFl9vRa6r9gFajOL5IOr9xrra7o2EuJtq9xNe4HfKDIwoJ/6CDMNfXSeeU61B84ckFGuffkUY9DEdbiuYDGbhZz1++TWNZFgKNwPnwhifx5BgLLM/Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRKtb3oi; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRKtb3oi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791544319; x=1823080319;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uCmnarb/qso5Zm62JTG5lKQG5AeMfw8PnLN6MX6NFTU=;
  b=SRKtb3oisYtcb0JKYu8F7wAL6KHsi63z+IG1jVUQw+bfx2qeXfjnpqBl
   sRXd2358LmxtyGCVb+YIqnEdlx8aT9fAdGNXUqszY6GsHjFSLDUhjnCsJ
   FZbNTzZLw5qdBvKPXDQNNsCAilMNXIr/AI+9dQC1hyDDxuNiWlFMy637A
   tJywwGTJ5TfycsFCEMeVMBQxexm2V2S6BQ/LYrzpqFe26CiwYIZkd9Ww3
   48VZSixPslDZ9hRWd1qtkGvogPIaskRwiBxXTh9mTWN5xe0JKakmwiqTM
   5P5DEfKxA5lCrw1HozWyXaWl6/mqc5hgxIuYKVPb+nXA4rG7zK/aIM5eT
   Q==;
X-CSE-ConnectionGUID: Inzd914dSeiVz4w9HLDWgQ==
X-CSE-MsgGUID: +SMm98UZQouHBFipGciLZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="349440"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="349440"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 04:11:58 -0700
X-CSE-ConnectionGUID: MlWoDZJvRYWzQBv++VNb+A==
X-CSE-MsgGUID: CNnz9xF/RHufth645ygVCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="2113166"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.39])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 04:11:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 9 Oct 2026 14:11:53 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 1/3] serial: 8250_lpss: do not touch uninitialized line
 in ehl_serial_exit()
In-Reply-To: <ef47d676a44346e058f29a00c8701484db722831.1791524724.git.jirislaby@kernel.org>
Message-ID: <5b38ebef-0df1-04a0-d736-d1c2295cd062@linux.intel.com>
References: <cover.1791524724.git.jirislaby@kernel.org> <ef47d676a44346e058f29a00c8701484db722831.1791524724.git.jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-595913266-1791544313=:8329"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-595913266-1791544313=:8329
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 9 Oct 2026, Jiri Slaby (SUSE) wrote:

> lpss8250_probe() calls lpss->board->exit() on its error path. For the
> EHL board, that is ehl_serial_exit() and it does:
> serial8250_get_port(lpss->data.line)->dma =3D NULL;
>=20
> But when lpss8250_dma_setup() or serial8250_register_8250_port() fails,
> lpss->data.line was never assigned. As lpss is kzalloc()ed, line is 0
> and ehl_serial_exit() clears the dma pointer of an unrelated port --
> serial8250_ports[0], i.e. ttyS0, which is often the console.
>=20
> Initialize lpss->data.line to -1 in probe and skip the clearing in
> ehl_serial_exit() if no port was registered.
>=20
> Fixes: 5318f70da7e8 ("serial: 8250_lpss: Balance reference count for PCI =
DMA device")
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Assisted-by: LLM
> --
> Cc: "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-serial@vger.kernel.org
> ---
>  drivers/tty/serial/8250/8250_lpss.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/825=
0/8250_lpss.c
> index 776ec1ef29d6..c5257847a94c 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -183,6 +183,9 @@ static int ehl_serial_setup(struct lpss8250 *lpss, st=
ruct uart_port *port)
> =20
>  static void ehl_serial_exit(struct lpss8250 *lpss)
>  {
> +=09if (lpss->data.line < 0)
> +=09=09return;
> +
>  =09struct uart_8250_port *up =3D serial8250_get_port(lpss->data.line);

Declaration now ends up mid-function for a non-cleanup variable so this=20
should be split to two lines.

> =20
>  =09up->dma =3D NULL;
> @@ -329,6 +332,8 @@ static int lpss8250_probe(struct pci_dev *pdev, const=
 struct pci_device_id *id)
>  =09=09return ret;
> =20
>  =09lpss->board =3D (struct lpss8250_board *)id->driver_data;
> +=09/* for tests in lpss->board->exit() */
> +=09lpss->data.line =3D -1;
> =20
>  =09memset(&uart, 0, sizeof(struct uart_8250_port));
> =20
>=20

--=20
 i.

--8323328-595913266-1791544313=:8329--
