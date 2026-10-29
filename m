Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259713;
	b=E8gx3pe1YKyMshL12C/gQJoF73koZeG57pU+v03+0gS+2YEVPC/2LlN12vNCPTu0hM8L
	 vbkem703FCS9rUGheF0MWLUGR7g17yKbtbOHHgikSF6PqxvRgDZ9zme6Ky+6GaOzW3DCl
	 slVODsUqspeAbmW97WjSfoZeUJt6rdMAUuD0p+7k3vxVaRqDBdX7uhZ4Wexl1wZepQf5Z
	 ZL4trEtAR8z6VtPKt+6OXE1IJMrTraOv01LBrm4e7hT6Uyn3Lo+4DAYkMR+DJbY3fAO1k
	 7xgJkJdfFH927G5ylvSp0SfG48fpAv80bpv/2SK6LOyY56G/E9PA7tUlW50IkW0d2HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259713;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TKOBHY7k1f+dcKmmZSaKB9dclhN+5Ok3bmxDcEgq/L4=;
	b=iplnYw5DNH6rpAWwpD3hoAsVnfC5kds9bVitSI1xgwV1ZEMZwzIrM65aJJOuGW4sXa2H
	 v503pzBnL7r5XgK42erEdxWXfc6mr8kldla23TSNhye5YVyRpK/oxHiA3unyfIxFLMHu3
	 IiDMTQ6+09T/kjrR9CjMThVsRkj11IjjvPceN+GpbPLl8SQEz4UghGdUiUObjVk8n4QcS
	 XuyJl2ohAPXGNMQ9MO0+wc1EXvOUYekDU4HkjEljMVU+fo1BnPaoWIZdIABlgN9ym5KId
	 D+q6yDipKOq4TUVoYiDHUAPyM7Mak7X14HwZYj4F6psbXHAC3Q42Lb23ayRN+qyLFGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZtWhSWYq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C518606A31C
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 07:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZtWhSWYq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C431F01825;
	Thu, 29 Oct 2026 07:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793259713;
	bh=TKOBHY7k1f+dcKmmZSaKB9dclhN+5Ok3bmxDcEgq/L4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZtWhSWYq1jyqI8co4QAy+Y7EITGN+U4CaAF5uxsUIDQxtmHE6yZxHA5tXKNxhtwF3
	 YpgVzGPwn6fublpwYHVT0Ezc1v4Q5XK3F5D6NpWV+OUgWiQMQzrP+Br0iEWgzu59n8
	 dnWypLxMGlIg1oY4rIjUAQmSG1Esdeh28aqLBh3FVkK0go0vOpMH8Gd2QzauKWQfWJ
	 ahVAAHqyHkjNIWggeeh7txXoAgf49XZ7irKWXp3jrBgfwdT6VyREKYvNT7jFqKZLXV
	 0nLsoZa0fOqzRSJR0oyObBDyq8/j+eyJw14L1Q6QOpFivIPQW+MWkwAgFjJ5jWpae9
	 80OQxYczsmMkg==
Message-ID: <sashiko-outbox-188888@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/6] serial: 8250_omap: separate locked TX DMA
 completion processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-submit-serial-8250-dma-cancel-v1-v8-1-3fd56ba352ed@gmail.com>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-1-3fd56ba352ed@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 07:41:52 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Separate the port-locked completion processing from the DMA callback
> wrapper. Keep the shutdown check and locking in the callback, and retain
> the existing FIFO accounting, delayed register restore and THRI handling
> in the helper.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-submit-ser=
ial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com?part=3D1

