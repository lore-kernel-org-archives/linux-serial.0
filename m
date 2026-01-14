Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6C833D4FF
	for <linux-serial@vger.kernel.org>; Wed, 14 Jan 2026 04:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768365564; cv=none; b=cMD+/te+N0QOxCgiMk5nSeC9oYlTTNoEdwBPijs/d7H+qxDx1JoTlOCUmD5ImzJdha34USFfcBjGuqISX8P+DdgAf9/gz6jJXb3PfNqD0JZ3iqMFPLqMlMSZzAdelI27CbjelWmsqJIpxxhhJ5T7rKUM3c4AEmpGZ7pgNZgudwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768365564; c=relaxed/simple;
	bh=ZQUOJEFm5bE4WZh4M4+JJZr/mm1xOunfrRx0WFTa8t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FwdYVukSsaR+KC97jDefmhsiJjejWda6LB6U8+ou8OTYwBqkSBtbhq/O9EFDcsQVLY0/YplXHphNyrgzl87CujnlCPlVU8T51Ssh9p014pi3H5707aB/AQ0V68+MhyRXVOqz99Bp0dZDcDjlSdjsmSjejarRxIxTT5UZrPSggEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wd3/RfvO; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wd3/RfvO"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64d30dc4ed7so16293614a12.0
        for <linux-serial@vger.kernel.org>; Tue, 13 Jan 2026 20:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768365548; x=1768970348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jV/XpQwP+sh7ML4rhDGyFAhl1yo1wNuzxIs+ixWD/3E=;
        b=Wd3/RfvOE0euhOEmkt3y2PmAHKb3/BbJ/HoTp4Ijl62hmCT3IWKWYcTMe3cd9PHNGM
         jPDspV77PSq7M0A4qIXok+M45w1q7OWltOLKD6jeRB/n/fmqgVB6NWQUsjC5LrPbUEze
         4jWINNkO++TE94YoLRwizioGXWqmFhNQHPZHDL0/0N9prlIa+3vKLVNOmI14RvSZCfnU
         0nMOwCefPneM4tZqevTTv7IhT6jsk14U9DJ0Ay5yk5ZD4Yq1A9wkc3AHummxl3c6VVTo
         JiPbeBv7gZaOqoGqHgVfetQGfD4Wo40+nFNGfXEJ3hMG2GdUO9HmnMijPtyo1JCZWsDB
         sCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768365548; x=1768970348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jV/XpQwP+sh7ML4rhDGyFAhl1yo1wNuzxIs+ixWD/3E=;
        b=JUiUnWdU9QJ6WBq6OfEp7hwqUYx2uZEuTJtPWjOJDFNYnhbm43oJHSrYTElWnoE6q5
         q8h/IZJFeOYSi46ftuWV+Z8WfxpMWdHsbG/+7jFicfOovvNe2gKZks445DztyyPHR2jm
         JcZ7Bofz1Uo+BrPXUg893eGzfz+SZ6Xs0dBbCVEC2yW0W/Tt4zmCgiQYWt0j3n9F/Lgz
         IQUDfv7Mn3Pbo0TyDEV8M7xnox6B3CGL6EgykbfyaFhYYxJ3W6zaSZj4Aedn76Hq/r/r
         0JNTZArpZfboN7RgaGevkdYJCP9CUCm7GunCQOwv082+wJnZw0ICWIEu2+gUuv4fSUaY
         jmuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYDmctLqLzKirDmLEQenBRFkAjSLr8HO9YG5YfVq05UqyClPsquVXMUFFzg3RV1pbE/a3DUDCCUCVf/Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKL71+jE7cde1jM3rQlZC7gDzgnz7zfoa9KYtkGv2NFtU1sfhw
	XdCFky2vpsWfEbJB3A9OWijjNmEQjVTB6iUF4m7koKzelrvYFRkQoi1OeDDQ3n4V0tmB6SPLJNT
	v7OzLWL1kU8sGg4VDGqj5JpZuBXwryN0=
X-Gm-Gg: AY/fxX5NhKQkXKVyIkk00M6tA6BLgDeBxxNMr3RQPW/FIYqhQywjg3bN9Ro3ToPZ6yy
	DDbd9KnC7Ig+MxDlPyvAu0BeM2aqHvMVEA4ruSOqzy4kQD5I06Rsoez5qipeJdPcwe40L7Qv4DD
	0kAgKoSDqYUE4qMk7kC5q8sv2KeQvA0NEpxmo2Dh2xUSVaOQXQtJ35s4vyIwdyiPBRp3vvt49vC
	/KWgiNvUxpI4uXqeSr7TA63AvJ2/YEumxgi2CMpDkOWzavWvi6OcUkB8ULqOjY6Rc0R6AA9
X-Received: by 2002:a05:6402:40c7:b0:64b:5c4e:e695 with SMTP id
 4fb4d7f45d1cf-653ec45d439mr887371a12.29.1768365547910; Tue, 13 Jan 2026
 20:39:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221103221.1971125-1-jakub.turek@elsta.tech>
In-Reply-To: <20251221103221.1971125-1-jakub.turek@elsta.tech>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Wed, 14 Jan 2026 10:08:55 +0530
X-Gm-Features: AZwV_QgfM5h7fqKdhk7j-yHOg33xWw8Otxs3wXPFYc8mUKCfOKlQeD0MFZTnDb8
Message-ID: <CAKfKVtEUj3=mt8FaU21zF5ZOqatzCAebW8R32f5E57VmyTtUbw@mail.gmail.com>
Subject: Re: [PATCH v2] serial:xilinx_uartps:fix rs485 delay_rts_after_send
To: "j.turek" <jakub.turek@elsta.tech>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, michal.simek@amd.com, 
	namcao@linutronix.de, tglx@linutronix.de, zack.rusin@broadcom.com, 
	sean.anderson@linux.dev, hshah@axiado.com, linux-serial@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2025 at 4:03=E2=80=AFPM j.turek <jakub.turek@elsta.tech> wr=
ote:
>
> RTS line control with delay should be triggered when there is no more byt=
es
> in kfifo and hardware buffer is empty. Without this patch RTS control is
> scheduled right after feeding hardware buffer and this is too early.
> RTS line may change state before hardware buffer is empty.
> With this patch delayed RTS state change is triggered when function
> cdns_uart_handle_tx is called from cdns_uart_isr on CDNS_UART_IXR_TXEMPTY
> exactly when hardware completed transmission
>
> Signed-off-by: Jakub Turek  <jakub.turek@elsta.tech>
>
> Fixes: fccc9d9233f9 ("tty: serial: uartps: Add rs485 support to uartps dr=
iver")


Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
