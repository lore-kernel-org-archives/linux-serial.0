Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1B73955D2
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 18:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790448754; cv=none; b=BDH0vltDqYvDaeaZtGU9nRs/FtBapxP8FsadeY6VM/zebJMAtXqnOeq8HlBT15keqPrihrrFyhT7dlMFnhQoy9XVcVPNY6eEmGoNWxU+W2Cw9S0L66CLLake/cucMTofo8JQ/CiVZwuYARAt0+mY2gDs5ErL6ak964zCXuRCFqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790448754; c=relaxed/simple;
	bh=dEiHgCOJI+B0ZOvFMP0mb9tvZcS4I1dNk5CUn69craM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WQpAOCrKsylkTr7qVtdzjuPMpnKiG7Mhez/mj5o/QpTMQXc8OtY+mAYMCV4QwT+zluAvXmIMJLcS8mHu37sKbn1+4mfxV7EEvyl+/UDDdFw9/NTNd5mTDHOnt+shWLKbIBhVQD9TcIzmkiehCRip2720L8Kitm1bDKo9FTT8g7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+w2K2sE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+w2K2sE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344DA1F000FF;
	Sat, 26 Sep 2026 18:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790448751;
	bh=bEA5y/rDFLBwAEecfWf7JzvrnKw1mmptYyy4nMvkiRE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G+w2K2sE3v7cnQss3aXXCpCaBvKua3WdfPkJBxZPv5//jdpF/zPSZkfKZAieCi4hS
	 rcQPntU6IgrLC3GUmGF7LtuZMUD5nsbtHJ/pO8Ui/2w4dwzQsgurcOV+T1mzW0Hljp
	 Fx8pShLzX2D0egzaV0/RGYQilmdimErTDO/MLTurnwfUtjd+dj4B5yFyva2jjfSwlK
	 iid7raQ7Yee5HVJnSMBMHgtiEkraaFLXC392+e+vv4shxfZCO0S2XTVy/Yxdv5wS1u
	 f6hrqHkiTOGjEFQC6N5aJ1gRBHy3zgs7BOpBDqE4LA01x0+Zsay4kOmt5u59V+7AOu
	 a9XZvwUTfBZSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: Serialize saved termios access with device
 registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengfeng Ye" <nicoyip.dev@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260926184154.3017929-1-nicoyip.dev@gmail.com>
References: <20260926184154.3017929-1-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 18:52:30 +0000
Message-Id: <20260926185231.344DA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] tty: mixing goto-based error handling with scoped cleanup helpers
--

commit 6bd1bebdb72fb484cd4c55333cfb5b66866fd06e
Author: Chengfeng Ye <nicoyip.dev@gmail.com>

tty: Serialize saved termios access with device registration

tty_register_device_attr() frees saved termios data when reusing a minor
number without serializing with tty_init_termios() or tty_save_termios().
The tty_mutex held by the open and close paths does not protect against
this registration-side free.

> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 48569035da56e..26bdc4560a4c8 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
[ ... ]
> @@ -3242,10 +3247,12 @@ struct device *tty_register_device_attr(struct tt=
y_driver *driver,
>  		 * Free any saved termios data so that the termios state is
>  		 * reset when reusing a minor number.
>  		 */
> -		tp =3D driver->termios[index];
> -		if (tp) {
> -			driver->termios[index] =3D NULL;
> -			kfree(tp);
> +		scoped_guard(mutex, &tty_termios_mutex) {
> +			tp =3D driver->termios[index];
> +			if (tp) {
> +				driver->termios[index] =3D NULL;
> +				kfree(tp);
> +			}
>  		}
> =20
>  		retval =3D tty_cdev_add(driver, devt, index, 1);

[Severity: Low]
Does this violate the guidelines against mixing goto-based error handling
with scope-based cleanup helpers?

tty_register_device_attr() already uses explicit goto labels for error
cleanup:

err_del:
	device_del(dev);
err_put:
	put_device(dev);

Mixing these paradigms can create confusing ownership semantics and
increases the risk of resource leaks or double-free bugs during future
refactorings.

Could the function be completely converted to scope-based cleanup first,
or could this patch use traditional locking (mutex_lock/mutex_unlock)
instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926184154.3017=
929-1-nicoyip.dev@gmail.com?part=3D1
