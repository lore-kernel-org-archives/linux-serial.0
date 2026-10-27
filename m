Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099904;
	b=pM4djC1DKFn+tyT3cJGFJbu6ZVvV86qJyw6/MqSHmuw+buKKWgef3b8+l92wgWgEyRLa
	 Rg8OownKl074M3SmR2cdiF4vWmPO65hVSxpXFk63Aj9CY9xMu4B7z+El+z8YbvDhjh8yJ
	 KS2NMkl3Osufbg0lvMtjKs4yEyuY4s3UbWjfeXS7hvTt/f1T1ZvOK9nF6zOfBXvNLt1Xq
	 QCxg+SZDnH7Nm3MK2RJbUvcXvd2MZo5ndqUrix9KyTNVMubto7fLDD9118ebFOkrgOfEi
	 BK3g/CighLKmaXsl3xVxG9aGbG08FPERN3lOwVq/RlgQTaOs5dAi8G/4J35G4oiSy9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099904;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vIfA76JmKUk8icMKx/BgD2Ukzflxjw1xaHBQ6RLQ0qM=;
	b=FWGSSDZSoHUex3LJp/Zyne6rHUyOjDp5AERcYKG4R3eJeAYPEMadHTodPP3oNBjoVsoU
	 N9hnUwvilQx9xFGSTIplY5z715N4CK75gbrhfl5rTUplqnx9NCZJNIp2RBj7NLVNyrOyK
	 G9YzASSIH/N0b9UBw9sSqCqXzK5syLWgsa9xwrJlDRb+xbMdBZYJ/0jv5haN1U8BRSar+
	 pPaJv675Xc96aZKkFUsXy20ado96c8pXPoz8n5Zqt9lTO7fzqkv2aR5npfHZvAJEt7t52
	 Qu6CMuFrQ23R+sgPeAPdGh53ivQ1TKmgCx4q7rbkhf84HscxW+aqoRUX8Ecy6f5WEmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DbozJz3A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84B7606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DbozJz3A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589651F01828;
	Tue, 27 Oct 2026 11:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793099903;
	bh=vIfA76JmKUk8icMKx/BgD2Ukzflxjw1xaHBQ6RLQ0qM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DbozJz3ARezOdJBNQmk6v83sV8orxqK1dimdAg+9gfnBM0wa4ldLYCf93N3ocjPl5
	 2YTg0tw5zFt4hetNeGok5N4TopeashsAlCEN+FTjClO6Lxjug9q25weswTFCD41kFb
	 JU2xpE3y25df/gk03fRD27DUjAbO/YnQrGDkYCMdAXcudY8DHOdRMnPKKU+daNOspJ
	 GilrE1djQA9Qhre9zPt5/0MeQm6qmGb3asTz+BXDTadp4wWAJXLDBk+gxPmq0Ghi2C
	 OyVdtPpFd0moKlkqMqXHPACnUxsnSdSdDLbLmhEOkrWzMXWFbKIdj82WLqC/rIPQL3
	 YGTFpBoIwWkqg==
Message-ID: <sashiko-outbox-186434@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/24] serial: 8250_mxpcie: handle hangup during break
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-17-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-17-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:18:23 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> Ending a software break on a Moxa PCIe port in RS-485 2-wire mode
> dereferences a NULL tty pointer if the port was hung up while the break
> was being sent.
>=20
> send_break() calls ->break_ctl(tty, -1), sleeps for the break duration
> and then calls ->break_ctl(tty, 0), without excluding a concurrent
> hangup. A hangup (a modem DCD drop, or the session leader exiting while
> another process of the session is in TCSBRK/TCSBRKP) runs uart_hangup(),
> which shuts the port down and clears port->state->port.tty. The second
> call still reaches mxpcie8250_software_break_ctl() through
> uart_break_ctl(), which then does:
>=20
>     struct tty_struct *tty =3D port->state->port.tty;
> [ ... ]
> Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Linmao Li <lilinmao@kylinos.cn>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D17

