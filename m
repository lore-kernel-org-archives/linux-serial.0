Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301991DDC33;
	Sun, 31 May 2026 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780210904; cv=none; b=m3k0oObHLpYVm58dGrEEo5D7N56L8cK2qXZ+JKvhb4XZPUQt6+zDidCLa3DZ2l9XMMm4ZgNsWHjVVEMUDeG8ZqeqWSgQIea2ZFFXFpZ+InRaxEMczG8lr3WLHnIsw52uQS8c2jab9ouRLgCUGVkrAG3XSyv36F+aZI7q3GC6uAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780210904; c=relaxed/simple;
	bh=Qwtl7TctBiECnaqJS7rXbdYdDWZ8a1Vlb+t+lsxDqBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcSZO5VbQbeTEeus+GsmrtIBVaEGyo2au2h34wCzwHZ2fQ0P3GNOUUdQqm6Ss/cYrjv1MhJjuIXjXB7adfxAcCqcN2xuZC1ketXJEzRfPpMmyVj7ZJaq5DXFEzeRh3XxuBJIuTcsKLiTORmgYmE68WJlNeynrsF0fDh19OJvSwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=g7VckALZ; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="g7VckALZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780210899; x=1780470099;
	bh=rRQS1MJp4S0193hCQQAqVm3auiTkQtjPuQ4wbXu26iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=g7VckALZ+lCaFO5OpPyQVMrKxbjtGsDsRkZkaSJcnXEvHkeqwOgKyq9sZ8tiqmor1
	 IkHQGZ0tkAEK7gmfOOjwCC1yRsmNAQIz+G9qE7p/6St15/ECOTOkh9gOpMCe8LGXAw
	 shm7K68wbdYv7qDVjs4cixPaY9m5ZpsvLcgjW2V4YDUbvEJ3bW4P4D6qyqyPCjPA/t
	 OsAAkH7609kL6Mr/nEYZTqfUa0ES81DbfthzqRP063/31wVOMXdulgD//0q+QXqpW+
	 RbMkm6SG+XtRt1QrFC+wxXnIbYKZypvECHqXWkwvwsOtME0ZXN5xrZmzwmV/wCeZ5r
	 lSJx8qnH7L+qw==
X-Pm-Submission-Id: 4gSp0t24nCz2ScPV
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Markus Probst via B4 Relay <devnull+markus.probst.posteo.de@kernel.org>,
	markus.probst@posteo.de,
	Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Kari Argillander <kari.argillander@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Boqun Feng <boqun@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v11 1/3] rust: add basic serial device bus abstractions
Date: Sun, 31 May 2026 10:01:31 +0300
Message-ID: <20260531070133.9405-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260531065838.7352-1-work@onurozkan.dev>
References: <20260531-rust_serdev-v11-0-dee8e0d830f1@posteo.de> <20260531-rust_serdev-v11-1-dee8e0d830f1@posteo.de> <DIWEXUCNLURG.136XXDBHSBNVR@kernel.org> <20260531065838.7352-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 31 May 2026 09:58:34 +0300=0D
Onur =C3=96zkan <work@onurozkan.dev> wrote:=0D
=0D
> On Sun, 31 May 2026 01:51:08 +0200=0D
> Danilo Krummrich <dakr@kernel.org> wrote:=0D
> =0D
> > On Sun May 31, 2026 at 12:51 AM CEST, Markus Probst via B4 Relay wrote:=
=0D
> > > +#[pinned_drop]=0D
> > > +impl<T: Driver> PinnedDrop for PrivateData<'_, T> {=0D
> > > +    fn drop(self: Pin<&mut Self>) {=0D
> > > +        let mut active =3D self.active.lock();=0D
> > > +        if *active {=0D
> > > +            // SAFETY:=0D
> > > +            // - We have exclusive access to `self.driver`.=0D
> > > +            // - `self.driver` is guaranteed to be initialized.=0D
> > > +            unsafe { (*self.driver.get()).assume_init_drop() };=0D
> > > +            *active =3D false;=0D
> > > +        }=0D
> > > +=0D
> > > +        // SAFETY: We have exclusive access to `self.open`.=0D
> > > +        if unsafe { *self.open.get() } {=0D
> > > +            // SAFETY: `self.sdev.as_raw()` is guaranteed to be a po=
inter to a valid=0D
> > > +            // `struct serdev_device`.=0D
> > > +            unsafe { bindings::serdev_device_close(self.sdev.as_raw(=
)) };=0D
> > > +        }=0D
> > > +    }=0D
> > > +}=0D
> > =0D
> > Just in case it came across otherwise, I did not mean to push for you t=
o go for=0D
> > this approach. We just kept discussing it because it let to the (to me =
more=0D
> > interesting) discussion around the LED class device abstraction.=0D
> > =0D
> > While this approach gets us rid of an extra allocation and the rust_pri=
vate_data=0D
> > pointer in struct serdev_device it also turns out a bit more convoluted=
.=0D
> > =0D
> > That said, both are correct, and I won't object either one; up to you a=
nd the=0D
> > serdev / tty maintainers.=0D
> > =0D
> > Please wait a bit before resending, so other people can comment on this=
 as well.=0D
