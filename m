Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877174ADD8C
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854485; cv=none; b=AwIVJ3xjLkTcJ+E8E4vRpMTkxtqft0msm9xC4SGjc69tTRHCp2m2D08xQI4CS7OrqFSCe/lB+7tvO6gPPtMBY2o371KTIQ8kNSGO6+OCrp2PL1yS6HE+qu1DIBhbXUk8KrfI6aYEAODJFSnPbMqhH/jmnZv2AhP6HBZ8gXRpN4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854485; c=relaxed/simple;
	bh=K2Vme2v/oIZYUsX4WHmulOsiNJXplArSGGmjQo2Uvrg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=btp2wv5mNyq6naSGKq0DVP+M4auhWKXh3hmEV0Os6XgZA0PwhVzZXR+HfxwdwPLvLWmH8ns3ccUTrz6qCsY1VQ4L2ZlCjEvgKtP4O2vOmpBM0DqucfSKL5OO3+jt1nsRR8ZF+TSdSqDec3NKonETGNM+9veS6VWmkZPaNznwNcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knLqhmfJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knLqhmfJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04EC1F00A3A;
	Thu, 27 Aug 2026 18:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787854483;
	bh=xFpWOdTEye0cSelUWzpDbZBMSCxBIx9UFRPfzQOk4o0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=knLqhmfJoWuMF4BefY7iJ6oAdTqd8ydTHWjtO+lhRRcnoJ1plGK1F50L77RA7lWgX
	 98EDvDh6bnT/7QhzSR3Bc4BhK+Tpz3KU5URScy7Fcb7l59MdJm1+c3V/MkkpOWFCk2
	 35TMH8T2r5yVf0rh1GWvtJrh3GIIfLGl1ltaYJgmrDWJsKjEvXTaZmS1OJiqbcJJzz
	 +W6QquBTGHUmGdtR7gRueR7JkW6NQp5Jau1Ke0wOssMu051ZMthdCNWqeETyjlbfn4
	 iPt0qThANqJONIuveLNvxjeYv0nWsFsqRLkdpo6FPgfW6uau99I5wHxbHLu8poQvnu
	 wAZiu01NtCx+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/9] soc: qcom: geni-se: Remove OPP rate reset from
 resource deactivation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-4-091697dbeb02@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-4-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 18:14:42 +0000
Message-Id: <20260827181442.E04EC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Stale docstring in geni_se_resources_activate() referencing removed=
 behavior of geni_se_resources_deactivate()

Pre-existing issues:
- [High] Teardown asymmetry and broken error path in geni_se_resources_deac=
tivate() leading to unclocked access crashes.
--

commit b2f71df99b253ff18b7c7e30383a3f897e2d8b04
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

soc: qcom: geni-se: Remove OPP rate reset from resource deactivation

Remove the dev_pm_opp_set_rate() call from geni_se_resources_deactivate().
OPP resource management should be controlled by the consumer driver, and
the clocks are already disabled making the rate reset unnecessary.

> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni=
-se.c
> index 04f58a6f26fff..d4f0544d73c49 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -1039,8 +1039,8 @@ EXPORT_SYMBOL_GPL(geni_icc_disable);
>   * geni_se_resources_deactivate() - Deactivate GENI SE device resources
>   * @se: Pointer to the geni_se structure
>   *
> - * Deactivates device resources for power saving: OPP rate to 0, pin con=
trol
> - * to sleep state, turns off clocks, and disables interconnect. Skips AC=
PI devices.
> + * Deactivates device resources for power saving: pin control to sleep
> + * state, turns off clocks, and disables interconnect. Skips ACPI device=
s.
>   *
>   * Return: 0 on success, negative error code on failure
>   */
> @@ -1051,9 +1051,6 @@ int geni_se_resources_deactivate(struct geni_se *se)
>  	if (has_acpi_companion(se->dev))
>  		return 0;
> =20
> -	if (se->has_opp)
> -		dev_pm_opp_set_rate(se->dev, 0);
> -

[Severity: Low]
Does this make the docstring in geni_se_resources_activate() stale?

The docstring for geni_se_resources_activate() says:

 * Unlike geni_se_resources_deactivate(), this function doesn't alter the
 * connected genpds' performance states, which must be additionally handled.

Since the dev_pm_opp_set_rate() call is removed here, is there still an
asymmetry between these two functions?

[Severity: High]
This is a pre-existing issue, but can the error path in
geni_se_resources_deactivate() lead to system crashes?

Looking at the rest of geni_se_resources_deactivate() below this change:

	geni_se_clks_off(se);

	return geni_icc_disable(se);

If geni_icc_disable() fails (for instance, a timeout in icc_set_bw()), it
returns an error to the caller after geni_se_clks_off() has already turned
off the clocks.

Because the PM core sees an error returned from the deactivation, it aborts
suspend and keeps the device in an active state. Later register accesses
bypass runtime resume, and since the clocks are actually disabled, this
triggers an immediate synchronous external abort.

Also, within geni_icc_disable():

	ret =3D icc_disable(se->icc_paths[i].path);
	if (ret) {
		dev_err_ratelimited(se->dev, "ICC disable failed on path '%s': %d\n",
				icc_path_names[i], ret);
		return ret;
	}

If one path fails to disable, it returns immediately without re-enabling
previously disabled interconnect paths, compounding the partial teardown
state.

>  	ret =3D pinctrl_pm_select_sleep_state(se->dev);
>  	if (ret)
>  		return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-derive_clk=
_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com?par=
t=3D4
