Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD6134250E
	for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789479329; cv=none; b=f1zq4Po2IaWHmFEd0+m87Q18ainCq7PqfTuJAZhGOJxbZNISaxlN3lEnErhHGIEL+zppocqAvI8HM7/KCuNCb0LErEuaAbTYTN9UcNKnWuGj6tRjLrl8eQDEzsjz/S+IAMaFfQ0x7FvDSNeTCdWpikFLiv7V53IK3THH9onEVu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789479329; c=relaxed/simple;
	bh=475q/j10nUXW3elmOqJ7M2W8tMYp6b4xfpOYfNcvv40=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j9lR0djnJZu3i668hrwNJ6cTAFOmGdRF7jurIcf5JW9grFuOhWWMwYrrVW7MbUnFup/k9bekSihi+fypZH+uebmj0YKQhhwV1hhYIV2DAU7NnmxpoZElG4TcdC56EO/8dd4dBS84Xoeo0+mLl4jS0cmELpehKyBih5hSs8U26kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrPv3hHv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrPv3hHv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3241F000FF;
	Tue, 15 Sep 2026 13:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789479328;
	bh=475q/j10nUXW3elmOqJ7M2W8tMYp6b4xfpOYfNcvv40=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FrPv3hHvQYInlZBi69NFiPzj8R26ntEsr99lqQRJf2icU+P4R/tBXWgRKnn99tnjD
	 ARUfjWSzCf+NaRnbUkk3fWFKG7c0D0Y8eVy6lvOffRg8r7+n03DMLmxf0etJS+zG4P
	 Ls65SGgoWz4TdWJrmADCUeSUItW2mDs++e/JqbeAiVE14gPJA81u6/BKTAc5iIYs+E
	 Itfjdqplz4sFnauAc6pSaKZGkBFJlilWpDVTZGpWNrvl6OAK4Zss3/ezitfLGsy8xn
	 irgrJAvWw4blA1rqNRVKipddbpqV/sLdHmwtyO4akSH9c1l8dSo02bPHe3SsFqH2pJ
	 rFWgmMH9o6apQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] tty: serial: qcom_geni_serial: Keep console RX
 functional after deep idle
Reply-To: sashiko-reviews@lists.linux.dev
To: "Viken Dadhaniya" <viken.dadhaniya@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260915-correct-icc-bandwidth-vote-constants-v2-2-f78eb611204e@oss.qualcomm.com>
References: <20260915-correct-icc-bandwidth-vote-constants-v2-0-f78eb611204e@oss.qualcomm.com>
 <20260915-correct-icc-bandwidth-vote-constants-v2-2-f78eb611204e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 13:35:28 +0000
Message-Id: <20260915133528.7F3241F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> At baud rates up to 115200, the serial console uses only a 1 kBps keepali=
ve
> vote for the GENI_TO_CORE ("qup-core") ICC path. This vote keeps the path
> active but does not request a QUP Core 2X clock rate.
>=20
> When the CPU enters a deeper idle state, the missing Core clock vote can
> leave the console RX path unresponsive.
>=20
> Use the 19.2 MHz Core 2X vote at low baud rates, while retaining the 50 M=
Hz
> vote at higher baud rates, so that console RX remains functional after de=
ep
> idle transitions.
>=20
> Fixes: 7cf563b2c846 ("tty: serial: qcom_geni_serial: Add interconnect sup=
port")
> Cc: stable@vger.kernel.org
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-correct-ic=
c-bandwidth-vote-constants-v2-0-f78eb611204e@oss.qualcomm.com?part=3D2

