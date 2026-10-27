Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115577;
	b=zr3jiWEeiJv56Y5YA3mPUvOhiplZ/9Q/umWExvtEoTOQVJLG8BnSpjbCeTiUmXCHgJ4o
	 Y+rZe7TXw6LudqPFJ0QG3ljnApu98zuZwnqev1gN0w9ED/tStzLWobZVlNbVikBEf+DYQ
	 8IIFWxPH17UOnFqLhUnqXFjt2HoDOYE6AOaAaleTX2gLBmTjxViUJnvG6IDVwOrOi0utv
	 bNkEg9Ifk80xTQRRl3K2vrmiPPG+BjJ+y7ijcgXFN2EXVMEz0S125tOR0HrI70WSPV8bK
	 XujR27xiMNER8m1QyQ1NHE0L98qccQAKbVEPCH36Z2e7arbeMYUJMDHwGEp0WECuYBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115577;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4U3G5T1GLs62tZp4hNYExMVTrTq/saiAMb8ekEckPro=;
	b=WqggMC3T6vGWu44n9ODb0E1iyjIhUkpvLcdfZy3ZSYUrS1cY7gc8muzPW1aVJL5RawMh
	 X1cfby+/XdWyA33OvmeldAVcejGWrPyvFwE5gNXfIezohpvmdZFvsBKpLWOasdMYryRd7
	 ICuEY/0S2nFdgnVI3HAi8IL0n1hJFwiBylvf+rt+eyDwon2FY55ccGj0HQyEBnYIYkGmR
	 iCf20cCNuRABdpVZkVYR37wDf03JjJQgXjNMzd0HCutfUmNEjWIC5Y99xuqDcESQUWvaC
	 +2NBtfM2Z8sI1B1X2xewPnj4bdwwoCH0lK3lvDNUB+EY76F1ryBNNC/kZSL2IcbTMVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mOSNXubw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7864606B54C
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mOSNXubw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD9C1F01825;
	Tue, 27 Oct 2026 15:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115576;
	bh=4U3G5T1GLs62tZp4hNYExMVTrTq/saiAMb8ekEckPro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mOSNXubwiXstyV2GW83yV2GhdhG4KoU0neuERl0y22MyCyZuXeNqZm8cDy7ErGlJe
	 yRxn4sAPUwqyaltMNq7g49E/BhHtHshwqSVtO8VEsD3RAvhWX6cP+3lot+LFwJkOX/
	 Op1iVp5n6CfoFpAtteksvv8eB46Pmbacjd2EveiEkdnpcuE5Uy7xmZ/YQAzChDbDZm
	 U/nOGRmkmnJGGxSerEy9FXOCVYW5kq33uXXaz4UHY4v0ZAyPcrs8G7Qp0i0fgdKYh1
	 tEp0GYHmtLeMfTxaU1/s6rQ4zLlVv3oH1/QCE+rLGA1sZixIknvRCbfSLDgknmErFx
	 3GOpuHm/wtb+g==
Message-ID: <sashiko-outbox-186851@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 12/18] dt-bindings: serial: snps-dw-apb-uart: add
 Zhihe A210 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-a210-scmi-v1-12-74d58ce85bd8@iscas.ac.cn>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-12-74d58ce85bd8@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:39:36 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> The Zhihe A210 UARTs have separate APB and serial clock domain resets.
> Add an SoC-specific compatible that, like the StarFive JH7110 one,
> allows both resets.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-a210-scmi-=
v1-0-74d58ce85bd8@iscas.ac.cn?part=3D12

