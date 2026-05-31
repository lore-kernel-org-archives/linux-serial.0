Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445002DC357
	for <linux-serial@vger.kernel.org>; Sun, 31 May 2026 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780210735; cv=none; b=kdHQ0fNzG5V2+ThAqFypbuNTpyWrU7Bx15q6qAILGybxd+pRgVUu9JA/FFaV4HH8AoajalYBDH6rwy7Sk289jTjCdBJlzKRNpii1ga/iw7ZCdc/aCQ37O9FRJFAaW3MY6gUqnOtl1Xnc72c4pZnCjrVoRdnWr5/GuNyCK2CFotQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780210735; c=relaxed/simple;
	bh=xutHP44hJcIDCGcIELGlCWuxjlQ1wFNS9DJ9kd6fNzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ByjpTzLdArpj/cMc8oBaXOrEd0g/tyvJuHr4YB+NJ6ffECDUWmvqwuQOz2R/Z6pMke8fEVq+wxZZHyeW4IvJspiPHgK8IgrVK7qTZ+uJ//L4fyBB3ckOve5iLa4wsR/23hCbsCN0NfNUryDzEYTbV79/Dy5ikeKJrnLSO499hjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=SoY3+pbW; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="SoY3+pbW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780210728; x=1780469928;
	bh=1zuTcz9lsZ3dSxS9JH0d/vr7IOtYnrFPsiw5PML6+Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SoY3+pbWoI8cC0zQAyDnyHRMxRceGzV9QkNEA442WHcQgE1DVT1H+X6fDltDwnCsM
	 5EULxZMeC5BgKlr7dqiU3qXao9xTPr3MkSZncNgHbLk5VIAwpvDIwy0tEtC0Cjqmb3
	 V1ZF8uWBx4py0dU3Uck8Ks+Njf1NFCH/wkGO67ZP2a9K9WNJDfTGubiawgZbualuyl
	 4evv8n2fpnwr+WTPwO8rf71+CKAlmbgDA6kzBaUyXdSWVuWqJIlxuWPwkk8TIpmJbp
	 HTQewyvcuyf38XcT5ehTYSUJ5LKEaU3eNd1WN8nmO2vYtywEpjm94ZH0PLKozYqgmw
	 KQlROHlxlU5EA==
X-Pm-Submission-Id: 4gSnxb0tjHz1DDKv
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Markus Probst via B4 Relay <devnull+markus.probst.posteo.de@kernel.org>,
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
Date: Sun, 31 May 2026 09:58:34 +0300
Message-ID: <20260531065838.7352-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <DIWEXUCNLURG.136XXDBHSBNVR@kernel.org>
References: <20260531-rust_serdev-v11-0-dee8e0d830f1@posteo.de> <20260531-rust_serdev-v11-1-dee8e0d830f1@posteo.de> <DIWEXUCNLURG.136XXDBHSBNVR@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 31 May 2026 01:51:08 +0200=0D
Danilo Krummrich <dakr@kernel.org> wrote:=0D
=0D
> On Sun May 31, 2026 at 12:51 AM CEST, Markus Probst via B4 Relay wrote:=0D
> > +#[pinned_drop]=0D
> > +impl<T: Driver> PinnedDrop for PrivateData<'_, T> {=0D
> > +    fn drop(self: Pin<&mut Self>) {=0D
> > +        let mut active =3D self.active.lock();=0D
> > +        if *active {=0D
> > +            // SAFETY:=0D
> > +            // - We have exclusive access to `self.driver`.=0D
> > +            // - `self.driver` is guaranteed to be initialized.=0D
> > +            unsafe { (*self.driver.get()).assume_init_drop() };=0D
> > +            *active =3D false;=0D
> > +        }=0D
> > +=0D
> > +        // SAFETY: We have exclusive access to `self.open`.=0D
> > +        if unsafe { *self.open.get() } {=0D
> > +            // SAFETY: `self.sdev.as_raw()` is guaranteed to be a poin=
ter to a valid=0D
> > +            // `struct serdev_device`.=0D
> > +            unsafe { bindings::serdev_device_close(self.sdev.as_raw())=
 };=0D
> > +        }=0D
> > +    }=0D
> > +}=0D
> =0D
> Just in case it came across otherwise, I did not mean to push for you to =
go for=0D
> this approach. We just kept discussing it because it let to the (to me mo=
re=0D
> interesting) discussion around the LED class device abstraction.=0D
> =0D
> While this approach gets us rid of an extra allocation and the rust_priva=
te_data=0D
> pointer in struct serdev_device it also turns out a bit more convoluted.=
=0D
> =0D
> That said, both are correct, and I won't object either one; up to you and=
 the=0D
> serdev / tty maintainers.=0D
> =0D
> Please wait a bit before resending, so other people can comment on this a=
s well.=0D
> =0D
> > +    extern "C" fn receive_buf_callback(=0D
> > +        sdev: *mut bindings::serdev_device,=0D
> > +        buf: *const u8,=0D
> > +        length: usize,=0D
> > +    ) -> usize {=0D
> > +        // SAFETY: The serial device bus only ever calls the receive b=
uf callback with a valid=0D
> > +        // pointer to a `struct serdev_device`.=0D
> > +        //=0D
> > +        // INVARIANT: `sdev` is valid for the duration of `receive_buf=
_callback()`.=0D
> > +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInterna=
l<'_>>>() };=0D
> =0D
> CoreInternal snuck back in, should be BoundInternal.=0D
> =0D
> > +=0D
> > +        // SAFETY: `receive_buf_callback` is only ever called after a =
successful call to=0D
> > +        // `probe_callback`, hence it's guaranteed that `Device::set_d=
rvdata()` has been called=0D
> > +        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.=0D
> > +        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<P=
rivateData<'_, T>>() };=0D
> > +        let active =3D private_data.active.lock();=0D
> =0D
> I think SRCU would be a much better fit, but the code didn't land yet, so=
 the=0D
> mutex seems fine for now. But I'd probably add a TODO.=0D
> =0D
=0D
Jfyi v9 is on the list [1] and I would say we are pretty close on taking th=
at.=0D
=0D
Thanks,=0D
Onur=0D
=0D
[1]: https://lore.kernel.org/rust-for-linux/DIWEXUCNLURG.136XXDBHSBNVR@kern=
el.org=0D
=0D
> > +=0D
> > +        if !*active {=0D
> > +            return length;=0D
> > +        }=0D
> > +=0D
> > +        // SAFETY: No one has exclusive access to `private_data.driver=
`.=0D
> > +        let data =3D unsafe { &*private_data.driver.get() };=0D
> > +        // SAFETY:=0D
> > +        // - `private_data.driver` is pinned.=0D
> > +        // - `receive_buf_callback` is only ever called after a succes=
sful call to `probe_callback`,=0D
> > +        //   hence it's guaranteed that `private_data.driver` was init=
ialized.=0D
> > +        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_in=
it_ref()) };=0D
> > +=0D
> > +        // SAFETY: `buf` is guaranteed to be non-null and has the size=
 of `length`.=0D
> > +        let buf =3D unsafe { core::slice::from_raw_parts(buf, length) =
};=0D
> > +=0D
> > +        T::receive(sdev, data_pinned, buf)=0D
> > +    }=0D
> > +}=0D
