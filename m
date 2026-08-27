Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2624457A6
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854322; cv=none; b=dol2VoJcVbtY2KiamF0jbz9w/s+XkOOsn/41TWt9drg50/CyCKZFUozgUeJmhIoaal1Ep1XnbpPU/lBjcjCCFGKYptAkwn6vamE5XoVbxjHyxdcQq7OQKQ4AvlgvH+AR2kHGi9IX0pH7xiveZFEehRSWc5ZenDDVD0flbnV0HVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854322; c=relaxed/simple;
	bh=3zpWay0Os8mxDycil9ikSmRQszgrFQda/FLeu0w0p1A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bUTIt0X5feN8NB0qBi9EtvciP3x3a2QYK/vKuN/tznw2u2wCDxeLwV7mU/hvhuosJu6Ldgk/qmjJDodto2xGPcEOQtHgHJ5FZteQ6cuUtK79ygN4AV5X2v1gycxqQ2lwVwkI3amQQIRXVdkhB/jNq3GuYKwLI/yvOls11AauCcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rz5BQ2w3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rz5BQ2w3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD471F000E9;
	Thu, 27 Aug 2026 18:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787854321;
	bh=5PpaJAmP953cMaVTfqct9NTBY2pg8oqE3wwdF2EaGHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rz5BQ2w3lW2WX4MAyhGQ0UEE230HCHnnLCWJIuD1unSqhH4FyE6Kkf6LO9AQq8ZOW
	 l+T3Dy5A4GKKwFDbIiADKv0MZjdrKgjzCAZGS2saYnYEp0Al7xySMAgnPOa5thiqnq
	 OZe6HYBo7Y7IilhoS5lkme1TxHyCvomFOdJ1mh4YSxbbH14RDGYUjNE6TnT03Ixif4
	 1ncZQDAHBUkriJHOK6jnjsSUnJmT/XSulLkFohkL+0G353FdvplEUnPoiFlWiDKQZ9
	 d4IIsEYAkmR35TM2A7q4z+PuNk+7aY9p9pQ2J9ZEizOFxGs1BFkc7wWes0xl+F10/l
	 r8vn3v9naEhjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/9] spi: qcom-geni: Use geni_se_set_rate() for
 setting source clock frequency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-6-091697dbeb02@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-6-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 18:12:00 +0000
Message-Id: <20260827181200.EFD471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] spi_geni_runtime_suspend() returns the error code from geni_se_set=
_rate() after already disabling hardware clocks, leaving the device powered=
 off but marked as RPM_ACTIVE.
--

commit dac5e1011a1f48eebd4fa7951d45a6efb1aeeb9a
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

spi: qcom-geni: Use geni_se_set_rate() for setting source clock frequency

This commit switches the spi-geni-qcom driver to use geni_se_set_rate()
instead of dev_pm_opp_set_rate() for source clock programming, allowing
firmware-managed platforms to utilize geni_se_clk_freq_match().

> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c

[ ... ]

> @@ -1161,9 +1159,14 @@ static int __maybe_unused spi_geni_runtime_suspend=
(struct device *dev)
>  {
>  	struct spi_controller *spi =3D dev_get_drvdata(dev);
>  	struct spi_geni_master *mas =3D spi_controller_get_devdata(spi);
> +	int ret;
> +
> +	ret =3D mas->dev_data->power_off ?
> +	      mas->dev_data->power_off(&mas->se) : 0;
> +	if (ret)
> +		return ret;
> =20
> -	return mas->dev_data->power_off ?
> -	       mas->dev_data->power_off(&mas->se) : 0;
> +	return geni_se_set_rate(&mas->se, 0);

[Severity: High]
If geni_se_set_rate() fails and returns an error code here, won't the PM
core abort the suspend transition and leave the software state as RPM_ACTIV=
E?

Since mas->dev_data->power_off() was already called just above, the physica=
l=20
hardware (clocks, interconnects) is disabled.

When the next transfer is queued, pm_runtime_get_sync() would see the devic=
e=20
as RPM_ACTIVE and skip runtime_resume(), leading to accesses of unclocked=20
hardware registers. Could this cause a synchronous external abort when the=
=20
registers are accessed?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-derive_clk=
_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com?par=
t=3D6
