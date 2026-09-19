Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2671AC45D
	for <linux-serial@vger.kernel.org>; Sat, 19 Sep 2026 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789816059; cv=none; b=Irlm5EKdcpwqIW4rAjCOdhPZm/RP5UllpgUEJAPjSD55IMHQgEr1B2pxq1xA1DDd9m7iq7DQkFzw0+4zJWtpsqn4B+MF3D3mm67e0gya51wmh7yjVDUxajSYWut1zhz6A8IGq1fERuf4/St27adzq/cImQmjdBbHfUimtOztkyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789816059; c=relaxed/simple;
	bh=HqMn0BV2+PlD0qW5e19JCYjv45y3ZSHzK3eS5ecXBWY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SpZIaNnMMXWxG3dNgohO9HVZb4o51WrkwLL9Hbp5HDdVMbh3m27P6oLXjvk95sa0QB/JRD56ax1OD7NrmzpOdGX8JE6cVk05QVEhLJxNSaTwDj6iVGwUeV0WwMVTbLdz6KHr1vvoclG07OxaQTocc5trkshCMs9RH7VEg4oKtno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTYcz1Jq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTYcz1Jq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B111F00893;
	Sat, 19 Sep 2026 11:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789816058;
	bh=mm2zvZr156anFQxSnOKD3Xb/wjJ9dK29Sui2GTf+cdg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hTYcz1Jq8UKjYIUvKBNDH53jqzvD7tvsaF07C4CIgpkB+JTXxwcMH6DHTE7bDIXzm
	 BoSj11PgxTAFYiXQNKyV+b5nHFCVmf9JFQNeuhSJNt9TAdh8vwrETokWsBletIOu3Q
	 KO/aaf8qHHuCXovpoMp8zXKXOzr8lpfqx9zREAS3U47V9mBuJe4Sgo1C/IzXc13zfg
	 9r6sXpTA0K01VFTYRfg1sS1UJW93Qhga9aYjHYg/wXRxxx7faTqpWHzFp7O0mh7xwI
	 Y1WVQzkA7pWda39U7bwUM4mKdMNVhuLkqgn0X1B/WyYiw2aylAmM4RwuLy1QiHN7Iv
	 GheHPU1GR0rTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] vt: selection: Fix unsigned underflow and
 slab-out-of-bounds read in paste_selection()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260919110041.3763078-1-benquike@gmail.com>
References: <aq5hK-fxgPUCe4cr@hovoldconsulting.com>
 <20260919110041.3763078-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 11:07:37 +0000
Message-Id: <20260919110737.D6B111F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> In paste_selection(), the loop copies min_t(unsigned int,
> vc_sel.buf_len - pasted,tty->receive_room) bytes per iteration into
> tty_ldisc_receive_buf() and increments pasted +=3D count.
>=20
> Because the selection mutex (vc_sel.lock) is dropped inside the loop
> Whenever the line discipline buffer fills up and paste_selection()
> sleeps on tty->write_wait, a concurrent TIOCLINUX (TIOCL_SETSEL) ioctl
> can replace vc_sel.buffer with a shorter selection and reduce
> vc_sel.buf_len below pasted.
>=20
> When paste_selection() resumes, vc_sel.buf_len - pasted underflows as an
> unsigned integer to a large positive value, causing
> tty_ldisc_receive_buf(ld, vc_sel.buffer + pasted, NULL, count) to read
> up to 4094 bytes out-of-bounds past the newly allocated vc_sel.buffer.
>=20
> [ ... ]
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Fixes: e8c75a30a23c ("vt: selection, push sel_lock up")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919110041.3763=
078-1-benquike@gmail.com?part=3D1

