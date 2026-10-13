Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9F9411A12
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 03:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863600; cv=none; b=rGUhhsbBuKvdUKADYkmqj9Begx4cvLb1zUzhGsyowyhwxyhQGI6DQDq3Cji4hLtQkVBu87Vh6SnKiP8LYnmL4gjhWMxdIObePYkuvqSigyfwKR/XjyyoiYYr8zhC3K9VqB2QcVqL7EA6n4R45NNXO5Cp1PhndwagjKqSSbN/lT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863600; c=relaxed/simple;
	bh=njGBqiqBrIkzrJE5N/7TVPeFx8fmcogJQRcXumtMIhU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QcfWtajeqMetQ7/q19B0YLDhBxUj/p70B29yRLvnUeeDbzuLQtPrxyhE4HfeCrQCYF+C3hPntaDQO9K4Sdy/qghsoB6hy8Hht+c8ucqUvU1o+TWjG9Qn/7a+2nq6zRN0B7dcqXJPncymDel0z5Um3WnrISC+MSj+yFfREU3alt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu4eAsYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu4eAsYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA031F000FF;
	Tue, 13 Oct 2026 03:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791863599;
	bh=njGBqiqBrIkzrJE5N/7TVPeFx8fmcogJQRcXumtMIhU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tu4eAsYOEEvemMOFXItD/IEVG/DJ6EBgD/e3AOnF0AZ18N7sV0EZn61S4oEPOk/jV
	 f1qJMviST1HYbGncDCb3eb3u6y5op5jAg5oNKFZGnWsvuh7PJqq2oimQ9//ta4etUY
	 /Miapw/jQywOAUJbNw0uRhHaw9Do9U5FbO9ypdi/ZpKgvi6uAoZaSxcZUixQptJfVj
	 PvKQCvVm6ZL7XNOEgZpY9TvFSFbCpXvQdwZRnx/cEMmCHrDr7UlFsCNPsG/YtnmRR3
	 AFdu4MI44s8/fO8LJjehfCzG6TuSMIlC2RRCQgeoPmGQPmTe5SmHVXgqmms215drJz
	 2EjvXiocB9N3g==
Message-ID: <sashiko-outbox-168929@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/10] ARM: debug: Add Cortina Systems CS75xx UART0
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013-b4-cs75xx-v5-5-4e72aa383d39@gmail.com>
References: <20261013-b4-cs75xx-v5-0-4e72aa383d39@gmail.com>
 <20261013-b4-cs75xx-v5-5-4e72aa383d39@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:53:18 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add low-level debug output through UART0 of the Cortina Systems CS75xx
> SoCs. The UART is mapped at a fixed virtual address by the generic
> debug_ll_io_init(), so no platform map_io is needed.
>=20
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
v5-0-4e72aa383d39@gmail.com?part=3D5

