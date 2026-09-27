Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FD23CB54B
	for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790506572; cv=none; b=Nz2jMU5OQeaPHaljySwUtRU6YMyB/t6dSSPUI3CgFGdWI4VjVOtIqVXx1ZBe2Qd+Qld75d/SPBymzAQjGZnu7/zNCA85zerW0nNR8iK7THVDCJZu20KyJW3DDvjraj2JsIWtECOHQz+ZeMfKudtWnGvCanOE8vUItEpID3SlZEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790506572; c=relaxed/simple;
	bh=rD40XuyV6p9UfhJGwzwKXfJZ3NfDmTEPQiMeKQ4UDBA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SkZmyrUr1blCewyInyhCBWJ0eFqJvpJUHuCLT7g2Qw7dKNpZFcXvMotQa8l4/hp1Z2up5OE1s5FZR9dxJOXH3lS6Eojq/FCkslzdWX3zOUC3cfJXbTw0xrUkb/HveKx9VVijpiuDyQ6FxWbcjSfKxDY6fv2af5NVrGguk3zdL4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0avg1mm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0avg1mm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189A01F00893;
	Sun, 27 Sep 2026 10:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790506570;
	bh=rD40XuyV6p9UfhJGwzwKXfJZ3NfDmTEPQiMeKQ4UDBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C0avg1mmyxyXeIzniadmLRCTHlZue5fdCijOdycqJjX/QtUgbnz2ELjEbXRvR8Rkn
	 dZfNkIhBByhsRu9LS+P8qRcvFRkYb9J/dcNA5dBGqMZzSEet5GJ7p71oi2IyRMGyWM
	 ia67TtJzTZ4775oTEuFMtOkM0p43EA38AnGXPlYWWMovqKNPtcYzWlQe2S1sviCubv
	 QMsfXfAF7TBPkRM7aO9lZ9q9nAE4fHqvpnQMxwiie+CR0rBcJmLmK0xv9sMwxJn2+p
	 f8fEZy9xDSpCe/S9pdxHoS03oFYt6OkheTv1pVuUDc47SOWL+IJbW6XnC5RpwC5LOM
	 Z08JWPcbOPAfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] rust: serdev: use DropGuard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Osama" <mohamed.osama189110@gmail.com>
Cc: ojeda@kernel.org, linux-serial@vger.kernel.org, gary@garyguo.net
In-Reply-To: <20260927104528.103881-4-mohamed.osama189110@gmail.com>
References: <20260927104528.103881-1-mohamed.osama189110@gmail.com>
 <20260927104528.103881-4-mohamed.osama189110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 10:56:09 +0000
Message-Id: <20260927105610.189A01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Replace the ScopeGuard usage in the serial device bus implementation
> with DropGuard.
>=20
> Use DropGuard::dismiss() when ownership of the private data needs to be
> transferred without running the cleanup callback.
>=20
> Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927104528.1038=
81-1-mohamed.osama189110@gmail.com?part=3D3

