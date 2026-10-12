Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8F74BE454;
	Mon, 12 Oct 2026 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826551; cv=none; b=ttw5yUNJU5ExmQGnrzIJhjsP57hd5OOUhLtMDIAYjz+PH0kG86Fy81XYEp5A9iTsJP1prS/7APQI7pslzWjukqJO6Ho4piesDYRERz7mQDL4jCywxxrFSvujQ1c8ClcPcS5b+psTC/Y6q6lD1MwVMSVyjM5HedWBZJKssqcwiNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826551; c=relaxed/simple;
	bh=HBxTf8l+C2mcPkdpixbR6C/doWhrMO2Nl3r9K21nWmo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KZ9VMtmdIo2Ps5Rv1h697p9qzTMLubvPvNJKqqYktWKo9XADWxodicZLAo1gRnBGOW6MqnexfFxeC7NnYMIF8eZopX9fcIJIcFSdJKjMfbcncJVoNBSQNjAShdK9gt7nEBRiIlczdPVexdK2T9S2mGH7wrVGCBvPvjwdyxSoQFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5SR4ILL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5SR4ILL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3561F0089B;
	Mon, 12 Oct 2026 17:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791826550;
	bh=HBxTf8l+C2mcPkdpixbR6C/doWhrMO2Nl3r9K21nWmo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P5SR4ILLg2SYDPV5fp3waCGBidP55KH55DO6Y7YsOuZs/NeDq/Kttha1eTH5EdMxB
	 2JCf9STsxaOG1ejZtSr+l6FcjmHcP+SscIP/SE+Fk+8MUwEXk78OVOEgfGGfmySHiw
	 VL0Uy++eJHzAWjCZkpGu/ID0CVlzcQTavq+pgbqngWDLqvouC84pxwrInyquVXulwn
	 33MQGKbzcMXWMyx275YOsEl+FjjH3mA2Fuf2yDqhhY7ZW4UvHyUL9nUa49tW+5qVoQ
	 JjKBspm2kRmu9GKSqpUGTk+0D40v+5/YHFsZUIV7GUlXAveOL+22GgdD/d4TK6xoN5
	 N5kBmlePEclkA==
Message-ID: <sashiko-outbox-168465@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/10] dt-bindings: arm: Add Cortina Systems CS7542
 and Securifi Almond+
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20261012-b4-cs75xx-v4-2-df250d903682@gmail.com>
References: <20261012-b4-cs75xx-v4-0-df250d903682@gmail.com>
 <20261012-b4-cs75xx-v4-2-df250d903682@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 17:35:49 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add the top-level binding for boards built around the Cortina Systems
> CS7542 ("Goldengate G2") network processor, a dual Cortex-A9 SoC, and
> the first such board, the Securifi Almond+ touchscreen router.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-b4-cs75xx-=
v4-0-df250d903682@gmail.com?part=3D2

