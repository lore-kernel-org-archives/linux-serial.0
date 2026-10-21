Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792549636;
	b=JIotn3IkzOccCafep0BSB/TiaKOJ6Af7p9K0cw/WpzXXZGFby+QwJhABmhoRLl8pdQ6o
	 4vpRU7rC+hsAHBJzSeKw8c1cd7nXGqYCMzT4Amu19kn7CjQg0/B+d2IBkS+UE98v/acI6
	 j8NjgHBa2x8ajUEDjGZyvr/BrKyCXZFcVPpwUCzyPm4k8PqhkMkqnjdvC4rNj057lqP+5
	 vRD63mT9RQE5oLKwKY5pAZD0PqVoKHSh7YxdgW6Bsf1lw2GMxqHt0OOwlRSJK/WJ8Tp/Q
	 aTGbPosL7fOyHnL5+cu2xUK3WzGAgRAtDI1bW6d4oyu5gEP3mllcTlPiO15xgLdPZzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549636;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w/G5wtZkMUO74NIwT3UmGSOGbp22rxDhDuL743qFMHc=;
	b=hnwvjMJq+ZnUnr+JQ3Q5WmXNmMSVpZjF+h1AFtEkYzaj9T3zFvJrPDPAZkQrfh017AEb
	 HG9stSMP1b4wHpi7zykyyiaIj3bYDC0cQExjsdSkOXhrQi1nILvehY6ZWA5T+UUergFMw
	 Njl35JFi2Y1x8NJyO/CVZgo+WtNCKpCnFw7XNJRIp9mos43+uW9UuyeLfKKI3PhjUY0sW
	 QA3EYwWPKJV/PTGERAv8OLZraN5CXQDHz3At7v1onEmUaM5lQiNEyUx64eWZDM+5g9odE
	 vuQGsaepzLLzzN+RNtxxr0z3RDoggo7orCP9XJqpUT58yXM2fYVYxuGyvFnrLb7DCbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c245kbno;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1F2606A319
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 02:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c245kbno
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95741F000C9;
	Wed, 21 Oct 2026 02:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792549636;
	bh=w/G5wtZkMUO74NIwT3UmGSOGbp22rxDhDuL743qFMHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c245kbnoPghFNNbNSSWkB/5JDKkPxxcAkawiBFSNeDFMPdk5PHBzryX3gwX27bO7x
	 o4Gu2CPKgnAf0gNpgswt51XGjZ1vuSydeEQ3DArEGzmYXxT3n9R2IsD2OwI4/BSODS
	 gUs8t9R8b42px7mKTAbIVbZ9ajkADzS7HqFMGkqxdxou5YulzTCrJI4m/e6bETYlCP
	 vMM8T1J58PSLcoY6d9Rv4DoLlSX92d3djz94HVxk0AkndfSfLA7ZbiwGaMt9wH82JR
	 jFbKlEhPa8ZYf2aPEvWOhjByojY/nIqIdcveK7/NzzMncVyvtdNFw55AAKCJs7ikx+
	 KswZGwIQA8v8g==
Message-ID: <sashiko-outbox-179700@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] tty: sysrq: reset the per-device key state when
 reparsing reset_seq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhan Xusheng" <zhanxusheng1024@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261021022007.1717207-3-zhanxusheng1024@gmail.com>
References: <20261021022007.1717207-1-zhanxusheng1024@gmail.com>
 <20261021022007.1717207-3-zhanxusheng1024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 02:27:15 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
>=20
> sysrq_parse_reset_sequence() clears reset_seq_cnt, but reset_keybit is
> only ever __set_bit() and reset_seq_len only ever incremented.  struct
> sysrq_state is allocated once per input device in sysrq_connect() and
> lives until the device goes away, so both accumulate every time the
> sequence is reparsed, which happens whenever the mode 0644 reset_seq
> parameter is written.
>=20
> After writing 56,29,111 and then 59,60 a device keeps all five keys in
> reset_keybit with reset_seq_len 5, so the effective combination is the
> union of the old and the new sequence.  Holding just 59 and 60 counts two
> of five and does nothing, while releasing a stale key drives
> reset_seq_cnt below zero.
>=20
> Clear both along with reset_seq_cnt.  Also delete keyreset_timer: with
> sysrq_downtime_ms set, holding a full sequence arms it, and it is only
> deleted on a press outside the sequence or a release inside it.  Dropping
> the old keys from reset_keybit removes both of those cancellations, so an
> already armed reset would survive into orderly_reboot().
>=20
> Fixes: 154b7a489a5b ("Input: sysrq - allow specifying alternate reset seq=
uence")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021022007.1717=
207-1-zhanxusheng1024@gmail.com?part=3D2

