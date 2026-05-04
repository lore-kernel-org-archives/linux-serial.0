Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD8F2E040D
	for <linux-serial@vger.kernel.org>; Mon,  4 May 2026 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880836; cv=pass; b=AtOl3V4YiLlqzZK/gFDBkfPFfxSiIVjNcv1DUxBEMWn3EDYRFKauv6L9cSMQ6dJv2ELs2+KzwAX8+z3V6tgeZyAdcXEMHYUGRU9IRji97oypamSAL0O5q9NeGSOCS2uqSxT4nDTRAxLoJ9F3Zz2zwz+wUAlhgcM1pCocQdsh/WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880836; c=relaxed/simple;
	bh=eDUPmsrdZNOpF6OT2ox4k8heyI9iQnvdMKYl7eoqPp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R12KQ5Lv0GZLdoGtS8qa+9GwK3dQn8M85auodV1BD32PxhzvXwK5z9Btw2g6g3WqpLNpG6VLGiMtxr2ZQs1HsEYmaS2590cEGQDwoB44Xa0wCHFZajsG+Q+sOAWq26Jb3HjMXWo9Ka75yUwGfAm5vbQrKIKy41TLPEVlZzijJCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n4fWjtxc; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4fWjtxc"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79a535e7c00so42103487b3.3
        for <linux-serial@vger.kernel.org>; Mon, 04 May 2026 00:47:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777880834; cv=none;
        d=google.com; s=arc-20240605;
        b=ZD1yz9k8EOqLkTHCfiQ7//85EjWwL9QIiEt6sFXosuM0y7QfRONWXiFd0IAsIuBypf
         mIotm0jkd7OGUd2VdJ6+4/18OV/ZwUALtDoXUBx3CAXuNpUtLd3CrjRjbogNUHk/KKEj
         kqXM965TXKfe41hAi/vfxQU4WXgemNRIa0GZq9rskmUnjYJ1i6+ZLELou3emwFYYKG4U
         Grv/bnYnS4v++UgB9AHLbUiHKDgVF5ascgLXzcDpPFTFdggyPl7kezFHmBhQiF7ib0Q6
         o6YQxXG9X2gwDmQhzjEA+czh6XADBW/OswN/iSRRUEZrzA/UB8KkSuMWOPGg+jIOXCLC
         dwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=n398fXLJ0TKmiWx3C1U37KBXGxMoIooQ+xPjdDlULSI=;
        fh=60ksQCI9PIOeRLdc9mfhYjnpeucLbni/D5mW7dKvXfI=;
        b=iu1A8IKbdMgLLDQpBCZgQ5iZ/t85R8TCgZ0tXwDfYCMHD87q6jK/6liTRI6aYMfH91
         MklwWbAtDMnwYS+RxWn64J6x+hRAK7YhLUhFTrMbXzt9GnrXoKvz+K03LlPRtqkt2C3E
         ePCk6IjnaV/Hru3R9C5Z0NSkCjo5PR6Ly7rPpAxvPaQwnnUsqbr/1eEU8ZfHkhbQbANF
         pwhaNiIaUQlx4OuzIkE4IJelk3dVXMhgFaHw2mwuo2DILNq2cb9twtegQ5vNO0D07gwC
         jR0OPexUEEE4c0lTOLzO6mWt6LPy+BbEHw8YcibFg+rpGu17DTVDo5OAJKvdRPoVnX8+
         JrcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777880834; x=1778485634; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n398fXLJ0TKmiWx3C1U37KBXGxMoIooQ+xPjdDlULSI=;
        b=n4fWjtxcqJZPfEgmbJ+f+5aFYuGQKBNeTrVC+fFlynkltTLXmT0O0oj/2PoC4iUukx
         igXL3HQp/4SCDrJr+nrNvUR+Xdp5Mv4empFr0f7hh66ePkJTJY7YzxbyL14ne1S/NOTB
         IJmISDBhtWyH289HDJT8vIuM5KbZLPgFAOL/YctctYjiWMq1sGUFfozk4UxU4Yg0lVmL
         GE59v8D/j/EkpSDwLVExcksHn+O0ws8rjNFNhPkFWSpiiRRdA5Ggv6LzF+9QovDeTy4Z
         EFUbgC7UQwPvYMoqx+EkLbxiWVA7LGq+extFpiQXoMoDq+CS9vTfE4YMk5Ul6uZ9pc/G
         o7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777880834; x=1778485634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n398fXLJ0TKmiWx3C1U37KBXGxMoIooQ+xPjdDlULSI=;
        b=USpMtveZYQLeqLHqRyI1T5REkuIIRDgDckK0jNN3CMOXxK3T4+gDaHTcxeRHSXuJC4
         OUejrXHk8e8RCvGE1HouYDzmMslpDlNRwXijaITrOoyxbmyrCQyzGnqgcOyyYLuUQO1m
         8SNbJyKz9lpmvQGrS5ZD9LsWuAWj/Uz81lsh3WhrrzNqOep95gdKEaf6HLDwFJcTzUgg
         pnWh4JZu2qUp7fIky/vUOBdCxWe21Y7QVW1gSqbVk9QfgbfuqPR2s3wgP+O3hfSZkB15
         PDuufdJT69O46/8/RoPjb4qyyT93h/WHWKa5J4YPonotpNVcAOW7D6B+evw+Fn8omAOd
         05ww==
