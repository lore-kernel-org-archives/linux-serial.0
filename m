Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550052;
	b=VK5EPTwUTjwk2O0tpp/+UjtK3DqEaNDEsSWw0TOLFjUvFOR2UJuTqoEovm47L8I648Y3
	 OoiznIzzO8OK8hdhcH+at2dB4/uFuZexeYBGci3zUPV0fwF8YQWWASAsyRJ+/xtOssq22
	 G6uldOULh6UlTrzmCM19e5XDoQoiTpCjSDEG8P4iIwRutSMZUOodRuYIy+3a4A6Y1gy2+
	 ww1J5GV0pOhgIys9B5gnuwuNdmVwhZUk2vpyjobTWJiB3OIQS4nMChleXleLMXf7POV3T
	 SLt0ZVp9vW3yO8idSGLW1BQVXiXd3v60axAOaRGJib+FQlVT7i2gQvXxmoutD5pvVBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550052;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pImvjD1CTjQsxzGemBNAMEAl7/cgLwhrf3SGfHlEmqw=;
	b=H2Emc6h2M6v99FlkgYTv5SFhA5VMQPY1V0AU4LHYdaaG535XPOsZ8QiVkcbW+TLKzlT8
	 hvnVZxIaOfMs/WU48dPJyjLIO3uJ1Nt7ILteVm6/Yh9ldlYBNGFdiKjuRhkhJheYZQpwh
	 GOwjzuqAS9nw7JWMwePIsVxy8vZ17WZA9qE4OlpKRedpSe6Nhw8EmKVEBNO2wuP+RYtIt
	 wl0op+6RawZi4071bnEoEJopgpnMvQ7f2QRxIsNMa4Yq1uTRFQ2DWeS9RCGWcKFxoucRO
	 DGEmCzjbVdPYW0ex2vGgzPpqOO+kLVNLIQ0TOqXSQ3Fs9pXr0KAgb8NcTulnTfPZ6PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6KQk03H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5F360A2606
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 02:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6KQk03H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627721F000CF;
	Wed, 21 Oct 2026 02:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792550051;
	bh=pImvjD1CTjQsxzGemBNAMEAl7/cgLwhrf3SGfHlEmqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A6KQk03HmaRHA8+WiLwvCbIKycVB8y+KhPsTZv/3jIMpeSqsS9f9Vxu0k9MUgNlKF
	 17rTd2HnREgs1pvOcyEM2x2MxzON5UVtyI2J9PoFxJQk3v1PjTecYtN/ur4hBn8jkl
	 VrQQs0pkm+oDfNgQeRI2ofPc1BtbM2AYyOLy5ZH1OYJWXCh6uoBRd/AooZgXRREaMU
	 e1716LLD7OyyD117MJiM+9Ap267CGzdOcWGqY6U7XjhrIi0/yoUlKKZhYpBGhRj5c2
	 jKBc79NSTEku9fBwsI1kOpi/jvTUeammtI6WU1GxfgooEflUaG0UuhlXKJnNkAshnA
	 HvfpQNlSAVypA==
Message-ID: <sashiko-outbox-179703@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] tty: sysrq: reparse the reset sequence when its
 length changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhan Xusheng" <zhanxusheng1024@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261021022007.1717207-2-zhanxusheng1024@gmail.com>
References: <20261021022007.1717207-1-zhanxusheng1024@gmail.com>
 <20261021022007.1717207-2-zhanxusheng1024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 02:34:10 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] tty: sysrq: incomplete race fix in sysrq_handle_keypress() during =
param_array()
- [Medium] tty: sysrq: unsynchronized version latching in sysrq_parse_reset=
_sequence()
--

commit 969b9cd1cf7c6541203279c0b287db9c5b090a8b
Author: Zhan Xusheng <zhanxusheng@xiaomi.com>

tty: sysrq: reparse the reset sequence when its length changes

This commit tracks the parsed reset sequence length in struct sysrq_state a=
nd
triggers a reparse in sysrq_handle_keypress() when sysrq_reset_seq_len no
longer matches the previously parsed length.

> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index c2e4b31b699aa..4fd5b3ace9c40 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -676,6 +676,7 @@ struct sysrq_state {
>  	int reset_seq_len;
>  	int reset_seq_cnt;
>  	int reset_seq_version;
> +	unsigned int reset_seq_parsed_len;
>  	struct timer_list keyreset_timer;
>  };
> =20
> @@ -686,12 +687,13 @@ static unsigned int sysrq_reset_seq_version =3D 1;
> =20
>  static void sysrq_parse_reset_sequence(struct sysrq_state *state)
>  {
> +	unsigned int len =3D READ_ONCE(sysrq_reset_seq_len);
>  	int i;
>  	unsigned short key;
> =20
>  	state->reset_seq_cnt =3D 0;
> =20
> -	for (i =3D 0; i < sysrq_reset_seq_len; i++) {
> +	for (i =3D 0; i < len; i++) {
>  		key =3D sysrq_reset_seq[i];
> =20
>  		if (key =3D=3D KEY_RESERVED || key > KEY_MAX)
> @@ -708,6 +710,7 @@ static void sysrq_parse_reset_sequence(struct sysrq_s=
tate *state)
>  	state->reset_canceled =3D state->reset_seq_cnt !=3D 0;
> =20
>  	state->reset_seq_version =3D sysrq_reset_seq_version;
> +	state->reset_seq_parsed_len =3D len;
>  }

[Severity: Medium]
Could sysrq_parse_reset_sequence() still latch a stale or partially updated
key sequence when racing with param_array() -> sysrq_reset_seq_param_set()?

In sysrq_parse_reset_sequence(), len is read from sysrq_reset_seq_len at
the start of the function and sysrq_reset_seq[i] is read in the loop, while
sysrq_reset_seq_version is read and latched into state->reset_seq_version at
the end without verifying whether sysrq_reset_seq_version changed in the
meantime (and the follow-up commit "tty: sysrq: reset the per-device key
state when reparsing reset_seq" adds timer_delete() and bitmap_zero() betwe=
en
reading len and latching sysrq_reset_seq_version, widening this window):

drivers/tty/sysrq.c:sysrq_parse_reset_sequence() {
	unsigned int len =3D READ_ONCE(sysrq_reset_seq_len);
	...
	for (i =3D 0; i < len; i++) {
		key =3D sysrq_reset_seq[i];
		...
	}
	...
	state->reset_seq_version =3D sysrq_reset_seq_version;
	state->reset_seq_parsed_len =3D len;
}

If a concurrent write to /sys/module/sysrq/parameters/reset_seq updates the
sequence to the same final length and increments sysrq_reset_seq_version
before state->reset_seq_version is assigned, state->reset_seq_version and
state->reset_seq_parsed_len will both match the final published values even
though stale or mixed sysrq_reset_seq[] elements were parsed.

In addition, sysrq_reset_seq_param_set() and param_array() update
sysrq_reset_seq[i], sysrq_reset_seq_version, and sysrq_reset_seq_len without
memory barriers, and sysrq_parse_reset_sequence() reads them without read
barriers:

drivers/tty/sysrq.c:sysrq_reset_seq_param_set() {
	...
	*((unsigned short *)kp->arg) =3D val;
	sysrq_reset_seq_version++;
}

On weakly-ordered architectures, can sysrq_parse_reset_sequence() observe t=
he
updated sysrq_reset_seq_len and sysrq_reset_seq_version before the stores to
sysrq_reset_seq[] are visible, permanently latching stale keys?

>  static void sysrq_do_reset(struct timer_list *t)
> @@ -903,7 +906,9 @@ static bool sysrq_handle_keypress(struct sysrq_state =
*sysrq,
>  		/*
>  		 * See if reset sequence has changed since the last time.
>  		 */
> -		if (sysrq->reset_seq_version !=3D sysrq_reset_seq_version)
> +		if (sysrq->reset_seq_version !=3D sysrq_reset_seq_version ||
> +		    sysrq->reset_seq_parsed_len !=3D
> +				READ_ONCE(sysrq_reset_seq_len))
>  			sysrq_parse_reset_sequence(sysrq);
> =20
>  		/*

[Severity: High]
What happens if the first key of a new multi-key sequence is pressed while
param_array() is still parsing the remaining elements?

When writing a multi-key sequence to /sys/module/sysrq/parameters/reset_seq,
param_array() resets *num (sysrq_reset_seq_len) to 0 and increments it after
each element setter call:

kernel/params.c:param_array() {
	*num =3D 0;
	do {
		...
		ret =3D set(val, &kp);
		if (ret !=3D 0)
			return ret;
		kp.arg +=3D elemsize;
		val +=3D len+1;
		(*num)++;
	} while (save =3D=3D ',');
}

After the first key is stored in sysrq_reset_seq[0] and (*num)++ sets
sysrq_reset_seq_len to 1, param_array() proceeds to parse the second elemen=
t.
If a press of that first key (value =3D=3D 1) arrives in sysrq_handle_keypr=
ess()
during this window, sysrq_parse_reset_sequence() reads len =3D=3D 1 and con=
figures
a 1-key reset sequence with state->reset_seq_len =3D=3D 1, state->reset_seq=
_cnt =3D=3D
0, and state->reset_canceled =3D=3D false.

Immediately afterwards in the same sysrq_handle_keypress() call,
sysrq_detect_reset_sequence() runs before any subsequent keypress can repar=
se
the final length:

drivers/tty/sysrq.c:sysrq_handle_keypress() {
		if (sysrq->reset_seq_version !=3D sysrq_reset_seq_version ||
		    sysrq->reset_seq_parsed_len !=3D
				READ_ONCE(sysrq_reset_seq_len))
			sysrq_parse_reset_sequence(sysrq);

		if (value)
			set_bit(code, sysrq->key_down);
		else
			clear_bit(code, sysrq->key_down);

		if (was_active)
			schedule_work(&sysrq->reinject_work);

		/* Check for reset sequence */
		sysrq_detect_reset_sequence(sysrq, code, value);
}

In sysrq_detect_reset_sequence(), ++state->reset_seq_cnt =3D=3D
state->reset_seq_len (1 =3D=3D 1) is satisfied with !state->reset_canceled,=
 which
calls sysrq_handle_reset_request() -> sysrq_do_reset() -> orderly_reboot()
immediately on that single keypress.

Also, because param_array() sets *num =3D 0 before calling the setter for t=
he
first element, checking sysrq->reset_seq_parsed_len !=3D
READ_ONCE(sysrq_reset_seq_len) causes a concurrent keypress to reparse an
empty sequence (len =3D=3D 0) before the first setter even runs (which, wit=
h the
follow-up commit "tty: sysrq: reset the per-device key state when reparsing
reset_seq", also clears reset_keybit and deletes keyreset_timer even if the
parameter write fails on the first element).

Would it be safer to synchronize updates to sysrq_reset_seq[] and
sysrq_reset_seq_len so that sysrq_handle_keypress() never observes intermed=
iate
states while param_array() is in progress?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021022007.1717=
207-1-zhanxusheng1024@gmail.com?part=3D1
