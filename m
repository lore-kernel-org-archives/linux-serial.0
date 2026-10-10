Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55F823BD1D
	for <linux-serial@vger.kernel.org>; Sat, 10 Oct 2026 05:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791611201; cv=none; b=frxS6DWbhrn3rgEj0YUaGplSd6pc/uLG8IBKRoYfuAVPIeCmya9HQ05VCeI1PpI1Z4hmrI3djfJz72fOLgz0tcB8/wBQrN2AadrmjhnOfamKG2KHeGRg3JB3MMx1VqxTYthjiYQl07mQ335LMSG2/lCa011CxqpF6VL+mEwiBIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791611201; c=relaxed/simple;
	bh=AsAJfoHclA0FMRWyI+vljAmciMwHdNQ2PlzcRuZLJqo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=G6MtOLN9THCRyizYh1s9HJ5Kurcd6wO+5chg1ZwCrm/JKWzO6piBUHmQwHWVOuOBTZmCMYrgwhw8p46Hk9ugZzBW5Ibm01JR2BkotajF+tI4SBuTY9BLQ26Sngy60mRhblU4Tz0rSN18FJkBJCDOnvqc6suCooTFi1Z9ECvcjpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwxGHBMj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwxGHBMj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193F31F00893;
	Sat, 10 Oct 2026 05:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791611200;
	bh=AsAJfoHclA0FMRWyI+vljAmciMwHdNQ2PlzcRuZLJqo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gwxGHBMj6kbl+i3uqsXgHF/fwc3Y+vyNtalBXvLr5gRicvWxuDTY4Q7Z8hfyjT3bk
	 DQWN8r9e+jGFMifmFAmTVWZmkpirrzhcLfXHwZF3P0kK5keoqOhIxJS0X9waQKXaSv
	 bfBl+EfOeppIR26HSXrVIlJM7O90op+W8yKlNlsd95YfVEKiVoTeqEDzefJIDBsVa8
	 k7end0NkDegWLxRYwk8LxbEe0V1Kjvrnn85aZ+G00i+rqG4xfqbIX3nabfmWxEzX6S
	 JjhgbfaOWL6MBbuNGSdxnHHx4AbictEF2Ft8bfnJqEiFM8er67CvJH7nPkZ6VLhNQe
	 +H9BSsUqNgDyg==
Message-ID: <sashiko-outbox-166268@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] serial: 8250_omap: set priv->line before enabling
 the IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <d25b0dc9f84e7cd9b42324a19cbe4b4f78164172.1791524724.git.jirislaby@kernel.org>
References: <cover.1791524724.git.jirislaby@kernel.org>
 <d25b0dc9f84e7cd9b42324a19cbe4b4f78164172.1791524724.git.jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 05:46:39 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> omap8250_irq() is requested in omap8250_probe() with IRQ_NOAUTOEN and
> enabled only in omap_8250_startup(). The handler obtains the port by
> serial8250_get_port(priv->line), but probe stores priv->line only after
> serial8250_register_8250_port() returns.
>=20
> The port becomes visible to userspace already inside
> serial8250_register_8250_port() (uart_add_one_port()). So it can be
> opened -- and the IRQ enabled -- before probe stores the line. An
> interrupt in that window makes the handler call
> serial8250_get_port(-ENODEV) and dereference a pointer outside of
> serial8250_ports[].
>=20
> Store the line in omap_8250_startup() before enable_irq(), so the
> handler never runs with an unset line. Keep the assignment in probe
> too, as remove and the system PM callbacks rely on it even when the
> port was never opened.
>=20
> Fixes: fef4f600319e ("serial: 8250: omap: Fix life cycle issues for inter=
rupt handlers")
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ef47d676a44346e058f=
29a00c8701484db722831.1791524724.git.jirislaby@kernel.org?part=3D2

