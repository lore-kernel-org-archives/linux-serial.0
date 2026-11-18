Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794960269;
	b=h1IWUT0S1K/gX3ioKPekW5qhpAkZX5JQ8+tACvHmBKrjPNYSPzF+P/h3ZYbcoZCKCWNJ
	 lNb4EaIucG6yG8ZadYqs946Xrydun3e2RlVfV8cD8katOctz/OH3jizcy/538NMYkOQbx
	 vemVwGefS+qGVD5DGTFkli90+0XE8ohH4m3OcIFTCfEQ6FE7DU58jloCF5tnzaxViiCe5
	 O0MQT021t2IauFVfVQHNleNr3dAKEboFhhbKEv3SXBgTFFEDJxjWH97I8jxfPuWXox3Dv
	 SJX/4wUGH4z6V1DmeQAmjOxuwJ8vqHHRzt5Fg8KIKgF3bvKnZ5HjdJtnbWwlOl4JcKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960269;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MRBtMSJDTmMOjpHVD+YQfVFhC7C4wCgjaibTFdtknFw=;
	b=eMfzjxurd3XEIql5We1IofJAlhwK1cQvLFCzG/ZxYBh1Nwd67Lo09PtjjHISdoIifW6M
	 TvidtnNUAS6wbuImNiuYVp/4d/z3wr6uJ6gQOQ7GenJUwSwGxncBF2doL3IG0XJ438xO0
	 nsrS5QmnjdXgO3wChgLD7KJHvTVpfmGX8RHZ7/trsv0falFSJtCatbqHK5qsL9ogRkoOO
	 CWU4QSzmFvytOBEPDZyFCXmTuruNVlztu3Zjl4ABW/EvYDB2c9Xs052D0Q8KpnKO3Hyu6
	 3KQR5J8WmcYYwwxYAm03NL3C+9/uF+2AT12/6cwmKiM0krVmhQU9cLZ0d4mwP9nQqiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VKMBi7el;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A8B606A32A
	for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 00:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VKMBi7el
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CFC1F000C4;
	Wed, 18 Nov 2026 00:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794960268;
	bh=MRBtMSJDTmMOjpHVD+YQfVFhC7C4wCgjaibTFdtknFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VKMBi7elDYCojpmz6XTVSw968QqW7zHxgMvXpVBNepEADyrWWbsRTKgsH7Sw0PyIe
	 xEW8m+cL9OJdLZc06Cj/0NGFZxbY8Be0X2xV1MgGc6pL2D2GdOE3ijdK1zQJ1BQ9Hc
	 ywJJEfKR6Mcat38fPuLtxo5rGLmXAjlm977DyWDSytNMSw+y75iWbx42CO1F7S0rQn
	 1yJ0uOEWWnYxvBl3bwfQtkqvynqTAio5jgRi9BpnhzVePsp6imOsSuVHslYBYsvAYy
	 QKGRD5HvWOfBpqyyMX/4RCvUqHt2ewIE5iVBrIclHkALn9jcpp8hu4t2rqAfbCrhjf
	 rUEd4EBFZTZoA==
Message-ID: <sashiko-outbox-219827@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/7] serial: sh-sci: Keep TX enabled on TEI while
 data is pending
Reply-To: sashiko-reviews@lists.linux.dev
To: "Diogo Ivo" <diogo.ivo.sx@renesas.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-g2ul_sci-v5-2-30b58ea18923@renesas.com>
References: <20261117-g2ul_sci-v5-0-30b58ea18923@renesas.com>
 <20261117-g2ul_sci-v5-2-30b58ea18923@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 00:04:28 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> sci_tx_end_interrupt() clears TE and TEIE unconditionally on SCI and
> RSCI ports. If new data was queued or transmission restarted before the
> TEI handler runs, disabling the transmitter stalls or truncates output.
>=20
> To fix truncations, verify that poll_sent_bits are set, and address
> stalls by checking for pending data (while the port is not suspended)
> before clearing TE and TEIE. The existing TE/TEIE teardown path only
> runs once nothing is left to send and we are sure that we are not still
> sending data.
>=20
> While at it, make sure to also stop TX when the port is stopped with data
> queued.
>=20
> Fixes: d61ae331d6f3 ("tty: serial: sh-sci: Add support for tx end interru=
pt handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Co-developed-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-g2ul_sci-v=
5-0-30b58ea18923@renesas.com?part=3D2

