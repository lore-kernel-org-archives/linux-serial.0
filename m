Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B333E2E3385
	for <linux-serial@vger.kernel.org>; Thu,  3 Apr 2025 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743684574; cv=none; b=mnpRX2OjTfKuWSzOExHZU1yeE4qUyLK94s7eTrYqTLeZGhsauEifF6hrJW+YIxP1qZ0Dd/v2keFD9ZDUzJHMxfCg8P+9+NuYC2kwltHvvQFUzHTm5HtksP7jvsX9MmYEFDjKJCaniyh8JRCtQV7FxfS8/EkE6YWyikqeIq1mrv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743684574; c=relaxed/simple;
	bh=Qk5d8xbhxNwjUd64AgFuXiKUrSyH4a2/vsRsybz6QzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfTtgPHWmRkLUq9Vn1oiHQVg2DlzPFcjCct9/rTR+NxMue/CIQH1+CpfcMG2OGStxJkCdz5161jYpRgPYSfDSx4gR6H9xpMappTJ2NAXkIYlKQL6YM6yjTprktMPm/RvBacFSBumRMpKu+O7MPaf6JzE3ROBxz4KBJhkENXHHNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=B1eA6UdH; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="B1eA6UdH"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-603ff8e915aso211773eaf.3
        for <linux-serial@vger.kernel.org>; Thu, 03 Apr 2025 05:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1743684571; x=1744289371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51Q3WOkegbyCBnKA5QrZibFPvAKsNArPzBsm1Qz0W+g=;
        b=B1eA6UdHhEXX9igZV9sXFUUVZ5hxgccTScez7ClCM0P+JOQXFZGx352Y/z+3a6F3PG
         Hmoi6zFWq8Y4lEeqOmLucJkfLfAZBjh+DKZBw00tetI5ikssNaM0G4Kba2cekfeXgoIH
         HqyCebbrp7oAE5PwiHpc+lp3imeNkIbdoG1wu4uW0XZKjfPoPx+3KNHSd2U/rCiogPnX
         uq3iEukOwQV2E/Qf21uTOshn5SHxg8DeLdcldi4f4PjFy9GsmAO58jeZ/jbxJE3BeARe
         QxBsirwITavKKn16KKPbuKdJxce78cjyg1vI/ANfvtxuz+J4x7kmuoTD53jxBGHu276R
         sB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743684571; x=1744289371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51Q3WOkegbyCBnKA5QrZibFPvAKsNArPzBsm1Qz0W+g=;
        b=XFMv+LuJTqNvkmM8a4d0PwTBIZY3zw25c0bERoj44w/nQ7QhR/gObGplMO9Yc+7SZY
         tQRkKXSsyef2n1YYsijfRrwjGXPa01qRkDula5LFAOJU/3B9GGJVQudy/GT6SHisPFm7
         oj0jHma0MKFcR129CL0C9aRbt+C5fZ+YHVvQVzF6raG6TdGrHBzxTqxxNI0xpJ4SdY9K
         gClhoaMHdLz4ZuxutS43Om1U2ZzttehGy3ZgHFL0NVNzrnD8+cAbJgVePQ0EKGuO+7Av
         S3v3zBMMy2zZTTf31f89HAt1zeMMgGT1CCsB9WMku546EVlosktbaJYaHr80EPJpxjeQ
         +F+w==
X-Forwarded-Encrypted: i=1; AJvYcCX74b7RkFhNJxaYuSwU0vaEeWJPKqZ7qS06Kzoxam0VnnhRaZBrGIpKdDjPNlMg1+l03i5S6HMFrcj03qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiGJxAN3+iWe88n424mqdprO887V1/5kC5ub/V3ONfKHNxX0qk
	3SnJkkHefys+vINYytoU3+ecNpmY404k9vNMvb9JW8CLKmoP2hKDuWY2zDJkq+Q9JOqf1eSKWeQ
	tyqEWWezZi1gNNOBOx8Nvi3rOsdsrNtt4XI0Q4w==
