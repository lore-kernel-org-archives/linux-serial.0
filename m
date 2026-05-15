Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB283E7BA9
	for <linux-serial@vger.kernel.org>; Fri, 15 May 2026 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861300; cv=pass; b=OO7TdmHNQyFmJaosJK7gw0DqnIEU3U8vtPD9ru6a9X2PyDdas1XV62jQPgpEfZ2HLJ4+4SGCg2Z36vd7AsZvHQKgYFb+fKEJc50JQvTX7ekUXigZlZgY/YfopZJ9/PQO5VCZHH9Fmr4ALu2Br5M9aQJIb+FUK6P3drh0YTvLwes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861300; c=relaxed/simple;
	bh=7t5kLbl/UZJ6cD3DAaWZIhowuyrXFj+3XTaKtfytOsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrGE1xZG3bQ8CrgVVhVWwx1wozBGsitUi8fE4quSZxRDD7H4er93vwKHv7nnWSN/7jdnZZ7y4IzNnq/JpoJ5qhpNiPuvvrEihAfFgZchrT+QZhTMAh9nXL4MZDziqYdyfXR4ls1K55cxdPHfXOKBCoaQEv+I7+2B+ca1DtM6Hsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBpi14RZ; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBpi14RZ"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65e170f1ca5so4139029d50.0
        for <linux-serial@vger.kernel.org>; Fri, 15 May 2026 09:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778861297; cv=none;
        d=google.com; s=arc-20240605;
        b=DYq6DDf2lqFWJ7xIgti2cVbmdePpP/wkWf3d/zeZ5TSIV+s3BCK9qvQ9KnfCzXvrsx
         fq6L6SXS4qn3P++nV27AnwNOaNhtZoAX/b47fy3+eKlEfg8u/ntfemeJI4V02jgFv0nY
         lke47K60mHUFxtYWGs/3AkjIuRc4sICfLFf5yn+t/HSD9pVJJasVh3Tmmmc8xYhqpbZ1
         eWPDPrSVPZ8ddbVaA5N/7EfPWDLGLnw/HQUoMGGcfDyAawK3HPnIclUKx5gSVgVhVmBh
         Rt9629CI9Y3H2ugupKWKzjz0fdjXuc8/J0ipVM8dN0/2dbvWf0oE4tarrTzFTxXO5ww5
         xqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=etWtIX5UhNNjCclgBMUtcF9H6RUdCFm4B4jOE4R5mSI=;
        fh=LKZWPEwbg1DnlLjpApPi7qaURinRY4TyqFiMoVj986U=;
        b=VftXjSP/FNeLtpP4pcmOItgAso6F1SvmM9oKFeAOXBsuz4uABP5pRcjk50Icn/YiBq
         8W9HUeZDz6WZbN0x3xtChyC9ii78bk9pEsw5EUkQYI+23Z1mGT0RvrnpVoofNjqB+1uL
         +b08HcTJDYYnV+znew/h0G26gTm362wLXrNDFvY9dIx21jVthSjsvIcAHEVYOUH3JZIm
         rWIgooeagZlXFb19t1Kr7Ej2MGZ4yOvMQZ4VO7kk5ETeDt+6gX1t6yPuXMoAi3b9CSXY
         qF7xHMDHPdfLMzTAA9Mgod4fijIloOqBOo2/40CGc1+mAisl3PfTAE0aikn9ZKzICBjc
         FdKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778861297; x=1779466097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etWtIX5UhNNjCclgBMUtcF9H6RUdCFm4B4jOE4R5mSI=;
        b=gBpi14RZdhhHjNbboStTjszFKViTtvqc7Gj+6slDxI8D3JTrrE7UGI/8DDtoZFymB8
         rFlcZHiPVjSKYl3eaDgab/OGQ6VoRMQEC9K+jBbPU45lB0NIPyfx+OiK0AUDaFm6jX0s
         5v4xbB2ZNm3sy44/rlvdAZGy0hb9s+3rJEXHMdZi+YLgz3wsgnBzs7WfA3+kWmhTMkpf
         ve0Dvn7yFxIrkF+Cg11Q6V/2mIiVDHUmodGkjS8L1b1AQPebHrGqN96TGDFQUp1esT+4
         FZsdhbWFXJNxzkfLyOS1tEFZvBXS7q2D9wye7eLcPwW9zA8hc5kgE8VEfDeC6gJB0/Ew
         REAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861297; x=1779466097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=etWtIX5UhNNjCclgBMUtcF9H6RUdCFm4B4jOE4R5mSI=;
        b=cZYja7RYXyMzKl/2H5UiWxvYfNaHnFn3QZpTidLda7P+1bZrDPdMLPgbIfb9980/r2
         CNmAwylIcgR+B/lUh7T8YuUHP/9qpd95yJN/s+GsrqgZ2Ce1gwp1tZ9WD42G/kJdEAFW
         z8Li6di6Ie2h5fBqElsPMc/p/sJw5uy/QbosJTwKdLnKj3+yrtPqmJh9BNHISPzQmH1L
         PkjkfgQk2qhNZeI8oBIgXW8KmrDTlMt3IFP7hoV2Zi+tK+oe/l7FOJVPF0TSfE3zayST
         XT2jOxMOxuMRpnxBhFwl4+SW0OrXtIlvfmzBmOddQ3KFCJbodZWadtwAyxhBH+3jPiwO
         6ijg==
