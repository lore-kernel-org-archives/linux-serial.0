Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274C957266F
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097136; cv=none; b=iD4Dw5qae9oFJyjAHJFbG4QXxGOBbirGEM93NLJm4KZKB0ayzfyR13Ce2CNApfxtb/NccbiLbwNIq2E4IEqrIu21GF+LVMv4r6MqTs/Xw+Uk89EYfAeiOjnkXg+puGIRv2oCI5xtxvavFVMtgJv7v0Tki5/O7dLSVPRtlmogZhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097136; c=relaxed/simple;
	bh=QWlMvXpTHNJ3xWFqWOQBbdWXF852/tdNg8xsmD5AKPU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t78bkVdbSKxoUEJNXtBQZGI062vbyrb1/qbtfWT3NJjTEZLeL3JdSMpd8uOuBDsKTF+HI9UqVbp2LQiC+5CS1amGId+THs7KA9KgFmy8LkWMxpHyo+RCcgc6TWY98+ZYE0AxZLTtdTStrubrVisJ7wzV7PPmglBdbfsn2jvewp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLBf1d7C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLBf1d7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36351F000FF;
	Tue, 22 Sep 2026 17:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790097134;
	bh=SynYuFaxPYcJENDmKP3gosK3xqeRteTeFSgqQOZhy+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YLBf1d7CwQ/t5cbSD2RpfBFCDVa+jmjOgVlcLcsO+F1BUMBJw/TKj9Yr4Bo17I5c5
	 +B/Y2dFnHaZlIUytF/R1Jv738mXHF59FdM7D+F896ILWEGioWqEnASivYuxch3PZLX
	 qRyh75puZ5xmRn0QnYv12Z/39mRe1a08E2aSJh1XuGJJAd7eSwpl3Jg0js0Jce5k5J
	 eUCBCa/FWLbVwu0MD7eRNQMas6fUe6sCUdhEfvASa+/xBtfxdIu9lf41SiUtcIHEBa
	 KLxEKb4HrmTXod+BG5SPy9W+QoWRw64wHlRRlrrJIoUlRN+8kML2YveazZwGIYvnYM
	 aq9e67GJ+KFOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: max3100: Fix a data race on s->rts in
 max3100_work()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ginger Li" <ginger.jzllee@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260922170239.33485-1-ginger.jzllee@gmail.com>
References: <20260922053151.11260-1-ginger.jzllee@gmail.com>
 <20260922170239.33485-1-ginger.jzllee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:12:14 +0000
Message-Id: <20260922171214.B36351F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> max3100_set_mctrl() stores the new RTS state and raises s->rts_commit to =
tell
> max3100_work() that it has to program it:
>=20
> 	spin_lock(&s->conf_lock);
> 	if (s->rts !=3D rts) {
> 		s->rts =3D rts;
> 		s->rts_commit =3D 1;
> 	}
> 	if (s->loopback_commit || s->rts_commit)
> 		max3100_dowork(s);
> 	spin_unlock(&s->conf_lock);
>=20
> max3100_work() consumes s->rts_commit under s->conf_lock, but reads s->rts
> itself outside of the lock, both when it services that pending update and=
 when
> it later transmits a character, so the state it programs into the hardwar=
e can
> be stale.
>=20
> Read s->rts into a local variable in the s->conf_lock protected snapshot =
at
> the top of the loop, before s->rts_commit is consumed, in the same way as
> s->conf is read before s->conf_commit.
>=20
> Fixes: 7831d56b0a35 ("tty: MAX3100")
> Signed-off-by: Ginger Li <ginger.jzllee@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922170239.3348=
5-1-ginger.jzllee@gmail.com?part=3D1

