Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65F33BE14A
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779259; cv=none; b=pPZMlS5EhYZZKqI3JmQTVzVE2fc2MxtYoOU0seI+uw9RTEf0q0iuQH//mFVkeVKQpEfE460m8/Cpty0ll1Es6gAGglHwQm9aYDRfgNIzm/Q8T6OMYioHTowxens4Hf8+0MINKGPU0IauyJ9hL0rz5Kv2udw/HJud2VAa8rY7dpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779259; c=relaxed/simple;
	bh=bbbtFDTXCsD1RdRW0RoIbahv9iksQPLcjcRJqio7lNM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O7eXbB7A6PJ+3rD3/jGytLGFT2ZcCiqGQxbCAAJTfOnczCVlbX53TqMV9utGPkAt55ZOWpWrRnBJjWXtCb1QejCKoWa4r9dMbDxR3Wxa+IkPu5fnH9t2qMUmIsD5Fkkegl0/StuftNt9fy6mRzwfgrOPlHzlEMuXEuxpSk1dTI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8Nk+8yc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8Nk+8yc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1804C1F000FF;
	Wed, 30 Sep 2026 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790779246;
	bh=bbbtFDTXCsD1RdRW0RoIbahv9iksQPLcjcRJqio7lNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z8Nk+8ycfheHGyNDwPegsqQKsvq7QcHasdPmBaZ4mzspnAG+V68FdfOS7WKpLRW/p
	 7JDXYNXOZr1t5yJ+Z6pb2707wol1lxlTehMdd1mi//9p0ybOPdO9bELHlIshft6X01
	 N5znLQjXP0tSQl9X1ISTZ7jX9nfDOSTPSylXNzjBAqW/sP/gx7NdfOgdCbiCytOmSl
	 uMSWP+uR54fvO+8IaMCqxO9sFQCDKx1XZEYIlK6dmV2sYH1OI0bG2OewIIxkwdRDem
	 QZwvgjcBvX2K/QASBM19JiJxNl8O6eZhaIgn3VbOpx0gStozMMuUjR4X5zI14UkPWg
	 DoIqAFBwPo5kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 RESEND] serial: sc16is7xx: fix TX gap caused by kfifo
 circular buffer wrap-around
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Mbewe" <paultyson.mbewe@ziehl-abegg.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260930143207.542930-1-paultyson.mbewe@ziehl-abegg.de>
References: <20260930143207.542930-1-paultyson.mbewe@ziehl-abegg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:40:45 +0000
Message-Id: <20260930144046.1804C1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930143207.5429=
30-1-paultyson.mbewe@ziehl-abegg.de?part=3D1

