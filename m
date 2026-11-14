Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697928;
	b=o4DxUFzLB5NFw96T53D7At10iHsl3r1fBfKcKJvyzWgtHuJPOqQKtlKNdv5GL9ZW8zHa
	 AxauFZlMYDQLGT6CHgBsF/YOBOFllknAgF+EHg8UvQoXTIPVwSU4nmUWV2Y49fNAk9Coi
	 N2vLiqLw8FW35JCXpL7UAcyBgZCRJTcQLoMLHMv81cddYYkh8XY7/Kacl3BCbv/wLlQJ1
	 dl2HmC3Agrx6smW9ogi+vMtF26GXITIVuoCbiNbdFlcWMcy7gDdCpm7N/z+AarFlu/1kr
	 F+mk//4H9b4A3ffQatg6qwk/CNnqzv1HLiBhj953pmBsVipEUAX30dN+YOHVx+3OLyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697928;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DD033I5fbQfRZBPD9FGzthu3rTJYibUy3kHJHCySvpI=;
	b=ULVI91DVl0veMvbuY5Xu+0/VuzP2FELYGWrqbi7wLOIOlxvg8cACwAsYWozuUa6h5Y3X
	 bL2LpMjav/gqCXQjihfKigDYuZzGwZroxMpCj4U/8bnzvyrbbACkgOQqefcLM0QuBHCc9
	 ZfuWZTayqWEQcZEwSw3sOyM3UCrj72yxgHRmJNrDtUuedGuvoeERq+d19dbIr8u+12D+n
	 /1iCYcLoZdrVAz+eE6XwMCqixUHvlo4hnzRWFl3T83/r4cyxrdzB6nBT7sTs1i9fxBIpu
	 R1g/DRqE6wJKN+TDXVa5vK+lL8rC5oej9S3Bluz95xO9vQMgRrYvWELl/qN9ZK9rsnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoBKBU53;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A59606A330
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoBKBU53
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E12F1F000C4;
	Sat, 14 Nov 2026 23:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794697928;
	bh=DD033I5fbQfRZBPD9FGzthu3rTJYibUy3kHJHCySvpI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZoBKBU53JYY4lCv3bk6gELpqtC/H3H6eHtFGY2GF2Rre6rjNaFFDTCeBBdiW8OeC9
	 vYpUiVdSnO5lFOQtmeW7HusDl+QAtdECiZbCfvqvgBrgJFV1VJ1JkJzwjCIe0k9M/e
	 FhnvcWD7ePUOyM9y4n0U0h9Ica1RmrLFDCjpE2VHCneLGRy+UGNxPDe4iALhmYccXz
	 zZWS7K1QbjmaQ4Xobh0l9zzPZ3CydKoDp76F1juDgwhGfmH/Er/N8XB7L8WUeTnwGb
	 2sIp6Qt37MEGon07tU7/Dkky7fZIyakNgO2jaEvavzCb/SknB5AWlOvyVuAPnIKR3k
	 l4k1F1YBYt0Bw==
Message-ID: <sashiko-outbox-215082@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/16] HID: ft260: i2c: reduce bus-error message
 severity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261114230800.1344401-7-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
 <20261114230800.1344401-7-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:12:07 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The driver logged errors when the FT260 reported an I2C bus error or
> when ft260_i2c_write / ft260_smbus_write failed after such a status.
> That was meant to flag unexpected failures, but bus scans (i2cdetect,
> HWMON discovery, transceiver monitoring, and similar) hit missing
> devices routinely and should not fill dmesg with lines such as:
>=20
>   ft260 0003:0403:6030.0001: ft260_i2c_write: failed with -5
>=20
> Keep returning -EIO, but print those via ft260_dbg. Still use hid_err in
> ft260_hid_output_report_check_status for actual HID/USB transport
> failures, which are genuine errors.
>=20
> Drop the extra __func__ from the write-path ft260_dbg calls; the helper
> already prints the function name.
>=20
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114230800.1344=
401-1-michael.zaidman@gmail.com?part=3D6

