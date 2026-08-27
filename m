Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2061F3F9277
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855110; cv=none; b=HJ7W2bS59RvkzzLN4haoAsIPxHMyfx7S5JXGXGVQccvSxbET26NqUOnx5dNcbG36Hjfb9fbtNyIzMKQpakYAqIIsxYyUeiv7OljoQ4DPJhH6wQCkve0gp03IPZB3FdTn9vPIK15/AEd13/vb8Wrg9IdllFgSiqN9CCl70nGQBI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855110; c=relaxed/simple;
	bh=gl+W3zFcnDALNgP3XKdmhR1ProiIIn5cZWz76RYs+2M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=maJjkHc0OUqQ1o/I+4Eb2pv6m0YdshLoernSETOrvHab7wk1aOMcYzwcgExqg583EWfS6GTE9WYK0574hlTVihVO4zo/IiqPphpQzvPSPY5nbEqkdu9c1OQkSF9mCkLfngnkAu2oOZRMauo6U7on/1UqNx+G6zqiD/WYRk6sjzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iir/Slg3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iir/Slg3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906AE1F000E9;
	Thu, 27 Aug 2026 18:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787855108;
	bh=01bqORTxQO9prxkDAEcJEfkoNBv4/jjGBR8XJr/Sojs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iir/Slg3sa1gbDjW2ytTMXGMNkw0cu96evXAhnRYCAtdAykLf21LaJeopJISQA2va
	 nkiFCDwXR9j+TYQwnT5JvD7k/RbohR3hj70+Z4YW6g2nStO7l1Ag4W8byBDuP2TxL5
	 oEK0+vTYY9gLyV8Ari88J7OkfrMmEoQfystMqsE0Ap/gUz3UU15YGKbnfLzOAtrl4y
	 6bHG91Tg9faNmKR0AqHRthimg+KCTZAmEKO700lZ3c/uF5VBUgLmDKSjhs9VpJQE1/
	 BPs7/DLCBSNVLotPk1kJ7CdjByJTnpP7YvqpQq/ef7ulzSF0QMFMkEaLuS1DBHQtBM
	 ytuLUzIGb1OsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 9/9] i2c: qcom-geni: Use geni_se_set_rate() for
 setting source clock frequency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-9-091697dbeb02@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-9-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 18:25:08 +0000
Message-Id: <20260827182508.906AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing pm_runtime_put() on error path in geni_i2c_xfer() causes P=
M resource leak.
- [High] Memory leak of `dma_buf` and `dma_addr` arrays on initialization e=
rror paths in multi-descriptor GPI transfers.
--

commit 94f912454825d4e32acc9ffbdaf4425dd413984d
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

i2c: qcom-geni: Use geni_se_set_rate() for setting source clock frequency

This patch refactors the GENI I2C driver to use geni_se_set_rate() for
source clock programming rather than relying on platform-specific callbacks.
This allows the GENI core to abstract resource-management mechanisms and
enables a common code path.

> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-=
qcom-geni.c
> index 0b178701e1d1e..deb0d822290c3 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
[ ... ]
> @@ -985,7 +984,7 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
>  		return ret;
>  	}
> =20
> -	ret =3D gi2c->dev_data->set_rate(&gi2c->se, gi2c->clk_freq_out);
> +	ret =3D qcom_geni_i2c_conf(&gi2c->se);
>  	if (ret)
>  		return ret;

[Severity: High]
This isn't a bug introduced by this patch, but does the error path here
permanently leak the PM runtime reference?

Earlier in geni_i2c_xfer(), we acquire a reference:

	ret =3D pm_runtime_get_sync(gi2c->se.dev);
	if (ret < 0) {
		...
	}

If qcom_geni_i2c_conf() fails, the code returns directly without dropping t=
he=20
PM usage counter or restoring the suspended state, which keeps the device a=
nd=20
its parent power domains awake indefinitely. Should there be a=20
pm_runtime_put() call before returning here?

[ ... ]


While reviewing the driver, I also noticed a pre-existing issue in=20
geni_i2c_gpi_xfer() and geni_i2c_gpi_multi_desc_unmap().

[Severity: High]
This is a pre-existing issue, but does geni_i2c_gpi_multi_desc_unmap()=20
leak the dma_buf and dma_addr arrays on initialization error paths?

In geni_i2c_gpi_xfer(), the arrays are allocated:

	tx_multi_xfer->dma_buf =3D kcalloc(num, sizeof(void *), GFP_KERNEL);
	tx_multi_xfer->dma_addr =3D kzalloc_objs(dma_addr_t, num);
	if (!tx_multi_xfer->dma_buf || !tx_multi_xfer->dma_addr) {
		ret =3D -ENOMEM;
		goto err;
	}

If the dma_addr allocation fails (or if an early mapping call fails),=20
the function jumps to the err label and calls geni_i2c_gpi_multi_desc_unmap=
()=20
with msg_xfer_cnt evaluated to 0.=20

Inside geni_i2c_gpi_multi_desc_unmap():

	for (; tx_multi_xfer->unmap_msg_cnt < msg_xfer_cnt; tx_multi_xfer->unmap_m=
sg_cnt++) {
		wr_idx =3D tx_multi_xfer->unmap_msg_cnt;
		...
		if (tx_multi_xfer->unmap_msg_cnt =3D=3D gi2c->num_msgs - 1) {
			kfree(tx_multi_xfer->dma_buf);
			kfree(tx_multi_xfer->dma_addr);
			break;
		}
	}

Because msg_xfer_cnt is 0, the loop condition evaluates to false immediatel=
y,=20
and the kfree statements are skipped. Does this permanently leak the=20
allocated dma_buf array under memory pressure or DMA mapping exhaustion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-derive_clk=
_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com?par=
t=3D9
