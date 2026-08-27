Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA09469857
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854371; cv=none; b=SbeabyrGrlP4AnYmMPQ0CxxO44OvB4I6Zdu5mpHiXXFMefQ4bCn5Z/oaKIW+NPmhVLd59cbkb0dugAqKhfSINjJeNdo4QVRcGFFeJeX9FiVsddBx2yxA/t7vbayFTRsPvCa6UIRg/WcUXhHXHiViFRBDwC3fXYI/a1Oe7g/XcM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854371; c=relaxed/simple;
	bh=WAa1uFv5XuZ8IuaYVxOvfFoML4z+2eeBthD/wR8X1O4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fqo2MCJWMf5vsa1Q/36+hNe3RXwImvS8LbfkOVkm/zgxxQ0pRMqShHarWeS0UVU9hFg4nxeZL5u8oENDwU2FgbrvywnZXXEqw747HXCtYs9DxnBymGa0cwjERzTmDl+n97sQGrbn2jXTqa9jm9ozldwe4oE6RAEU/1tknzFEExA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfwA9JdV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfwA9JdV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22661F000E9;
	Thu, 27 Aug 2026 18:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787854366;
	bh=UeVUCOLSXyhfSojexQp9r8OLFVUF2xQ1d5HmhsG/koQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NfwA9JdV9cjLJ4cvI84Zo6iqeDPoiPRkqIfuYMCfxV+dxfMJb/UXtAfXLin/Aw4v7
	 vTNUxQCzwa06v+JZBQ7BSG850oLJqHGRi7kq/5coCeDeM3YoowOLTZ5RRZJND4k1ZS
	 JaWFHpJiNhz4HuQZ0QxNWUJWrEes711eAXvG4QAwwgf8NotGpj3UD1ZbTAwy5FXb3Q
	 LHP37sYykWMCcAxxNM+k9kcYeJeYiqljM9OzW3ywm1UKu/JNPh93dj1kb0f4E9/K1T
	 p8ADrERsWyfTXSCan2wFONQ1OboCA4tNbhsvqPclPLczeUuO/XmcPLuQ4aGx7RnszT
	 49jhcyjYI6JxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/9] serial: qcom-geni: Use geni_se_set_rate() for
 source clock configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-5-091697dbeb02@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-5-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 18:12:46 +0000
Message-Id: <20260827181246.A22661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Device clocks are enabled before restoring the OPP performance=
 state during resume, violating hardware constraints.
- [High] Returning an error from runtime_suspend after hardware is disabled=
 causes state desynchronization and system crashes.
--

commit 23fad340d403394b171aaa614c65cbbd0f718351
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

    serial: qcom-geni: Use geni_se_set_rate() for source clock configuration
   =20
    On the SA8255P platform there is no Linux clock handler for the SE
    source clock, so the driver has no way to compute the divider needed
    for a requested baud rate. To work around this, firmware instead
    exposes the SE HW supported source clock frequencies as OPPs on the
    perf domain device.

> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 3633723acef8d..23ecd137c5210 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c

[ ... ]

> @@ -2039,15 +2041,19 @@ static void qcom_geni_serial_remove(struct platfo=
rm_device *pdev)
>  static int __maybe_unused qcom_geni_serial_runtime_suspend(struct device=
 *dev)
>  {
>  	struct qcom_geni_serial_port *port =3D dev_get_drvdata(dev);
> +	int ret;
> =20
> -	return port->dev_data->power_off ?
> -	       port->dev_data->power_off(&port->se) : 0;
> +	ret =3D port->dev_data->power_off ?
> +	      port->dev_data->power_off(&port->se) : 0;
> +	if (ret)
> +		return ret;
> +
> +	return geni_se_set_rate(&port->se, 0);

[Severity: High]
Does returning an error from geni_se_set_rate() here cause a state
desynchronization?

If power_off() succeeds, the hardware (interconnects, clocks, and pin
control) is physically disabled. If geni_se_set_rate() then fails and
we return that error to the PM core, the PM core will leave the device
state as RPM_ACTIVE.

Subsequent accesses from the console or user space would then attempt
to read or write hardware registers without calling runtime_resume.
Because the hardware is already powered off, wouldn't these unclocked
accesses lead to a synchronous external abort and crash the system?

>  }
> =20
>  static int __maybe_unused qcom_geni_serial_runtime_resume(struct device =
*dev)
>  {
>  	struct qcom_geni_serial_port *port =3D dev_get_drvdata(dev);
> -	struct uart_port *uport =3D &port->uport;
>  	int ret;
> =20
>  	if (port->dev_data->power_on) {
> @@ -2056,8 +2062,8 @@ static int __maybe_unused qcom_geni_serial_runtime_=
resume(struct device *dev)
>  			return ret;
>  	}
> =20
> -	if (port->se.has_opp && port->clk_rate)
> -		return dev_pm_opp_set_rate(uport->dev, port->clk_rate);
> +	if (port->clk_rate)
> +		return geni_se_set_rate(&port->se, port->clk_rate);

[Severity: Critical]
Are the device clocks being enabled before restoring the OPP performance
state here?

In qcom_geni_serial_runtime_suspend(), the driver disables hardware via
power_off() first, then drops the OPP performance state to 0.

However, in qcom_geni_serial_runtime_resume(), power_on() is called
before geni_se_set_rate(). The power_on() function enables the serial
and core clocks at their full target rate while the power domain is
still at a 0 voltage vote.

Could enabling clocks without sufficient voltage violate hardware
constraints and cause a synchronous external abort on resume? Should
geni_se_set_rate() be called to restore the OPP performance state
before we power on the clocks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-derive_clk=
_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com?par=
t=3D5
