Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF2233A014
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 01:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041171; cv=none; b=YBe6btFrFM9xo/OM0ULJk6h+moNryNQg49doL26YVRZ08/+gHjxed6CX1J+uoMrqoxB2/pe/Q6BZkjTnq3/N4bBdSwIzOJi3vvUCqIDHnjKl0TYM+/71HUY5QsrOF4NmbEPpsqekZAr+a5XPXWhnyCjReQplPtC5c3MW6F/M+7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041171; c=relaxed/simple;
	bh=9yZ8Zsg1niHqId0bztnBgF6teKqT31lKgb55x0sZFCQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gNgYTdf2HZyaRlVRf1SVbp3dNp0Ms7kzF2EVBY0NSDgMYKziiSJ7RcRsnkkuQF1dWAO0H1EKCtNIxMQUMuUFPhI/SlQHD5t5pafNp1l1xGapXLLUNtZhWzgrkNtAaltSef5T713j7PhXzKh8XkdGKhknNfO6QI5irE784f0bqmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJ+wOZcn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJ+wOZcn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DE51F000FF;
	Tue, 22 Sep 2026 01:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790041168;
	bh=NnIOHE/9jd1UK/McyGbn4ewMj8CS82rjU2dN/MMp7eY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hJ+wOZcnG2Bp1GDodeg0v6L5X+DCUph9v6mPrJBOKDRPcq+cy3jN1rf+2YsEp/lVU
	 MNXYO7ECMoCTvQLRfmRQdRJ6qV5bjpCLs5oS+ilMJygKjKuSl4bHH+UDCjl3grioZz
	 ZTc2bLVrgRn84cSG6ByH3S1s3FwF0bevTDxW0vkwthJCPlK+G1wHFGDHm8cRiLRPaE
	 XC9v09L4l6koRpczx7QWQm6qpgYn8g7jJy3bRfVy4QLFlvrt5kcj1nAI/m4nen2eMK
	 v5Hd6HYd1C0pMYshQAOvap3SqCZ56xj24+YHLSWVorwn0SgEdrQgYYPkM4Z98LKcSB
	 mVpGN0E6Ujp6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] vt: keyboard: publish npadch_value with release
 semantics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaidev Shastri" <jaidevshastri@vt.edu>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260921-mb-keyboard-v1-2-d170228b80c0@vt.edu>
References: <20260921-mb-keyboard-v1-0-d170228b80c0@vt.edu>
 <20260921-mb-keyboard-v1-2-d170228b80c0@vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 01:39:28 +0000
Message-Id: <20260922013928.71DE51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] vt: redundant memory barriers on npadch_value under spinlock
- [Low] vt: broken lockless pattern with inverted flag/payload release
--

commit e52bca2cdc7445b0c1faf7ccdceda38d504afc27
Author: Jaidev Shastri <jaidevshastri@vt.edu>

vt: keyboard: publish npadch_value with release semantics
   =20
k_ascii() accumulates the numeric keypad code in npadch_value after it
has set npadch_active. k_shift() tests npadch_active and then emits
npadch_value when the modifier is released. Store the accumulated value
with smp_store_release() and read it with smp_load_acquire().

> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index 089f3b048beee..6f3472cd4f24d 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -898,10 +898,13 @@ static void k_shift(struct vc_data *vc, unsigned ch=
ar value, char up_flag)
> =20
>  	/* kludge */
>  	if (up_flag && shift_state !=3D old_state && npadch_active) {
> +		/* Pairs with the smp_store_release() in k_ascii(). */
> +		unsigned int npadch =3D smp_load_acquire(&npadch_value);
> +

[Severity: Medium]
Are these memory barriers redundant?

All invocations of k_shift() and k_ascii() occur under the kbd_event_lock.
They are only dispatched via kbd_keycode(), which strictly executes within a
scoped_guard(spinlock, &kbd_event_lock) in kbd_event().

Because all accesses to npadch_value and npadch_active are serialized by
this lock, concurrent execution is not possible here. The static analysis
tool appears to have missed this locking context.

>  		if (kbd->kbdmode =3D=3D VC_UNICODE)
> -			to_utf8(vc, npadch_value);
> +			to_utf8(vc, npadch);
>  		else
> -			put_queue(vc, npadch_value & 0xff);
> +			put_queue(vc, npadch & 0xff);
>  		npadch_active =3D false;
>  	}
>  }
> @@ -939,7 +942,8 @@ static void k_ascii(struct vc_data *vc, unsigned char=
 value, char up_flag)
>  		npadch_active =3D true;
>  	}
> =20
> -	npadch_value =3D npadch_value * base + value;
> +	/* Pairs with the smp_load_acquire() in k_shift(). */
> +	smp_store_release(&npadch_value, npadch_value * base + value);

[Severity: Low]
Does this inverted lockless pattern fail to provide the intended guarantees?

Even if concurrent execution were possible, the release and acquire
semantics are applied to the data payload (npadch_value) rather than the
condition flag (npadch_active).

Here, the producer updates npadch_active with a plain store before executing
a release store on npadch_value. This allows the condition flag to become
visible prematurely.

In a correct lockless pattern, the producer updates the payload first and
then executes a release store on the condition flag. The consumer would then
execute an acquire load on the flag before reading the payload.


While reviewing this file, I noticed a pre-existing issue nearby in k_shift=
():

drivers/tty/vt/keyboard.c:k_shift() {
    ...
	/* Pairs with the smp_load_acquire() in vt_get_shift_state(). */
	smp_store_release(&shift_state, state);
    ...
}

[Severity: Low]
This is a pre-existing issue, but is the use of release/acquire barriers
invalid for this standalone read?

The shift_state variable is a standalone integer and does not act as a
condition flag to synchronize dependent memory accesses. Applying heavyweig=
ht
memory barriers here adds unnecessary complexity and overhead on
architectures where barriers are not free.

The reader vt_get_shift_state() merely returns the shift_state value to
userspace without taking kbd_event_lock:

drivers/tty/vt/keyboard.c:vt_get_shift_state() {
    ...
	return smp_load_acquire(&shift_state);
    ...
}

To safely perform a lockless read of a standalone variable and mitigate
compiler tearing, READ_ONCE() and WRITE_ONCE() would be the correct and
sufficient primitives.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-mb-keyboar=
d-v1-0-d170228b80c0@vt.edu?part=3D2
