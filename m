Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947818;
	b=vonnt6F4sfcv6wHynUNYPSMIPYXQh4NM1Louvj3IPOTZfYeoeuKu2+oNMGH+VNsEG8NJ
	 1LvKWsSFBgsHtMZgHBYXZPEIjS9EAwDKPyS/xSEpXhtNElFjnSNOtjZ9P3KWi+FzO4Bz5
	 q3eBX6byT0KiQrXMVddPHiGG+xQ93X9R3Fn+4MVlVnfxAzkJ8WMnCUQ+mWBx7aaJjnwJg
	 S/dNC+CsRIaqfFNDMrdvslQxjr+nS06khfF6492WQ/1EF2eQoW1tWx9q2cvmhxE30pyM5
	 pfMvPD1BYSjTlNmBshL8/bu0KIegJE5RirRDSVbDUDSv/P7rCJJIF2MDiRUv10r0M0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947818;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Oq8i+12L5K5xuGwwpQaXwirOBrtVvh3lFTcB7zMu1Sw=;
	b=mkqUm5ZxLsVxlnktE2XLe5ccrBRD/5giogs7gd3ircpyon3KZYa4aWSJhmp/cgsgd8iF
	 5FCNNtPy8899B2GiayMu4V5/fMka1xOROPxeenYuyXIvSosTzsPzUh+VD2Od9Hi+BsV9p
	 o/r5xcYfB59pISW50H49ee0KDd5lfDpoT/N+0WAlcA9Xfqb2In+avG0AWaLYlRCzBvhLn
	 1AAOaP6QAdJHMuMaxwGYakyd68wFNpVPeeEIt6qC6HlnWpV8smSWOghG74HT7XtJTOdnM
	 fCU5IkokC3+iGLhdi+C63YJdqduAziS0EQ4EUJa4wEVoF47l9gajjRuAOF7Zw0pvigw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CD6WDZkN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0B6606A32A
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CD6WDZkN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790941F000C4;
	Tue, 17 Nov 2026 20:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794947818;
	bh=Oq8i+12L5K5xuGwwpQaXwirOBrtVvh3lFTcB7zMu1Sw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CD6WDZkNfFCPdwXHsTIz7OH5ZA68wlyaRXWVSA7HoW1oY+GCf0Up4QbMx8lV41O5C
	 OFdOiocpQXMGMEeZqYIv5rPXUvCLLU5zriJ5Jdzx3Mzi9WVSkux2mCni4mdy4wPrVB
	 YMGLOBqyaddHku4vIHYSChYefWzzR45YMJ6+JBOG+eKHSUQR7Qpi9FX5uTIZrf3bYR
	 3DDUuq2QeDI2ZBMOIYihlneh97Pngub4yuMcJx4WccvuIR5w2U+TG7FjYO9hLd1YXp
	 hmKEvAujPZl1I22YEz4qeBaWfYBLKUya6eICrQobDs+UNdxWN01Gbc/fa4Ea2Ee4S9
	 NLXcZ8cOHq5Jg==
Message-ID: <sashiko-outbox-219629@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/16] HID: ft260: use lock guards
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117200423.19561-17-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
 <20261117200423.19561-17-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:36:57 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Convert the mutex_lock() and mutex_unlock() pairs to guard(mutex) from
> linux/cleanup.h. The lock is released on each return, so the goto
> labels that only unlock a mutex are removed, and the error paths
> return directly.
>=20
> ft260_uart_port_remove(), ft260_uart_port_get(),
> ft260_uart_port_destroy() and ft260_schedule_reset() take a lock for
> one or two statements. They use scoped_guard(), which releases the
> lock at the end of the block. ft260_uart_port_remove() does not hold
> port->lock over the tty hangup and the rest of the removal.
> ft260_schedule_reset() must not hold ft260_chip_list_lock when it
> calls ft260_chip_put(), which takes the same lock.
>=20
> ft260_i2c_xfer() and ft260_smbus_xfer() set the normal power mode with
> hid_hw_power() once, at the end. The i2c_exit and smbus_exit labels are
> removed: ft260_i2c_xfer() has one return path after the transfer, and
> each error case in the ft260_smbus_xfer() switch ends with break. So no
> function mixes goto with a guard, as include/linux/cleanup.h asks.
>=20
> No functional change.
>=20
> Suggested-by: Bartosz Golaszewski <brgl@kernel.org>
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200423.1956=
1-1-michael.zaidman@gmail.com?part=3D16

