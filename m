Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92C83BE627
	for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2026 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002134; cv=none; b=VNE5EsRaRltDbym0rEoCmxhB5MI4Qk3RS1Ad8MVa1wP/arrnECuK8fcbkaRVJt8aIZGI6O39Moe/+Yg1/zB1Mojc2kQuVDrnyr2JqY1s8uDtXU+d8tQgvM7hYI8XrsArxVpiRAuCBRQS8RgbZLAHKc4JAszm2yZ6zxLVS0skVDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002134; c=relaxed/simple;
	bh=nHhle2SQDhFzmUYQ8A/alsuIrrV0YozjOCPkSy2QB4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XjlEmxk8rJuuZMIzwhoqpyvixfy3XMx3mLmtoAz+qcf14pB/TqcfZcR3WCAhSDkq7iNXuDgQf4g22VJQ7LFK/joF0QhbEi3djH3raAwx1SnIPOFPeaLG0JiTB+ZRTuUTsfObKDDz2HbT4ghDG/lirpllzy115OvwONt7LUFx5rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHBNtaJW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHBNtaJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C70E1F000FF;
	Mon, 21 Sep 2026 14:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790002133;
	bh=nHhle2SQDhFzmUYQ8A/alsuIrrV0YozjOCPkSy2QB4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZHBNtaJW0YusW0pIfCwItDtCUsd5BEHbGkLXZQqs7SUH9R1pzEcN/y4ldJRD1+AxC
	 PRggEsuZEn4oV6lNKX6DJZNbm9sqPQ59BuVTjvzslYwbdfRdNGxW0/2CvatGSWggqN
	 oQLJozGcF3adCSEBJAgTKoLekrhbQb4F7icwK3SvOEdqRy4YtVAL5lqkGQuzzWqHeX
	 qf7PH9WPoSVsWajid5NyK6PBLZjQ0K4Erjfs/Rha/Tysmq7dVtO7wlXoKIGOOszEr7
	 3Q+hjtZXgK7su55RPyOdVKMV+UP2OgYvrE2pItmWTsydztuctae3DO00FCqCdLElQF
	 FUxO3AqbpG5og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH tty v2] serial: 8250: Change console_msr_work to
 IRQ_WORK_LAZY
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Ogness" <john.ogness@linutronix.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260921143939.170314-1-john.ogness@linutronix.de>
References: <20260921143939.170314-1-john.ogness@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 14:48:52 +0000
Message-Id: <20260921144853.5C70E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Change console_msr_work (defers MSR handling) to be IRQ_WORK_LAZY,
> thus not raising an IRQ upon irq_work queueing. The irq_work is then
> handled on the next kernel tick. This additional delay is acceptable
> because any pending MSR handling is also performed in the interrupt
> handler, if mctrl is queried, and during console resume. Using
> IRQ_WORK_LAZY has the benefit of not needing to raise an IRQ for
> each line of atomic console printing when modem control is active.
>=20
> On a side note, the Tegra20 and Tegra30 platforms can hang if an
> irq_work IRQ is raised while entering cpuidle states. This problem
> was reproducible by performing atomic printing while entering cpuidle.
> So this change also provides a workaround for these platforms (as
> long as they are not running tickless). The discussion on this topic
> is linked below.
>=20
> Link: https://lore.kernel.org/lkml/f3757a75-0ba1-4558-bf57-f19ab7e59a4c@n=
vidia.com
> Fixes: d3539347022a ("serial: 8250: Switch to nbcon console, take 2")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921143939.1703=
14-1-john.ogness@linutronix.de?part=3D1

