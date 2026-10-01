Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E673E51C5
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870188; cv=none; b=G/tQ1VPeYsDjxEAPmNumf7ZiHGOoN+rdQcOG7YlFMT40NSqyWxT0chUpdxoiU+gAaLxYTaeiXQxSxfi8G7oi2OmWWepoqFe09QSTZidjMwfnacqBBf3WRTKpE86v/PL2e8GgRo/jFtPCUZ23PwsL4ozlmRiimWXkjkonGRDIuz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870188; c=relaxed/simple;
	bh=yrElVdOjSh/oxWXkU1O6uEmEYeeM0V/Y68V9t2tGqZk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iiAEK+y3nS6cP0foAJ65PvvvhVAiaWrCJSFuM9nU3iY/ixFlwmlutBgEpnA3rrYlI437UJZC9vcvh1nYQ2gzk1J9ofyaGrskLYS5zztLyC5Id4qzbwmWuYYm6J50JjS+bYL2fnI9GRh3dVoFMEqwGUlqaZoRlDUnkJHJJ5RjhXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAx7oOh9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAx7oOh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D261F0089F;
	Thu,  1 Oct 2026 15:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790870186;
	bh=yrElVdOjSh/oxWXkU1O6uEmEYeeM0V/Y68V9t2tGqZk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oAx7oOh9RE5uDZ3THDgHrW8KPVFuUm3L7ovi5EXWOquq3YelghRLV75QQs9Bz9+84
	 2ux3ekACVyDj49tVIUiQL/izToPyi3cRtchWx8c05hIu0PLy6PFIIEkX3JDfJJJYur
	 Bz6CWvj72O2BZ7HyQ/C6/ryL19Hskq2mB0vmh/7IKwfVyMU6Id3xvBWX4dq5fg2IGM
	 7ZbJIBAV9NCpPxSkFTQ041Ur0Zs7+AMRnS6uwW8DnNY379j/Y9wi9D+eOrr0vVQBet
	 tHPmQASToCtq9EcIlMm9Gxa+RCunXggC+qs4U+LtdqWSAam8cZJ5Pp9PXlTDpomjQT
	 UbJ98kyytBN2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] MIPS: SGI-IP27: print the NMI dump on an nbcon console
Reply-To: sashiko-reviews@lists.linux.dev
To: "Imre Kaloz" <kaloz@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261001155013.1694-1-kaloz@kernel.org>
References: <20261001155013.1694-1-kaloz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 15:56:26 +0000
Message-Id: <20261001155626.91D261F0089F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Since the 8250 console became nbcon, printk() in nmi_dump() only queues
> records for the printer thread, which never runs because no CPU leaves
> the NMI handler before the hub reset. Print the dump from an emergency
> section.
>=20
> Fixes: d3539347022a ("serial: 8250: Switch to nbcon console, take 2")
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001155013.1694=
-1-kaloz@kernel.org?part=3D1

