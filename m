Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04491483832;
	Fri,  2 Oct 2026 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932492; cv=none; b=Z7DLSXcsU/Wlj6vXmiU5docbTKnvLBLTEDhqVAuc7Vrq44tVaMrgjBJ/8LpG4STWus5OCw/G7WF1/IrKzP3N9yJ2PIqGrt0wHCQx0bBlveCqyK0gFMdjNg9+oYBf1cvxlqyA6J2SKtp2U4sjnYJm6Dq69cMsbIhF5B3LCje/ZLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932492; c=relaxed/simple;
	bh=HBMqH89VWxpIRyUQWMPadKOiKfhyb5TdKNkdcRPEdpw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cECORPdzbBCZhEZgayFwM41LtG2keU4P/tq+p+Pdv1NUFN0asFp9q8/Wb5NlnybD5keYmSeZ2o1O9DfVyY3Hf1L8Wy2N8mNRPTEtYRps7SdHw+geFF3mgQ1JTypULafK7CpTIg//AdAdxno+/8lS8ce5FThvrrQBI5mS330fIoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuzHgLWQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuzHgLWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021551F0089B;
	Fri,  2 Oct 2026 09:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932490;
	bh=HBMqH89VWxpIRyUQWMPadKOiKfhyb5TdKNkdcRPEdpw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cuzHgLWQL687s39rXnLi6PQXldXtVE/ygeVjY5yr753VjrP2GHeU4yU6/M40hxoS/
	 M+0NGeEZurQ2CRG2sTMgDLK+x5mrC8XL/yuVqPucLLWtajjfAad/1cqvwbf0ulYO0j
	 aAuif9sczc+biFeXvZgYGew5n/eue//JujJC271j2iHLDMq9feQITqy/wLgiDBKxPq
	 HbiDfX7kofaopAU7bmv4XPKlWhqXAG83mNyhB60nrdz5dBhNLxwUK4TTH96PVm2fhi
	 8Yl1vzIPS3mrIGP6pznNx5HYeMmXDRu7/46kl8c7t1LfuwaN6Nps0iQGodxanAtEsi
	 Oeltlvdr3vqUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drivers: Replace __MODULE_STRING() with
 __stringify()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org, linux-hwmon@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, intel-wired-lan@lists.osuosl.org, linux-watchdog@vger.kernel.org, "Petr
 Pavlu" <petr.pavlu@suse.com>, dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20261002-module-string-v2-2-fc7438acaf4d@suse.com>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <20261002-module-string-v2-2-fc7438acaf4d@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:49 +0000
Message-Id: <20261002091450.021551F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
>=20
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
>=20
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Andi Shyti <andi.shyti@kernel.org>
> Acked-by: Ian Abbott <abbotti@mev.co.uk>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-module-str=
ing-v2-0-fc7438acaf4d@suse.com?part=3D2

