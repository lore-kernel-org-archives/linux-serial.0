Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CEA39EF1C
	for <linux-serial@vger.kernel.org>; Sun, 10 May 2026 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778431420; cv=pass; b=Y8fIkD9oXC214pj6g7G1THCDkfDvd9ekIxjg1LfRBHDT+DyLVaruJ5xkrgrLDbVjh/j/WcTMlDqrUfzLd1U5N1p8q9ihqt1nu6iv0SfttRzuPgUdAZOeAAoa3PxSHWH94I+nKN6zA8dezLJLFJfamkwr/96AQ9r9tzu0DxgM+A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778431420; c=relaxed/simple;
	bh=fmoIy7ly3Uuw0EYJ/qsL+ocukvGJU8ByLX1KE1ImXuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZV78qbQRjrg5k8qtYo/fnphQZ3b3WwPpNw29DiFvJxljI44HXH43EBphVDvi6fzdvvZPLQqaH+3VYP7Q4PKfmmGKaWnQPJvRoP8KwmV/z3tMac3MJhp+q2UKyQwxY2VsV5hDPPDxyaJtezfmYzuo3NW02WUXz782t4vOZiBe4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCWi23FC; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCWi23FC"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7bb0d18c7f9so32312547b3.0
        for <linux-serial@vger.kernel.org>; Sun, 10 May 2026 09:43:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778431418; cv=none;
        d=google.com; s=arc-20240605;
        b=g6Kdlk2tviWarvk30BUvAAhYMAkCAWK7I6T5y8fdoU4ig+0b+jGucSmm002dsp9XJO
         GVUN7PqrfL2qPONgx+uQGLoKbcCM6ZOxVBOzPiD1vb5MfUQoqrM46N4RdkZkYIM1cnt/
         vmQ9dmTEP2dW6016i2aFLH6zNqbrW0QF6GLDnTqw/rR/83UsNv0Kep5cSoXGSbQf2S6U
         Tl/GRCMGIRQTtQcYzqNRvvf/uVOTwa3Xoajw2+26kYyozjyXKhZZfLe/JSVDkGA/VjSD
         jkVxcpm9v1DPK8w/RqD8Z5wTocEYAJ10Pfzm9lZA/Q0kj+gSvSEPxFDRh/+f2R+INXlE
         0Osw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+i/oN2tVHdUz35XHSRaGXjkB2nkgYzjZUJsPTeZ5r0w=;
        fh=bT+v6dN9SOXIpLQiMHZeb6DfMV12YZbn8X4F2WjHEp4=;
        b=XswxzVgDhft65AE45TnNkVGkfEx7XZPuvUh4Bndz4ROQQ7PvIfGt0ayze9AIDvJo4N
         xmIT5IprdDi7brPiFahCxdt3igS/sQy/I6EzmaIXsaBVQupYsWTD7A58ktIazKMluHtT
         swNo7T0OGm6mUSw+Ts69vZYQroXFbwfEiyDfajvsfyrxw9BeHny1KB0hIYr1xlJcWmhw
         TsLtu2zsIFfvVIv2IiOKRixJXxw43RxdTtoyHqiBQhJtbgMsXOQdqhL1mDb6z2N6werP
         CNjp/uqQEJUvpaA1vNWGX+Wjvy7T8eKnRideHErx3yOoj1ROI/B4yZUUVSNgpdlIKS9Z
         qjBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778431418; x=1779036218; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+i/oN2tVHdUz35XHSRaGXjkB2nkgYzjZUJsPTeZ5r0w=;
        b=FCWi23FCmk5DA2eHhRoxqN1rKLpqf2iHZvx28Sif4b0SWFkR5BLbR1o2BUuo/GJI6g
         HaEX+Vvl4a3i7w4Ftmb2TWyK7pCUACej876E2euE1H2dyYDwC6kmCKRfn6cgJhBClL+W
         n8l+cEwg5Fmg6POMnu9h8PaxtSbOB8uPGQgq1ptZVrkebCBPCPGr2Bc1NkC/9vOJztEF
         RZSIFmjJWtVhZzhQOwW3Xbev8x08QsjC4WgnPje4SMuWj6GR+6NU8v04lZ2H8TBDZNTI
         XjNtE6TzfFbENbCRehlSIDBwoYstKyfrt6WO3oWxRHDMpKDTGzfQP1RMgEIVmN09MAzb
         Bnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778431418; x=1779036218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+i/oN2tVHdUz35XHSRaGXjkB2nkgYzjZUJsPTeZ5r0w=;
        b=dc7CdzUm23mgCB/rzwaKJa6niiRs3QEiBsASZYxT++fuL413dOhYQ2dP6E9E0KQ6bm
         KbDGqLE/sJTVUxhxyxlMpP07QiuQo7P1uYNCrTPIkxRj+VF6Mk4oHjSDU8cyO9ZX2XDh
         sHbrnjBU19d38MID3rnkar//Amrk5fzNdinKVqgqUTZjcDXNcIcGl5DEyMdh9USVqT62
         LfHKuw0TJSJ7mtJObRy/G8l7oIgk7gQ9ttsXdnAFxtfDHXjx9SDxTHpvXBDEWmOAdt/H
         UkQULxZyOZOd4lj0cRQmsbpFqc575VSGh/07IEILghhPdPlV5GOMzdIHqyJQgwvLoVjX
         TB9A==
