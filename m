Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708C431B833
	for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 02:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649946; cv=none; b=G/IC4AhQ9bWt7+J0rzojEQMInn5JjyQLQHFoRl+9QckYVypakJGyoy0lyeuA5NtLFJLVziUDLXCMss4/DZ+XIFbBL7PgwJ+lLEbUlkbqzIL0eMvDozA6DJFQXjetrWS5HGzRnXNXgfAYl5p0w7TfSU73Sqm/B3HLC+bzZ8iK3dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649946; c=relaxed/simple;
	bh=CLDIFWFkhChhRn5595dLSwzdeELg28c30EoCNlSXSic=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NnMozWQX9lDtP12I5XShvBZoY034b/oQV+9tjmLP1I/g1tEP1kSlY4PjC0d8Mf7nd73eySihYAPzDWiF82jj5N+lYxL4vw3V2BVWllrzLi3K92vW20mFxn0XUZ1WAgGDdFTP+50jYtp325jJDojlxZAoJwgDZisO8q4DRKantGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/ePYg+I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/ePYg+I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3009A1F000FF;
	Tue, 29 Sep 2026 02:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790649945;
	bh=reW1UhtAG37VbIRBZ0+YtL3Slz/KDozs/BsLZd+VG50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E/ePYg+IBWkKgUmHWIB4d1AEi7ifIClVglle6rvwvTeg7mGvjoR2YoQJKfMybwSNc
	 a2UEAzzCrnjSnW5/GjyORTKAzC6gzwWnpQG2RlFyBjQRBT1+UViHqOKoutlJciY31f
	 aE/tKNFyR04ZA+6naBn3P6AODyZQgscyUWLxqguO1q+0uAu/7AT/yUfAQhb5Up1zH1
	 uB9ZsS3iJIf5nkXVr0WpMTEOzMjIL5rsZSpyX3j3648/l+XTmRhUPK5L+J8h6cYsWA
	 64yEf6yXxSrjgExT+e1bR2Tpu8fS82VQyCu5uvSUezlV99SexMmpK3l2QzeTQRNzXG
	 JmpuuCx9l6XdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next,v4] serial: core: fix NULL/dangling port_dev on
 failed re-register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gaosheng Cui" <cuigaosheng1@huawei.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260929023155.3259567-1-cuigaosheng1@huawei.com>
References: <20260929023155.3259567-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 02:45:44 +0000
Message-Id: <20260929024545.3009A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Cui GaoSheng <cuigaosheng1@huawei.com>
>=20
> serial8250_unregister_port() removes a port and then re-registers it
> against the legacy serial8250 device when that device is still
> present, ignoring the return value of uart_add_one_port(). When the
> re-register fails, the error path of serial_core_register_port()
> removes the port device but leaves port->port_dev dangling (or NULL
> if the port device allocation itself failed). serial8250 matches
> ports on ->dev, so such half-registered slots still reach
> serial_core_unregister_port() on the next unbind:
>=20
>   KASAN: null-ptr-deref in range [0x40-0x47]
>   RIP: serial_core_unregister_port+0xe5/0xa00
>     serial8250_unregister_port+0x103
>     serial8250_remove+0x61
>=20
> Fix the error path to clear port->port_dev, and bail out of
> serial_core_unregister_port() when port_dev is NULL. Read
> port->port_dev under port_mutex, like all of its writers.
>=20
> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to =
enable runtime PM")
> Assisted-by: LLM
> Signed-off-by: Cui GaoSheng <cuigaosheng1@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929023155.3259=
567-1-cuigaosheng1@huawei.com?part=3D1

