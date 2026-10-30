Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400192;
	b=TiEkyMJFVh+VaFuau9ilNW55v+ivcZrw6eIqUXnHXJrENbEbjTkkZGXI8mV4pH9rUqoZ
	 6IYAhLAc/QRyYl8YKXEeleR2Zyrgj3i37Go3f3M4uJ+cDzxbDHLzSIDE5BmqSeNUOl4qi
	 tRRLJzLuaFB+sAf9ZBm7ZnwNsLvYHMDAKC081JaAOyq9QY5baylXifyF2xX4LBS3cWSg4
	 TdtHDVrY6ZKQxptzeOLuJh6xNcqfMs3iBx7Xj9HW2WrLuqiWUDhpiXMtAAGIxXUZgTO8t
	 4zHK5QpH6A/trpIZulnhZgcB2FtaC9LYZpUhVcn5Wr4uTMReHDcxmNTqCJB0/3kEalw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400192;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P1wPm3rd75SekB4J2Xxhktg+4vYxKLWTUd4AB/ecnPc=;
	b=isvzcC/J6misxHUT5gD07M3NrM1lD6+LWIAV0LEuyyW39SofCAgHoJm5YG3iWtGJZeac
	 xeD9WjU4LvTqfWUiLvm4gQno7GtU6pLgSbQpWsf3XpLnIxEug1QtW7sCv8fVI541ZdCg6
	 87Zhrj2LiqB20I5JdMOq0uAl/f5whYvZFPqz7lPtjzi1DnrMt6mpRhyWQ+wIxY/SlnRzQ
	 n9oapS3URvJ6I3Q6xmdrI9NebPDZRrUSEVVkcdlNpPCJCiKZ55xX3jh+27hoZHG7fRggH
	 ykgL+6LxjdYlUqWbMGvvTIBgwYRkzYtKah4oJeVclV5h+wvHqRlcw84dlrOXIvcatRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSRq6YOY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB925606A31A
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 22:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSRq6YOY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B7D1F000C1;
	Fri, 30 Oct 2026 22:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793400191;
	bh=P1wPm3rd75SekB4J2Xxhktg+4vYxKLWTUd4AB/ecnPc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hSRq6YOY4ThkBPmg/WEMlUsw19GzV5pddI3LiPq7YzvAoRn7WbND84H+Iwwgw8XpA
	 PZADiidRx6UGDykL/26VUob2C1Yr1/yE6LozglJn18IsaAd3sDxvcb4YvECO9Hif8s
	 Ss0K4Zjferxsj73VBk9SUfkZ297l5Ux7fKPrYrQ/1VLh7RKn5f9RtxpXk0vkYKTzq8
	 9jXY9BC/I+BYh8JyAFsoWCWd0IeiFfmbp5nF87Lj33Dhb9vJ3atREA2gYuU7CfvH8Z
	 Sb0tWq1eN6KW5vcJeWOpT3gp2QFjGr5U1fVw2wKiqfDirD7tKheNHgZNEWmJfl9g1a
	 XTalDG2sYuIvw==
Message-ID: <sashiko-outbox-191583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/15] HID: ft260: i2c: fix large write transaction
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261030223637.86907-11-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
 <20261030223637.86907-11-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 22:43:11 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Fixes a regression from commit 5afac727defa ("HID: ft260: missed NACK
> from busy device"), which waited for bus-idle after every HID write
> report except when the report flag was exactly FT260_FLAG_START.
>=20
> Multi-report I2C writes keep the bus busy between chunks for atomicity.
> Treating those middle reports like a final STOP caused ft260_xfer_status()
> to spin on -EAGAIN after the second HID report and fail large writes.
> Write-then-read combined transfers still worked.
>=20
> Pass the bus-busy check policy from the caller: ft260_i2c_write() and
> ft260_smbus_write() wait for idle only when the report they send carries
> STOP; intermediate chunks and the command phase of a combined transfer
> do not.
>=20
> The SMBus side matters for register reads. The command phase is written
> [ ... ]
> Closes: https://github.com/MichaelZaidman/hid-ft260/issues/35
> Tested-by: Chris Keeser <chriskeeser@meta.com>
> Reported-by: Bruno Giacomazzi <brunoceg1@gmail.com>
> Closes: https://github.com/MichaelZaidman/hid-ft260/issues/42
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030223637.8690=
7-1-michael.zaidman@gmail.com?part=3D10

