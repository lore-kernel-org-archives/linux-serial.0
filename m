Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9FF49E143
	for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341488; cv=none; b=UjFBiqhwYbwgLdjj3p0LQPxW+aVniBYPWUqvwqub+LNAg+lge0pYXbBmNsic9yuOFr7cxPWallVUR9W/saEDC+nwsBRDUXMqTl0uGPHmRhl/PdGQ7rVNCgAvnB11XJZwEP884f+nl7jRI18/vy3+yoTGNAsjzRf4lR1FRr8k+ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341488; c=relaxed/simple;
	bh=WGSOc1cJBFuNR/LsR6uXNGa6Rv5l7gkj5jvs9DSrMd4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lVPx0rO1YCWq7jbY0qTY2LMxV4MB3aj13y/qenmlolwHeVGDNFyGeDwJ6QgYCzamPvO0+ltD5qve+kUR7NtuW/aDltSMbyR4yeukDbnAEsujmASEjtxPUnm5J2kgeX2cMStC70tBB8SfzYMrMEU2x/1dEFgiaSVk/igIjcTqibI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWRCtFgo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWRCtFgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BA81F000FF;
	Fri, 25 Sep 2026 13:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790341487;
	bh=WGSOc1cJBFuNR/LsR6uXNGa6Rv5l7gkj5jvs9DSrMd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RWRCtFgo9PifFgmTmzCzZv5mlS9athpXeEvKVIHlHRzn0+55HAi1ejUD5LDJca+Ae
	 csRdTQAKo6FtaGYoZVLUF+mzACHIfGkzN4dysY00IHJ10KpfaK2E+8QNI2sliziLV8
	 Q3O1Ht3OXAFBpfgncyMdn/e2p3aDZ3rfurufK/107jZVP+/90iX263n4RfQHOy9LUW
	 mG6Et0q5qURDCtAMzkuWxUkAhKNIn5lrIGsQYwvDoSN5YGTsiFsBk9Y4jEwL5RhqzW
	 8ptgJUYQEEDpH7+07CTOp23YsqJV9hHzgdoJi4jIW6pPGNRWlyODLc5SuuoYS+rHrA
	 Yb3AZ3Eydtxng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: sc16is7xx: fix TX gap caused by kfifo
 circular buffer wrap-around
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Mbewe" <paultyson.mbewe@ziehl-abegg.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260925125443.168134-1-paultyson.mbewe@ziehl-abegg.de>
References: <20260925125443.168134-1-paultyson.mbewe@ziehl-abegg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 13:04:46 +0000
Message-Id: <20260925130447.01BA81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> kfifo_out_linear_ptr() returns only one contiguous linear segment of the
> xmit kfifo. When transmit data wraps around the end of the kfifo, only
> the first segment up to the buffer end is sent. The remaining data at
> the start of the kfifo is not sent until the next TX interrupt fires,
> resulting in a visible mid-frame TX gap on the wire.
>=20
> The resulting gap is unintended: data remains queued in the xmit kfifo,
> but the hardware TX FIFO drains empty before the remaining segment is
> sent. Such gaps can break timing-sensitive serial protocols such as
> Modbus RTU.
>=20
> Modbus RTU requires a message to be transmitted as a continuous stream.
> For baud rates above 19200, the Modbus Serial Line guide recommends a
> fixed 750 us inter-character timeout. On the tested 115200-baud system,
> oscilloscope measurements showed mid-frame gaps exceeding that value.
> [ ... ]
> Cc: stable@vger.kernel.org
> Reported-by: Tobias Gannert <tobias.gannert@ziehl-abegg.de>
> Reviewed-by: Joachim Knorr <joachim.knorr@ziehl-abegg.de>
> Link: https://lore.kernel.org/linux-serial/20260623112225.82386-2-paultys=
on.mbewe@ziehl-abegg.de/
> Signed-off-by: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925125443.1681=
34-1-paultyson.mbewe@ziehl-abegg.de?part=3D1

