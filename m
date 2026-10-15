Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098232F0C48
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070130; cv=none; b=rKTENbdJcbNZkgQjub8KJK7dFqHjVlPhW6cwrHHVDqm8QRtSTGc+uAtNspnvwo+LxXXuYtbhyykQ3XxZhOMya2G9Ul+cIYRsoH9kfU+yRO0+jdV8AmmGLWRxS2a3SbgPfPHAkoa3L5LPNpzpuIxRl+95wI+Vrvvb9MucKYdyuO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070130; c=relaxed/simple;
	bh=sUFPZXsCtNtGPXWV0RgvD3LncyecRvN0wAePEomv34c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=imtQUJ5hwrvjS1/VDWscp/5NmCvCtqnOJvdNi2WaAAIJeU1vZUDJ0M1sxcuuaUxc/IlcmrNtcRhIEnQnlfiBNF+Uan5WUJWV9tio4GQyheNk/oJN3qdDiSSYB8BJfo/gch6oUynN92IMi4XjPHh347qfZ9LcojD9AbrWOGzQaPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wj0UjkH2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wj0UjkH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE151F000C4;
	Thu, 15 Oct 2026 13:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792070128;
	bh=L2H+VznNe1NjKEOSxrfHGP0qDCNR52fcQet/tdnrZQo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wj0UjkH21wJrFD3VBj2g+LWlmKPeL4pitA3qovEuYXM+3p6l/FjdlrTDkGL5lWdch
	 77gquKu4wVj05v5/2Dti0zLZbpxxbSlP7GpKPGXMoxmHRyklcbsh3wLj6MCzOc4MBL
	 UuQ9oH8om13xzTPXoIwYPKJUF82ELIMy62OMRM0UbMm/u3nPUzo8WQQUWUe1IYaO+f
	 oUnco32B8XpslkvTwRyU8bUqJNEqX+iq8F6bRzdKqZt+oQbKZyQ1QaMJzwvPBIqeOv
	 NPTKiBRw127FoOIQJnpvc6M+Wi085wup9RduG++1HTm5yXuT/7KfuqLv7KuLvv7Z5T
	 4B0J9J6B/LTnQ==
Message-ID: <sashiko-outbox-172902@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] serial: qcom-geni: Use geni_se_set_rate() for
 source clock configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-4-5da1096243c9@oss.qualcomm.com>
References: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
 <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-4-5da1096243c9@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 13:15:28 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] serial: PM state desync in qcom_geni_serial_runtime_suspend() erro=
r path
- [High] DVFS sequencing violation: clock ungated before voltage restored
- [Medium] tty: serial: qcom-geni: missing power_off rollback on geni_se_se=
t_rate failure
- [Medium] tty: qcom_geni_serial: Inconsistent state on geni_se_set_rate() =
failure
--

commit c05165e9ed1c294def3b3c9c4244bbde141fcad4
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

serial: qcom-geni: Use geni_se_set_rate() for source clock configuration

This commit transitions the QCOM GENI serial driver to use
geni_se_set_rate() for source clock configuration. This allows
firmware-managed platforms to handle clock programming centrally by the
GENI core.

> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 4a6f526340b8d..23e423009255b 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
[ ... ]
> @@ -1461,7 +1460,10 @@ static int geni_serial_set_rate(struct geni_se *se=
, unsigned long baud)
> =20
>  	uport->uartclk =3D clk_rate;
>  	port->clk_rate =3D clk_rate;
> -	dev_pm_opp_set_rate(uport->dev, clk_rate);
> +	ret =3D geni_se_set_rate(&port->se, clk_rate);
> +	if (ret)
> +		return ret;
> +

[Severity: Medium]
If geni_se_set_rate() fails here, the hardware clock divider remains
unchanged, but uport->uartclk and port->clk_rate are updated without being
rolled back.

Does this leave the software tracking variables advertising a new baud rate
while the hardware remains at the old rate? On a subsequent
qcom_geni_serial_runtime_resume(), the system might restore the new
port->clk_rate to the hardware, resulting in the source clock running at
the new rate while the hardware still uses the old clock divider from
before the failed termios update, permanently garbling the UART baud rate.

[ ... ]
> @@ -2051,15 +2053,19 @@ static void qcom_geni_serial_remove(struct platfo=
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
>  }

[Severity: High]
If geni_se_set_rate(&port->se, 0) fails, this returns an error after the
device was successfully powered off.

When a runtime_suspend callback returns an error, the PM core assumes the
suspend failed and keeps the device's runtime state as RPM_ACTIVE. Since the
PM core considers the device logically active, will subsequent UART accesses
bypass runtime_resume() and directly access the physically powered off
hardware, resulting in a fatal bus error (synchronous external abort)?

[ ... ]
>  static int __maybe_unused qcom_geni_serial_runtime_resume(struct device =
*dev)
>  {
>  	struct qcom_geni_serial_port *port =3D dev_get_drvdata(dev);
> -	struct uart_port *uport =3D &port->uport;
>  	int ret;
> =20
>  	if (port->dev_data->power_on) {
> @@ -2068,8 +2074,8 @@ static int __maybe_unused qcom_geni_serial_runtime_=
resume(struct device *dev)
>  			return ret;
>  	}
> =20
> -	if (port->se.has_opp && port->clk_rate)
> -		return dev_pm_opp_set_rate(uport->dev, port->clk_rate);
> +	if (port->clk_rate)
> +		return geni_se_set_rate(&port->se, port->clk_rate);

[Severity: High]
Does this sequence violate DVFS sequencing constraints?

During runtime_suspend, the OPP performance state drops via
geni_se_set_rate(&port->se, 0), which drops the voltage but leaves the
underlying clock frequency unchanged. Here during runtime_resume,
port->dev_data->power_on() (which invokes clk_prepare_enable()) is called
before geni_se_set_rate(&port->se, port->clk_rate) restores the voltage.

Could this result in the clock being ungated at its original high frequency
while the voltage is still dropped, leading to hardware lockups or system
reboots?


[Severity: Medium]
Also, if geni_se_set_rate() fails here, it returns an error to the PM core
without calling port->dev_data->power_off() to roll back the resources
enabled by power_on().

Since the PM core marks the device as RPM_SUSPENDED upon a failed resume
without invoking the suspend callback, does this permanently leak
interconnect bandwidth votes and clock enable counts, and leave the device
physically powered?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-derive_clk=
_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com?par=
t=3D4
