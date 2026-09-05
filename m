Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED594F054B
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633826; cv=pass; b=B9KDe/3SQFsKf0RMSH4G8GGN+CvQV1t7L4hbqluK4hLew0/0+vsPUdMboJNTShX7sC60x5Y7dbes4zGqUzwFIoJBa1cLwvtklAinOU6q9yH80CZN40SpOmhW4S17G2mg5wOE5yeRkYJoGnQA6hnRifirMJdgJnuX1+0wLP44ABI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633826; c=relaxed/simple;
	bh=9Ip1MmxeUGWd0g47wSBTjabQGaYtNljWnxUSLDkQK1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfy97DMbqM20xwpDu/UURbBgBIBVdPXjOEGd7vQRudYm/lym555g3g1CsqA11SdSTaRYAlBA3k1wNYjI/+F7T0d7YR1V16F/q8bpgvJGllZrXRQCyd950qWjyJMODxyAj7fCK2pcx0mpW/3egAqK1pLYztiJZV3rWCAxUFy4WhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DG0uZ7te; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG0uZ7te"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b1a806664so167890a91.3
        for <linux-serial@vger.kernel.org>; Sat, 05 Sep 2026 11:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788633821; cv=none;
        d=google.com; s=arc-20260327;
        b=ASKTZCAZEOAkBBG63DCbXuqg2+qloqK5l+t1aLbQ1im50MnmAgMhCKxHyqObF17Utb
         /XuheCjJnnys1R8m2QF52Nzb65QuUj2YG13SSH8HZWXF4xCGye4EQDkQQFbW8Z9IYQc5
         wMPlWuMiSGLqIvxJUqD0eVmGGufkrMo6oroMSevabjqNGfYWuM5TDTA/8RT+iTJ9fTsT
         VxNfaLJxjI8Tr7+eCIdU4KWy8Grp/jC3fOD8M9zyEOcAkDZ/8wVpADAl9nj1cHx6F5T3
         SWe/Vyz5QGN0T6dEoa7qGKiCy5C4WkWzpiOsAuj7Q8zePRUpmMszm/tplDM2rZCJPoL9
         lCdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XekwQGEO2G0SV/gVTmMZu7YurR3mOY4ecKYwztJmR8M=;
        fh=hGHZJ+A92yOZ472l7h5Km1+jy4O2vSGnDl6nj/ygoG8=;
        b=KpWJA1FffHGuiKJo8DQmUoYfI279LZMXuzC2jpD+yWkLc5ybABE9noOmWrhv3VvomO
         xDKQ4hyaqOkxGmiNVZkBe+X69AoHTaJbeJfmLXtbB2qCsHKQ0qCn1VlDhwztOLQ/KDIR
         B+eBI/DGbYHid2dfqk9jBje/vWpmRzfrg0f5zJe9A9NDQSqeV/ePXNDJPl6aFLEuVeXb
         NKVsobI4CLaI71cv55W6jId1FEexAfG5qnldERZavfiXsnY+sOt6bng/ue1CDfctz4j3
         CRoc01nlUQpGvEEGGZd6a4fT0hagooCnBqSO9GhojnmJk5FysdAcJsYpY0mxr2E0LECR
         Tukw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788633821; x=1789238621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XekwQGEO2G0SV/gVTmMZu7YurR3mOY4ecKYwztJmR8M=;
        b=DG0uZ7tevCNBnZAHnuosaAZzgsHRRF5mmGFjNHK7mUDp+yWev1GRtAWDzYqg7es5AX
         5hy6wpN/bhoB5/ME/AJNtCE5dNy8a3Q7OTGqs9rlaoUEHXZyb0eRkylYhx+VsBfAfb56
         WNWl/pMm7XbiYeWpMNt2g8Z33H2gP1gIzkaW9rFkLImTkVnub4tWyf0mIvm6uVAji2Od
         XymjB4gFAyuCYdKa0++Hn9d4N8Z3rfNDLfm8B3m4eFaX6l55U2co5srn31ACVM7ldnHO
         ldc3gltHTSL48gvLI5Osw3DsFa2p593Q5UANgnYDHr9OpsQHq5WZzoHJfd8OrOA0GlCs
         sKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788633821; x=1789238621;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XekwQGEO2G0SV/gVTmMZu7YurR3mOY4ecKYwztJmR8M=;
        b=hSqZMObljevn2dgXFuf0Wn60hHYKD8tiKD3H5RBohr00zJJsw4REyTboZFE8w5wCM0
         GEcjeumvbbPPnR+rZksbnl7NwPAbsNWf3ap+2QZjQqrmKRIHXaSBZJVhgR0c+ad7q7ex
         KaXGh50/miIYNFE8+oaLZF7QKgt0ZNDt1CR6DR/sgWamNLp8MD/xYQPjfM69sviFnI6H
         cs9LyNmw3wKGqI8LG1eDknIoFHHhJXeYRx7vH8s4b3OuJnZCLbiTe1venvtyPFkmV9LV
         nA+GGNfXKfx24QW6TmTUEMFFpWIUB3IwYs/gTye2XwjpdiZgpgWIcxdiM/QRUtz9RxZv
         qmrg==
