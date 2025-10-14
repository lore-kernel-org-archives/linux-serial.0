Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D40313274
	for <linux-serial@vger.kernel.org>; Tue, 14 Oct 2025 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444387; cv=none; b=J6SdC22bdb3Kjt5rgSQo8lMIrKYCg/C2cZgkIrz2u/2lou96KLTyUaKnV+k1e7aku3O1ce5Ag82Gv4PjSXXP8UoREJGYG02TySskvVHsYEiz/APtZr8eRvAdokdMHWe1PxHxHB9kcaf1m4yPT2A2UljFzJvzJXJXauWO+vtat+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444387; c=relaxed/simple;
	bh=9Cgq3/vxKjPa4FSJjaPLjZD4QjTbX4U3nZUHUx9kdvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCcIpfG3hSCYTrPoypOqmc68qLvL0Lr+z54Qzd7wxefYQ72e1vsJgKHX+Orpi+UVGt8tUrbPljagh5jWZ+WwvNeDiD2JI+bBchV54Qr3ZO9AywaZ1Uer/uDFaUx9vpZ7cP4SkvQc03s1rpIm/pAipvmTLtZAulglUxQfybVjc0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Dq4CZnV/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Dq4CZnV/"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27ee41e0798so84676845ad.1
        for <linux-serial@vger.kernel.org>; Tue, 14 Oct 2025 05:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760444385; x=1761049185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyztOWHi8asqtnrtL9aOW3mSM7WuQU1xzUJYBCn4JPE=;
        b=Dq4CZnV//tza7E3FP5gglEEnLiYQEl0PS367PJDMB2Yk2ZUOnyaNuwG/ivneuv+Fk9
         e8pYY0k0ZnJ0Q82eRec78UYGXUX2DzQcp8rqt2jsFtZlA++LGn/TBU+gZVzYtbcKDE7X
         r8sJorh/rKuxZz7YeLO9XHY8xD6QcX2jZcrrUoSleap3qSYOrOlhUZ34Vj901AwFSDz6
         6ruJRsLfNxiXhnzTskfWwoQQhp/ZwGgPrZWad0NShIxIsB5GC1e8ohQSO57b4t91888q
         E0XDlEWcyicWjDZVfDda4QZczUCzzZ3zmvcSdAV4WU3wGFhf/LDcW/jQQLrZA4YkrDZW
         lpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760444385; x=1761049185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dyztOWHi8asqtnrtL9aOW3mSM7WuQU1xzUJYBCn4JPE=;
        b=EcmzKa27lT7M05uiFqbS9D0TXSu2qzL090gsGP4mZLW7QHX7SUJshN11WRPAz+//l9
         xXMhdzSnt+U52RxWDkKcuipdN4gskIYKS3NbJ260iu1kB+m76j1BD8/ZlS5DaNFZ1018
         5D1P8mNRnZeMilo0LzFomGs+PWxGEM6A0btV3B1TY1jVdyVmHrks33884qhjKM5KoCmX
         TetrlLppdyz+755mWRoYsiG1UJjyOEd16u0rmP4zRRblouBOPNkrCYi0pRW63Pi2Cxde
         /Jk3H4lNduWbGFsDlO84GwJa/eu+EshrxxLvz+TC04S3RaEx+rIHdyBdsW+mv7px+4DM
         dL0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKt9Nrtp1UxFQC6ROhCLQ3nUm98JUUj3JkLJIeX/lqQUx8ok9QUxnKIL4UHJUN2PuJmFaXIUTNMhGEgzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7lP8v5zpUO4/a6XP/RTf5d/MtQ0zGoBk1Lq3NoKbie5BdBMqU
	++Ra6iQ2KzsItF6TVw6rFVPlP6kxYM3vblR8gPSR4N0Wqig8ITE8ArKckyax4pQFVbs=
X-Gm-Gg: ASbGncvn3Cp/LNz7vA/1ecUY0eAwGR+SPKQbibNXHi/U5YS2dEku2R9bqdSftS0J0Uv
	RxKtx28bsDCix+QiwF/qDzMdWO4WCs/P/FCdSPk2buEvWnX0yiN4NphlpiDkxyCjG6r9jgGj/og
	76P+JyD8pUDnyQkqKCpQouI84ItD9e9blTuSyxSdHYmh42p8GpCCYjVps3zaRntgB6lahxPY/aB
	E3pTFuUwbzzRcOLgtAVYs0oY6aBxdRz3MS5Fv65avm32Ef7LXIZQI1zIMohZ1l7Mk5EoOexTIqw
	Y5Vew7q6Qnua+Zwfexl07tV7d43htjo9qwjKLeLC9tSbfyfapo/IYmppVl3xIN7nSRk6VRitWUB
	Sj2NPuSmrElPSPL2sfhu+GqCRSov0KAgm1ERQwIeADpePqImi6bq4CPwgpDjVfRQvxeFRH6cdlN
	i4Gi28hsk=
X-Google-Smtp-Source: AGHT+IF3sLetSxQ1m94sJzX4H+YdIKP4pPPwBOsljLuRxv8OwwGf8uQEto0kkirs4QMlkzqClPfJIA==
X-Received: by 2002:a17:903:3c6c:b0:269:9719:fffd with SMTP id d9443c01a7336-290273567e5mr321957135ad.1.1760444384799;
        Tue, 14 Oct 2025 05:19:44 -0700 (PDT)
Received: from [100.82.93.103] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e44ef9sm161761065ad.52.2025.10.14.05.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 05:19:44 -0700 (PDT)
Message-ID: <94d19d6d-5bb5-4156-8499-0be3d227f478@bytedance.com>
Date: Tue, 14 Oct 2025 20:19:40 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250: always disable IRQ during THRE test
To: gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 songmuchun@bytedance.com
References: <20251014114727.1186-1-zhangpeng.00@bytedance.com>
From: Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20251014114727.1186-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/14 19:47, Peng Zhang 写道:
> commit 039d4926379b ("serial: 8250: Toggle IER bits on only after irq
> has been set up") moved IRQ setup before the THRE test, so the interrupt
> handler can run during the test and race with its IIR reads. This can
> produce wrong THRE test results and cause spurious registration of the
> serial8250_backup_timeout timer. Unconditionally disable the IRQ for the
> short duration of the test and re-enable it afterwards to avoid the race.
> 
> Fixes: 039d4926379b ("serial: 8250: Toggle IER bits on only after irq has been set up")
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>   drivers/tty/serial/8250/8250_port.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 719faf92aa8a..addeef7a0d59 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2147,8 +2147,7 @@ static void serial8250_THRE_test(struct uart_port *port)
>   	if (up->port.flags & UPF_NO_THRE_TEST)
>   		return;
>   
> -	if (port->irqflags & IRQF_SHARED)
> -		disable_irq_nosync(port->irq);
> +	disable_irq_nosync(port->irq);
disable_irq_nosync() may need to be changed to disable_irq() to prevent interrupts
that are currently being handled.>   
>   	/*
>   	 * Test for UARTs that do not reassert THRE when the transmitter is idle and the interrupt
> @@ -2170,8 +2169,7 @@ static void serial8250_THRE_test(struct uart_port *port)
>   		serial_port_out(port, UART_IER, 0);
>   	}
>   
> -	if (port->irqflags & IRQF_SHARED)
> -		enable_irq(port->irq);
> +	enable_irq(port->irq);
>   
>   	/*
>   	 * If the interrupt is not reasserted, or we otherwise don't trust the iir, setup a timer to

