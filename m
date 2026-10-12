Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548A9377AB4
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831358; cv=none; b=m7SpYOmHNhPmiLBSOJTkBs5G37p70TFjBgKoVBjdWbsgU0lg20PeeXYZGZuL67u84j96h66HkTM91U+UxjZ8d6VmanQQMotFKxPVqZbKD27cbVqX1j2aGnGzafxviSrOL7S/aeerig35mptJlhyrq97I6Us4mnSq2mawvGyn2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831358; c=relaxed/simple;
	bh=/Ly6qlnEleswEUDiUfqDJPISnm8pJ/vmk7wNZHeR78k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=thxJ513Q2PpK8esMamsBUZTZVuX1NdVAjr1U7LGwE/3/qlTsKs5vA00zYwKPlRVuF5ApPBqy3/obUEE3HhH2vZEBUp9EgXmtKT+WR04fQOCsJRjiEFJo03yPgm9Snv0rLFQDyHyqoTpLN7XLGMgvCrv9S70/UYOVvZfrFxWueK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPjVdAKx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPjVdAKx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51531F0089B;
	Mon, 12 Oct 2026 18:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831357;
	bh=/Ly6qlnEleswEUDiUfqDJPISnm8pJ/vmk7wNZHeR78k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WPjVdAKxcExXm8y426lu9jx76OF+mzzxvNY5CMzxSH3v6JeSh1AhtoPvvD6C07su3
	 E6JMiluyPbjq/k8Jj0B6RfimB6tOh6ktNfn0DOm6UxyiRCGX/vOK0EY8W1YJzNCplB
	 qYgktn4nJEhOH6qvGJ9VEYYBGIUPUGUVJtkuKsXigHIdA3Ndx4Uhe5CVOs0mur9fKT
	 cXfpA9L77IXLtP5yofzRn4OoQSGQiVCRxJI90suWAoHvp7KpdYZ2JSCMuUY8lRDCkK
	 wkA0+iYjzRJl+8cXCkHUcpq/qtogbDJ0009XbDPnxkddjBmv6tlGf3MbhLs+xWxUlD
	 QRimaBc8S+njw==
Message-ID: <sashiko-outbox-168559@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] sparc64: validate Fire register properties
 before initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261012184826.986050-6-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
 <20261012184826.986050-6-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 18:55:56 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The Fire interrupt translator reads one reg entry, and PCI PBM setup
> reads two, without checking that the firmware supplied enough data.
>=20
> Check the property before allocating the translator or changing PBM
> state. Halt early translation on invalid firmware data rather than leave
> raw interrupt numbers untranslated. Return an error from PBM setup so
> probe can release its allocations.
>=20
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012184826.9860=
50-1-linmag7@gmail.com?part=3D5

