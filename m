Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D493B7742
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831347; cv=none; b=AZTmDdn0sGgyYGQ+vcjVpPeQoUx0ZmOorxH3Zt7zsTrFBYeWSRBRkQFHq3hLFukvBv5Amw3VGwS7/07s9Nurxcq1slRGOzRKn6WwUNaLhOggFXr4rUy8v7WU3Hg/OKIkL3Zd/vfXZdY1XxlKoz2ixx0d6OQUrlwlohRHLrQOpuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831347; c=relaxed/simple;
	bh=8nPLQkL3r2MmJgNcqK/Djl9+sVFHvzCiXPHUWbU67Ag=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=VfDEB+YB11ei6xctZsom+th57IuU0cCR6xoCfSndAnHKXrkEqokkGWRpt5qgVpEen4DzCwr/RfqikwNXgVa98+QYkdMm5BlmKKP/JyqP0nOkT2q4jl/3e3uiA67Zia1pyFNSyE144YdZXkxySQrbUh7O8Innbrsh7uXu1VGmpPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFSX0NaJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFSX0NaJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE841F0089B;
	Mon, 12 Oct 2026 18:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831346;
	bh=8nPLQkL3r2MmJgNcqK/Djl9+sVFHvzCiXPHUWbU67Ag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QFSX0NaJaigxb0gKtA/tGo6tUSGpMJ7PpSShIqjWPXYSh5qirfhQDbl4hWgxlFuIz
	 Mp9BwokzueEBinFaBRSUK4Yfgt9Zx6e9UmJ8nk1+gfZoomd9Eu5+CMWy8NZqLxv7jY
	 32wQuSnEqroNHRIXvOJVSZnZvS7Bo4Jdmcbc7Q6gpjtsjnviLA1obcfdrrFeMGGh2R
	 tTd2tXxscHD4ydW4P0kcu2bKvGr8guEfPnPz3qzrH6P3AxbGylyHyThJKRDen6KFFv
	 jgN1W5hARIScw6WfKZK65+vmyYNq3Eb++VTdYaNfl+QHMXQKXBUAbivjxVouQHYowk
	 4y8m8GY8bAvrA==
Message-ID: <sashiko-outbox-168558@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/8] sparc64: honor queued spinlock layout in
 secondary startup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261012184826.986050-3-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
 <20261012184826.986050-3-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 18:55:45 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The trampoline's ldstub modifies the queue-tail byte of prom_entry_lock,
> not its locked byte, because SPARC64 uses big-endian queued spinlocks.
> Acquire the word with CASA, release byte three and poll while contended.
> Retain the predicted-branch barriers for Spitfire erratum 51.
>=20
> See qspinlock_types.h for the layout and JPS2 A.10/A.35 for CASA/MEMBAR.
>=20
> Fixes: 145d97858597 ("arch/sparc: Enable queued spinlock support for SPAR=
C")
> Cc: stable@vger.kernel.org
>=20
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012184826.9860=
50-1-linmag7@gmail.com?part=3D2

