Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D98F27D766;
	Tue,  6 May 2025 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746535907; cv=none; b=mq/DnOhMYN/vRgQkk8IPrABAK4nCjym8UVnE8EPw3S2RtwAjmL4OAKF1Wl3ub9veIb4r+ZfbvGi8FSWgHSEbQ2qSff7cV17wcnPWy3DHI43f7ncrwsA+yA3WNaOHiX3zRVYpy6LCcaqU/ARIw0UXhr8qpA1s2nPCUIAu+SJRJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746535907; c=relaxed/simple;
	bh=UdxC2W3mb0RSsOAh3jcVexeroYMpLSLZI12XCkxa2nY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Iy9ViSAfkTJcY94diBHsXHrENP+qfItGNXpjT1q4iQQyVgHUYoaP3p9qQBLL45SEBJmPpFioV5k3yM+Lkxxmneowcc+9s7ZuxbMvWpD9aksMcMeXHX/VR/LAnGEQT68unjipFQ4MvQm+J9y7Exsaw481oP8lQyKxXHm8OCd1Aoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=nyIYz6fX; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="nyIYz6fX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1746535901; x=1746795101;
	bh=6w1E0JQK4vGVijywC0hPfVOEZE2BTKLrnsyaHr2oPWY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=nyIYz6fXiP16PPYh3rAlC+1UTsdTS+yqCeGAdAJ5t3flNA5Actd3BAoczC9DfLNy9
	 /l8gm0w8Ad8rU5Y8+Hwdxwlco4Z25QigmvoEzrXLGHNEToQmC4PD4YPXWJkoIWdkY7
	 p+OGTYVjNgroqtWf9lwFZO6Pw5icEpco5FJx/8VY9WEZ4Qw2V9Gxa/hYPzMuAQG7Ll
	 hlOPCojED6PmzQDzYUuNCovMzPdJ2YvjC+m6aayiO4iAonwvaLGNWtA3InBgjG9+1m
	 U1dhmHnjpGh6CgoqtvTGR81fGvlsETWqUH5a3axtD+o269BM7qLZGbaEz3yZzkyskV
	 reAE9XczqdgzA==
Date: Tue, 06 May 2025 12:51:36 +0000
To: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, jason.wessel@windriver.com, danielt@kernel.org, dianders@chromium.org, jirislaby@kernel.org
From: Roxana Nicolescu <nicolescu.roxana@protonmail.com>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: [RFC PATCH 0/2] serial: kgdboc: convert to the faux device interface
Message-ID: <20250506125133.108786-1-nicolescu.roxana@protonmail.com>
Feedback-ID: 136600343:user:proton
X-Pm-Message-ID: 67af8fe5938cbd91a2c9f36bf7adce301daa31d9
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The kgdboc uses a "fake" platform device to handle tty drivers showing
up late. In case the tty device is not detected during probe, it will
return EPROBE_DEFER which means the probe will be called later when the
tty device might be there. Before this, the kgdboc driver
would be initialized early in the process (useful for early boot
debugging) but then the tty device wouldn't be there, and retry wouldn't be
done later. For a better explanation, see commit
'68e55f61c138: ("kgdboc: Use a platform device to handle tty drivers
showing up late")'.

This replaces the platform_device usage with faux_device which was
introduced recently for scenarios like this, where there is not real
platform device needed. Moreover, it makes the code cleaner than before.

To acomodate this, I had to change the faux_device implementation. When
the device is created, if probe failed and the driver did not bind to the
device, it will be destroyed, therefore probe won't be retried later in
case of EPROBE_DEFER. Now, the faux device is destroyed only if probe
failed with something other than -EPROBE_DEFER.

I am kindly asking for your advice here, because I am not sure this is
100% the intended usage of faux_device. In the kgdboc driver, the
platform device is for sure fake, but if we're gonna use it for deferred
probe, isn't it defeating the purpose of a faux device not being
attached to real hardware? I also checked the previous discussions when
the faux device was introduced and some people even argue than having
probe and remove functions is also a bit contradictory.
Let me know what you think.

Roxana Nicolescu (2):
  driver core: faux: create the device if probe() is deferred too
  serial: kgdboc: convert to use faux_device

 drivers/base/faux.c         | 10 +++++---
 drivers/tty/serial/kgdboc.c | 50 +++++++++++--------------------------
 2 files changed, 21 insertions(+), 39 deletions(-)

--=20
2.34.1


