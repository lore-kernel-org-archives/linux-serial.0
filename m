Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBECC17A599
	for <linux-serial@vger.kernel.org>; Wed,  4 Sep 2024 21:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486711; cv=none; b=mtxQ8IQfSuqx915dH1ngcJ2P7iK+cgovGdF1cz55C5DP0qtqrHRRfJ/8ARTqDkilO8YCEuHywbN29HVKy0+Vq5UfOtsWyrvgS4K12mbS2BRkGoNsQu2mttmeNEq5f36vbUzqN38twQ522ND+k8+EdqDbVDPuTgR5jB4z1CiB+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486711; c=relaxed/simple;
	bh=3HkNVCxJy56k3u+LITc9D7/1LsDfdZXPVJ2TlkcFnSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0aUn7OaMEhRTGxiPZ4d3rTz+inIRRYfxpI5okJmn1/8EuuBkuJf4nVFkh628FR4UwQOY0URUXnPhZLSykQkVu0gOLVcAz4GS2RugrgEnGpMIQz7MmajsnE4ASG2IV5md49b8AQ2j9PIHIPyVyB3vREIhshirwfqvsZUtlm/fv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bDkWiP0O; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bDkWiP0O"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6d9f0cf5ae3so398827b3.0
        for <linux-serial@vger.kernel.org>; Wed, 04 Sep 2024 14:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725486707; x=1726091507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yUwPDHkK2WMXQHvh/6LMKlWFNebPcDI2OCZ0Tor/Kg=;
        b=bDkWiP0OWbahkdJJV862dxvCBBGEyc9Fe3I3Ne9SfD/UsmcqGlpNINc+JbC4P4S9Nd
         0LU9tf5JjE4bgzcT6uYMkBu5fNF+EcilHbicB8rNezYhzikTeMKPdVwWcAQfC/LZOoIw
         xyWENCa3H/rcw21vr3vgtYgV8EslwAraLdq/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725486707; x=1726091507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yUwPDHkK2WMXQHvh/6LMKlWFNebPcDI2OCZ0Tor/Kg=;
        b=PT2hqnoHrR8MQuIKg5U3p+gp1SoLGwgVWN4YQlGel3PM86PRXnJyLgHLUA9MzZqTS0
         v6wKwyVMDHQFPujEZ8LpZ7pN54gbvm9SjXMDeO99W3iJqqBhUEJ+yVjGflQxpCzjQy8L
         EVtzqFq+KwDG9B/SXRfY8BHGbQ5j5PX+hzoR+1g9Lm9J1n7LycnZrCugyLAU7GyrICin
         mtZqzPn2LU8ipYbH5eQqiyWTqcnqOjO14szK3qcMeK3lyoxixZaOOMUOV9lnqQCltZmc
         aX9djERdDcR2WrGUxWXN4r+kgMwj+q4PX8YNP2cKWDmwchzF0tzDbyd7F3fBs1E83/mc
         KaoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/Mt1HGFMR77aMfWN9hTP9w0dSRr+feLo00hPKGkh2IxfqTQuYJrFbzNvhUgqTbZPoDYpMory/uuJX1Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQn3GbPNKf64x0P67kAxXNKo3edCxWjvstkJeesSidTTCZXThN
	ODz5Ulo58RnY9MRGGxkxpIoareAmPpM+WYWgeNcvCQM7ghVprJhA5KOuK7Upzvuik7MWj6YxDH0
	=
X-Google-Smtp-Source: AGHT+IHztQeNk/QRQ+XEYsXP3DKteDsgyi7g0JOcUvdC0qNA8QIuwBqqqkVDlc54CGeCQJDErzGciw==
X-Received: by 2002:a05:690c:dc6:b0:6c8:e45d:ebd8 with SMTP id 00721157ae682-6d40ea72287mr213811087b3.9.1725486707025;
        Wed, 04 Sep 2024 14:51:47 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d3e990e9sm26380177b3.34.2024.09.04.14.51.45
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 14:51:46 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e1a9f84699cso145996276.3
        for <linux-serial@vger.kernel.org>; Wed, 04 Sep 2024 14:51:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlmy5X6J3DMktCIZN8CSCm/PYXuwCH46M+RSsR0tOqGsdVHS5vAWLNelpVh5eONfDyhAcQPvPSpGvw23Y=@vger.kernel.org
X-Received: by 2002:a05:6902:1886:b0:e1b:27d7:76c4 with SMTP id
 3f1490d57ef6-e1b27d77c64mr13543115276.30.1725486703973; Wed, 04 Sep 2024
 14:51:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902152451.862-1-johan+linaro@kernel.org> <20240902152451.862-9-johan+linaro@kernel.org>
In-Reply-To: <20240902152451.862-9-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Sep 2024 14:51:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WGbjWXB95Rk5Np7Fp6sN+_AySVw0WtdNXE9xURxdVU5A@mail.gmail.com>
Message-ID: <CAD=FV=WGbjWXB95Rk5Np7Fp6sN+_AySVw0WtdNXE9xURxdVU5A@mail.gmail.com>
Subject: Re: [PATCH 8/8] serial: qcom-geni: fix polled console corruption
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 2, 2024 at 8:26=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> The polled UART operations are used by the kernel debugger (KDB, KGDB),
> which can interrupt the kernel at any point in time. The current
> Qualcomm GENI implementation does not really work when there is on-going
> serial output as it inadvertently "hijacks" the current tx command,
> which can result in both the initial debugger output being corrupted as
> well as the corruption of any on-going serial output (up to 4k
> characters) when execution resumes:
>
> 0190: abcdefghijklmnopqrstuvwxyz0123456789 0190: abcdefghijklmnopqrstuvwx=
yz0123456789
> 0191: abcdefghijklmnop[   50.825552] sysrq: DEBUG
> qrstuvwxyz0123456789 0191: abcdefghijklmnopqrstuvwxyz0123456789
> Entering kdb (current=3D0xffff53510b4cd280, pid 640) on processor 2 due t=
o Keyboard Entry
> [2]kdb> go
> omlji3h3h2g2g1f1f0e0ezdzdycycxbxbwawav :t72r2rp
> o9n976k5j5j4i4i3h3h2g2g1f1f0e0ezdzdycycxbxbwawavu:t7t8s8s8r2r2q0q0p
> o9n9n8ml6k6k5j5j4i4i3h3h2g2g1f1f0e0ezdzdycycxbxbwawav v u:u:t9t0s4s4rq0p
> o9n9n8m8m7l7l6k6k5j5j40q0p                                              p=
 o
> o9n9n8m8m7l7l6k6k5j5j4i4i3h3h2g2g1f1f0e0ezdzdycycxbxbwawav :t8t9s4s4r4r4q=
0q0p
>
> Fix this by making sure that the polled output implementation waits for
> the tx fifo to drain before cancelling any on-going longer transfers. As
> the polled code cannot take any locks, leave the state variables as they
> are and instead make sure that the interrupt handler always starts a new
> tx command when there is data in the write buffer.
>
> Since the debugger can interrupt the interrupt handler when it is
> writing data to the tx fifo, it is currently not possible to fully
> prevent losing up to 64 bytes of tty output on resume.
>
> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver sup=
port for GENI based QUP")
> Cc: stable@vger.kernel.org      # 4.17
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
