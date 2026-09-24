Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229C5442B16
	for <linux-serial@vger.kernel.org>; Thu, 24 Sep 2026 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248267; cv=none; b=BGAOeqG1nqCXX+dI6B11RZ8YpVugGOBylRxXBoqA7BhnXpxrGZSHtyQUxNoKmjSXsg7eVeW7y5LfgpTJfE5Gh+iwKHrDgKGk9DeB7NQc+ivqAgt/FI8OpOU7fT2YZ7iOT43M0Pn78IrPU5j1nMg2rbswsliOZGCivdwE+2MvopA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248267; c=relaxed/simple;
	bh=t5jKFDHySY9d0AXvbasD7yY5egWib+1KrMWZI3h8vyI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c7H5YiO1LBJEMsEMndUs8wuqHB4bgB55zZNe4D0uw4BEJMgT87UFP7Ec1sDo8mgUpiw3gPVwpNJqNSe6kbKbcmN2YkzGtEDHERChDuFh7FkmwJ+OxIVhVVrA7Z9bx7R+s5cYt/ETbnehIvRzNQ1UEPoXHQmpe/mLgSbyB5eH4XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdPO4ZEN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdPO4ZEN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9287A1F000FF;
	Thu, 24 Sep 2026 11:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790248265;
	bh=t5jKFDHySY9d0AXvbasD7yY5egWib+1KrMWZI3h8vyI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cdPO4ZENG/A4pPpZzOI3n6aRSWCZkxvHgjAsKp0d6tBLiMaxDbMBtE2H5/0s/BRv7
	 oTuxOjaM1/vjR2wuQmWQkZSlFi341mqI7dMS6KDnYbOsE6Tz+lyLCXKq1iJPevWFID
	 jvk7pBk3Xl64mSQjDN4RSLNIzq0NZa+A4SuYuGAxByLZACTLJSGpB59QBRCU0bKTNw
	 WQes+b/BKWFE/e/+zeggw2UjowBbNd0Q0lVHLip9bTJy9rkEY3RZklqTaJ68/960G+
	 wyE2eILtPgYdreC5yIfYkyT3iC6FcwWiTOjiXzeFLaVd2nBDJmVfy5/WhoPLcHXcb8
	 mhCc1K52kyOmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: ma35d1: unmap MMIO on remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260924110400.1556396-1-lgs201920130244@gmail.com>
References: <20260924110400.1556396-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 11:11:05 +0000
Message-Id: <20260924111105.9287A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> ma35d1serial_probe() maps up->port.membase with ioremap(), but
> ma35d1serial_remove() does not perform the matching iounmap(). The probe
> error path already releases this mapping after disabling the clock.
>=20
> Add iounmap() to the remove path after clk_disable_unprepare() to match
> the resource cleanup order used by ma35d1serial_probe().
>=20
> Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver suppo=
rt")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924110400.1556=
396-1-lgs201920130244@gmail.com?part=3D1

