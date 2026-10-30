Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400524;
	b=mSZdtYcGY6Rp9kerNhTHW15ntxnqYG7oeUoDJ2o23ql6zEFptKi1equ+nayipBmPIMe7
	 RArrXhJzVyqzHdeU+kk2BcPx0DZVlzwQIOBDmxYYqxoO9F1xCG0XvStbl3T0qEQomJy1L
	 hxx4ud4lxGbgf3AV1tv2o3uZiMAFiKxspROG3fHe7n1G0WUWajVCg6NWmOq2jreYa+7+C
	 83Q2QDwUBEVT8I3jIjzNCNkzZFAKLw18iRM2K2HL39SNNESFF8jccDThCIXUW+vSkupDL
	 YoSI2frnNUj26z1AKgU3y75SPOD8BFxwFSGrtH+xBtZrc1f0XBY2t6bY8X/hqPatPkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400524;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nj7RWTaprIeagKUplVjV26KVRQjtS9oKti12nqKCvew=;
	b=ECtqwbjALg5xVtUyQa6amjXcCLcIyroBpImsIFkocMpj5LJi1TWmNAoiwSo9tbZMWDaM
	 GUbXurUZIdK7L5ez8CrIyH3jEypsQfRrKHVjn1dA2da0yr+wfiNCPQ2vATIRfaSWd6kwZ
	 aIJgjcJtD2qKPHlhQGCVf/aXigB+2cEsx6StfUeVezhVEvE0cYUKFm2FCh4D8Khx+4/Dz
	 rNnsRteteDjWW8jsocLNlHEdsMaHduQheupEFO21OwqVrk154jwyiqIcQOeAMBlm3qQI/
	 eN8+J6/yX/QsmdfqdHg5KFzVl618BQxrxvpVfiXYF0YM9ntYYPjdhYco3mc0ITme9TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gDvcqGL/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EB6606A31A
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 22:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDvcqGL/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D7A1F000C1;
	Fri, 30 Oct 2026 22:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793400523;
	bh=nj7RWTaprIeagKUplVjV26KVRQjtS9oKti12nqKCvew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gDvcqGL/3Ma0M+NEObrolcvyO3W0Pt6weApIhyW+7IsquTK1VDvbSIL9wH69uKUq9
	 AEK3zkwkAgs9oNSW80Idd4EgVyhQqZiIzcjp5HNRLTaoXRlz0KqFAIuvqtkTYf+UrS
	 VFGa5WjPyaehdChxNlGrFTKaf3kAu31GkVBDn0BFsUaQpnx68P1FDlLn5cMSnsKcK4
	 tVMfkKLDZakZ9OY/FfoLngHXIdvG3BUqnFV2yV940Auts5pU8ePxvWN+wL5QmCYVd9
	 HZx5CpN6MTop9STg8kv/wrtURezP7+yJlyGNfNOfbpLq5U1UcwVKBnf+hn9JYk6IvI
	 ipC52Nf2rfjYA==
Message-ID: <sashiko-outbox-191598@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/15] HID: ft260: i2c: fix i2c_reset sysfs store
 return value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261030223637.86907-15-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
 <20261030223637.86907-15-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 22:48:43 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> A sysfs store must return the number of bytes it consumed. kernfs
> hands that value straight to write(2). i2c_reset_store() returns
> whatever ft260_i2c_reset() returns, which is the length of the
> feature report it sent, 2, not 0. The "return count" below it never
> runs, so every write to i2c_reset returns 2 whatever its size.
>=20
> A write of two bytes is right by coincidence, because the report is
> two bytes long. A caller that leaves out the newline, as C and Python
> code usually does, writes one byte and gets 2 back, which is more
> than it asked for:
>=20
>   echo -n 1 > i2c_reset   1 byte, write() returns 2, bash ignores it
>   printf 1  > i2c_reset   1 byte, dash reports an I/O error
>   echo 1    > i2c_reset   2 bytes, correct by coincidence
>=20
> Return 0 from ft260_i2c_reset() on success. The value is discarded by
> its other callers, ft260_hid_output_report_check_status(),
> ft260_i2c_probe() and ft260_i2c_abort(), whose own four callers
> discard it as well.
>=20
> Fixes: 6a82582d9fa4 ("HID: ft260: add usb hid to i2c host bridge driver")
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030223637.8690=
7-1-michael.zaidman@gmail.com?part=3D14

