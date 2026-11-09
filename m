Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794196818;
	b=V5rx5PuN1f4cXWwtr2IT544c9svCQXi367vhy/KYsO17lp3tnBbaydSq6vuM/F/YmGYq
	 HXexvTdaOIePYlxyN8H91hG9k6apIfSBYdcXYt68GqvfH2LOMmtJdKvB8qJrte/QdqLbM
	 Gz0jWNy4FuOENN1qSlzRS/AMDJ0qIhQpLetx7hOLFA+Iq+kv0ZCRrl8d53zTfhZU6qeBb
	 5Pc+wH/Z3uJs0vdt2UdeNU09jkUQ8fF8FHQJB4wpQNxmQ44mJDscdaxFn7bDcj5wZVJL+
	 9fc9fKgD3HqSmeSBkzDrE3N7wyuxeQR39KZevnMjMxAjeicbtNMB2/R2MBJT6rzEd0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794196818;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=V1lHAyXMbF5QROqxzWvTGqbZp1Pyl8cuuGhs9j/sniY=;
	b=DJ1WEDk4FYT0rMIEZZbaYZo4unL7CRd5aRjqZkiny9cactsXayF+hofusWCPMpd2nLEf
	 Zrd8feGLDRG0JmblkBhtwtKKgCkVsqFT92WwLY+ucgJR3SpMk0p//1AzjPsQifgRj6C8R
	 kwiz7SlNUt8Vur6dnkT5Ck7PzTSMYoYqYsUry36uU2M5HL1kGOQ66aeVO9ZKCoArIhDom
	 2OasMPIkJgfAPJmwWjbZZiXTjtsETGS/0Kosd8Bs0wxgsA0DnL2NKSrfTO9IgQTjwLqsW
	 pFEEn7l+FCY2ON81gkvoyqgJBB4qRHIVnI0wErVhvVWho2O6d0OOqBdt/LbXHqS50Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A5UQDBCg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DB7606A321
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 04:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A5UQDBCg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BC41F0089F;
	Mon,  9 Nov 2026 04:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794196818;
	bh=V1lHAyXMbF5QROqxzWvTGqbZp1Pyl8cuuGhs9j/sniY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A5UQDBCgXN2T7w5cjCzliHZu2JHCfsm0esxxeeER7pneOWZjAAbp6QVRM85OmF16J
	 WRgFgUiOCWl/wHCg7cmLmyNvcs1XxR8FDj321SNjtrfLQD5ug2UtJmSViZ8r1okYAr
	 JZfuJlpzaV52f2m2uWm5b40xYnVNDJ4LmnXvUubZe8PtoHeeXzj2vqgsKjjxnX+SSK
	 soK5EWpdUEgv8qcaUUHdETT3PljiYehN0ZK4OUxm1uoDvX3odlEjleycyP3y9tXuc7
	 rfCJUpqWYgZy9OKQkTXReWsRREzTUKWDNYqyIyaDYwB0ghrgZ/vBf0sbcsbD/N2Mg5
	 JoTwtpGdh8hhA==
Message-ID: <sashiko-outbox-204388@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/8] serial: 8250_omap: quiesce DMA IRQ handling
 before shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261108-submit-serial-8250-dma-cancel-v1-v10-4-e6227ddb95b1@gmail.com>
References: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com>
 <20261108-submit-serial-8250-dma-cancel-v1-v10-4-e6227ddb95b1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 04:00:17 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> disable_irq_nosync() masks the UART interrupt without waiting for a
> running handler. That handler can have observed up->dma and continue
> using it while shutdown releases the DMA channels and clears the pointer.
> Synchronizing the IRQ later in serial core does not protect those accesse=
s.
>=20
> Publish the DMA shutdown gate under the port lock before the final RX
> flush and interrupt masking. Have DMA IRQ handling check the same gate
> under the lock, so a queued interrupt cannot restart receive processing
> after the final flush.
>=20
> Drain the UART IRQ outside the port lock before releasing DMA state.
> The lock excludes competing RX processing during the flush, while
> disable_irq() also waits for a handler that observed up->dma before
> acquiring the lock.
>=20
> Fixes: fef4f600319e ("serial: 8250: omap: Fix life cycle issues for inter=
rupt handlers")
> Reviewed-by: Raul E Rangel <rrangel@chromium.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-submit-ser=
ial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com?part=3D4

