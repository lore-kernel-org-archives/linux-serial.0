Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649462;
	b=YLqLAws8tQTw+9Xe1GLfasdX0VuOXgpTHi3K3PelQF6irTlFyZCpZ5LadHR8uKF0P0XH
	 dBgS6z+foNEDQz05FeJblCvzoVT4/LR6TmM1y8xCXviJbZ1rYK6pfXylnXFsA9+S0F0YO
	 9zgVjtzwE4Qbjf8aO3cmhAnDZTNhkdZHpGxqa6+OQqdTljfDjHYPv68RkAVIykOCuE5HV
	 p2BaTmbMbRlWTrvb6Buk1MhlrjCLwyrcUrvRYFwNpRo2UFxkqsoluccXbS/PSROUL9rsf
	 DGR0JlXsRrwFDFH0NWUls8fgWWVBzmIcNcwPMbZoVxnuIdNy+vraL6VPa/MMK9m6Zeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649462;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uJI/fUteif5wdaSpu1Ls+jPd3N4DM6mRbJhEAThCHBA=;
	b=cUEkjkbKUlRhdCWXkQXDPMc9bF1REtVtzav8dJqv3b3wGbqnvu3wct/GFUm4J0UwiR9K
	 VIMB0MP1a4GSMW/3reMnnSFncNUl//GficOm4FhO2ASc12SQdBWfPXOqQOFg/JZBk4/vD
	 y2m4PWCR1NyftQoQ13mG91CGVZI/iKpfV3zbdfLHC7MpbniZP1ynH7apsqvII3eC5O35a
	 WVBOLE74imTk9UYNp1+lHakHG+vko7uTtDgiAMjCILw0LxNN2uzQ/MpfKZtwuXF9iKv/w
	 TfU6URTOasBaFp6cIHr1OkZXFo8sva0bywwU9k7YiXbj4WsYZpcEPHwcbeYKpumch5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dFkwYDuI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5961606A32C
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dFkwYDuI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8BC1F00A16;
	Mon,  2 Nov 2026 19:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793649461;
	bh=uJI/fUteif5wdaSpu1Ls+jPd3N4DM6mRbJhEAThCHBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dFkwYDuICWinADZFVvRwfLWfAenlH1eeZs7Hc3hpJC2s+mOmvvPREeXd10pC1bD8m
	 kqkjUdEOOTJyssfXByRDbd2AS90NQPx7BVkEjJssawUUSZ/8KHhoyg6U10wWcN0xf6
	 r3ABX1NCLQ8nQguOgX0CHAKxzZRrksyz/eixbu9ZWs4Ym/liGUSLhN3TupLnvtFZsV
	 sK2UcU3bCzeoKLIUeaxLVhzgYdAHBJAwxLEYK8tHaVAzVhGMMA7EKivIij+uT36SsK
	 9eSZwVpv/FYfHrrC4jvGrgf7vdBqmOUTdA53OtNh2bDsr6FdPGg8qOBTYAjxmLDxMO
	 XbW/LQUhHAaaw==
Message-ID: <sashiko-outbox-194039@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 05/17] mailbox: add Zhihe A210 AP to E902 mailbox
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-a210-scmi-v3-5-ee6b31580808@iscas.ac.cn>
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
 <20261103-a210-scmi-v3-5-ee6b31580808@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:57:40 +0000
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
> Add a mailbox controller for the doorbells between the A210 application
> processors and the E902 management core. It serves as the SCMI
> transport to the E902 firmware.
>=20
> Channel 0 rings E902 and receives its completions. Channel 1 is receive
> only and carries E902 notifications. Both share one interrupt, and E902
> writes INFO0 or INFO1 to tell them apart.
>=20
> The E902 firmware keeps both mailboxes clocked and out of reset, so the
> driver does not manage clocks or resets.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-a210-scmi-=
v3-0-ee6b31580808@iscas.ac.cn?part=3D5

