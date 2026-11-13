Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599255;
	b=SW305/lf/NloxZU2Ftcy8+9WKYtOXrrpYZ0PZ8fPk7ReeTy/wsxp+ucvYmVP95dsYgpC
	 dkIqhfogIUt4fAwPCHwA96vTSPTWOupP1gpE2jiNSaLKOsGJ572RqKon/eeUR85gdeUdb
	 bRZQLJB2rdhB1brv+tcvfjfHukfupELGjrdoL463oFFpm/nojxQKIfaNnu2ExUq8ZVhP9
	 6B++iJu53hquyERPS/yroL4+JM0EHlfUsDwOUDrJ2+LghOzQ3zWQ3TrTvgSqDD0HDlp7i
	 Ubpt0LVF+7wyHbFhUzw+d/mMh0jyFUnvUoW7jFSQEFBD2zgUAH0E3I1b7UECNOzKDuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599255;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6VKmlVbdrlB+BfWJnCzTQA/Pa9YDXFyVUuEHp52Q7N0=;
	b=Vhd25Qez9rCjDXLJdWXMWbcJtjjchgGwjP033ftWs4onbB1g1W4FjJBS/fgJHPuZzvdI
	 GsYtHHHGACjF+sMSnAWoRlbSVwUyjGYRMfazdFPt3Etz4gV+GHblSmT2VMsf7Pd5UpvYz
	 XQmyhw1soC0XZY+mc5PnM1Mg4eB/X2g81PmZ7xyxCb++FnFovP1Juha4j9wdk2QW97ce6
	 2dIlr9GEx/9Vlg2D7DNwByk/f3HdhDPMi5lTsu3Mdm2YCkp1pDYVHWEhrFA8hPz84f5Ov
	 n1znpEcUqZsa+Muv85EVEc4PdKjo+BgYGv/W7zDP2dRvfE1y/9j3vj2xcaUQ7opHvzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oU8nCv7W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3AA606A323
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oU8nCv7W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8061F000C5;
	Fri, 13 Nov 2026 19:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599255;
	bh=6VKmlVbdrlB+BfWJnCzTQA/Pa9YDXFyVUuEHp52Q7N0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oU8nCv7W8lD5JhNSm7VsaET0hkl65Jd19l4bO5TAJzL1sMUKXrJbvLyUZKIVmwGx2
	 55xTl8KBTtNalyzysDbzsFEADiB1m/MhHd3wKQBrAxm7azgWTzG3vXm6QEKE+5JkB+
	 8WFRRrMbJvvAJao9GlM6kEalgMms5HyCs3Xbqr34FN3oHxNnj8/v/bDFe6ttmQCkr4
	 s2mfYX/OLxaIzrTZut9F2zFQZdsx4sVgrk+O6DLX0W6/P9l+8hBzLTH2AID3F+tu9l
	 PY8SfzKEUJqnTNQtESk9t3ySRjVslirgEk86h6gDfwjvOR0sOZpI0egsXqOuP7PQ4Q
	 +Tg4KQ+Kyhj1A==
Message-ID: <sashiko-outbox-213570@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/7] serial: sh-sci: Skip TDxE clear when hardware
 clears it automatically
Reply-To: sashiko-reviews@lists.linux.dev
To: "Diogo Ivo" <diogo.ivo.sx@renesas.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-g2ul_sci-v4-5-6815e41d90c5@renesas.com>
References: <20261113-g2ul_sci-v4-0-6815e41d90c5@renesas.com>
 <20261113-g2ul_sci-v4-5-6815e41d90c5@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:47:34 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Au Dang <au.dang.jx@renesas.com>
>=20
> On some SCI variants, the TDxE (Transmit Data Empty) flag in SCxSR is
> cleared by hardware when data is written to TDR. Clearing it again from
> software via clear_SCxSR() generates a spurious TXI interrupt, causing
> the last character to be transmitted twice.
>=20
> Add a tdxe_auto_clear flag to struct sci_of_data, propagate it to struct
> sci_port as has_tdxe_auto_clear, and skip the clear_SCxSR() call in
> sci_transmit_chars() and sci_poll_put_char() when it is set. Enable the
> flag for the PORT_SCI (of_sci_sci) variant.
>=20
> Signed-off-by: Au Dang <au.dang.jx@renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-g2ul_sci-v=
4-0-6815e41d90c5@renesas.com?part=3D5

