Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792816183;
	b=k7JEm6aW4I09lwFV6/Yx6c1sjkWBrciwgHZtMA903KSW/wTZWK1608tqAk8m8OJNPFFO
	 KEiOqjzGVbvxMaUqrjNwicPBjXdxG6i9Az3opBL4pUXzvk5WMr8wbUelaNVApqnYGCmeb
	 Z5datHng0HxNgglc2KW17QlL5+yx9ZQk954/Y30G7nu6wp00pmB4eEL3qpaC4thI7uVTD
	 A6IXWgu2oA9E34guZyuiq0VWXjne88KeCVMwoo86Ol9J/WIld7KuG6u73f/42XQldD+iE
	 EccqR9x1xsdN0QZ7xw3jMVQN7UlQ7URd1nrj/X4B7rmqDXoeGBB6mA1O1+0kNDslBbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792816183;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ybTOYLq/IZ20Ii8KGuzZtdaOIprVyYIFYZ6hjdPxt4Y=;
	b=Lyqn98pXJtw1lmCe/TqUwQq/nAX3NWrLqBYUk+GdtESQmD94N029r2RNwY4FRuuoaCxW
	 jmveqYCojYvz8drFuRsJ8AVK5tz5DbX/HWcVhuMg21x5CoadhzdEAFDXUGo9sVyLwy5FO
	 QvAfILkiGjO9VOCpa7RNoEG8h9q+9RZ2cC0f52UR1ZlGH4KfhfBnSMqyUzgB4WqXnMeyO
	 E9UJlkyhO0Ddir8WATDhOhfD+Rhbglz68yTzU3nnR6chG2yguPtgrGgfh1G36dVs37OQQ
	 ao7/qDjhdvF4PKxcAvYMkbXQHcKzrE3o35lXms4N9G6goGO54ipIACMfJIrPllBZ1TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e5KzJn8z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EDD606A31B
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 04:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e5KzJn8z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A6D1F01828;
	Sat, 24 Oct 2026 04:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792816183;
	bh=ybTOYLq/IZ20Ii8KGuzZtdaOIprVyYIFYZ6hjdPxt4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e5KzJn8zQVGqA80Xw4yoBF5x5mai2l477kXes+GtQGoeNsm1IxgtU/j9QMfAJrIf5
	 jmxt4jw6NxrImbuKhffazRHK0IpjnVIDWdMbMOG68DsFZYlw2AZ0PXLGzo/m5F52pc
	 fhEhGEYBi2kkcN1EFkKuEmA1jOpaiuREEHrqeGiftargxi+u60ArabAbQzBOJn+AsM
	 pB4N7cml1xxUlsRRQ+yYcj5zVmL/TQHC9uVIb5ZGv0RM5wayw6xuvBDZJtYK9hXylV
	 IYoyp7cemj69ZyClszZND4KH8mtNNMKPT5O75ZL83ZUWvTNYXYCmyc66HpreDdxB7B
	 PlwzyF8+kglgA==
Message-ID: <sashiko-outbox-183545@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: serport - defer write wakeups to a worker
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023-submit-serport-write-wakeup-v1-v1-1-74e7311638a2@gmail.com>
References: <20261023-submit-serport-write-wakeup-v1-v1-1-74e7311638a2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 04:29:42 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> UART drivers can invoke the line discipline's write_wakeup() callback with
> their port lock held. serport forwards the notification directly to the
> serio driver. I-Force's callback can transmit a queued packet through
> serio_write(), which calls back into uart_write() and tries to acquire the
> same port lock. A notification after I-Force queues a packet but before it
> sets IFORCE_XMIT_RUNNING can therefore deadlock.
>=20
> Defer the serio notification to a work item, as required for transmitting
> from a line discipline's write-wakeup path. Keep the SERPORT_ACTIVE check
> and callback under serport->lock to serialize with serio close. Cancel the
> work before freeing serport in line-discipline close, where the TTY layer
> has already excluded further line-discipline callbacks.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-submit-ser=
port-write-wakeup-v1-v1-1-74e7311638a2@gmail.com?part=3D1

