Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1B62FD665
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070191; cv=none; b=E48ZRfftyT7OS/e0xZC3Z3pM2POs8lTXuCjl5FeDzU5IIaN9nA0m+L3p8zxvhjlf0S09FxTr3FkPrq4/OO6oEODWhz2zYZTqgBDZsQ6e5hpy0T/246MU8/bJ0olWgAgL1IEv4aiE6twPceu/Vex+SjND2R9R5nxayamRjBwHIKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070191; c=relaxed/simple;
	bh=p9UwT3Fdy6bBPdBdcwpw3WgimojKYGvPjlybEIaifQA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PFUCrzwPZRNemqfU8E4ubyIZPjCr2YKS7U8G4bCJWv+TbnlcppSZ8EDnhNWad9bNPypPQe3h2vYk8MOQZBW+gsgpx6VJDRvsV82aanEfoyJIicsXb+Gj0zWrUhv1Gx0BA/iYdHDBcyDXlec2Pa5tcPOTzAHTf0pTmGkqYJVNZzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2vUzNYl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2vUzNYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2AB1F000C4;
	Thu, 15 Oct 2026 13:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792070189;
	bh=p9UwT3Fdy6bBPdBdcwpw3WgimojKYGvPjlybEIaifQA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b2vUzNYlZiY2ZrWgDN8fnNA0Exo5fbInhXxmwF13i6eKJ3nmCr2P8yYgVN4zTgL5R
	 zq+TYAQyvkRRYM+wpeGQDmveMtB6WSd7YFzoYTN8l4lRMPxeiDPgy+rS8e6RsSZGmA
	 HO16YIxp/tbooyGqqLwmr70Uf0UwCm0RIqqfp7frsqYuIwBi9sfezisQH2gLLl/otp
	 /OIFC9OsPwQLn3S6M4GY1HDNmswLppTI0p3XHQFYl1/k17oh6RKyxlwoJvHwa46BK2
	 FIWGXtKdtrUzwiKD4hg40aVtWsNH3ZTGJuuXR6/cpamD1yci/qUf2WGtkOCg4sUlIS
	 NJUR7NBGKbJOQ==
Message-ID: <sashiko-outbox-172905@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/8] soc: qcom: geni-se: Remove OPP rate reset from
 resource deactivation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-3-5da1096243c9@oss.qualcomm.com>
References: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
 <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-3-5da1096243c9@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 13:16:28 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Remove the dev_pm_opp_set_rate(se->dev, 0) call from
> geni_se_resources_deactivate().
>=20
> OPP resource management should be controlled by the consumer driver.
> Additionally, clocks are already disabled by geni_se_clks_off(), making
> the OPP rate reset unnecessary during resource deactivation.
>=20
> Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-derive_clk=
_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com?par=
t=3D3

