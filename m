Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115798;
	b=CQdZWQyvSzlJQMUm3W+dBnWL+wEXIHo/J5p5BRxQwzIroI1hBwegPZWU8y1TKqG4pb5/
	 VAijlbv2XkuD/jaoe6C4iDdLhONHRkG7ZgfZWlFvRRoY2WJOeMR5886+M+05lzbXFE/rN
	 eybjuqaRPuaoOJ9OuGOUXyC7UtFpMd7SYYGCj6fBlPe4xxzXg05KNR2eGln8cSE4iaptH
	 cr1TS/U74ORqp916PTKdoRJADw7NPIgx8353bwR+IHkSj11+n5SUl7VgO8Abx6t+NmFME
	 lLLEyks1XqFlfVh2cbncfan6SzXcIDeosVcgOu0d5sHeN9Dn1fdvLiNYM5poBmKMHzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115798;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/UIpHZMP4Gw57CgHHsEuZBLeZ6egUWbk3eIS8lGInTA=;
	b=Cirz79oUOFWk6Gov7ygLCitrPdpgLQCTxmPN9Cj7cK6C2pIm7UF8HvSMnrqBSjo/pI4d
	 TS3ljKB6+4kCeuW8MwOLJepVWSESLkYwtBJz9x7ASNuM+In20h+QL0wvd/ScFLJLu2QaL
	 StcfLMCjvMpgKsDithhlyYtbrTtw52/uEPMzlm/fV5hDLOWoJjCYKTbA/s1Ai3FujtX9k
	 FK5Z9Uwj5C3py7MStM7WEdNc4gr+AlayWKeOPBIfmXbMQ0hQAY4kAfDCT7ybLVGXBNfRC
	 3UJGpjVvhln2oopaKGcWw2QZelJuCsmiv4l5/Y40BEpbu5BD8HeV3oLZpz6lsMrdXKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RyfRFw9c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968E3606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RyfRFw9c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6101F031E0;
	Tue, 27 Oct 2026 15:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115798;
	bh=/UIpHZMP4Gw57CgHHsEuZBLeZ6egUWbk3eIS8lGInTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RyfRFw9ceAdaE2EBj2ZLqdH0+qTpyxo3paTF31xT85NFbvFLy2MPZf9WPMkErUe4k
	 FlcmQ36KhBknKTPXp76N1CZwtsiHTnJGF0X0pHXTnrlxhFLTpAyBUGcQ8zwzp2q1LS
	 afRflX1CF0yRrGrLOd57oObEf6kcnCraphH5SzBs1TQjROp6de8t15fqvDHyja911o
	 syyC5Bv6bLxozXzuz/Ik1Gs6jH/8Hu2Bt5E5jxA8uDCFPmc4VcjnP7/8qseMnUy6V3
	 e5DcTkXAcuhm/cQniUyqVSQ9BLNd8x2jczz8afGiWz8n8nQ1INIP28GH92wid9k9iG
	 WK8PXhAtisuoQ==
Message-ID: <sashiko-outbox-186862@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 13/18] riscv: dts: zhihe: add A210 core support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-a210-scmi-v1-13-74d58ce85bd8@iscas.ac.cn>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-13-74d58ce85bd8@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:43:17 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
>=20
> Describe the CPU clusters, interrupt controllers and pad controllers.
> Use SCMI clock and reset services through the E902 mailbox, with a
> second mailbox channel for firmware notifications.
>=20
> Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-a210-scmi-=
v1-0-74d58ce85bd8@iscas.ac.cn?part=3D13

