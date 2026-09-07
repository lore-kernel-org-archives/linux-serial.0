Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167613F4DDD
	for <linux-serial@vger.kernel.org>; Mon,  7 Sep 2026 06:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763905; cv=none; b=PGSa34JNsnQr4fcytZxnljsJ2iHeiou0nAkni5AZWaZYu4nTzgVnjz7Cwk7lwyICkbUbhd9m7CDj0WrRB8HG83ykWCd2ggaVlcTIy6in0Jv3QyUiIKanUnqSFdOX2tltMphx6Zxnjzvjehg3q56eF2jLIo6ThMOt8CZYg1pr/Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763905; c=relaxed/simple;
	bh=G0ldfJQhxfROsBUHfrVKFc6A37eoQCQL0WLMO+moIOg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D/Dby2AudvHMPGYbMahvSayLXWsd8lM822zuIqrdgGRVl7KB2UXJE8nICCGb0ZVhkw4Mtf6rO0oMbR9zPAl+9ZlRE4HcKXJIVUSQvjrVxXdxDe9DaeaL59IfD6dLJDRHARbYl3BHLBNyDGOj+SSlkglHFnlP02BVLetsK59sYmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ds7a/cOt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ds7a/cOt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6421E1F00A3A;
	Mon,  7 Sep 2026 06:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788763903;
	bh=As6A9bnHxrPaf0WLpGZTr8y5vLgoyRQOCfVt8XhxQMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ds7a/cOtuTo8ZvHQHPbqCBQMUuCdH1cF8EhOAu49Yz9oWC02PBdoSq+BhzBkPjvf9
	 iSBdqcrklAtwtUJw9fFmkPfJ2U8d5WWvTvrDYe3/LwD6Xw7ChvTZnDRCo74TFsInKo
	 Km7s+7FrnkvWrTy/nozYgPbRE6D0ZeirxeL/E9W05U7QT7q2hZHgTJpPKQb/7iRvUK
	 ZL770nDBI98GRbk6C7Bd33QLq9y5sIwoQos7HTKfL6/fTIsnya9W1SZ+ZEewnVRNlo
	 iWHa3SHSll7ePMjFJYq+g3RjxLxBFFMGeGJCNlg/6F5imYTSfKtxHhnirelTLAAXZR
	 YYc4DIgRkOucg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] serial: revert guards in
 uart_wait_modem_status()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260907064418.92953-2-johan@kernel.org>
References: <20260907064418.92953-1-johan@kernel.org>
 <20260907064418.92953-2-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 06:51:42 +0000
Message-Id: <20260907065143.6421E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Mixing scope-based and regular cleanup is discouraged and
> uart_port_deref() used by uart_wait_modem_status() falls in the latter
> category.
>=20
> Revert the premature guard conversion in preparation for fixing a hangup
> race.
>=20
> Fixes: 56609c050051 ("serial: serial_core: use guard()s")
> Cc: stable@vger.kernel.org	# 6.18
> Cc: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907064418.9295=
3-1-johan@kernel.org?part=3D1

