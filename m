Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0032E377007
	for <linux-serial@vger.kernel.org>; Thu, 10 Sep 2026 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045188; cv=none; b=MJbiBN9yWvoulVTvx03W5f+5LHcqOMd4+AfHFdQcBd18tB3kwVz/VMwNXwc8Di2x/UjY7oBhXuvpJ3X3bGx6C592TZODiy/Co+aVZ1y/b6Saz8qm8+9ju7nUZWUhPsAWavtZB+Op/xMMhcTLZXShGDoV70DEHDvC/bX49vFnX9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045188; c=relaxed/simple;
	bh=CAqVBq0yNjdVXnxdrMwS3VIDQK7n5HEdypmgTM5qY0c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gtkleU51C+TfUkqFUlzmDfSXEtD0jiYnNcioyipq7c9KdGk+VBeg/NWTMnICW/wEIsw8Utlv8kY8pqpjDgYXObl/1O+RzdOz66k7yZyho2ZUhzMI6VDbBoFcCrE8dQKSedSLsVrAp9CmnYMVAO4uM33bnkq7eQKgtTDaA0S6ewA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9sHmNU/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9sHmNU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6886D1F000FF;
	Thu, 10 Sep 2026 12:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045186;
	bh=F7kuuXT2My30hcKxrl3efGYHkbgo60ALNkqayj8J7eQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n9sHmNU/77nQ7g5MLO8WkKzcRDKv8lIFB+R1g6v+FNjmhDNCzev1Ajms4L2Ib+8OI
	 LeUm7cGhZ3d7gmMOK+pjjZ1eniXvCWGZzcPPzr8Vr7x2EgmyWtSUrBHsyvsHx4/xQk
	 JXFpIic8Ai8X9egL1p/mK2CnoUY74fE6l4ErEmatIcpe4hfdltcWAATOTbOMcMe81X
	 kl1QKN+3p4fJqWo7UxrlJv8vZ3TWzVHeSQFmUG2o1iMVyvJu6fYd2g3+8Jo3QieTB5
	 rWQBRVsHTyFIjKK7JIHHn6jNhTO2OneAzBMGwRooVccGuFuX0HBxF5tisHuCVSNkQx
	 NWSALNBerirZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: port: fix tty_port_tty_vhangup() race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260910125114.640880-1-johan@kernel.org>
References: <20260910125114.640880-1-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 12:59:46 +0000
Message-Id: <20260910125946.6886D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Drivers rely on tty_port_tty_vhangup() to synchronously hang up their
> ports before tearing down resources as part of deregistration (e.g. on
> physical disconnect).
>=20
> If tty_port_tty_vhangup() races with another hangup it may however
> return before the port has been shut down. This is in turn can lead to
> use-after-free and NULL-pointer dereferences in racing ioctls (including
> a synchronous hangup) and in processing of racing asynchronous hangups
> (carrier loss).
>=20
> Add the missing serialisation to tty_port_tty_vhangup() and
> tty_port_hangup() so that the former does not return until the port has
> been shut down also when there is a racing hangup.
>=20
> Note that serial core does not use tty_port_hangup(), but it already
> holds the port mutex when clearing port->tty and shutting down the port
> in uart_hangup().
>=20
> Fixes: 7ca0ff9ab321 ("tty: Add a full port_close function")
> Cc: stable@vger.kernel.org	# 2.6.32: 2b5eac0f8c6e: tty: introduce and use=
 tty_port_tty_vhangup() helper
> Cc: stable@vger.kernel.org	# 2.6.32
> Reported-by: syzbot+5fabc1ae99ff40690d84@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/6a944641.4d659fcc.734b4.003c.GAE@google.com
> Signed-off-by: Johan Hovold <johan@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910125114.6408=
80-1-johan@kernel.org?part=3D1