X-Forwarded-Encrypted: i=1; AKwUvByEFIMQPmmhwV/gjdRvX8RIQg3RXbunRrits5tq6Ae4WnuptBKZw7afxUUZJSdB9p3SMCtFxBpejNHcviQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lf5utaE+ItLmAeJWAZzt7WwsJNdTDbR88NBeyx+sQf4Q++N0su
	SQUkQQPbjedckLlqyFJIepcYoIK0vP5hE8lxbgsodYd6V3h9r8m1CbI/ejZFRSAz/3oQp6X8HUn
	zeH2vJouovlA9Lj3CD9Ee5DjKeTeNtOw=
X-Gm-Gg: AYBFou1MeGu2Krym0hDx6vlUb8vkTv7RukOZLhxZ4M8dO2IrToVFCKJU4NMnxCuV8KH
	n0q3J4ymWHyL42TI/Vo78PMyWtghJ1YuCBx0es0fWd15uYzjkovWlzPGQtuCULcORnDihx59aZb
	hAyXVINFYDkMF7RgMrl43zFFGxsZCFt1tHDHDDScXbJ2tovk+OIRuYqEEeCHEjXTGmXtKZKH9SB
	l7Pt/tEaA1FzXZHy5fYNPdcU5mv486LsqjpyFY+/gE3c5c7XSrTq5qrCg4gKShCUhmxav3hC1VI
	G62ZYJeSJ+zJVR4rbjdrHuPp/fItTFjd/gRBLVPrDUeV1GlBE1C2Ohw9n5b6s1lt4/gYaag/MLI
	uxKg/fwk1qQvQO1hr+HjawHGaG2dHhXqHNqvlVOy/O+SLvbHT+/hgXV8uxZyj
X-Received: by 2002:a17:90b:4b41:b0:398:bad2:c0f with SMTP id
 98e67ed59e1d1-39b3d8310d0mr6299253a91.5.1788633820895; Sat, 05 Sep 2026
 11:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905-rust_serdev_fix-v3-1-b86056c3f7a4@posteo.de>
In-Reply-To: <20260905-rust_serdev_fix-v3-1-b86056c3f7a4@posteo.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 5 Sep 2026 20:43:28 +0200
X-Gm-Features: AcwNN1VE7R5Qpqg2xVKghrSvMCGolroPW6Kcwa9i6GRHIirw3YVUbccVS64BWkI
Message-ID: <CANiq72kWczjEZY1q9rF=zpMAqQ_yUhdb-n6FgXXuF7==zgOT5Q@mail.gmail.com>
Subject: Re: [PATCH v3] rust: serdev: Mitigate race conditions
To: Markus Probst <markus.probst@posteo.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 8:33=E2=80=AFPM Markus Probst <markus.probst@posteo.=
de> wrote:
>
> +        /* receive_buf: if T::HAS_RECEIVE {
>              Some(Self::receive_buf_callback)
>          } else {
>              None
> +        }, */

> +        // Bound,

> +    /*fn receive<'bound>(
>          sdev: &'bound serdev::Device<Bound>,
>          _this: Pin<&Self>,
>          data: &[u8],
>      ) -> usize {
>          sdev.write(data).unwrap_or_default() as usize
> -    }
> +    }*/

Please don't comment code out -- it is fine to just remove it even if
it is a temporary measure. The code will still be there in Git.

Thanks!

Cheers,
Miguel
