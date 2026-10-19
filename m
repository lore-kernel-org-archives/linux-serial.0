Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338C13E0758
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 06:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389822; cv=none; b=TTmoj6oNbJ2v5ZqCYM5DaYWqe9a39A9XwxozRaSUa1yoxJT2CUBjtyxRwQc2QkOsmv65YTnhHAw6jukEwxmqVLW9TLtTNsSLZtUirwzn7FdnTbe4KSNvMXZIzQ/y3Pdv7AlMjgU4TspO6vvIvE1ejuTf8620i73Qorovd7N1XTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389822; c=relaxed/simple;
	bh=azh2X/0C7bZHYoWq667a2MdkfwvPoXsZasVCaYiUtUg=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=PmiIkRvUNMRSmHzhIdT2cr47j10rxuZnH8yNJX/4hFHD16DZLMtaxXtIMdG0h1pxHWGwF2mht6QwIxSLE90Rn9MwGPcV4vvoBP1lsr2Fw55MReaElq7M8uoRZzdH92NA3j7IMtnjTX/WqylvYRvF3vUWGRi76RV1JZXcTkh3BTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1FM63G8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1FM63G8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC5C1F000C4;
	Mon, 19 Oct 2026 06:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792389820;
	bh=azh2X/0C7bZHYoWq667a2MdkfwvPoXsZasVCaYiUtUg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Z1FM63G8ymUv6cJhvrbqWsDQTleSSAO6ZrbiUEl4DI9eKEeuYTkimnqEfg5mUbgg4
	 7sHkFu+o3gvPRaB8/JTxfXvnJ7KPiyWQsAasL7nfXdsnTq4aF6YkE+Mvn+Aw/TCLkR
	 v2NB0JSQNVqA8euRMkPTRcQ2Se+YEAiiFpUDyh5BLKdDUjWzHJloGdwp5HBJNI1fRy
	 k9t/15dMU0D6fGa4jSwmLr1wE7v69ChwUxIl00TYf3WIgBapRiCMXx0ZAIde5AodRg
	 lsCEKhByQYygkoYarFVIesHSRPa1/aUpINf8VVBMkCJ+xd4zS7N129yqlZErrUhWUV
	 Fadh2mqfXywAw==
Message-ID: <sashiko-outbox-176681@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serdev: handle devices without an ACPI or device tree
 node
Reply-To: sashiko-reviews@lists.linux.dev
To: "ChunAn Wu" <an.wu@canonical.com>, linux-serial@vger.kernel.org
In-Reply-To: <20261019054513.1966382-1-an.wu@canonical.com>
References: <20261019054513.1966382-1-an.wu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 06:03:40 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Some drivers, such as dell-uart-backlight, manually instantiate serdev
> clients without an ACPI companion or device tree node.
>=20
> For these devices, both modalias helpers return -ENODEV. This makes the
> modalias sysfs read fail and suppresses the device add uevent, even
> though the device is registered and bound to its driver.
>=20
> Return success with no modalias when neither metadata source exists.
> Devices with ACPI or device tree metadata keep their existing alias
> generation and error handling.
>=20
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019054513.1966=
382-1-an.wu@canonical.com?part=3D1

