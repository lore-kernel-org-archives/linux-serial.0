Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661692;
	b=sVFXGyJYfAqKGNIl9YYocZ1srF9CDlNpny2jmEoBPPRfvHUCUioQ+mH5ZC1ttEkfvyKI
	 NiyN0Bld15qs5rcd8ZiG7SnBdOrrHBN3jQEobrzucAxG3JU0D/+hNeOSs5bfi7zMrerxb
	 DTCQAuuNiSLQ/BkaPw9bd4ZfG9leOqmMl2SHN3Nl3peiZ2Pk7l36n7tv4mPPIQswLBwSc
	 Div5HfSmV+rgIUtZldi49pdyzhRnrCQTEKpISBzAQJ+VqSxd/N46eyC3AsHNRNmMWBY0p
	 bjQRNUmEs3CgIFRU2uY2peuqFYLn6mU0PPk8wZACw2f7S0iBPD43xlcGcBJfjYUK5rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661692;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WQHxUDCuxughJ2ES3+la5gyWkWrCz45l7kLBC5gktk4=;
	b=SQGzZ7x68+z0MNeSkz9SPWGNmdtT/Ru/n8uSlf1o0APAHFg936xn2ufulGopSkVxTLV4
	 FnAsV+EegT9vHRVzQ8L68vOOo3jb8lTaVYkCJ7SnEcjD2IRDL6GEZ4ho2Xn5gzusF2+vc
	 RhMM25eh9zLurV9JEtajWyPdRgO47mXkmbD0kmMU4ZIYZdKhFYxZeCRxuvhoUYrk8Hmkj
	 zuVOYSqOCS/KqxVOTnegdmQcK0i8gOnyLCrl8fmEht3Im2ErDp+7QLKftsxZY/fHrBFYx
	 Qwc0UgyT+IuA8TQ+nPsAXynqjD16FMZHgCnm/Lj/kzbLGmAx82jITfrGz/GqCvGc99g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3bXtZFf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF929606A326
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 23:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3bXtZFf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715261F00A16;
	Mon,  2 Nov 2026 23:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793661691;
	bh=WQHxUDCuxughJ2ES3+la5gyWkWrCz45l7kLBC5gktk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k3bXtZFfxL4HiORYcO8tNsezBjDsn4LK5U+da73muZNzC5DSLgWchYVY9a+HfvvFI
	 ptFS32eoqQ0foAuOVo3pCMY1LaPmKeU+AtGQ76wg4VQc5VQ/QLcNJxi3k0LC5zZmXb
	 1/EfonhRNq2fsXSGGnF7NqqFlMsKH4iCW/CZzm+RxeAMye41NtBGjNT4W+l7oP+ffl
	 ZWcHpPFWNvpEBDxVOgFo63IXc8PRz6p/D+Q5goc+8Tjcwx6l1v6zvI98B/ao9Aqm9J
	 YVW4Spd/aknjVG81gDtM0duymZlTinrzNgcyJLWLZvte9j7TlrLnRi0lM7O8vhsgyZ
	 G5A5vmCUhFUSA==
Message-ID: <sashiko-outbox-194328@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/8] serial: 8250_omap: separate locked TX DMA
 completion processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-1-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
 <20261102-submit-serial-8250-dma-cancel-v1-v9-1-9159caade148@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 23:21:31 +0000
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
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-ser=
ial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com?part=3D1