X-Gm-Gg: ASbGncvqggXjm963cT+IzIcVH59pVd+cSNLASRPZfkvqf+D6JsxMdYecy81omVqEayc
	9lqfONEkzAbJjMj3VIHeIatEp4VLUle+98J3dHG0dcLmivtBD9OPm2ax+tjK+mJVpvF8+2knqKz
	ake3lAEqAbbFAwTvDZrKRd3xrTSoxj
X-Google-Smtp-Source: AGHT+IHHKd105pMUM7hpNrdHw+DbdrnqZ5EC6cx99kZCwpvRgGxoGb+A1fhqNQ5wFNuzoFZcndivxdAsgOXkV0/lbpk=
X-Received: by 2002:a05:6808:2f16:b0:3f4:bc5:d478 with SMTP id
 5614622812f47-400363134a7mr3524712b6e.25.1743684571646; Thu, 03 Apr 2025
 05:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403090336.16643-1-cuiyunhui@bytedance.com> <84iknl5uex.fsf@jogness.linutronix.de>
In-Reply-To: <84iknl5uex.fsf@jogness.linutronix.de>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 3 Apr 2025 20:49:20 +0800
X-Gm-Features: AQ5f1JpnMmubUJfEadYVURd58tuRsHjz_7_L8SWcbm5caDG690SroX2z58Xym34
Message-ID: <CAEEQ3wkOQUh03Ggpf=mBWzNt1_Qtcv53gNXm7JH5Nban3tOtvQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] serial: 8250: fix panic due to PSLVERR
To: John Ogness <john.ogness@linutronix.de>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, pmladek@suse.com, 
	arnd@arndb.de, andriy.shevchenko@linux.intel.com, namcao@linutronix.de, 
	benjamin.larsson@genexis.eu, schnelle@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John,

On Thu, Apr 3, 2025 at 7:58=E2=80=AFPM John Ogness <john.ogness@linutronix.=
de> wrote:
>
> On 2025-04-03, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> > When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> > an error response if an attempt is made to read an empty RBR (Receive
> > Buffer Register) while the FIFO is enabled.
> >
> > In serial8250_do_startup, calling serial_port_out(port, UART_LCR,
> > UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> > dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
> > function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> > Execution proceeds to the dont_test_tx_en label:
> > ...
> > serial_port_in(port, UART_RX);
> > This satisfies the PSLVERR trigger condition.
> >
> > Because another CPU(e.g., using printk) is accessing the UART (UART
> > is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) =3D=
=3D
> > (lcr & ~UART_LCR_SPAR), causing it to enter dw8250_force_idle().
>
> Didn't this[0] patch resolve this exact issue?
>
> John Ogness
>
> [0] https://lore.kernel.org/lkml/20220713131722.2316829-1-vamshigajjela@g=
oogle.com

No, these are two separate issues. This[0] patch is necessary, as
expressed in this comment:

/*
* With PSLVERR_RESP_EN parameter set to 1, the device generates an
* error response when an attempt to read an empty RBR with FIFO
* enabled.
*/

The current patch addresses the following scenario:

cpuA is accessing the UART via printk(), causing the UART to be busy.
cpuB follows the CallTrace path:
-serial8250_do_startup()
--serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
---dw8250_serial_out32
----dw8250_check_lcr
-----dw8250_force_idle (triggered by UART busy)
------serial8250_clear_and_reinit_fifos
-------serial_out(p, UART_FCR, p->fcr); (enables FIFO here)
cpuB proceeds to the dont_test_tx_en label:
   ...
   serial_port_in(port, UART_RX); //FIFO is enabled, and the UART has
no data to read, causing the device to generate a PSLVERR error and
panic.

Our solution:
Relevant serial_port_out operations should be placed in a critical section.
Before reading UART_RX, check if data is available (e.g., by verifying
the UART_LSR DR bit is set).

Thanks,
Yunhui
