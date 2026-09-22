Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA77F361DCB
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 01:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040855; cv=none; b=AEnAjUOYIU9YcFcFKfI0pjh7fxb0c2/0AqnH/DT1GnI20t23xrd8stPTrEnaNIprGg3PcCxqrpM1zLA4PG/Zg7OLZs6tuX9T6pm7Te6PMv2BsWEgOOFmoBpVXUNRy1zPdMJMNyOnBp+jmj0jrQsL6kJMiS+rbtFH+oIK5bOBQc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040855; c=relaxed/simple;
	bh=Gi8/4OxoXh6C7tkPfMbs/JsqU6ZstOu6e5E4X6/Vnb0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ALLdB3zpg5Aufu0ty0z3DhQGGoViNDkqEuIBk0K0q5mTkbuktvz3L5Fd/GS+lKD/ABYd4bmMsvzsUDAo1SkVAy3kPdXqvZTqqcQdo3COfzUD+zf4a2/edJ2yxCPD/oFU1RHPsgG0FbdBn5zdlboThhzOSr6QF0srzcPj8Yna9WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHDPQPLO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHDPQPLO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F58B1F000FF;
	Tue, 22 Sep 2026 01:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040853;
	bh=Gi8/4OxoXh6C7tkPfMbs/JsqU6ZstOu6e5E4X6/Vnb0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HHDPQPLOu6kwaqNOe0bagtSL/8u7G2qoijDUWT4c5QZH2xpTCEzVrpIBhXu/3/J2K
	 tSF+tP8lDvPFJxfgIaMtcXI0JKMbJwomngXGV6IXziB49/qJiHe+wwVrckYqDetJsz
	 wRUgswq19769kJcV07oR/Lsa1+6UmoAxPuZsTDNZ/YzsaW19rrgGp0OqQX9phogZJF
	 IOePwvRSU8ckcirZDmzwnif/kEGg3Vcw2GifAqlxCgF47EH0sn+ilySv3f59e2+sD0
	 MrWA4lvWDsctT13y1Sx5ffsasxcLtXFWYNzki9cHJsRoQV33SuBRZ8++CU008hQoTa
	 cuV7Cxa17EeMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] vt: keyboard: recompute the shift state into locals
 before publishing it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaidev Shastri" <jaidevshastri@vt.edu>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260921-mb-keyboard-v1-5-d170228b80c0@vt.edu>
References: <20260921-mb-keyboard-v1-0-d170228b80c0@vt.edu>
 <20260921-mb-keyboard-v1-5-d170228b80c0@vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 01:34:12 +0000
Message-Id: <20260922013413.2F58B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Jaidev Shastri <jaidevshastri@vt.edu>
>=20
> do_compute_shiftstate() clears shift_state and shift_down[] and rebuilds
> them in place while it iterates key_down[]. vt_get_shift_state() reads
> shift_state without kbd_event_lock and can observe the cleared or
> partially rebuilt value.
>=20
> Compute the new state into locals, copy shift_down[] first and publish
> shift_state last with smp_store_release().
>=20
> Found with MBCheck, a static herd7-based memory consistency checker.
>=20
> Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-mb-keyboar=
d-v1-0-d170228b80c0@vt.edu?part=3D5

