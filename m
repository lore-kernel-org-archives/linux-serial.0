Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283538;
	b=MRtFue94azoaNszxK4r4YdgiJ+9pV83FimL03c+LnN0LJmmUO4AOUaN0T9jVuJHaMWIP
	 GQHCHXZnKJlpoDDmuA/W7Abso+N8F9q3dmENM3RIcO40fzklHTE9Q8cRiRDe+sPoTuB5H
	 MDZtPBNfW5Qdc9dHum5ce6M0cXGws1BhfYdAwVMJyAjlMtbp5OkktepGK+lVKo3EhjuFb
	 kE3uTVzy2Evde4zXjEdJ71MLvYgwKIqKJmL3iQdO9VWLr2ViDDB1jqkqcjTuqynnCRYWq
	 PwhCYLv/TWcVgo9FMnqdQcuv1dHmHQlOUqZ43/oRqjCUDbE32i9uiDHiTEGhEB4xYzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283538;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aa1iQTvrSfJCJfke5l1cZfiACn7eOEvMFeVqlB2qRp8=;
	b=J+I5y3ZFDi3hGQBX00hLVuxgm+bxkMoNyEPpVChi+8YMJ4Oramp0qlSn9RLjZ8ecuDiw
	 W60RsiwUQc3jJVC05MCYjlTrk6uiqUEHMHRdDXCg8CYdHsmAyG3CGkF7+jXoMZxYJyGMj
	 +a7nQpBFJ0firQruc7Lj/VmiQYx6l+Bh2KoWPq0cD7h6SeqHBJTEM2fT5JaE1NJT3PqjG
	 7Jj0AqDBpOGzplKcwSH7g/Vx0fQI3Zm3CyXLy4LMzN2LQUvkVBs22BLsocPfLL3HFQLDG
	 fiYrFo8uapqXC5xCU9A0EL+u0BMM9gKm/Q6RXXM6DbxiUXSO7rpsW5NbN4kbrwb9nvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFBl37t7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB9F606A31C
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 04:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFBl37t7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936031F0089F;
	Tue, 10 Nov 2026 04:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283537;
	bh=aa1iQTvrSfJCJfke5l1cZfiACn7eOEvMFeVqlB2qRp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HFBl37t7EoVfhBzp68rAt2shL3qQbgYyAn9gMeSN6o7sDyL+o4OHKIWElDBI8tnhm
	 Ux5JQa36VUs3kVrmYHijDqwG8o7CVnVmUUBVa0ZoQEX3X+HbR8XucSS8h/IsnIKZv9
	 +p0PJeNHgtYMnYhuxexGwVhlPKAeirHYYMNUbNrlQR3Le7WSivdp4/R2FvLii8jur/
	 WIBukcgDl/VQ5gyjiITRN4DkprwkkEaF/7WBdeUS5Elccg9C78lvkJWYkrbj2Q0xPj
	 yksU2czM3ZrHWCgFTEOnH2UuOiN8vE5hqB6F59ho770wAWP/isqnXzmRiCVR3ETWMS
	 yqlyY2qHuxk/w==
Message-ID: <sashiko-outbox-206164@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/8] serial: 8250_omap: separate locked TX DMA
 completion processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-submit-serial-8250-dma-cancel-v1-v11-1-6364edca63d6@gmail.com>
References: <20261109-submit-serial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com>
 <20261109-submit-serial-8250-dma-cancel-v1-v11-1-6364edca63d6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:05:37 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-submit-ser=
ial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com?part=3D1

