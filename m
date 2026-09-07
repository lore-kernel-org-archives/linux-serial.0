Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4523D40803D
	for <linux-serial@vger.kernel.org>; Mon,  7 Sep 2026 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763803; cv=none; b=DCJdw45s5khO3scfEAuYCxk4yuRAVu7bIOG1iDQ6AWsgjbjl+CbaEDcFjvByuTIhFACdIlU2sTXwCFgKRFcLyrG43ablVN7nTr8s0mN4larM8wTaZFf+y9SD2YPpYWyZES4x0LvWkGZ6NavTnbHrsuV76tw2jQN+EILoAFdUsTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763803; c=relaxed/simple;
	bh=dF9Riq2G91SVf7DnOlEkmpqjTKh5zn0+5F0UmNLz6+Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dX1lCTfs/To57pyrW5f7sUrYCApCpJi7dTQuorzl96Pe/FpkOsxP7aZkJPAEySY2J7e0tPSbc9FGTy2g0c9tHU4M+5KIMvKivkK5S8yvWkrAZ1Nq+b+ANcUHBEzpQmCEM/b8Hc0N/EbjTFgifsgKtqwYilDm7YTfN2HTw6jfqrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N04G0Urp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N04G0Urp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B18E1F00A3A;
	Mon,  7 Sep 2026 06:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788763801;
	bh=dF9Riq2G91SVf7DnOlEkmpqjTKh5zn0+5F0UmNLz6+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N04G0Urp8KDnSJZCCPmjaoPWxMpBVuIkVFL6X82vXQON6ouOqwRuVW7KxPMI98WMZ
	 B7/83HE/aCgopSBz3ZRrx13tRIFDqJRDn+fFjKtIIPUohxGSP8p6fuJ5rVjNMWpQq+
	 OX9VppcuACw6SHN8qDTdCRUCwUHoiWzSZz3/IaXIZfRBWTC8/0IYfaNQ5VAf22ZWgF
	 PviUNejiQPRXCeJc/ezHZ1oxrl2T9thAbwmae7oW8dZ3vkmBQek91O6XdK/lavwIVc
	 rU4ztgegkcBMZ/Aw/YhJqGGme1StLkd9OtgQG8TqMSxTAeDtqCPkpSvQM6g7ZkMV4c
	 vpkQgG4zr8xQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] serial: fix TIOCMIWAIT race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260907064418.92953-4-johan@kernel.org>
References: <20260907064418.92953-1-johan@kernel.org>
 <20260907064418.92953-4-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 06:50:00 +0000
Message-Id: <20260907065001.4B18E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The task state must be updated before checking the wakeup condition to
> avoid missing a racing modem status update.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: sashiko-bot@kernel.org
> Link: https://lore.kernel.org/r/20260904115542.E20D11F00A3D@smtp.kernel.o=
rg
> Cc: stable@vger.kernel.org
> Signed-off-by: Johan Hovold <johan@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907064418.9295=
3-1-johan@kernel.org?part=3D3

