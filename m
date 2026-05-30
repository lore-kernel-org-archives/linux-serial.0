Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4593225775;
	Sat, 30 May 2026 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780146620; cv=none; b=moy4oLamtcNhM7eXCo828KJ2WaH6ZsE1vbVNv2fl+scPAZfUzgg2ts601j2LW+w2McRyTdcC6mdQhBnXYu4LIxP7vGf0i3hUl758RkzXu8zjpJZ1WspYYQfWZs0CMnS5wnro3e0yLQNjEk2Rc3iVHMXvxdW8lwiQM5DaRKXCwYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780146620; c=relaxed/simple;
	bh=OIuD491KSCisdQ+EcRYI437BYyKWTPj5CxFAnaB7bZY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=KYoRIWBmkGzawZUy1G1ABMvWyY49Mt3FSxv22W4Ag32JA4d+6r4JUAwJ3ncc1y+3Pr1WGMJ6z9Srke5F7doxrGZQurLeluC6EL1Q1sXdUu3obJ+zaw6DCQC7DHZ/bBAAZDCJonNcr93H83CqYUexO9vR5TQr1WGFsh5ENOLnmzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqKO9Mn+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqKO9Mn+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9561F00893;
	Sat, 30 May 2026 13:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780146619;
	bh=SP7i8xqzkSDvXySCs/V8aUcE/te0zaQ5nqg1gqmhcYs=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=WqKO9Mn+jBrEQH8HU/rNoVnKflCAf0//gRzZKcK+/cvEPWRUrvd8X0FvR/SdDhTWD
	 1nNUsw57f+9Ku34CnFZr8S2ycOOqBly6cmDP+ht4kfqZaJWNI2EBmWNLQ1rSisiAjX
	 StZ9IVBargDknO6BRXkgPihh3suhtwqKcJ76GZoJpS7Ek5rQ22zthHICd3WBLl1F9b
	 Zrmg7PdmBSWG8+2WaG/v2nwRpzM0D7wUdITPwiJJlvyJpIpQ5Ihc5rr/i4MNaokRsH
	 6DUzKZ/m5E4C0Oi+wZpRih3aZLiFshHihMLRVgGx1/a7A2/6pURbTlX7Kp/FmyuDA+
	 k+39FPBFDME6Q==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 May 2026 15:10:13 +0200
Message-Id: <DIW1B4FUIXO7.28GSUA0CEA4EV@kernel.org>
To: "Markus Probst via B4 Relay"
 <devnull+markus.probst.posteo.de@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v8 3/5] rust: add basic serial device bus abstractions
Cc: <markus.probst@posteo.de>, "Rob Herring" <robh@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jiri Slaby"
 <jirislaby@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Kari Argillander"
 <kari.argillander@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Boqun Feng" <boqun@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
References: <20260530-rust_serdev-v8-0-2a95f1da22a7@posteo.de>
 <20260530-rust_serdev-v8-3-2a95f1da22a7@posteo.de>
In-Reply-To: <20260530-rust_serdev-v8-3-2a95f1da22a7@posteo.de>

