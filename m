Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB3D18FC8F;
	Thu,  8 Aug 2024 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130871; cv=none; b=RsMOuh1huSQkVowuh3xLpXIw7I91MesmuYU8v4Ve+ScLCASGvS8XcjOG6UUZ2D0Mf1ciUxp5CbaCkjiQ5KWnX04rZU55cgtmom9EwFpPv+1ID8b0P1e1H2Oc0pWmIMLDNpiR9/pXGM3IbNSRPS+hJgVl+GOsPOUH7vPEaL0Ugmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130871; c=relaxed/simple;
	bh=pVXT/WpO/Vd+dSlyATMq7jQ1Q/Ms9tqOBgO9J2528xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FEBESiNipDgP5SROq6sH1QXkbA5IIAdoa+ylbDh5IHb/CdGmZoroZNpzu9Ad0ucQEe2QTcwS6WiL4vgqRE4CjZcp5cmgGiPe3es3+Phj5LQtrzA01dYv5ERaOeKVZkS+GyAKWK4eEDDIToKGaRtdhsmGy35i78vtXaHTh0dyWvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=B+w6oTaR; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=aj8lF0Qk reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="B+w6oTaR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="aj8lF0Qk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723130866; x=1754666866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O3S37yAL7py1iqZdhmEM/jnGQrTXFEljfmn4dyezkII=;
  b=B+w6oTaRhDuMKbTFBk0vX1WS22Fm20j7bpG0ENkrhK8KqGqSJSyQrug2
   L6Og/VRCQYD/Kb97QtxGmS0jcoUpHytrB4CzuzvjXLnoc2Xz2XRwQdxPM
   53NRCAOL4FApyNNeHWdxru3YUPRzZ9pcCjBqgPF+D/qFcNWjtSzvz45Cy
   X73NuZ1bEcuGwo0kzU9SjtSojh46TwR1Rz+0R3KrEuFR1ILs3coG5Flh7
   atK5UPOs5qWlROtAMKJYhofk7LMscndDauXYqbhIpL43TH5V1WUO2YzRr
   J6RLIJ6GYXlQYHPbvq3FKfM0WQkenL0mTqUdAvjCTPhsz7tzA9CGegn83
   A==;
X-CSE-ConnectionGUID: 0wLTaXIwTD2fd/4FQ+5ajw==
X-CSE-MsgGUID: 28+Zl++PSV69A5l8RYZXrQ==
X-IronPort-AV: E=Sophos;i="6.09,273,1716242400"; 
   d="scan'208";a="38319885"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 08 Aug 2024 17:27:43 +0200
X-CheckPoint: {66B4E3EF-12-DD19D171-FBE73682}
X-MAIL-CPID: 763AB2045628BCB4D3D087BA8D28C6F6_5
X-Control-Analysis: str=0001.0A782F1D.66B4E3EF.012A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F2149160A0C;
	Thu,  8 Aug 2024 17:27:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723130859;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=O3S37yAL7py1iqZdhmEM/jnGQrTXFEljfmn4dyezkII=;
	b=aj8lF0QkVhsxHv10leLLBYcFFhyNrnFMHCxdO+qRBHqCXF3X9nXJw5yzfJeHI9OTDj+lDF
	hMxfll7WJabig2mxinq/cY/IPnr8/MYfWNOL5UTLY7mkdzkjkVUM3/cN3kVybuGuvuIiY9
	GF2UZq2gj55H+GUVwyxaaYd0USFUyCwUrImQRMm6abDkwjBMLc6/vUWFZ1GJctI/Hd2+TD
	OgJMQ6k6gdwN+WMU1dJ889UL1r29pBntowJbSR3J44ECJKpu1A7qouUFdEx3iMfjGllpeX
	FbY3yVYBHFLPuKuNzzbTfJGFBCJWSFh09FnHLRkxm1oyADOULe9JP1ebjoNtAA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, u.kleine-koenig@pengutronix.de, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sherry.sun@nxp.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: mark last busy before uart_add_one_port
Date: Thu, 08 Aug 2024 17:27:40 +0200
Message-ID: <3306657.aeNJFYEL58@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240808140325.580105-1-peng.fan@oss.nxp.com>
References: <20240808140325.580105-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Donnerstag, 8. August 2024, 16:03:25 CEST schrieb Peng Fan (OSS):
> From: Peng Fan <peng.fan@nxp.com>
>=20
> With "earlycon initcall_debug=3D1 loglevel=3D8" in bootargs, kernel
> sometimes boot hang. It is because normal console still is not ready,
> but runtime suspend is called, so early console putchar will hang
> in waiting TRDE set in UARTSTAT.
>=20
> The lpuart driver has auto suspend delay set to 3000ms, but during
> uart_add_one_port, a child device serial ctrl will added and probed with
> its pm runtime enabled(see serial_ctrl.c).
> The runtime suspend call path is:
> device_add
>      |-> bus_probe_device
>            |->device_initial_probe
> 	           |->__device_attach
>                          |-> pm_runtime_get_sync(dev->parent);
> 			 |-> pm_request_idle(dev);
> 			 |-> pm_runtime_put(dev->parent);
>=20
> So in the end, before normal console ready, the lpuart get runtime
> suspended. And earlycon putchar will hang.
>=20
> To address the issue, mark last busy just after pm_runtime_enable,
> three seconds is long enough to switch from bootconsole to normal
> console.
>=20
> Fixes: 43543e6f539b ("tty: serial: fsl_lpuart: Add runtime pm support")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c
> index 615291ea9b5e..77efa7ee6eda 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -2923,6 +2923,7 @@ static int lpuart_probe(struct platform_device *pde=
v)
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
>  	pm_runtime_set_active(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_mark_last_busy(&pdev->dev);

This change looks sensible to me. Is maybe [1] addressing the same issue at=
 a
different level?

Best regards,
Alexander

[1] https://lore.kernel.org/all/20240808-gs101-non-essential-clocks-2-v6-0-=
e91c537acedc@linaro.org/

> =20
>  	ret =3D lpuart_global_reset(sport);
>  	if (ret)
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


