Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793788408;
	b=QjRzbIRe+xGvHPstbpF1G5qzTjgOio0LRHKUdQKNq/du9yy+XMfg2qBCRQx6+me4BsNp
	 XYMv9QS4Gl9Sn7s7ECqW7k+wQOJFsysN9DQEm46J4eWLe+/6xEgsj+DM9g+Y7lXVL3eB5
	 njQozb3PqVEIeds54Q5WTds6dlA/cwv41S8WADBhLCJfvvZYj+CL1BMboUURheJfLdKy2
	 yCKv8+QTTFE7RoV+mJsY5Lb5oLp1n9ywpVuU+uJZfFnH+4tA1U8g7m3LuCu/JSYk76FGV
	 BOM/24J9F4bUV/C744qJ6JNhnrLmi862Iipk957kFtMvulziKOgPiI8S1DhfFi5J2rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788408;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nu7da5HR9TF0UcQ2nda1Wt3NGqOlfIB7RiqasA8fcFU=;
	b=bD0tGdlWEPYsB3FgXC/osXT4WToCPV7XhZ/x64fo4qvwQSS7gNVNUot6kimzaUOriFN4
	 gIOqC9e3Gk2NenIiblcy4it72SEmvsk4vDMYPYSAXb4ghm7Ex2Ol+p3kStRKk739meZnT
	 8UJByvGMpK/uDywqgPzboN3hW5SeL1BvMAWoTbQk1Qix5k0D69gXNtvxp1DtQoF15eUgm
	 7rhVbDyFegVz8qfGxk0e95IKTYzwrN6i+hitOI5BCH5SWqM1fE8Fc3wOvBRIkjToyUfyA
	 qVDoUUz21V8n2RydZ6fZRo9wxiv0JpIC7C07GFYkIdF92Eq3IJvJseSFo1jj5cdhGuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QK7LMHBh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7F606A31B
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QK7LMHBh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4925E1F00919;
	Wed,  4 Nov 2026 10:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793788407;
	bh=nu7da5HR9TF0UcQ2nda1Wt3NGqOlfIB7RiqasA8fcFU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QK7LMHBhHRRCPWmr4U9fxbJeKlHdLHVPXjjJjbwxxQTHupKaYDURWqoVawlid5Mvr
	 V3JbHPhvvsCR6aP2NVjH93G14v4DkPFKLYl+GFIitGwSB1wqNtoP+lHKJ/1fEIhxBp
	 l23grzYKtGWx+3U3s6Gs9WbSr3do7enBHMpBOGrt975ksnqCFHOAJqoRpn2h/UYt3B
	 208VMVbd132aVdIGXJfZiBxNh/sXP5a1bibjScxPAsekvIiYUQZJVLids1v9JowsA/
	 TYTCvHhNL8zOROzF7W0DGD4Cny2xp0ob8ighjoRB6UGAC1/LdtkJXcIemCJv22ZJQx
	 cGyhkkLqsR7aQ==
Message-ID: <sashiko-outbox-197099@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] serial: core: do not touch the port after dropping
 the last reference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261104-serial-core-remove-deadlock-v1-2-6a30597adcbf@vaisala.com>
References: <20261104-serial-core-remove-deadlock-v1-0-6a30597adcbf@vaisala.com>
 <20261104-serial-core-remove-deadlock-v1-2-6a30597adcbf@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 10:33:26 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> uart_port_deref() decrements the reference count through uport->state
> and then reads uport->state again for the wake_up(). The last
> decrement is what lets serial_core_remove_one_port() return, and the
> driver may free its struct uart_port right after that. A reference
> holder that drops the last reference can therefore read the freed port
> on its way to the wake_up().
>=20
> Read the state pointer once, before the decrement. The uart_state
> belongs to the uart_driver and lives until uart_unregister_driver(),
> so the wake_up() target outlives the port. Drivers that unregister the
> uart_driver in the same remove() are a separate matter and not changed
> here.
>=20
> Found by review of the removal path while fixing the deadlock between
> port removal and a blocked tcdrain(); not reproduced.
>=20
> Fixes: 9ed19428a51d ("serial: core: Prevent unsafe uart port access, part=
 2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-serial-cor=
e-remove-deadlock-v1-0-6a30597adcbf@vaisala.com?part=3D2

