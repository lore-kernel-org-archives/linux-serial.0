Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794196570;
	b=zzXsn7vs43tPZsHvDIMeb5UbnX67HvNE/7FipjWTH/S7SiiZ3C0nhvI3xGoeLNt+Nw6R
	 LCngbiN8uHKqBR0TXfUVrJTezbsl28xQxnxSDTENr4+83fjpP07LwhemN609opkdYiaxZ
	 AWXkDcwQDH3KdymyhxvD+0mjeFzXLd56EQYNYQ2JbUfAJOmteRNi4llXLeXSMX50cJesV
	 vyDasw537WFg8twIQimFIiBoFwM5OuYr5Q9gRHXwvSteVzMWUOXcm2G+nAn9Q2x9JU+bJ
	 vUhTYfKMaEVPECIF9a0BkqvcvtI3KtM1SrzWgZlLt0XgmsCbmfL36lWvpdXbu6nrrww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794196570;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NT+KjlRcQ7TWq0aG3BYWdXYmooRcul8tsLp5AcwqcXc=;
	b=I9TiwmIDvvp6QOZE0cZO97gWJwNhQCrpkxpUtmh1BgEg1kEmoIb2ciIbxvAVWLItQsuS
	 wmN9WmUjRVwL2aiGroZl+nqenQv5fGy075ncI87Biie6teYmtRXiEp3AASwCGoWFFPPmk
	 /7wgdrtF1Qdd6nxG1JvJO2LB5yKqdwyrD8ovXmGOL+L2sTWzL6RnaoBiTBqYbwZezUmIi
	 6NzARaUw/Ab2R3dIiORfbrFmnQxjXfuccqTZjQLN42yp7I6sFWDfCYl7DS2Qn8LgZ2JI1
	 qSgpvwqqO9qlEeOReWhrCga9qdfkbxh3TUqEZ18AgRCTwNJt5DIeUFpTlHvtdTgf9Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBFmS9Ks;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3200606A330
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 03:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBFmS9Ks
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478D41F0089F;
	Mon,  9 Nov 2026 03:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794196569;
	bh=NT+KjlRcQ7TWq0aG3BYWdXYmooRcul8tsLp5AcwqcXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OBFmS9KsimUOPXnyUuu3StszXgHp2QWWlvPg/sJLoTgfs9JFCe753oDT3VAzQ818t
	 dAB1eKxWHWOKY/R6xLqOsomDFhKG9PyA9mn+Cpyogw2RQd7LSXn1MSwTs2hO/q1HG7
	 5R+m6+j4UbTyax2DLZsyHWxd407fvyY5x+MU4mnucIp4ET0QIoDHcJ/WohoLRAiCVI
	 5CvS3//dzUvNzxEVQZ3nd8Zgzs2/rw7ApTfShrvfQpCcIL8705xgQk7RjclFY0h81F
	 nmttY/3ZahGF0j6eAP2urJAAJLypBBqernoB9AHyjrNAySgqlJLkJ23XXd068SaE3u
	 jI4tOllbJwWWw==
Message-ID: <sashiko-outbox-204385@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/8] serial: 8250_omap: separate locked TX DMA
 completion processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261108-submit-serial-8250-dma-cancel-v1-v10-1-e6227ddb95b1@gmail.com>
References: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com>
 <20261108-submit-serial-8250-dma-cancel-v1-v10-1-e6227ddb95b1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 03:56:08 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Separate the port-locked completion processing from the DMA callback
> wrapper. Keep the shutdown check and locking in the callback, and retain
> the existing FIFO accounting, delayed register restore and THRI handling
> in the helper.
>=20
> Reviewed-by: Raul E Rangel <rrangel@chromium.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-submit-ser=
ial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com?part=3D1

