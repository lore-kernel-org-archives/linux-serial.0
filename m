Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A7F4A262C
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069600; cv=none; b=i2YqHwXuACBTnZRFP8XydB7C1/3QeSLXj91WNBBcISduAfiojZVzSGDpxs0+OWTrefGyKZ/bvV6KaWVqF7QXlkHfv+u8+SUf8IQtz9jnxqsMx7r5UeGR9SGSRIi1eQD9HzEnI7vxiAzkCORzqjRbf/krjEOTE+DZTxBGXhiwcmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069600; c=relaxed/simple;
	bh=VW7652/ORNgwfymwsd0nqFcGR9NiGs+ZuwnnVhkwM1g=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZdXMnD9qsHrV08kl8u9M7FfJ0IHjsnhxPl67oqPs3goCiFPGXGPvSH0ISsfZD6KEqVIx4+JPsTl/tpQ2sH+XtgUG/Tf62LsL62FICYOiNKppHNDQwCRl6erpodsZGPLd18lkXYv6sgsY8WOzrBMt7bO/kHMnXESNmP9hWaXxab8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDPd/8nG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDPd/8nG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E681F000C4;
	Thu, 15 Oct 2026 13:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792069598;
	bh=VW7652/ORNgwfymwsd0nqFcGR9NiGs+ZuwnnVhkwM1g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oDPd/8nGvNHJ3Gvkv07qJXanvZPS3tiuryh/r2uDmKYtOf0ttTojaqLRmi1mLIbhx
	 JkfUx6M08wpjzWR5zrM2F62CZiK9QCyXELBxlO5VNlZ7Dto+jMJW6xCAOhi8dE93fc
	 p5jCpSf2VEQdrDpsGmQ1j2zcIraRmljD9n+oWb/aJd9pkHZKpUWKX4nPo6RPV4iUks
	 tyfOMvSwFZkhE6FGxIaIIVg0jQDlEvU5mPSyVXLnGSWN7Frr7pzWx9Rya9bezAzyaq
	 A0XPT3xanDBOaSKVSH9P7jGJON8pKFKPeXz/2uVAVFYHBmwsoQsl6i7VCMLqmscklb
	 wzIap+U2AIvEA==
Message-ID: <sashiko-outbox-172896@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/8] soc: qcom: geni-se: Add helper to set SE clock
 rate via OPP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-2-5da1096243c9@oss.qualcomm.com>
References: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
 <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-2-5da1096243c9@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 13:06:38 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> GENI protocol drivers need a common way to scale the SE source clock
> through the OPP framework. However, the device that owns the OPP table
> differs depending on how the SE resources are managed. For Linux clock
> managed platforms, the OPP table is associated with the SE device,
> whereas on firmware-managed platforms it is associated with the
> performance power-domain device. This requires protocol drivers to be
> aware of the underlying resource management model when requesting
> frequency changes.
>=20
> Introduce geni_se_set_rate(), a common helper that abstracts this
> difference and applies the requested frequency through the appropriate
> device. The helper automatically selects the performance-domain device
> when power domains are attached and falls back to the SE device
> otherwise.
>=20
> Acked-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-derive_clk=
_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com?par=
t=3D2

