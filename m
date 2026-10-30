Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385745;
	b=TWD8+8e26dPUYUAyGBRVkQEl8nIWAOGUc11rID2Yu/AwVUu3xV4ALg6OjkVExDBPXJjX
	 VbHYpt//zlO6/HGnfzpNLtd7nFICusfBXBy/jwigfZlFGwJNdg5mhmra7GWhYurRb/0Xt
	 EBvKBE2WMwiHyeJLL6S+GhdAvXh7qEOS0UjlHlBsyWvFjWsyvpk/g88NV0FQIReF+uhJ1
	 xQDaYC4c3tFAlmO1XbVFSOSf4e0uRMs6jQMVZHd+g/qtfsUns1pSbFxNB974rTh/4NFiz
	 TWzEsEGApoJycEABbzzIst6XuUWzctaiCAYBBSHAzmaFhiW3bxClaRTY2J3jbSkaAaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385745;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Tv4n+xLRt2+hUO2Fpv9cjXOvOXdOYS1pIh5/lsvKsb0=;
	b=XSc7TW5aB5kVxGrKOchwalIBC5VeDa2zCWM3rqD5z6OkwvvVEZnmw1gwjjyFC9djfAwK
	 YywxI/cABF84LAi/qjG4XQwVHrIlHOxNvDDR2AC4kg/xvwtypTmB3kEOK1phftHvCwN13
	 0hFXPzNLh79JIP2O+1iTgYQOzj5wZf3+aYbSrf/gff9vWzN4y8rjJTyOpL//id38Cy2C6
	 cSRDOkWZ14QE6a2OsU6hLKUhC4ds3KalP+nj4FKXVl6PSBV7GW/Z2P/P2gwupUVODype1
	 VU4fVCefWWolDW8hpKEBzOomUbOEPI8eXN6HiaqNlBMTGiSJfqbzmh0VPlXwSJkQkhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGQl+kUZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A440A606A31A
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGQl+kUZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E261F000C1;
	Fri, 30 Oct 2026 18:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793385745;
	bh=Tv4n+xLRt2+hUO2Fpv9cjXOvOXdOYS1pIh5/lsvKsb0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BGQl+kUZWGQdYN9UnJYkRBGQ0MbztD8hEGolc9H0lZzQ30FP18fVtzIzGCX2N4pfy
	 b5fWKnxj6hMWT4qGVjp9if3oJ2U1DrWUHoz5pVqF0n6E2w6OVK6SgLjZMwAOO4Di4O
	 ruhDyxJNmRUMQ0I7C//1g/jYrwDZnPilJn/cVIb1Zutk4N53tRP46evvryE4bs27En
	 lC9fNQf7h8nR4SWNSJNZxVxg2WaiaNipmlvBJiblUpZfek/OpK8FdoP28Bbebz9+W8
	 X3x1WATYBvo+xHyHdwxx+HLv9wjOKWdhABI4G+iZH4XiBL81wI7siLekTZFzvXTHJh
	 gAz6eRod2HDIg==
Message-ID: <sashiko-outbox-191415@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tty: serial: mvebu-uart: use device_get_match_data()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bramwel Barack" <bramwelbarack89@gmail.com>, =?utf-8?b?b3BlbiBsaXN0?=
 =?utf-8?b?OlRUWSBMQVlFUiBBTkQgU0VSSUFMIERSSVZFUlM=?= <linux-serial@vger.kernel.org>
In-Reply-To: <20261030183332.23834-1-bramwelbarack89@gmail.com>
References: <20261030183332.23834-1-bramwelbarack89@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 18:42:24 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Modernize the driver by replacing the legacy of_match_device() call
> with the modern device_get_match_data() helper API. This cleans up
> the boilerplate code by extracting the match driver data configuration
> directly.
>=20
> Consequently, drop the explicit inclusions of <linux/of_device.h> and
> <linux/of_platform.h> as they are no longer required by the driver.
> This allows us to also remove a now-redundant forward declaration and
>  drop the problematic of_match_ptr() macro wrapper.
>=20
> Signed-off-by: Bramwel Barack <bramwelbarack89@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030183332.2383=
4-1-bramwelbarack89@gmail.com?part=3D1