On Sat May 30, 2026 at 3:13 AM CEST, Markus Probst via B4 Relay wrote:
> +    extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> =
kernel::ffi::c_int {
> +        // SAFETY: The serial device bus only ever calls the probe callb=
ack with a valid pointer to
> +        // a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `probe_callbac=
k()`.
> +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInternal<=
'_>>>() };
> +        let info =3D <Self as driver::Adapter>::id_info(sdev.as_ref());
> +
> +        from_result(|| {
> +            let private_data =3D devres::register(
> +                sdev.as_ref(),
> +                try_pin_init!(PrivateData {
> +                    probe_complete <- Completion::new(),
> +                    error: false.into(),
> +                }),
> +                GFP_KERNEL,
> +            )?;
> +
> +            // SAFETY: `sdev.as_raw()` is guaranteed to be a valid point=
er to `serdev_device`.
> +            unsafe {
> +                (*sdev.as_raw()).rust_private_data =3D
> +                    (&raw const *private_data).cast::<c_void>().cast_mut=
()
> +            };
> +
> +            // SAFETY: `sdev.as_raw()` is guaranteed to be a valid point=
er to `serdev_device`.
> +            unsafe { bindings::serdev_device_set_client_ops(sdev.as_raw(=
), Self::OPS) };
> +
> +            // SAFETY: The serial device bus only ever calls the probe c=
allback with a valid pointer
> +            // to a `serdev_device`.
> +            to_result(unsafe {
> +                bindings::devm_serdev_device_open(sdev.as_ref().as_raw()=
, sdev.as_raw())
> +            })?;

The bus device private data drops before devres callbacks run, thus you can=
't
use the devm helper here. I suggest to use serdev_device_open() and call
serdev_device_close() from remove_callback() instead.

You may also want to consider whether you potentially want T::unbind() to a=
llow
to have concurrent transmits in flight regardless. IOW, you may want to cal=
l
serdev_device_close() before T::unbind() anyway.

> +
> +            let data =3D T::probe(sdev, info);
> +            let result =3D sdev.as_ref().set_drvdata(data);
> +
> +            // SAFETY: We have exclusive access to `private_data.error`.
> +            unsafe { *private_data.error.get() =3D result.is_err() };
> +
> +            private_data.probe_complete.complete_all();
> +
> +            result.map(|()| 0)
> +        })
> +    }
> +
> +    extern "C" fn remove_callback(sdev: *mut bindings::serdev_device) {
> +        // SAFETY: The serial device bus only ever calls the remove call=
back with a valid pointer
> +        // to a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `remove_callba=
ck()`.
> +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInternal<=
'_>>>() };
> +
> +        // SAFETY: `remove_callback` is only ever called after a success=
ful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
> +        // and stored a `Pin<KBox<T::Data<'_>>>`.
> +        let data =3D unsafe { sdev.as_ref().drvdata_borrow::<T::Data<'_>=
>() };
> +
> +        T::unbind(sdev, data);
> +    }
> +
> +    extern "C" fn receive_buf_callback(
> +        sdev: *mut bindings::serdev_device,
> +        buf: *const u8,
> +        length: usize,
> +    ) -> usize {
> +        // SAFETY: The serial device bus only ever calls the receive buf=
 callback with a valid
> +        // pointer to a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `receive_buf_c=
allback()`.
> +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInternal<=
'_>>>() };

CoreInternal dereferences to Core, which is technically unsound within this
callback.

I think you want CoreInternal for drvdata_borrow(), so we should add a
BoundInternal type state for this; I will send a patch for this.

With this and the above fixed,

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

from the driver-core side of things.

> +        // SAFETY:
> +        // - The serial device bus only ever calls the receive buf callb=
ack with a valid pointer to
> +        //   a `struct serdev_device`.
> +        // - `receive_buf_callback` is only ever called after a successf=
ul call to
> +        //   `probe_callback`, hence it's guaranteed that `sdev.private_=
data` is a pointer
> +        //   to a valid `PrivateData`.
> +        let private_data =3D unsafe { &*(*sdev.as_raw()).rust_private_da=
ta.cast::<PrivateData>() };
> +
> +        private_data.probe_complete.wait_for_completion();
> +
> +        // SAFETY: No one has exclusive access to `private_data.error`.
> +        if unsafe { *private_data.error.get() } {
> +            return length;
> +        }
> +
> +        // SAFETY: `receive_buf_callback` is only ever called after a su=
ccessful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
> +        // and stored a `Pin<KBox<T::Data<'_>>>`.
> +        let data =3D unsafe { sdev.as_ref().drvdata_borrow::<T::Data<'_>=
>() };
> +
> +        // SAFETY: `buf` is guaranteed to be non-null and has the size o=
f `length`.
> +        let buf =3D unsafe { core::slice::from_raw_parts(buf, length) };
> +
> +        T::receive(sdev, data, buf)
> +    }
> +}
