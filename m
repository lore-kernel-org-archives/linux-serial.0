Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B565E1C5F27
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143997; cv=none; b=I8eMR/JTVwfYZAjKq/qMFe8pXylVixOreuqcCbO82x3fncX+a/qLMbY+yZ902qRCMyErHQUyt/FZK4Ebzz3b1CvmKlsGkSCWJDSNcku2/flmNAqhcMj39iH/sqicU3EmLBIAo/oScu2TEfeFRWTs5IaPJR63P3LeISmeU9obJ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143997; c=relaxed/simple;
	bh=W9IEFZpiGVgTN4WJ3FGv4XAfYljID3qErKnfSXjZwE0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pwkn3Ro4T8KGMZemPst1W450sPoH4cCjoVz5iHGqJdb/iBbaIMc5XE52agACtCAzyuVbDoASkUcCRGBlpCX7IIKBQvkTearOjiP8NXnUiVxhaNQP4iZUu69TgO+MdvSgCM03mW6U2h1QAnrlqQswhXJpXmHFabQPyH+va3S/m3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyR4yDIp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyR4yDIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224131F000C4;
	Fri, 16 Oct 2026 09:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792143996;
	bh=W9IEFZpiGVgTN4WJ3FGv4XAfYljID3qErKnfSXjZwE0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gyR4yDIpNC1v9mCN2YJIk/Wx7UDU7veHu9LnqeuEoz3tsz3TXPtLAEEtxXklDTpg3
	 iUIEZ4r3BCBdyCnrz4sXvyyFvr7N04RxazubIfRo1wIGiYECzMzAFlO70jREMTmAWw
	 FUaQr4xEAIixgpnGYMzldz4wW/O5RmK7YlkoAFkAZtMZEWQcjdJoBHh1hlQEmPeHG7
	 U456Vg28fRQ3ZKVi5OzxwznwIaoNGGUuXODjWV+sg58A2aSZY++Z6K40fSH2wl0sxu
	 U+eEaV0EyDUUik+WyqPml13t3c87+g0RIJXjWo864fwjl1VrafcnWzRjcsuMUpOb/m
	 3b9D+KYD5se/w==
Message-ID: <sashiko-outbox-174096@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] dummycon: Implement struct consw.con_unblank
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261016093357.33294-3-tzimmermann@suse.de>
References: <20261016093357.33294-1-tzimmermann@suse.de>
 <20261016093357.33294-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 09:46:35 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Implement con_unblank from struct consw as a duplicate of con_blank.
> As dummycon does not do anything, the implementation only returns
> true or false to trigger a redraw (or not).
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016093357.3329=
4-1-tzimmermann@suse.de?part=3D2