X-Forwarded-Encrypted: i=1; AFNElJ/RxqStgrrsuyn/AlR2flwZte0fWcyznd5AjcMjCE26g5HukRhYrrIEYcTw00x33+8kS63N57GV5uNjJ40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4zRRanFdTMpFre3bUm8FwipJwooU+g/53/nLDsB7sbWUzmNBt
	YQ21YVNLI26NtNpYbY0OF9IuRyXCVRRpeVMnkEEv9J/2jsK5uTaMxpZ1lO7sr17Di/zhbbswobb
	BuM66IqsEahBYSJsxKdC/MXXfZF+1zL8=
X-Gm-Gg: Acq92OHFCuajM+RlycUFwXQot09jbXuL/tyXHj6A2KRaxBe8MTN+RQ/TI/0UKFobIXd
	fZEcQxZ9Sss47bEjIjShdpgmybSln4Gnglp0KY4KiWrMLbOHvN+YE2dbzbz+sEKo4pnzml9xVaF
	HF8RIlgHtxahpQqQydIUWEBMfduKlmT8fj9Bd4qfYB/2t3/9PQeJ6RG6vecx0dMocDPBIgsZ4Mj
	pF1f2qk+X6+L9sfmGAFthg7Gz1uhgOUHajKCZskK57KgbgzW1L1PR3BeZejWsKmzcOP2xe0zLAB
	+1KDuf+x8SSKhPf8WROjvD97d9NCzBtzmFK0Nu70AX4jGudjQ0l4ojR1xVdFLjEU9TZeWw==
X-Received: by 2002:a05:690e:43d3:b0:658:ac79:ad4d with SMTP id
 956f58d0204a3-65e22869b53mr3588378d50.47.1778861297407; Fri, 15 May 2026
 09:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZLjreYY_BczAQr2G6L=iJjBYKksFp53CairG-6V0Cb0EA@mail.gmail.com>
 <20260515140548.393865-1-w15303746062@163.com>
