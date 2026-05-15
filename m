Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38A83D25D8
	for <linux-serial@vger.kernel.org>; Fri, 15 May 2026 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848692; cv=pass; b=kwGJOFgIh6TqEDkzt7o30fvWfl0/Dut816h/Um1zCk2NwYOH1HL9fTxXhueH7nB5XYrGRIMgqbiuCE7lgp9ZFpvJyDwW/iRon5V+9vkTgIyrLdbuyPou2FnbwszBwUIQALtUGiMF1Xj+ZuvvPNbHTtx1qfnHNCCvbdNjadw0eDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848692; c=relaxed/simple;
	bh=uUm1+vPKAawVjOiJgNJ7LCFjNddZhopNdukMhxVFjMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cs0BdNP2UROZLwfgo9Y7YEITcqqqFzr9o6G56FF+ZiouZsPSrPVAadBlQAaeq0f57y1qnKkiWzf9Kh81/U3808hPPav0sN7bFSkqyqqasVftHg0mg81IbMO5Uw8+RjotTVDTpbIPxuzRjthi2GecFaHNYrHtQVpOCKGtTkOQaMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlJArw/k; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlJArw/k"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65c3ea2ebf7so12350814d50.0
        for <linux-serial@vger.kernel.org>; Fri, 15 May 2026 05:38:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778848689; cv=none;
        d=google.com; s=arc-20240605;
        b=ZRW79bpwluchz5+fPm1jZyzL/zrjmD/4CCSc6aZRsAa3/L5Z6RHZMAdpRSIg0yAHRA
         y00gS5aspdX/v7d0N6ahkg5iVU4rRvNCcFvyaVxhRBWrUIxRo+YEpt9JoXuQ2Wm2668b
         06w9+R8u1xcqPv6nrVIK/RdtMeHME0guMQsm8SsAewoPbP0seI8Z1lNWbjSu4KwBxYkZ
         tV8E/Iy6X4m8V/zbyDVGQB+QZWN1C76eN55xYOkqFSva6I1Et8Tl+9lHrySGLS5gUmTO
         XcMcU+g+pOBzUiMOlY1mUcPnI16cXRmcNzAZUpP0ZiDONYO4d6wGgQG/iOxXHMusrEoV
         bMmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VP5YCpspQORwjSvDQCKN487lTY4JiFEf6+8HukEzf0U=;
        fh=HhMdgeV7b/+d6225Mh3EQANIKN2L7XlUEu1MyEB1wrs=;
        b=J4ktZmpFfSuhxDHrL8Bro4YyB3xPNyuYIUBVQPCWSUWvGvE66nXt/cBdJbrZmb6jOj
         RevXIdpCxf3K/UoSbQhUBJbZyEXQRWOvdEZh+NtQ57jhPQr8Uw+OsxfFP+DAmqx9ahpW
         ppJshcGoZ6KdsOV+xgAUYb/FawcOeDkfc4wb05OsPMhqt7lBemiQGETff9GVAXT0UKPe
         YwynaEDdih5f0GQcu/5IuNsiMAfsPNe5EpNRozOMmqadeT2lG+khW6Z8wY4nFFrKgA3B
         3+xofpFHuOqX8fuHqcC5RkInc2N29VyA+hw4My+tTr18Fb9wVGSohULVi2VFkSLKnYyZ
         fV7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778848689; x=1779453489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VP5YCpspQORwjSvDQCKN487lTY4JiFEf6+8HukEzf0U=;
        b=qlJArw/kMR1FCUGHI5BNTmj/e9MRsDxxiNcB1qO/V3BHJU2QbYAaB0Ujn2zH9Asyag
         f5gyfMlsQHg6Ixixnr70+2TPNWTkJxsWkLqDHNwCcNUAI112D0focfYhE/IQGZ0k4KKq
         KK1f5M9wS22I/cTbzIxcEpRKJlWF6IxrxzYcs3dVuPWSCpAW/nSmJSpHy7/B1o6JNLvD
         Y9bAzVKyHsJszFVwK0kGBklspknU+KEjr3JJ3JMDqfHR33rmcO3yuPeHTtrefODvVawY
         YKy3u/E19bjPPVnMSmxAGckqb1bNq43Og6GJL19vuHzfXXETUSRLAJeqqmsLwIUvyBYc
         hc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848689; x=1779453489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VP5YCpspQORwjSvDQCKN487lTY4JiFEf6+8HukEzf0U=;
        b=r+HdPmysh21FhggbFkOKIpWceMDoTxA+cwFdv/kZOSBW1jmVkNqGXR+pC5Q6SissKy
         Gm4fgVhFHXQFLu8FR/cMyyDR8mHQMMvj2rko0+j5QCe/BlL8tpjBbEWgzhb/BKnt3tDn
         hY5NEOCgMe4RZg7Xcku7sQNZpEHIoaQLIwpU35FV28X5scmTyvBqYAJtq8O8uQHp/gOP
         MJRaCousm5TCrMXHEDphIIlWRxSdR93xdcDvGWKGGof2UFDglHhqta9wXU89i+wJUXKF
         xXGAWx7/QBdvLfoyOEK0XkRtiZB0EGUK3Poz7Y4luilCfgP1KQCg6vS0inuC81i0bExT
         J61A==
