Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914278;
	b=GMfIJE/hiwfdycpgkHaNmtVvZcOfhlNwXeYgN5I3kp0l2Kg6BNrHzgsFGbYLTfYG99wd
	 FvFt5sWliedjyU179zl7q+2LKqcO9q/t5PSaO7rf2rLe7KKwlkN372cf4C2ctkGokRvsR
	 6a0adIdPF4AX/IjjXkDM3YphYF3MKSPSgj2tddI5qXiuWSzMSI6ZaYVOUODCLpyFLVOI9
	 Ir4gMlyJXidxYcCVqQFTe9ZoqIO2tyWsyQvwAGmOA+5+aRhniAmcJWu810Jt0Rt6jaVmz
	 4CcRPf1nXDZtyJS8CpQQ7CnPPoYTAkhlKXHQAscgiraYpALEhAzYW+XDIOdIuNa1ZHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914278;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7ojVcfJwkMUs4N4NzXgYW8/NYwCBdSzjABJ/zhhfkyc=;
	b=1nyiDKGkI/89A80cSTSGGpBo1U7FwQ2LzD2HdsWDXdWII8nPWeIO3wC6pZtnk3+rjILZ
	 IrE89eE4kK+zQkvcZLVHZS3DYH8l0FtlF+hQInqgiGSyRHLQ0NKsxfjfqAhvtZVRCXSfa
	 DsrFUCazKRN3EMAFethVRoI8KMPkPbFbqYurS1nwn7sHwSmlJcoSGCzcqvBW98bADDhnS
	 ZrALjV+dsKRMy32hKV4dMMb8kGa8U16kkKnw2sAmyGrU7qZPDt19eSsUtdMMWyv/uVuas
	 AXhcx2m3BrbHc4PKmcUybnAYijWxTLnj6Z21wfs6jl2RG3EB1Fbo+zX0xZK5+f2rdTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8Pk1BSW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95E606A32C
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8Pk1BSW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D33E1F0089F;
	Thu,  5 Nov 2026 21:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914278;
	bh=7ojVcfJwkMUs4N4NzXgYW8/NYwCBdSzjABJ/zhhfkyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N8Pk1BSWu6ySf+JSWGvWJVlC++sizj59oSFRdFYof1nWuz6hjPRIDn4zi+eiKVw8W
	 LeufqKJyoNsB1d+0437VQ7WKmU8Cre5OFx/5j1BV9scSRRvEyBkjhuXnWh5DrVc+2b
	 f2iKDjE1QKAPr+tr4OrlCP+i3lr+Q0hswZBn5OXZ3NSvMMy/FBTpc4Hn7BdGMywthQ
	 4Be+ZLxxwcyTNE6XfXmStp8O0P7yvs1vV3LwdqcOJkylTRtN08CnkTIb0uFi4n+ZCX
	 4qULjUwwnjRywmsbcISMvarVdZ+RIIJwnndgv95nKoS0K/qZAkoWzIGPhz/BHLvKxE
	 9MEkwxK+T3uaA==
Message-ID: <sashiko-outbox-200232@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/11] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner A523
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261105-submit-h616-uart-fifo-v1-v8-9-14024d2b184b@gmail.com>
References: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
 <20261105-submit-h616-uart-fifo-v1-v8-9-14024d2b184b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:31:17 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The A523 UART integration has different FIFO depths across its controllers
> and reports each controller's depth in the FIFO Clock Control register.
> The receive thresholds follow the standard DesignWare FIFO-relative
> mapping, while the optional-register layout differs from the generic
> DesignWare integration.
>=20
> Add a compatible for this integration, also used by A527 and T527, with
> snps,dw-apb-uart as a fallback.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-submit-h61=
6-uart-fifo-v1-v8-0-14024d2b184b@gmail.com?part=3D9

