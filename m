Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CCC3AB288
	for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475734; cv=none; b=VHoIqCs7HDmoYrI2TvkYESQtbQ9ky/1KzeV3J+uvRM+EHyO71FcXCEqIcnZ12FDhGTlA/1N6ZQsTiW3h9XYVAl4ys5ZPMvifAMy0LwFHafO3LZtEB9q9RB+gGw0pEAq5cfGDmlCb9htt2I2oKLAI1ycr2x5y5gCsWef1gJSQi1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475734; c=relaxed/simple;
	bh=eCyCXsu14uyEEEb4D8Av7jChEq04reDNElcoG18j6QY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BIkM4e/pTfzQH9vksY7pdIo9wB32wz73TBj3/MCZNDEAe0lX0PSgiKwtEwS3IlA/Jl7bdKUIx5QwGb1lBnW/T6mQeQQyteLGdEXPduA3TFmwYB0VSOpThV+2IaVO+nQlqvB17V9wRwxI9fT8DQiVdukyInmEcG2QJbQ9kj90OAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIFx8EFw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIFx8EFw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A351F000FF;
	Tue, 15 Sep 2026 12:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789475732;
	bh=eCyCXsu14uyEEEb4D8Av7jChEq04reDNElcoG18j6QY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PIFx8EFwjsB1Snvu6nHGFouPIa1361BkWOs1RbABYfXggw6SPpxU6VzeC2+tsYLun
	 FIGhUs5H6Q80we9JcFYfvFOA+o/7UInIYmr8r11pEHFfwZNb+341ARsgAHZciUizQh
	 AQfqnXhPLdozIrdPVJj0S1oZK997hhxPXqss/1/rm1DmPtTgx6ELg/gThuvBHm9Dtu
	 7BM1KqztM0PA5NjbUZ+8YESJPKIS5ZJXBNncCzmXE93FDsanO0S2t/a93xZeVdr1CS
	 UwV/egY9KrfrNuXpLWjU5JLnBc7chWGu4mMC9a9AZbOXCNzC2bBKyxJF8MfSDp9Ar7
	 +5WpGF2N/v9dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] vgacon: Remove trailing whitespaces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <20260915123304.1027277-3-tzimmermann@suse.de>
References: <20260915123304.1027277-1-tzimmermann@suse.de>
 <20260915123304.1027277-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:35:31 +0000
Message-Id: <20260915123532.55A351F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Fix coding style.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915123304.1027=
277-1-tzimmermann@suse.de?part=3D2

