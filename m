Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA5D2AD03
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798344; cv=none; b=bf6IoE+QEMvtERBa9lCsoD+znGEXesnXJtZXFa/l2KV/ELk7WGE65ChogklN8Ik5La9ADEC8XEv4xGT+Z07Rg6t4GCyp1T3FLlv1VPy2Mm9yT8UcRl/Kz+h+jmVFgE9yoyrXqI4e4dMRys+wWP6PJoUHsOI1RYXf4KI3DbvW+HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798344; c=relaxed/simple;
	bh=WREHPYSGr7vYyUudJIz8tHtOyW+K/zHZGPX6zWJKKC8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FZ2dErrNQmp+7SsrH2glHgz17DmQDjsy7hoqWa8K8ECFGvwXDoB0F3XfGDJDpmYY7iGk0xnIKnpCxZGFgrFvchB+sPVY9EAox1PbHQn8c3WdoH0/uYw/S16ksTSM/XKokMUjosv6MVbJqeF7Z5Sq5qd+IYbx5ZpLzrqbmgv216U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxPGjYaO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxPGjYaO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D593F1F0089B;
	Mon, 12 Oct 2026 09:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791798343;
	bh=WREHPYSGr7vYyUudJIz8tHtOyW+K/zHZGPX6zWJKKC8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PxPGjYaORIDvt1mUUu/31cA81Sx9QFxa0dabuPKMbqjkqmf9wBBJ//EYUeUPjC/x7
	 uXpp2etVr6atu7rWQ04XfCZP0C7EV+ZnahNXGAdRNXi+aTwEt6IrkFGB55Rm5i5wBY
	 rHrP74VMQYnE2lp06LwoYIA9bBgHpT+EwAaerSeQ39Jw9uFip5myndeZRziP+2BAl5
	 3qrbrrH3fCTXCUCuFNfRwbXA420Kl/eOkUFWhoMWO/BZUdxkEC7RBjDXfAmyKDwXbt
	 xjxYrVOujyIz+KHHs9HjrNOOcEvMRmCDm3gAlu/DgtQ5sTA+q+BvQZSt+gHaQG0pjB
	 3rj9xXeXo3XQQ==
Message-ID: <sashiko-outbox-167904@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] vt: Use boolean as parameter to do_blank_screen()
 and do_unblank_screen()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261012094114.38549-2-tzimmermann@suse.de>
References: <20261012094114.38549-1-tzimmermann@suse.de>
 <20261012094114.38549-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 09:45:42 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The parameters to do_blank_screen() and do_unblank_screen() signal
> whether the call is part of a switch between text and graphics mode.
> Convert to boolean. No functional changes.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012094114.3854=
9-1-tzimmermann@suse.de?part=3D1