In-Reply-To: <20260515140548.393865-1-w15303746062@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 15 May 2026 12:08:05 -0400
X-Gm-Features: AVHnY4IVRNEVNxNgiAR03-73eocXaRC0pMA7aacCJ9NkP_1-TTMuYszH23iee7E
Message-ID: <CABBYNZ+r3gm37FW5WqE79bRp+x9UZsaCtyvfz_FdixqEucAxGw@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()
To: w15303746062@163.com
Cc: pmenzel@molgen.mpg.de, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, greg@kroah.com, stable@vger.kernel.org, 
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 15, 2026 at 10:06=E2=80=AFAM <w15303746062@163.com> wrote:
>
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
>
> A Use-After-Free (UAF) vulnerability and a subsequent kernel panic were
> observed in hci_uart_write_work() due to a race condition between the
> initialization of the HCI UART line discipline and concurrent TTY hangup.
>
> This issue was triggered by our custom device emulation and fuzzing
> framework (DevGen) on the v6.18 kernel. Due to the highly timing-dependen=
t
> nature of this race condition (requiring a precise interleaving of
> TIOCVHANGUP and protocol setup), Syzkaller failed to extract a reliable
> standalone C reproducer (reproducer is too unreliable: 0.00).
>
> The crash trace is as follows:
>   ODEBUG: free active (active state 0) object: ffff88804024e870 object ty=
pe: work_struct hint: hci_uart_write_work+0x0/0x940
>   WARNING: CPU: 0 PID: 338273 at lib/debugobjects.c:612 debug_print_objec=
t+0x1a2/0x2b0
>   ...
>   Call Trace:
>    <TASK>
>    debug_check_no_obj_freed+0x3ec/0x520
>    kfree+0x3f0/0x6c0
>    hci_uart_tty_close+0x127/0x2a0
>    tty_ldisc_close+0x113/0x1a0
>    tty_ldisc_kill+0x8e/0x150
>    tty_ldisc_hangup+0x3c1/0x730
>    __tty_hangup.part.0+0x3fd/0x8a0
>    tty_ioctl+0x120f/0x1690
>    __x64_sys_ioctl+0x18f/0x210
>    do_syscall_64+0xcb/0xfa0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
>
> The issue arises because the workqueues (init_ready and write_work) are
> only flushed/cancelled if the HCI_UART_PROTO_READY flag is set. However,
> during the protocol initialization phase (HCI_UART_PROTO_INIT), the
> underlying protocol may schedule work. If a hangup occurs before the setu=
p
> completes and the READY flag is set, hci_uart_tty_close() skips the
> teardown of these workqueues and proceeds to free the `hu` struct. When
> the scheduled work executes later, it blindly dereferences the freed `hu`
> struct.
>
> Fix this by moving the workqueue teardown outside the HCI_UART_PROTO_READ=
Y
> check. Furthermore, use disable_work_sync() instead of cancel_work_sync()
> to unconditionally disable the works. This ensures that any pending works
> are cancelled and no new submissions can occur before the hci_uart
> structure is freed. Note that hu->init_ready and hu->write_work are
> initialized in hci_uart_tty_open(), so it is always safe to call
> disable_work_sync() on them in hci_uart_tty_close(), even if the protocol
> was never fully attached.
>
> Fixes: 3b799254cf6f ("Bluetooth: hci_uart: Cancel init work before unregi=
stering")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> ---
> Changes in v4:
> - Adopted Luiz's suggestion to use disable_work_sync() instead of
>   cancel_work_sync() to prevent new work submissions during teardown.
>
> Changes in v3:
> - Added 'Cc: stable' tag as requested by the stable bot.
>
> Changes in v2:
> - Added KASAN/ODEBUG crash trace.
>
>  drivers/bluetooth/hci_ldisc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.=
c
> index 275ea865bc29..333c1e1503e8 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -544,14 +544,20 @@ static void hci_uart_tty_close(struct tty_struct *t=
ty)
>         if (hdev)
>                 hci_uart_close(hdev);
>
> +       /*
> +        * Disable workqueues unconditionally before freeing the hu
> +        * struct, as they might be active during the PROTO_INIT phase.
> +        * Using disable_work_sync() instead of cancel_work_sync()
> +        * ensures no new submissions can occur.
> +        */
> +       disable_work_sync(&hu->init_ready);
> +       disable_work_sync(&hu->write_work);

Looks like sashiko has a problem with these being after hci_uart_close:

https://sashiko.dev/#/patchset/20260515140548.393865-1-w15303746062%40163.c=
om

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


--=20
Luiz Augusto von Dentz
