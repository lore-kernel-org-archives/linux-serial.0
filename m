Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CCB3C0A0C
	for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541625; cv=none; b=DeQSDOD9FgVyahoKfX1/ezsevGy9oGDcWHsKc+lhrfiBA0ba5bqxaFHfw7x9Cj0C+8VOXlyJuKGx/3rq2wqVWO94HY4ERHRCD47kfsip6/6ys3osEG8cgREKuwu/KrmWbFFDU2fHMNEq9Cq2ib1XReDESI3GM8Q0dlY4Kf1LEQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541625; c=relaxed/simple;
	bh=Tt9cgaZ+BAaMjTwumbohCSTk23UR27YzyIm1pGeWkQw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QSp4Xxunv5oQjHyL3SUCFrt7EIYFLqgN6pQ7x380rpBpngujp58KqooLtgs4+sFpNPzVD5VnVV9Li0etPS2oKrLeduR9gmueI5DIo/cDFXr+vHA69Cp+NvDFTMHSOPfCO0FXoeTNm0zVJANOuyrXz5V+6NVR3647MQOqaJCz2T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjuXET8Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjuXET8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384531F000FF;
	Sun, 27 Sep 2026 20:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790541624;
	bh=Tt9cgaZ+BAaMjTwumbohCSTk23UR27YzyIm1pGeWkQw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UjuXET8ZHtNeO4Ka7OnsqJvbH+8G30iwklGA1Lbbq5zNRxI5/0KUqnLkzFdVHCQP6
	 w0W3zLwKgCXAVS1OelvwXygR79Q60BaGUP96ZJXM9WHmPkBQJgIyjZmnv0HxQeWHBU
	 N2XzTHOUV3zpvNXYZ65vEgZLy14OxegbPc1bV/tYCHIcsLV4Ud4Dy6i+U74D9dTtth
	 qtlhjxhPpQKMJzRTKCgnmjxcV7h5PceLaFBXo3mArk8CRPwGeehoZGlWNlg4AjxTnV
	 sWzpS88Fk36fTocrjaYOqMH8Q0DgteohfNqN8kxg/A+7adkS9h6WuAFZMQp7rvJv53
	 Ku7hpyETl/FKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: serial: mpc52xx_uart: move static declarations up.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260927203501.14105-1-rosenp@gmail.com>
References: <20260927203501.14105-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 20:40:23 +0000
Message-Id: <20260927204024.384531F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Avoid a compilation error so that they're not used before being
> declared.
>=20
> Fixes: 4d105880666a ("tty: serial: mpc52xx_uart: add bounds check for psc=
_num array index")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609260356.tJWbd1WU-lkp@i=
ntel.com/
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927203501.1410=
5-1-rosenp@gmail.com?part=3D1

