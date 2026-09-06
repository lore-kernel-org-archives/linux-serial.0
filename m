Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4401437CD29
	for <linux-serial@vger.kernel.org>; Sun,  6 Sep 2026 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788711096; cv=none; b=vBmC0LxRwfT3z4ANgXH5BFaUUNIJjrWmgMFgb8lZWrLlgXCdwZwlWI1MmfMLmkhrKe8f1tShQqNxBEih+5Pt+mvHz+uGLhj2E6VCK4cV0o60Y0SmLi3AsjB5FR1bIFP3PBuSFHCO8nLD3atMtVynt4tRuprruzaWRXzeBoBsLHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788711096; c=relaxed/simple;
	bh=DnNsuYEBp12ISfydWjvulwyToNl4G07EnMfUXFNR0Eg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C3vtE6EnvjQ2KhvwroAAYQTzfqFZVA7xjOR3Wm4RFms5O+iSizHI1uUfnz1U7seCIw2DtMIqhTtuv0LuMbWIMfQqlilqZNmWl+3zLLw1W1TrMusmuAq2+7Vq+whJJBunf6X+RdCEh3O30OtkDXVv5Rviu2V+W7EnIu7zwZ4rldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a94y0pbM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a94y0pbM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EAA1F00A3A;
	Sun,  6 Sep 2026 16:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788711093;
	bh=QjDafJWeAv8MbGJoOZhJOonZQkamOrvLPQmwlp3Sn8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a94y0pbMURawC0XT2tXtUs0Gfl0PtUR2bmfjeMn1bPUHpdNP3G1fneBALuLQG3i3d
	 3HgpW/Qe1XfqXxocT/PZmzAMTz13/jYiBzpMOoQjoy6U+M3ajMXydVWcK1qR/TcikU
	 o9ZRjiokNG5C8JPhmYcLQM+jOckBtrTcnTXASB2zF+IjD1GtZfXifRLD5ljteX3+G8
	 R2oTR8sXxRQDg09001Rw8UERD/mu+QtK5CYzDjdGAeynzNI5Ou3gywJhi4o9WSNRz7
	 BNIE6Hse2zRfQipgDFisHZxJRMhXmpy9V36mQ+IIYqATHHyfoshx9KU/tOJeSQJF52
	 IcGoe4QCEgBOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] rust: serdev: Pause receive callback before calling
 unbind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20260906-rust_serdev_probe_refactor-v1-5-69cdae0074ec@posteo.de>
References: <20260906-rust_serdev_probe_refactor-v1-0-69cdae0074ec@posteo.de>
 <20260906-rust_serdev_probe_refactor-v1-5-69cdae0074ec@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 16:11:32 +0000
Message-Id: <20260906161132.C5EAA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing memory barrier between setting drvdata and resuming RX=
 allows concurrent NULL pointer dereference.
--

commit dde2ba583b3f14a65bfcd445c3ea93289575651c
Author: Markus Probst <markus.probst@posteo.de>

rust: serdev: Pause receive callback before calling unbind
   =20
The receive callback and unbind callback now have exclusive access to
the drivers private data. Provide mutable references in callbacks to
avoid the need for locks in the private data. Remove the Sync
requirement.

> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index 66543108ec2fa..7d47d91e3bc35 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs
[ ... ]
> @@ -200,10 +203,14 @@ extern "C" fn receive_buf_callback(
>          // INVARIANT: `sdev` is valid for the duration of `receive_buf_c=
allback()`.
>          let sdev =3D unsafe { &*sdev.cast::<Device<device::BoundInternal=
>>() };
> =20
> -        // SAFETY: `receive_buf_callback` is only ever called after a su=
ccessful call to
> -        // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
> -        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
> -        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<Pri=
vateData<'_, T>>() };
> +        // SAFETY:
> +        // - `receive_buf_callback` is only ever called after a successf=
ul call to `probe_callback`,
> +        //   hence it's guaranteed that `Device::set_drvdata()` has been=
 called and stored a
> +        //   `Pin<KBox<PrivateData<'_, T>>>`.
> +        // - `unbind_callback` calls `serdev_device_pause_rx` before acc=
essing the driver data,
> +        //   which guarantees that this function will not overlap with i=
t. Thus we have exclusive
> +        //   access.
> +        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow_mut::=
<PrivateData<'_, T>>() };

[Severity: Critical]
This is a pre-existing issue, but does this code allow a concurrent NULL po=
inter
dereference?

In probe_callback() in rust/kernel/serdev.rs, set_drvdata() writes the
driver data pointer to memory, followed by serdev_device_resume_rx() which
clears the SERPORT_PAUSE_RX flag using a relaxed clear_bit() operation:

    unsafe { bindings::serdev_device_resume_rx(sdev.as_raw()) };

On weakly ordered architectures like ARM64, the CPU can reorder the plain d=
ata
store to occur after the flag is cleared. A concurrent tty receive path
observing the cleared flag will enter receive_buf_callback() and read
dev->driver_data before the store propagates, obtaining a NULL pointer.

Calling drvdata_borrow_mut() on this NULL pointer creates a reference to NU=
LL,
triggering undefined behavior and a kernel panic. Can this be triggered
externally if the serial port receives data from an attached hardware device
during the narrow window of probe_callback()?

> =20
>          T::receive(sdev, private_data.driver_data(), buf)
>      }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-rust_serde=
v_probe_refactor-v1-0-69cdae0074ec@posteo.de?part=3D5
