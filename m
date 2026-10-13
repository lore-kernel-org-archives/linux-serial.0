Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0734718DB1F
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874044; cv=none; b=KoyJrd1ROi+XPNTTj3fnon4eU9XwC6rCYRTg8NaeoA5zLQeU1K/O5JCyjKOlJ0r0iFFp7BqRyNXJSZdBCCBmCPbRCiCq4IP2+49M7oWHiieEDBsTsZ0tuOAjo0yQI+NlTW1WmRI215kkV6egtRHRUMGvAYtVl1T5UyQOm2YzivA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874044; c=relaxed/simple;
	bh=gpztnL6nN6X3YXAwpUFXD41U84InSZrUdIQr52oEFTI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Nmxs2UhwAF3Bzyn5IKknRY3XSAdEDdx9sUOPD/Z6twdys8ndFwycMaoy/2K3zkYk6x4ZZWGdBknXeOdZzlqYzndO4BfPeFXquQm7yFo3QlqIp/f4uQvQWbKpDxmt27NwcsmdiLpbcCQSIHjqhep3uy2wCVUtJM1WHzTlOOneWxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAIZJgfv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAIZJgfv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B7B1F000FF;
	Tue, 13 Oct 2026 06:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791874043;
	bh=gpztnL6nN6X3YXAwpUFXD41U84InSZrUdIQr52oEFTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nAIZJgfv+PGKqkh1Lnt/y36fOkowtKSf2IYsx5QumgxnNoTkERJGV1mAU7mFb/d+b
	 E5pCJBD7sd2nd7AJYotSvQpF0hp1gaVDkM0/m66p96Fs2kd1i/MB6BYzEuV0lp2+JJ
	 wNU4tnEiIjfKmPabd9vzqFCJydWwXhhHn3L386v5FfSIWoZ88v4MrDnIXvQYo3bd8H
	 b/9C3u2ZCL/ONTtzbyEriwSEg7+hh+cNQfQKqcgIioCwakEbAvnQtZpeLLDhLgcnLK
	 yog+vcCjm0D+7DAplumF8lQF3mbtsZyfZGEoxCBPyF+WjHsBwDXU5loflSjho8VTtz
	 fnn011eGakLWA==
Message-ID: <sashiko-outbox-169130@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/10] ARM: multi_v7_defconfig: Enable Cortina
 Systems CS75xx support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013-b4-cs75xx-v6-9-37e8f3969b7c@gmail.com>
References: <20261013-b4-cs75xx-v6-0-37e8f3969b7c@gmail.com>
 <20261013-b4-cs75xx-v6-9-37e8f3969b7c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 06:47:23 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Enable the Cortina Systems CS75xx platform and its UART driver with
> console support, as used on the Securifi Almond+ router.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
v6-0-37e8f3969b7c@gmail.com?part=3D9

