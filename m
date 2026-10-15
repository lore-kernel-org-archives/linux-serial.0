Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4203E2459C5
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069800; cv=none; b=DnM0O6jei6ieKc7eRCVay1TSwKxUhsFHLcXS0GyIeOSlN2yIEQhj0IFSR79B8CX9fcLarAaRy/FaHmV8JDbTexqbK/qtjKze0AQlv0db6Md7ksYsZkW9JfWHRvxKMsMb11J6ZgLGdrueJHA4h/2GIGkITLInJPOtkGg7pA0B1r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069800; c=relaxed/simple;
	bh=xypxk3WcLZZGs8FZHMzCxsKIH5f80SnavlDT4NY+vR8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FlKZ1mMtTTxP1OwZwpxb47PO6ZXpH+rRWZng0ivBfilRW6yCB2QdpAIeyEPAGy27nGIE+7MKeU6oXZI1wx450dvMA9OjjppqX+gQAKoMwbPzPBUYnMunxwVdWNwzmpiMjzBXOuMyPQoi4di9+xP+E3NpgFrQAHvxQELDSvnS1xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ee0tM6u0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ee0tM6u0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA101F000C4;
	Thu, 15 Oct 2026 13:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792069798;
	bh=aNaawadwwEAs5ZmFM2dY8Od5eO//wWyOJWWJVt0vSJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ee0tM6u0PzlIFGodspTl1mWXGaErllP93VHa73z1q2nDChliEcuRjgLKIGxVqB4b+
	 qy7C25OWgsd9paP2e938sGEonbEeJz8XfgnTeSvW6jKNE3FLPMIvbVHlqDthY3h5Ka
	 3j2Ptgquaoe8xdylugHy4C6crxTXYBWtrDp8MVw+IdmF2nQEr1c6u3/WJg7jcHcHTe
	 HPyluUZY2DHJqAR+TKIvArff++/4ShJ18hzo0Rx5Psjip11NKK1yNHLEtwD7dH+u0O
	 PDYPbP1Fr30Sd1WC7lkF8R7O+s3V3qWBHtDH6WFprEFsBN4AcGtjIUauZdhHS9LsB7
	 yD488bAtEKSzw==
Message-ID: <sashiko-outbox-172900@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] spi: qcom-geni: Use geni_se_set_rate() for
 setting source clock frequency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-5-5da1096243c9@oss.qualcomm.com>
References: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
 <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-5-5da1096243c9@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 13:09:58 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pm: spi_geni_runtime_suspend() desynchronizes PM state if geni_se_=
set_rate() fails
- [Medium] pm: spi_geni_runtime_resume() leaks clock/power resources on gen=
i_se_set_rate() error
--

commit 18dd7909ccc7f7c6dc80af1c7154961b4692ab24
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

spi: qcom-geni: Use geni_se_set_rate() for setting source clock frequency

On the SA8255P platform there is no Linux clock handler for the SE
source clock, so the driver has no way to look up the source clock
index and divider needed to fill the GSI CONFIG0 TRE for a requested
transfer frequency. To work around this, firmware instead exposes the
SE HW supported source clock frequencies as OPPs on the perf domain
device.

> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 91e75e213f929..cbccd6d8689ab 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
[ ... ]
> @@ -1248,9 +1246,14 @@ static int spi_geni_runtime_suspend(struct device =
*dev)
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
>  }

[Severity: High]
Does this desynchronize the PM state if geni_se_set_rate() fails?

If mas->dev_data->power_off() successfully powers off the device (disabling
clocks, interconnects, etc.), but geni_se_set_rate() subsequently fails and
returns a negative error code, the PM core will abort the suspend transition
and leave dev->power.runtime_status as RPM_ACTIVE.

Since the PM core considers the device active, will subsequent operations
bypass the pm_runtime_get_sync() resume path and directly access hardware
registers while the clocks are actually disabled, potentially leading to an
unclocked access exception?

Could the error from geni_se_set_rate() be ignored or handled gracefully,
or should geni_se_set_rate(0) be called before power_off()?

>  static int spi_geni_runtime_resume(struct device *dev)
> @@ -1265,10 +1268,7 @@ static int spi_geni_runtime_resume(struct device *=
dev)
>  			return ret;
>  	}
> =20
> -	if (mas->se.has_opp)
> -		return dev_pm_opp_set_rate(mas->dev, mas->cur_sclk_hz);
> -
> -	return 0;
> +	return geni_se_set_rate(&mas->se, mas->cur_sclk_hz);
>  }

[Severity: Medium]
Can this leak clock and power resources if geni_se_set_rate() fails?

If power_on() successfully enables the device clocks and interconnects, but
geni_se_set_rate() fails and returns an error, this function returns that
error directly without first calling power_off() to unwind the state.

The PM core will then mark the resume as failed and transition the device
state back to RPM_SUSPENDED, orphaning the active hardware resources.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-derive_clk=
_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com?par=
t=3D5