X-Forwarded-Encrypted: i=1; AFNElJ8De5duFL5apJFHJOgkbaGs7pZmsKLYTECqDb8CA9lnL4bR+g94IUcbRbcv62+lyLrzjxMoP7I9JR+SBXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzSyociSzW6nEm5e9E5tjwGmfMO4mAsaQ0eWjt/c/5fTKjKOOH
	WBJ1VBpNfDE4ES60ZA/ts7BhXcc8xDHkKXajlaMJWXx9WYSGOE1UEnkEZaQD5wwTpwoJhi9jWrd
	N/5mCsDx2nL6IxQo5SgiOd4xtO+RwZT4=
X-Gm-Gg: Acq92OGroXleJTsXrOenyetK5o1D/yUtjjmAUFoRwtDk2BrCUe27KjSuisCpIoZxBH8
	k7vkXLlptfi8nBfCAfnhLkycqa6vt+4qU5Im/+OYCEWrMfaBIPuTUD+eRPJgPmV4Ea9hpmOH84X
	exbA9Zlki31RcVTiwcOMBGr+kSA+G6zUcpghAMubtHFJkq9JOS70v1yZomNqmTxxTokJrBIYkb1
	bAWACoLaBo+prGEeAWPp1Shv4b/zlUMo7iXnhScnPzB5vLcZg+YRbjfhUN5hNuXMHplDKHm5T9F
	853CNoiHVpfw3O6MZ/A=
X-Received: by 2002:a05:690c:4b91:b0:79a:cc18:19c6 with SMTP id
 00721157ae682-7bdf5eb86b0mr219541917b3.34.1778431418400; Sun, 10 May 2026
 09:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510031348.1922157-1-zzzccc427@gmail.com> <2026051001-peso-enamel-2e62@gregkh>
In-Reply-To: <2026051001-peso-enamel-2e62@gregkh>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 11 May 2026 00:43:26 +0800
X-Gm-Features: AVHnY4JiGwab_Bt4UdeCK3fQre15z76RNavbHH_NL3-PtHZtxLAXVJGIUii9yow
Message-ID: <CAFRLqsUeat=rUj7aCSAku=A9NBNj3Wxd+xi8xzzBtRWqCxp18Q@mail.gmail.com>
Subject: Re: [PATCH] vt: keyboard: serialize KDGETLED with keyboard_tasklet
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

> On Sun, May 10, 2026 at 06:22:xxPM +0200, Greg KH wrote:

> Why is that an issue?

Thanks, that's a fair point. The issue I was trying to describe is not
that KDGETLED can race with a normal LED state transition and return
either the old or the new value. That part is just the usual snapshot
semantics, and the value can of course change immediately after the ioctl
returns.

The specific case I was concerned about is the VT-switch force-update
path. vt_set_leds_compute_shiftstate() sets vt_switch and schedules
keyboard_tasklet, and then kbd_bh() does:

    if (vt_switch) {
            ledstate = ~leds;
            vt_switch = false;
    }

    if (leds != ledstate) {
            kbd_propagate_led_state(ledstate, leds);
            ledstate = leds;
    }

That first assignment is only an internal old-state sentinel to force LED
propagation when switching VTs. It is not a committed LED state intended
to be returned to userspace. Since KDGETLED currently returns
ledstate & 0xff without quiescing the tasklet, it can expose that
temporary complemented value. For example, if the real LED state is
LED_NUM only, a read in that window can return the complemented low byte
instead of 0x02.

> stable for "what" exactly? This is a snapshot in time, be it before or
> after it changes is not always going to really matter here, as it can
> change right after you "enable" the tasklet, right?

Yes, I agree. "stable snapshot" was too broad a description.

By "stable" I only meant "not while kbd_bh() is in the middle of using
that internal force-update value". tasklet_disable() would make KDGETLED
observe either the old value before the tasklet runs, or the committed
value after it finishes. It does not make the value stable after
tasklet_enable(), and the changelog should not imply that.

This is a small userspace-visible consistency issue, not a memory-safety
problem. If this behavior is considered acceptable for KDGETLED, I can
drop the patch; otherwise I can send a v2 with a narrower changelog.

Best regards,
Cen
