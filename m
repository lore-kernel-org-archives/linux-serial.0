Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F453932D9
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062380; cv=none; b=GACBfAud7IigZ9HUeU28bkQb0uDOBG1c1NCYX3L+6RND+ZocVfuoOupQP2dAO7EA5LOaOrpb60ame3EsPV6Ef1TwRcYMzDhx+Q6CiGBPtquBZSzwojtZ4tUhvak/AW/8IMtiE8gZQRuVETIWavj9PVwq0JjDzr8yijctVb4DcMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062380; c=relaxed/simple;
	bh=V3YBJ8QJHDaDCp78tM4CM2w1YVIIKg1QegIIXtW4Q/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SI0WbFH+43OZ3Ox2E95Q4ismjgWd9TWUGqfph3jrudUJQOwfRb/bZbm5JpW248XyRh1UE3Yao0eRsM5L/Wl0v5zXC6A7VBubP08QQmYP5tLwSg/tmenAl6boXQYT1mRdoVnnoHf2PV42xhjtQ0JD63BJnOO2Ef726tyJhLua6dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkUy3Zz1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkUy3Zz1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B621F00893;
	Tue, 22 Sep 2026 07:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790062379;
	bh=V3YBJ8QJHDaDCp78tM4CM2w1YVIIKg1QegIIXtW4Q/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EkUy3Zz1NmtD5TJc0OIpMLywaLgPsX7pfJ97fxwZHpBREJBvj79aWUZCPpvhKzQup
	 94YoCtybzyLaJ7GCOjuebdVuEZnEWLDpJES/1YDgR+aihjWT9RWJwcvPKfdjAhyUsN
	 7CcephOWVYAQ4vQwV83vSCL1fhNX3w1E9zsMd3/QDqfCd70ppLH9wHwW1Jy+A7JWhk
	 bQ/Gv7XH43aXS2HYZgFBnRasQqKV+xDmRU17euE+W5JtJXXiTm2ht8QtG+RqdgHxel
	 9RaMDjRlPT+TSA+uoTB85xPloTB/aiZpc71zEuBwpme+WbLKSfXXX8YkedFGpwrR+A
	 fve6d6jWJRT+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] printk: nbcon: Introduce Braille helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Mladek" <pmladek@suse.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260922072558.98854-2-pmladek@suse.com>
References: <20260922072558.98854-1-pmladek@suse.com>
 <20260922072558.98854-2-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 07:32:58 +0000
Message-Id: <20260922073259.42B621F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> These helpers will be used when calling console->write_atomic
> in the Braille console driver.
>=20
> The Braille console is not registered as a standard printk console.
> Instead, it is integrated with the virtual terminal (VT) and writes
> data using the legacy con->write() callback of the associated serial
> console driver.
>=20
> When the underlying console driver is converted to the NBCON API, the
> Braille console needs to use the con->write_atomic() callback instead.
> This callback must be synchronized by acquiring the nbcon console context.
>=20
> Fixes: d3539347022a ("serial: 8250: Switch to nbcon console, take 2")
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922072558.9885=
4-1-pmladek@suse.com?part=3D1

