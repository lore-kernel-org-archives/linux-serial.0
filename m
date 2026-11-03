Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742181;
	b=K+tc1Y3zxiQvaWZxc6OTU4hLorn7ZbYwzXlOjFqWpQ7Uvqp/atswuNPjrn+pVJ395Ysm
	 +7TvGpiVKzlCsjUPnjtkkhDWfsFpcvCSCQAvriLNKAeVU64ujQxMqx3ZkT+1qGBh+h1tK
	 +h4f6kBhNHrTc/X7fl/LesUTAvqO7HDOe+5QHRW2PbR/rU6+ZKKqlzCMmnpv/SnSGjPYq
	 CdzkVj/4bWcM8gNCVfaZ4XsErnJ35S8SPXuKDsJY4Tv9cogBzb4Ml5uwxv1kTuiaRcExu
	 xcUbSuEEr5UWE0idD3kMa4rPAAtcRlw5947+4UZTnw+cWa+rmJPlpSNXkAMKWpAZCyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742181;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HuuG1T79zeTCzd7w96CDlpY3TbIzCJ2kj5J56BRRcsM=;
	b=RaCt09+JPYnhixHiGVEoOD8yKlroWNwGbTDAtPVP+L5bveg5QcCRNBUVcSmvJQnynonb
	 wA22HN7QISUQSfo4tcQ7ojlyI8QLiYD0WOb2ETWetQ4DYksc7kHYPHQ92z8QNt19RQVpn
	 DJQE6nu2k7PRS3oVNTmvy1i7N40c7Hu1Btf1CnaSv6+369KnjG/jkeiF3UtrG6/06fNdj
	 vX/a3LCWEWybbAbHrqyppLG3SBxHz1oWE1NhucQpUEj1oSFLTW/30Uottq1UU/OOBc2d3
	 FE55J9N/+iiWs3mGSO3zs3+Q8KFSg2WJQ6st+f8DMIkU/jN6srOclZ9nWo0SnyXr3rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImwUp4zl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1DB606A326
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImwUp4zl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A925C1F000C1;
	Tue,  3 Nov 2026 21:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793742180;
	bh=HuuG1T79zeTCzd7w96CDlpY3TbIzCJ2kj5J56BRRcsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ImwUp4zl/FeS18+bqs8D3Q7hE/PnBMy4p9FEC1B/wKimJ+s0Mm75ejOHxe2yneVez
	 ndZsPSzea7zgHHuXu5Xtl187E+2u8udqUAnd8BxOD93c/o4h+D6GFPZhnpSpeCufuN
	 h+pvS38/rwZjF8qKD+EsJ3ZpElkBta6zOfzzZvEKDsIAWoLveRH/AQzmLuY3tGePu1
	 4Cg7kya3HlhinNuLTH0OqgIUpm7Waeuet8yNNEGPk3aj83d3ATIXuMfLvlImp9SPxl
	 UYB2/C6FkAv29D1nfCiIP0X3rKTs8kX7q4y9Kb/nuPEis5MTn4rPQMIkHAmf6Ety2J
	 zVwqfyF0AXoXg==
Message-ID: <sashiko-outbox-196069@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/12] serial: 8250: widen RX trigger byte counts to
 16 bits
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-2-c9e248d685c1@gmail.com>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
 <20261103-submit-h616-uart-fifo-v1-v7-2-c9e248d685c1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 21:43:00 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> DesignWare UARTs can have 2048-byte FIFOs, with receive thresholds as
> large as 2046 bytes. The byte-sized threshold tables, setter argument and
> sysfs parser cannot represent these values.
>=20
> Use u16 for the threshold tables and byte counts throughout the 8250
> conversion and sysfs paths, including the uart_port callback interface.
> Keep the FCR encoding byte-sized and preserve the existing threshold
> selection. The Moxa setter continues to validate against its 128-byte
> FIFO before writing the byte-sized trigger register.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-h61=
6-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com?part=3D2

