Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E801717BED0
	for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 03:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787888251; cv=none; b=Sw5tlfHVTKXBkSnCjjUPaw6uc/ssP2SaHshpkV0pSwgExokU7geOh5TVh77RCoGHrjsG0oEkWhMSaigpDuB9Ut4fDZzO2NCYebPe7aO+vcx9eSHUFsOi9BvlGqUldF4nSB2KPuiNP2Zfi6Gn0k0ZiDckZ4bbwqsA4yZHALwsxtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787888251; c=relaxed/simple;
	bh=V3ufYqnTTxThZ7rBz/BRVdqjSOYh0iYIjXGIy/aSzfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BxSsTNPtpHUtd6Cm1j/qVchCBviqwbpFVnPX4I2xHGAquCKmAgoBQdyNpKS9+LwAKbE32lvBeLnC4WZIteBP2ksCuzhZ2v+VBdUG6pee3O7cEn0zY7fxhBFwkVAVjYDKHzsBq4t0ZQZv+2Nffkis8nzlC+ry25AGJp+bsyonKf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOJZiIpB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOJZiIpB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499ED1F000E9;
	Fri, 28 Aug 2026 03:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787888249;
	bh=x2M3+sVfSepX+U/6enE9cEq0cwNeeuusM12aaZF4X8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UOJZiIpByzUoo6qk3YPMwn44xOIinqlIZwg/Q1DYvKDKE3/IuN5ptRHToh44LhWBX
	 eCwbow8S/iu/PvHGmuB+hdZMcVAzfZIZPeMe9GPxw7ErNvZg8LXBwSpGnKWFxqWhvn
	 KKx7LDPcjyQyT/DtxHnY8mIjIDI/C++6SxW3kH+nLjBpE0M70UZWMXurLBXxVY89sf
	 Tj9ZOA/nn6gu6pPOD1ByHgA+0ST9/Z9oTd5V23vz+yUx/PYHoq4GrL3JvNw0mo2umL
	 DHcrCurvGlNREci5pImWScjS/hJHQ8gmUVNNOylXuSVsYzC/ydypgPcHQ2qesiMt2+
	 BfbsIRV44nPlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: n_gsm: pin DLCI during configuration ioctls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qing Ming" <a0yami@mailbox.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260828031949.18580-1-a0yami@mailbox.org>
References: <20260828031949.18580-1-a0yami@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 03:37:28 +0000
Message-Id: <20260828033729.499ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The patch introduces a Use-After-Free and refcount underflow b=
ecause dlci_put() is called outside of gsm->mutex, and gsm_dlci_get_or_allo=
c() fails to check if the acquired reference is valid.
--

commit 705962eabdbe5c697544b69418bcb84720186a19
Author: Qing Ming <a0yami@mailbox.org>

tty: n_gsm: pin DLCI during configuration ioctls

This patch addresses a lifetime issue in the N_GSM line discipline by
attempting to acquire a DLCI reference during configuration ioctls. It adds
gsm_dlci_get_or_alloc() to retrieve or allocate a DLCI and pin it using
dlci_get() before releasing gsm->mutex, then unpins it with dlci_put() after
use.

> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index c13e050de83b1..605549d742e6a 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2711,6 +2711,22 @@ static inline void dlci_put(struct gsm_dlci *dlci)
>  	tty_port_put(&dlci->port);
>  }
> =20
> +static struct gsm_dlci *gsm_dlci_get_or_alloc(struct gsm_mux *gsm,
> +					      unsigned int addr)
> +{
> +	struct gsm_dlci *dlci;
> +
> +	mutex_lock(&gsm->mutex);
> +	dlci =3D gsm->dlci[addr];
> +	if (!dlci)
> +		dlci =3D gsm_dlci_alloc(gsm, addr);
> +	if (dlci)
> +		dlci_get(dlci);

[Severity: Critical]
Does this code silently ignore reference acquisition failures?

When looking at dlci_get(), it wraps tty_port_get() but discards its return
value:

static inline void dlci_get(struct gsm_dlci *dlci)
{
	tty_port_get(&dlci->port);
}

Since tty_port_get() uses kref_get_unless_zero(), it can fail to increment
the refcount if it is already zero.

Because dlci_get() returns void, gsm_dlci_get_or_alloc() cannot check if
the underlying tty_port_get() failed, which might result in returning a
dying object to the caller.

> +	mutex_unlock(&gsm->mutex);
> +
> +	return dlci;
> +}
> +
[ ... ]
> @@ -3862,29 +3878,29 @@ static int gsmld_ioctl(struct tty_struct *tty, un=
signed int cmd,
>  		if (dc.channel =3D=3D 0 || dc.channel >=3D NUM_DLCI)
>  			return -EINVAL;
>  		addr =3D array_index_nospec(dc.channel, NUM_DLCI);
> -		dlci =3D gsm->dlci[addr];
> -		if (!dlci) {
> -			dlci =3D gsm_dlci_alloc(gsm, addr);
> -			if (!dlci)
> -				return -ENOMEM;
> -		}
> +		dlci =3D gsm_dlci_get_or_alloc(gsm, addr);
> +		if (!dlci)
> +			return -ENOMEM;
>  		gsm_dlci_copy_config_values(dlci, &dc);
> +		dlci_put(dlci);

[Severity: Critical]
Is it safe to drop this transient reference outside of gsm->mutex?

If a concurrent GSMIOC_SETCONF or gsm_cleanup_mux() drops the mux's base
reference, this dlci_put() could drop the final reference and trigger the
destructor gsm_dlci_free().

The destructor gsm_dlci_free() runs unprotected by gsm->mutex and eventually
clears the array pointer without synchronization:

static void gsm_dlci_free(struct tty_port *port)
{
	...
	dlci->gsm->dlci[dlci->addr] =3D NULL;
	...
}

Concurrently, a new ioctl could call gsm_dlci_get_or_alloc(), acquire
gsm->mutex, and observe the non-NULL stale pointer before it is cleared.

It would then call dlci_get(), which fails to increment the zero refcount,
returning a dying DLCI to the caller. The caller would then use the freed
object and subsequently call dlci_put(), triggering a kref underflow.

>  		if (copy_to_user((void __user *)arg, &dc, sizeof(dc)))
>  			return -EFAULT;
>  		return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828031949.1858=
0-1-a0yami@mailbox.org?part=3D1
