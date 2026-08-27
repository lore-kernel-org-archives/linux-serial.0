Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B13A3FB052
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854267; cv=none; b=uLK1AjYtUCoT42Xbxv4OfInpOXlceajfROVplCe6B2TpWT93CdZFqyHTEOVEVoPbNx5viT1QVaohI8msOjFOlJwiT7XzD8reoq96GgpPxf/JI2aUT1Of4lwF9FEuDC2txgo9J5JQEJgdcNadszVmjQYR96vDWJ/6Q+A3AaRoIJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854267; c=relaxed/simple;
	bh=mmOdqNag6RP/Q08tBoXzbT5nVUiYiPCXWMobM0A61Bk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qme6RvtxfUpiT8W2nWDThkn5w0gUTrZ6V5YIq2M4Yz/+SWOQYIYW+yqwVg/nPZj1rShnknd55uyOzqMd0P4yhQ+ynewGRg2tDKVR43WfGYmWd9bC1aYJLGYvWkkMY8i5RQdaef1rPTJUb3bFQ1lhMTZkE8rS/ySuywvu9Om104o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLVi/JZW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLVi/JZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE481F000E9;
	Thu, 27 Aug 2026 18:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787854265;
	bh=FFN7DSp/J2lYrpnZHoSjUSrA7gn+BrG0PLtMJOFyDd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MLVi/JZWKwrpQy3f3yuah4oKV9uXdmQwOkufY/3j8CoWLFtOR8B5qLywVN2IEiQ/1
	 cE6NLGrxC3TsoGj4Q7dt/8HIcGWeozE8t10lFxsw0eBEOCNn5LSmpvRMgOQim3rxC9
	 G3lLOEkw1xCxkbgnwrCfYTu2WONqUYqr9YmyEWwJ+T4WVHfEi32b8hj0TI0TEFl4t/
	 xuFhBdNZNOBVA4ykvlMKhrnTwr7e/L6xiSU/Lbxw2LbFGhCLRv7vANrYJvrUYErmcw
	 IgmhqX/fcmEcF1C6WmMsO12fuOm52icQU9ihc7q2oYdboI6SInF9BRM4UpqIrYNSHW
	 IBiSPGsLQmfTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/9] i2c: qcom-geni: Vote for SE clock rate using OPP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-7-091697dbeb02@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-7-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 18:11:04 +0000
Message-Id: <20260827181105.3BE481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] OPP performance state vote is leaked in geni_i2c_runtime_resume() =
if the device fails to power on.

Pre-existing issues:
- [High] Missing pm_runtime_put on error path when set_rate fails in geni_i=
2c_xfer().
--

commit 4acc892f1fa53a19ee146b34812667642ea2545f
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

i2c: qcom-geni: Vote for SE clock rate using OPP

This commit adds the source clock index and frequency to the I2C clock map
entries and uses them while configuring the controller. It requests the
required source clock rate through dev_pm_opp_set_rate() and programs
SE_GENI_CLK_SEL with the matching source index.

> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-=
qcom-geni.c
> index 658636c1ee0e2..a3b7609e3cf95 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c

[ ... ]

> @@ -218,8 +224,13 @@ static int qcom_geni_i2c_conf(struct geni_se *se, un=
signed long freq)
>  	struct geni_i2c_dev *gi2c =3D dev_get_drvdata(se->dev);
>  	const struct geni_i2c_clk_fld *itr =3D gi2c->clk_fld;
>  	u32 val;
> +	int ret;
> +
> +	ret =3D dev_pm_opp_set_rate(se->dev, itr->src_clk_freq);
> +	if (ret)
> +		return ret;
> =20

[Severity: High]
This is a pre-existing issue, but does returning an error here leak the
runtime PM reference in geni_i2c_xfer()?

Looking at geni_i2c_xfer(), it calls pm_runtime_get_sync() and then calls
this configuration function:

drivers/i2c/busses/i2c-qcom-geni.c:geni_i2c_xfer() {
    ...
    pm_runtime_get_sync(gi2c->se.dev);
    ...
    ret =3D qcom_geni_i2c_conf(&gi2c->se);
    if (ret)
        return ret;
    ...
}

If dev_pm_opp_set_rate() fails here, does geni_i2c_xfer() return directly
without dropping the runtime PM usage counter, permanently preventing the
device from entering runtime suspend?

[ ... ]

> @@ -1236,6 +1249,12 @@ static int __maybe_unused geni_i2c_runtime_resume(=
struct device *dev)
>  	int ret =3D 0;
>  	struct geni_i2c_dev *gi2c =3D dev_get_drvdata(dev);
> =20
> +	if (gi2c->clk_fld && gi2c->clk_fld->src_clk_freq) {
> +		ret =3D dev_pm_opp_set_rate(dev, gi2c->clk_fld->src_clk_freq);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (gi2c->dev_data->power_on) {
>  		ret =3D gi2c->dev_data->power_on(&gi2c->se);
>  		if (ret)

[Severity: High]
If gi2c->dev_data->power_on() fails here, does this leak the OPP performance
state vote?

Since dev_pm_opp_set_rate() was successfully called just above, if the
power-on fails and returns early, it skips calling dev_pm_opp_set_rate(dev,=
 0)
to cancel the earlier rate vote.

Will this leave the power domain artificially elevated indefinitely, since =
the
PM core considers the device suspended due to the resume failure and will n=
ot
invoke the runtime_suspend callback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-derive_clk=
_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com?par=
t=3D7
