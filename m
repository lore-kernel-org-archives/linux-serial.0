Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628DB24A078
	for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933934; cv=none; b=cTBt8C8VpdwlgUqMPTFAk+GAMLzNWvQR/PPSBkmyPAm9yLBoobQ+jA1MrRzn4YpVvk32qFO83bWyFzNGKZRc06sv1eDnAg2nGgI7m0AOjjKB4WhtE93mS1CaweDCSOX3lAFwU9GaK7O48uuzRkl88sz/KcVE+Ly+xRyLUhP1G+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933934; c=relaxed/simple;
	bh=GFljN4FtAYNpohdzQvqlvs4Vxbyo0Mlte5/B3mzFxls=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xf5xWkbjtSDSwcLKvORTDB2wnvoHxJrvf6H4khOKdMMWJ6LJ/OnA8ea0NHEIOcE9lstZqVQxpS0GOApM2d3f3ZnmkJm5aK9E4/ERS+YI1stH2NWTNA4hmt+NrjkXXPzZeI4ZHAjNIAHHMGDPi/W3JGdru1XWZob5kImoVwinUmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byoT0ehL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byoT0ehL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80551F000E9;
	Fri, 28 Aug 2026 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787933933;
	bh=GFljN4FtAYNpohdzQvqlvs4Vxbyo0Mlte5/B3mzFxls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=byoT0ehLYqmQIhsvAPDLsdQ37lBQmy+G4Rel2zHajg8P1N4qfCdBtlX2DcQodnyR7
	 gjmbDmh81WBFgpriLDSaYjpPBnh7cahmkKpJ8IvMZRbu2pyEhHMeqJA8IErEgFdGqI
	 VM8FToNjZiFuFOEx4zHfYOvKzLLf6qYn2vbteSdcATCQ+C8lTLujEKZvHXwr6KjgWg
	 3sfEshpecqhDbHKssUciWACCuyUzkKRh3VSKEQ7Y4m4pHIQkZ11vmJQPMB4xFeWnFN
	 OwFNn/FHxhd4KYoQvsVOzA0Ol7QfmlxC87Itly09b+kotUSTNZiBzkMsvME1af1BT1
	 SVDk/3wy0sCWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH tty 1/1] serial: 8250: Change console_msr_work to
 IRQ_WORK_LAZY
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Ogness" <john.ogness@linutronix.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260828155811.270462-2-john.ogness@linutronix.de>
References: <20260828155811.270462-1-john.ogness@linutronix.de>
 <20260828155811.270462-2-john.ogness@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 16:18:52 +0000
Message-Id: <20260828161852.E80551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> For some platforms it is a problem to queue irq_work when entering
> cpuidle states. Since irq_work is used for deferred MSR handling,
> any atomic console printing when entering cpuidle states can lead
> to the affected hardware hanging. Tegra20 and Tegra30 are examples
> of such platforms. Avoiding raising the irq_work IRQ has shown to
> circumvent the problem.
>=20
> Change the console_msr_work to be IRQ_WORK_LAZY, thus not raising
> an IRQ upon irq_work queuing. The irq_work is then handled on the
> next interrupt (worst case, kernel tick).
>=20
> Link: https://lore.kernel.org/lkml/f3757a75-0ba1-4558-bf57-f19ab7e59a4c@n=
vidia.com
> Fixes: d3539347022a ("serial: 8250: Switch to nbcon console, take 2")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828155811.2704=
62-1-john.ogness@linutronix.de?part=3D1