X-Forwarded-Encrypted: i=1; AFNElJ9Mu/OLQxKjnW1UQfxmEcgGruhymMe4E/NNUHOz6vCVoCNIii0YzS6tqMhx6D/1AMIKrxMOdux4Auj8G0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCTuXLveVoWj3U4BOpjVczk6A23iZpVbQ4kDD7/4fDPh1AMJ9f
	wwhj9mAU31BJ28D31kzytDM/1vvXOjx6sopaV1PJz5h/NQ+pwiHRsmk6S6/it43aA4uRbGYXawU
	EyKujufTHC0EtxYO8aliUEPlteP0EvbI=
X-Gm-Gg: AeBDies8mMALVF7I+1uyF8E+aBwqowdf3n6EijINNJrKj3H+kbtsaRMmkhNVb72XFGQ
	U6LVMw1uQC4qCe3yn58HllKhiJzcQaq8EqlVxTfgliHwvxztb3a1C7jRoshBLsxhRsKjxmalYHz
	5O0OqRMyqgdKPj7rINoK3ht1K4/F+m4NAlU7XeXZrqGDzQmXUlprYfAAAg86uxeM13qxBo1a3Xb
	4uVQbsaYZp88a99+SSJTdLMfQw8BkvA1QfIzldqGi6wuM2jESkgeAdqUijBMbFM4abWtwxf5FPr
	q0TynAOm7tAfA1cuXaY=
X-Received: by 2002:a05:690c:6e81:b0:7bd:4a12:4191 with SMTP id
 00721157ae682-7bd772b4bf5mr93232227b3.49.1777880834094; Mon, 04 May 2026
 00:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504072321.928921-1-zzzccc427@gmail.com> <2026050451-tree-trustful-a841@gregkh>
In-Reply-To: <2026050451-tree-trustful-a841@gregkh>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 4 May 2026 15:47:01 +0800
X-Gm-Features: AVHnY4JjVVP9xk8VgmV6LlSM-rdMPhQcbHZMn3f9RiEqfqXtd0ataWhc6mnCkJM
Message-ID: <CAFRLqsVMYRESR4dhpcsxXF17FvaX5obXyT0ZXZMkHymnw-6K6Q@mail.gmail.com>
Subject: Re: [PATCH] tty: n_tty: order lockless input availability checks
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, peter@hurleysoftware.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"

Dear Greg KH

Thanks for taking a look, and sorry if the changelog made this sound
stronger than the evidence I have.

> What tests show that this is needed?  That commit was a long time ago,
> and surely we would have had some bug reports since then, right?
>
> thanks,
>
> greg k-h

The evidence I have is from data-race reports produced while stressing
pty/tty ioctls.  The relevant stacks, mapped to current v7.0.3 source,
are:

  - read/unthrottle side:
      chars_in_buffer() at drivers/tty/n_tty.c:216
      n_tty_check_unthrottle() at drivers/tty/n_tty.c:275
      n_tty_read()

    racing with the receive side:
      n_tty_receive_char_canon() at drivers/tty/n_tty.c:1258
      __receive_buf() at drivers/tty/n_tty.c:1588

  - poll/select side:
      input_available_p() at drivers/tty/n_tty.c:1912-1915
      n_tty_poll() at drivers/tty/n_tty.c:2440/2444

    racing with termios changes:
      n_tty_set_termios() at drivers/tty/n_tty.c:1782,
      drivers/tty/n_tty.c:1786 and drivers/tty/n_tty.c:1789

My reasoning was that these helpers sample the same lockless read-buffer
availability state that the read/copy paths already handle with
smp_store_release()/smp_load_acquire(), but I do not have a test showing
a concrete functional failure beyond the data-race reports.

Would you prefer that I drop the Fixes tag and respin the changelog to
describe this as a conservative KCSAN/LKMM cleanup?  Or do you think the
evidence is too weak for a change here?

Thanks,
Cen
