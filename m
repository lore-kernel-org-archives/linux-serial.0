Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376E344E671
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854590; cv=none; b=gpgeKaUyIZyrYtzisCqldhb8GI8tTvwE+LrHLfGJkYxAklZ2KLeK4R8aHn0kGUcrEy12xlFQFVVvHHyoXN0pFzG8x1cX2vtX8tgSJ6CQayX+lO3RhQS9yPXvvaeSqnJg+/C81QNOd/e4HA1U1l8g86fSuYnR6se7aEvZBfxXmg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854590; c=relaxed/simple;
	bh=xx3O6dCdbDuk7s0FOMMXNKlkJ1IiqP9vXF3WOtpmcJ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=juYkjJ9ICYDCD/G1zhr3pZE4VOMAQVXORIrtuxxDsc7r1bvBzWDc+W5TxieZPuavhQMwgNKjSCCByuIKujqiRAkoZvW31sbXWdPYiikfR9FtNJLmIoBvW9rUC8QvAej3WeVuinotolFuXx2n0kO5n85LNp/9ifiLAQBykrIX/Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5iKe/ze; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5iKe/ze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D811F000E9;
	Thu, 27 Aug 2026 18:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787854589;
	bh=nKxRAvIziaS8cj6N4nYRGI9aJ6s75khPeADdPKw3sUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y5iKe/zeqPANYZ8ahYZhWu23dXTtJ1JY+bqZwhkMlbfcr5Z7T+jNyt650btD3PH9h
	 SI2azqGJOqFVIlc7vLYxTRkjx6wFki7ekEkh/8yFkhBkCP04evKKBy6fj4z5oWEMs3
	 eO6OeltknYc1l067bRnB0SD18eY8LbNTAoNXVRKYNntHl4/+keFSreIzQTHdlSRH3K
	 0Wjd/fbTMz6dKj6uZQ0vbRdkac/S+OJw/NPuWmhSKIf8ygnclgx/vgGbjI7d3SW818
	 6q88pOe6YiUp58vG0IYz8/P1JRd0c/cWugC8kmMQYS0ygV7Bri+N4/vsAh4OwLvhRf
	 aWDOW3XEM88eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/9] i2c: qcom-geni: Use common GENI resource
 initialization helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-8-091697dbeb02@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-8-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 18:16:28 +0000
Message-Id: <20260827181628.D8D811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Severe performance overhead by executing heavy interconnect calls =
on every I2C transfer.
- [High] DMA channels allocated during `geni_i2c_init()` are leaked if subs=
equent probe steps fail.

Pre-existing issues:
- [High] PM runtime usage counter leak in `geni_i2c_xfer()` on `.set_rate()=
` failure.
- [High] Memory leak of multi-descriptor DMA buffer tracking arrays on tran=
sfer failure.
--

commit 70cf5551bb430cb5f179e24ea3c574d784037179
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

i2c: qcom-geni: Use common GENI resource initialization helper

The driver implements a custom resources_init() callback for clock
frequency validation and bandwidth vote programming. This commit moves
the clock validation to the probe function and programs the bandwidth
vote from qcom_geni_i2c_conf(). This allows the driver to use
geni_se_resources_init() directly.

> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-=
qcom-geni.c
> index a3b7609e3cf95..0b178701e1d1e 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -242,7 +242,9 @@ static int qcom_geni_i2c_conf(struct geni_se *se, uns=
igned long freq)
>  	trace_geni_i2c_bus_setup(gi2c->se.dev, gi2c->clk_freq_out,
>  				 itr->clk_div, itr->t_high_cnt,
>  				 itr->t_low_cnt, itr->t_cycle_cnt);
> -	return 0;
> +
> +	return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
> +				  Bps_to_icc(gi2c->clk_freq_out));
>  }

[Severity: High]
Does moving this interconnect vote to qcom_geni_i2c_conf() introduce a
regression that causes severe performance degradation?

Because this function is used as the .set_rate callback, it is invoked by
geni_i2c_xfer() on every single I2C message transfer. Executing an
interconnect vote unconditionally on every transfer forces expensive SoC
fabric updates constantly.

[Severity: High]
This is a pre-existing issue, but does a failure during the rate setting ph=
ase
leak the PM runtime usage counter?

If .set_rate() (which now includes the fallible interconnect vote) fails
during an I2C transfer, the error path in geni_i2c_xfer() returns directly:

drivers/i2c/busses/i2c-qcom-geni.c:geni_i2c_xfer() {
    ...
	ret =3D pm_runtime_get_sync(gi2c->se.dev);
    ...
	ret =3D gi2c->dev_data->set_rate(&gi2c->se, gi2c->clk_freq_out);
	if (ret)
		return ret;
    ...
	pm_runtime_put_autosuspend(gi2c->se.dev);
    ...
}

Returning early here entirely skips the pm_runtime_put_autosuspend() call,
permanently preventing the device and its enclosing power domain from
suspending.

[ ... ]

> @@ -1199,6 +1183,11 @@ static int geni_i2c_probe(struct platform_device *=
pdev)
>  	if (ret < 0)
>  		return ret;
> =20
> +	ret =3D geni_i2c_clk_map_idx(gi2c);
> +	if (ret)
> +		return dev_err_probe(gi2c->se.dev, ret, "Invalid clk frequency %d Hz\n=
",
> +				     gi2c->clk_freq_out);
> +
>  	ret =3D i2c_add_adapter(&gi2c->adap);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Error adding i2c adapter\n");

[Severity: High]
Does this error path introduce a regression by leaking the DMA channels
allocated earlier in probe?

The geni_i2c_init() function successfully requests DMA channels via
setup_gpi_dma() before this point. If geni_i2c_clk_map_idx() fails here
(e.g., due to an invalid DT clock configuration), the probe function returns
the error directly, bypassing release_gpi_dma() and leaking the channels.

[ ... ]

[Severity: High]
This is a pre-existing issue, but is it possible for the multi-descriptor
DMA buffer tracking arrays to leak on transfer failure?

During multi-message transfers, geni_i2c_gpi_xfer() dynamically allocates
tracking arrays. If an error occurs (such as an I2C NACK from a target
device), the transfer loop terminates early.=20

Inside the cleanup function geni_i2c_gpi_multi_desc_unmap():

drivers/i2c/busses/i2c-qcom-geni.c:geni_i2c_gpi_multi_desc_unmap() {
    ...
	for (; tx_multi_xfer->unmap_msg_cnt < msg_xfer_cnt; tx_multi_xfer->unmap_m=
sg_cnt++) {
        ...
		if (tx_multi_xfer->unmap_msg_cnt =3D=3D gi2c->num_msgs - 1) {
			kfree(tx_multi_xfer->dma_buf);
			kfree(tx_multi_xfer->dma_addr);
			break;
		}
	}
    ...
}

Because the error aborted the transfer early, msg_xfer_cnt is smaller than
num_msgs. The kfree() condition is never met, resulting in a permanent
memory leak of the kcalloc() allocated arrays.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-derive_clk=
_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com?par=
t=3D8