> > =0D
> > > +    extern "C" fn receive_buf_callback(=0D
> > > +        sdev: *mut bindings::serdev_device,=0D
> > > +        buf: *const u8,=0D
> > > +        length: usize,=0D
> > > +    ) -> usize {=0D
> > > +        // SAFETY: The serial device bus only ever calls the receive=
 buf callback with a valid=0D
> > > +        // pointer to a `struct serdev_device`.=0D
> > > +        //=0D
> > > +        // INVARIANT: `sdev` is valid for the duration of `receive_b=
uf_callback()`.=0D
> > > +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInter=
nal<'_>>>() };=0D
> > =0D
> > CoreInternal snuck back in, should be BoundInternal.=0D
> > =0D
> > > +=0D
> > > +        // SAFETY: `receive_buf_callback` is only ever called after =
a successful call to=0D
> > > +        // `probe_callback`, hence it's guaranteed that `Device::set=
_drvdata()` has been called=0D
> > > +        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.=0D
> > > +        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::=
<PrivateData<'_, T>>() };=0D
> > > +        let active =3D private_data.active.lock();=0D
> > =0D
> > I think SRCU would be a much better fit, but the code didn't land yet, =
so the=0D
> > mutex seems fine for now. But I'd probably add a TODO.=0D
> > =0D
> =0D
> Jfyi v9 is on the list [1] and I would say we are pretty close on taking =
that.=0D
> =0D
> Thanks,=0D
> Onur=0D
> =0D
> [1]: https://lore.kernel.org/rust-for-linux/DIWEXUCNLURG.136XXDBHSBNVR@ke=
rnel.org=0D
> =0D
=0D
I pasted the wrong link, sorry.=0D
=0D
It should have been this instead:=0D
=0D
  https://lore.kernel.org/all/20260529134004.396743-1-work@onurozkan.dev=0D
=0D
> > > +=0D
> > > +        if !*active {=0D
> > > +            return length;=0D
> > > +        }=0D
> > > +=0D
> > > +        // SAFETY: No one has exclusive access to `private_data.driv=
er`.=0D
> > > +        let data =3D unsafe { &*private_data.driver.get() };=0D
> > > +        // SAFETY:=0D
> > > +        // - `private_data.driver` is pinned.=0D
> > > +        // - `receive_buf_callback` is only ever called after a succ=
essful call to `probe_callback`,=0D
> > > +        //   hence it's guaranteed that `private_data.driver` was in=
itialized.=0D
> > > +        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_=
init_ref()) };=0D
> > > +=0D
> > > +        // SAFETY: `buf` is guaranteed to be non-null and has the si=
ze of `length`.=0D
> > > +        let buf =3D unsafe { core::slice::from_raw_parts(buf, length=
) };=0D
> > > +=0D
> > > +        T::receive(sdev, data_pinned, buf)=0D
> > > +    }=0D
> > > +}=0D
