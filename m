Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745184;
	b=P9pnEvE+79DU7QpNKxtp8iNRtRyOIp8bOWgkxSNvvhDhu9q2ytPUDcdK6U9x97v1UGvZ
	 S12n7Srs7Jmu9ygHhySfwq1EWe2ecfOJHq/P4R4IctnVDXS71bewDHCQXF/SlPI4GFIEg
	 3R6pncy6H7Hpdk+XeW6tq2Ng+pzUD7U19cX+pAXrMONWQziR3VtsY3PAiugVZzy0sXbiR
	 nnCREqsp8/WDpAsoy7ImZarV/laSgnpK6xnEmE7MRe8J7wLVc43XfwFPGVFlGwCKVqat+
	 6ymd6lzdl39BlQOkIeivkA+Pd3uFpKnBua960Kf3/MXlOBB1AIVPg/tsFBiQie/HlMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745184;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A6GMBZEqkcxB7ZksuM3qTztOdsAPT6gVvyoKXdVdRGg=;
	b=rkvOA8fG8IaaZRO87FfyyftvPlipDXx80rAQMjE997wPnKU/0YeiVtT4Hw/xcIQVHgOo
	 J1EZyfJ9Bo/eFyuWWj0O+DsNudLqTFAOIAUT8t5j2UjWWQtBALeULkZXbqnjwdUcpBOPE
	 Nz2GjCOqE/UtHniSLUFyPc4cBy/eg4pvShDsyEgcl3EKYOxnecnWbzkzUVQuxMt+VaSwW
	 ir286xihXFOxrOj8LkExdg9h4h2xfaBE8SuPkDUNHjDGPf46celJfsziirEH8zt/vcWcS
	 crfdZ9QgrSnYM4j+hmK//7scSSHIdtPxtOhS8F5Fxu0FSnuyqsDQ0SA/DGha6vcRAVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lUo52UfI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861C1606A324
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lUo52UfI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DD31F000C1;
	Tue,  3 Nov 2026 22:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793745184;
	bh=A6GMBZEqkcxB7ZksuM3qTztOdsAPT6gVvyoKXdVdRGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lUo52UfINN/nJcAVS0+K7rpE99vesSGPgsPT8S5PznpppuDWW4OtnvKJ7QC1zIrP4
	 uXdLehXJRMidLrG4j/kHx46plcPZE3iRCwhOzu30cazcynLE+A2CjNu5/x2RLJgYmo
	 oM1fwryOTjL7ueI+6QVx+sNKbr3eNnMbZauXw/Y+OxoCPVT0uYys8LglusTKNS6CQt
	 TYd72S0nSmnBJ3joWOxIh7D7N7ydjSIu0RruKdtiQJREdeju8xrEHB/dKa2F7rN3Lj
	 Nv/A6hLFw9sdJ8Gu760nN0YLkRMaNNj0O30xf4y8hqL+KDejBhdcox36UszKEGT/pg
	 ZoX1wR9sKCyEQ==
Message-ID: <sashiko-outbox-196122@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/10] dmaengine: dw: calculate residue in the status
 getter
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-5-2ee0c348224d@gmail.com>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
 <20261103-submit-dw-dma-synchronize-v1-v6-5-2ee0c348224d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 22:33:03 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Serge Semin <fancer.lancer@gmail.com>
>=20
> Calculate hardware-LLP residue while looking up the requested cookie under
> the channel lock. The scanner and the status getter currently take that
> lock separately, allowing a descriptor to start between the scanner's
> residue update and the status query.
>=20
> Have dwc_get_hard_llp_desc_residue() return a local residue value from a
> fresh LLP snapshot. Keep the persistent residue field for software-LLP
> block accounting, subtracting the current block's progress when reporting
> status. The descriptor scanner continues to advance software-LLP blocks
> and complete cookies from RAW.XFER, including for polled transfers.
>=20
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: retain polled completion and software-LLP progress]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-dw-=
dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com?part=3D5

