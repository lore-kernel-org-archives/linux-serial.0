Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795518374;
	b=KXlqPPD720/o4fwzgo31ibSLn/YKZneQByJA3zlOSrGQwLMdUfi3j5BmS4EPdc5JsgWn
	 Ph8or3CBnUG2P3cMyVlOO/XhtUddEEcRXtxjM7b6d6VtPXl05m7+oeej0uHE8zKRD8PzU
	 +0vlhT15ZIxk7vaEnuLephAEyDsMph4ZhtkcGTRQ5wrYckpKEJ5cCWGJpTGSuWWhnWKtD
	 7IsgbtgdHsDEAByJbxF8CYo4Jj/s9ZG6VxLT3lOi9NXIDh0h3HG9X9OFMjFK4pgWQhFlq
	 FKaMhyoKjcbqW+eRUDlwXWWbIDCTW6F08+pWlbFV28y2iYxhWb4LpUVpT5p7WllBbpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795518374;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fZ9ioQa+cKW4maWs1mswM/usvCMhiiutfYcOtGCCGwA=;
	b=xLkGSAoH21ngT4zcnMWlwf/8hJgYhWWnwNC7VHJKOncgbaE0fYPWFb8FdGkU5bXKvg7z
	 HBOR99buy/4JbmP8ufnARLrNBipgCVAmY6veamx4nnIKnsnagv5SZHPK5fAbWhRngjp1D
	 Y3AYW/FLAVaSJVKwdZUSjYEKPUZnlhsGdhIBNBJiaf6QhiafMg5YsEDbNsX19g2cKKeRN
	 2eiFGJfE1FjO0OPmD+IGYRaoEcrm6DYkorPJXkbc8qpjEel+kAxC54KHWEqyCvhzJ0ivH
	 U5b+/sEuwmRQxSPXSFrGdJKoOXIcKbeYGbEHkAZTLiXBqaZwhmPy7+p2HPedc0xj3dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VJdcpK2+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FA7606A31E;
	Tue, 24 Nov 2026 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VJdcpK2+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915901F000C6;
	Tue, 24 Nov 2026 11:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795518373;
	bh=fZ9ioQa+cKW4maWs1mswM/usvCMhiiutfYcOtGCCGwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VJdcpK2+cDV4sSuRw5wwoBaKzfVEpnw/H5oYFOIfRxjA4plE4ywG7emV3OEQWfKaM
	 daUC+C6iEVkaqxwkVEccDlUwDEhejLSG38EFuyEn1t01iTh65arQggIpyReiMoxU5G
	 dV+3Wufrml4MahJRReIGOxBoMgKXWebgKNG7dCpNcyPXQGODT4ZWCN0vikQVjqJQOH
	 fk6OKDEKNGSCmPwOEo1S0f1ScsnIGwzW7BfJASsAILN5Zikz1GfrmRJQcHMhfiK4sQ
	 q01HeYXI7EvOxUsJDdDXdjZZFW1wL204tzbJg21SornbZs460ZfyjnZmtbZPXxILaP
	 gEVOSIE0lq6IQ==
Message-ID: <sashiko-outbox-231019@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: serial: Add compatible for Qualcomm Seca
 SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yadu M G" <yadu.mg@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <9ec98ffd6cec85ad77738128329ec77777a1f69d.1795517676.git.yadu.mg@oss.qualcomm.com>
References: <9ec98ffd6cec85ad77738128329ec77777a1f69d.1795517676.git.yadu.mg@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 11:06:13 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] dt-bindings: serial: qcom,sa8255p-geni-uart: duplicate fallback
  items blocks
- [Low] dt-bindings: serial: qcom,sa8255p-geni-uart: Seca vs secaau
  compatible mismatch
--

commit 2d2cf33141fe90fb33e2e810ca0831e391c86266
Author: Yadu M G <yadu.mg@oss.qualcomm.com>

dt-bindings: serial: Add compatible for Qualcomm Seca SoC

This commit adds compatible entries for the QUP GENI UART and debug UART
controllers on the Qualcomm Seca SoC with a fallback to the SA8255P
compatibles.

> diff --git a/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-u=
art.yaml b/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.=
yaml
> index 8496f822dfa5c..8415764222ac4 100644
> --- a/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
> @@ -24,6 +24,12 @@ properties:
>        - items:
>            - const: qcom,sa8797p-geni-debug-uart
>            - const: qcom,sa8255p-geni-debug-uart
> +      - items:
> +          - const: qcom,secaau-geni-uart
> +          - const: qcom,sa8255p-geni-uart
> +      - items:
> +          - const: qcom,secaau-geni-debug-uart
> +          - const: qcom,sa8255p-geni-debug-uart

[Severity: Low]
Why do these compatibles use the "qcom,secaau-" prefix when the commit
subject and description refer to the "Seca" SoC?  Codename-based Qualcomm
SoC component compatibles documented in
Documentation/devicetree/bindings/arm/qcom-soc.yaml follow the qcom,SoC-IP
pattern, so these should either be qcom,seca-geni-uart and
qcom,seca-geni-debug-uart or the commit message should explain the "secaau"
identifier.

[Severity: Low]
Can the new SoC-specific compatibles be folded into an enum in the first
entry of the existing qcom,sa8255p-geni-uart and
qcom,sa8255p-geni-debug-uart fallback items blocks instead of duplicating
both fallback blocks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/9ec98ffd6cec85ad777=
38128329ec77777a1f69d.1795517676.git.yadu.mg@oss.qualcomm.com?part=3D1
