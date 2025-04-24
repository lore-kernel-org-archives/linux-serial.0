Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED5917A2EA;
	Thu, 24 Apr 2025 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745519659; cv=none; b=XFoHDOmvfXXoz0Ut6rnbIZq9aFSV4itURQ9gy6LtJEWVWA17m5FH2wxb/I3sCqCPQZeNhVRn+YQy3W+3wc/uSo8evmFgoAWT0BcT6dg4D3+Jkdrppw2owOHineW2Ji9X2tW6HxHQ12WnoRHsTA4Toax7ICxsHIWLn38lV2+dncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745519659; c=relaxed/simple;
	bh=39IgTCoRmuwSBhN8pXGBMrTZGCajKZKYCqn0HyEFy5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F69gZWd9hR403CCS+yKk4UHHzp0nQICUYqHTOpDB3mFw7+Hb7SJzF7Jl2NgKtq+e22H9vJQytGFFKXGzBnPuhzawjYk8CZR3xyetNQZ3xGUy/m/BPLCNoEpRqiLpv3rVJwKRo2SZjmMJ/w0rpSy02xmbtgh4iwmNCvacjHZiAHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1qj+Li7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1qj+Li7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411BEC4AF09;
	Thu, 24 Apr 2025 18:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745519655;
	bh=39IgTCoRmuwSBhN8pXGBMrTZGCajKZKYCqn0HyEFy5U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B1qj+Li7s/BjjdVgE52QnZmfPkuPkbHDAX01eV5TpkavST1t6/sP/ybj6wCUNkDHe
	 NJaIodkm93Wq1eu/ItimduYJAWuN3t7pRYNsUvspJvhUSTjGqCEM5acgGZsgSANkRz
	 eQTlC2QAKiXyziIQ4HF0eoma+BBIZdZibnqWPRG1ZaehlzaAt/8hGwsgTZN+qvTERg
	 3ozb/R7v961WmeiSh9THOSPJT2NOU3MywSa+/B0eJ9l7sO+pCJgrc7jM7KuZJnjeit
	 AoYpShFJpLymWgBOXR7/01vHHlfwMjxwyQyIIQKdFGznF1OdKSpSfrp2u2bCR+/R6V
	 c4un9LUOfwMHw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f4ca707e31so2285075a12.2;
        Thu, 24 Apr 2025 11:34:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVL5DygTyDeFrk/97JKTd2QJrSTMox0oQ7T4NMk2XMTK0zqttUxMkk8cXW5RwPDxngid/jyo11jlBKNaoU=@vger.kernel.org, AJvYcCWC289LVlaJjKotZYrz4sH2kzx34UQJrZKbHsabZZ+I+aq6382wgOnf3ixuHj2pq6dgvPdRsAnBJMUoMlFM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/i5HQewHaE9i1QvMAhqNSmKsLEk7JLzSwY9H1xyzLNXc84Trr
	INNgw3EXIE3XnhfCnsTMzgUJDIKODWSJIqMtRknCkcK7+PTCMFf6tPwk7uHd8SLgBnCBLONTzOR
	Fv8IXYiNnrnPAi8WyeQPqSWsLKA==
X-Google-Smtp-Source: AGHT+IETA7koFRPQpCNgF9bB+lBmBatuYMkCAvFK0AhyzDFySWaXfC2Y30MblCgtSC39xMK1leTosTnJknluZ8y8Yh8=
X-Received: by 2002:a05:6402:51d1:b0:5f3:7f32:3919 with SMTP id
 4fb4d7f45d1cf-5f6fabdaecamr384013a12.16.1745519653832; Thu, 24 Apr 2025
 11:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424-fix_serdev-v2-0-a1226ed77435@quicinc.com> <20250424-fix_serdev-v2-2-a1226ed77435@quicinc.com>
In-Reply-To: <20250424-fix_serdev-v2-2-a1226ed77435@quicinc.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 24 Apr 2025 13:34:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKs=5Uf1rJy3iBROL5ZZVo62cTbNq+yzKr2DXU+Nhabbg@mail.gmail.com>
X-Gm-Features: ATxdqUHFJ4GtQopsA6kBZicfwSwvYKcPW-wwVym6ikDdQEIuuuMK-FbLj2TOWQo
Message-ID: <CAL_JsqKs=5Uf1rJy3iBROL5ZZVo62cTbNq+yzKr2DXU+Nhabbg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] serdev: Remove repeated device name in
 dev_(err|dbg) messages
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 7:24=E2=80=AFAM Zijun Hu <zijun_hu@icloud.com> wrot=
e:
>
> From: Zijun Hu <quic_zijuhu@quicinc.com>
>
> There are serval dev_err() and dev_dbg() usages shown below:
>
> dev_dbg(dev, "...%s...", dev_name(dev))
>
> The device name is repeated since dev_dbg() also prints device
> name as prefix.
>
> Fix by optimizing the messages printed.
>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/tty/serdev/core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 971651b8e18dcbb5b7983cdfa19e7d60d4cd292b..f00106de76a0f1e547310c7d2=
1cc2fe3d5869e28 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -118,12 +118,12 @@ int serdev_device_add(struct serdev_device *serdev)
>
>         err =3D device_add(&serdev->dev);
>         if (err < 0) {
> -               dev_err(&serdev->dev, "Can't add %s, status %pe\n",
> -                       dev_name(&serdev->dev), ERR_PTR(err));
> +               dev_err(&serdev->dev, "Can't add serdev, status %pe\n",
> +                       ERR_PTR(err));
>                 goto err_clear_serdev;
>         }
>
> -       dev_dbg(&serdev->dev, "device %s registered\n", dev_name(&serdev-=
>dev));
> +       dev_dbg(&serdev->dev, "serdev registered successfully\n");
>
>         return 0;
>
> @@ -783,8 +783,8 @@ int serdev_controller_add(struct serdev_controller *c=
trl)
>                 goto err_rpm_disable;
>         }
>
> -       dev_dbg(&ctrl->dev, "%s registered: dev:%p\n",
> -               dev_name(&ctrl->dev), &ctrl->dev);

I don't understand why you add dev_name() and then turn around and
remove it in the next patch. Just squash the patches.

> +       dev_dbg(&ctrl->dev, "serdev controller registered: dev:%p\n",
> +               &ctrl->dev);
>         return 0;
>
>  err_rpm_disable:
>
> --
> 2.34.1
>