X-Forwarded-Encrypted: i=1; AFNElJ+dBHlBaxyHukJuHhLIycQZGu6zd3j6/Q4gx4H5nzIpTA/1cSsrEMMubstjlTk/4L8sC0VDZ6dr7iTL+3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoT4D2WwNd8YNsxf3IAGhsjbIFlYU+CSXmmvj9PM2rWeq/ae3S
	1ghHenKWzMDQq4ekNJdTWwwY1hnIXZKa2x0EReokS8b83qyx64xqmm4+wOVgxvOEvaXRDZ5waZ4
	88sql0oMO8HplTgy/Xij1ch5Uo3FO2y4=
X-Gm-Gg: Acq92OG31CHUwTDG2DmcoqbH/ZUMJFmW75HKX/64vDzN2GmZg6yM2sU54sO88mdc+aw
	Ren8P+bu3Ed1KgqFbrzlHjr3f1k8IVdDvvhm8SH3cX8uIlOTqg2CgOvgWYIKz/WXcfDDmLatz4C
	+PwBgpu6mtFe1xwdZAWRW7YBcP3J9Vu7rO0tqdlmafWpxu4OnpzoaE+8ggHUSY3rLnbuZj12+uP
	KAPbitMaxKEioRSD1WfSSG3TXSceaXU/HH7Cum151LRhsU2pcQZZWZ1qHqj1qA7X9NAor13VCb6
	FIeFik7LgFAd0xr1U0xT6p8C/znqzqHQGBkuHjVQLb2zxkGxtSCMjO1/YGYhf4KxwrfqNRxmhr+
	R2AS8
X-Received: by 2002:a05:690e:429c:10b0:65c:5fdb:e97e with SMTP id
 956f58d0204a3-65e226688d4mr3129213d50.11.1778848688513; Fri, 15 May 2026
 05:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513064547.352601-1-w15303746062@163.com>
In-Reply-To: <20260513064547.352601-1-w15303746062@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 15 May 2026 08:37:57 -0400
X-Gm-Features: AVHnY4LFlpopLYzSmAZHruAtmz5zLKfogXDk37fsSmI8BfYu6KcukqYXViunKCY
Message-ID: <CABBYNZLjreYY_BczAQr2G6L=iJjBYKksFp53CairG-6V0Cb0EA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()
To: w15303746062@163.com
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 13, 2026 at 2:46=E2=80=AFAM <w15303746062@163.com> wrote:
>
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
>
> A Use-After-Free (UAF) vulnerability and a subsequent General Protection
> Fault (GPF) were observed in h5_recv() due to a race condition between
> the initialization of the HCI UART line discipline and concurrent TTY
> hangup via TIOCVHANGUP.
>
> The issue arises because the workqueues (init_ready and write_work) are
> only cancelled if the HCI_UART_PROTO_READY flag is set. However, during
> the protocol initialization phase (HCI_UART_PROTO_INIT), the underlying
> protocol (e.g., H5) may schedule work (such as sending sync/config
> packets). If a hangup occurs before the setup completes and the READY
> flag is set, hci_uart_tty_close() skips the cancel_work_sync() calls
> and proceeds to free the `hu` struct.
>
> When the delayed workqueue finally executes, it blindly dereferences
> the freed `hu` struct, causing ODEBUG warnings and kernel panics.
>
> Fix this by moving the cancel_work_sync() calls outside the
> HCI_UART_PROTO_READY check, ensuring that any pending works are
> unconditionally cancelled before the hci_uart structure is freed.
>
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> ---
>  drivers/bluetooth/hci_ldisc.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.=
c
> index 275ea865bc29..566e1c525ee2 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -544,14 +544,18 @@ static void hci_uart_tty_close(struct tty_struct *t=
ty)
>         if (hdev)
>                 hci_uart_close(hdev);
>
> +       /*
> +        * Always cancel workqueues unconditionally before freeing the hu
> +        * struct, as they might be active during the PROTO_INIT phase.
> +        */
> +       cancel_work_sync(&hu->init_ready);
> +       cancel_work_sync(&hu->write_work);

Can't we use disable_work_sync? If it frees up at the end, it's
probably best to disable it so it doesn't allow new submissions.

>         if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
>                 percpu_down_write(&hu->proto_lock);
>                 clear_bit(HCI_UART_PROTO_READY, &hu->flags);
>                 percpu_up_write(&hu->proto_lock);
>
> -               cancel_work_sync(&hu->init_ready);
> -               cancel_work_sync(&hu->write_work);
> -
>                 if (hdev) {
>                         if (test_bit(HCI_UART_REGISTERED, &hu->flags))
>                                 hci_unregister_dev(hdev);
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
