Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.192
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793119002;
	b=2HRUiTvZGGa5vWulKdol3VcOpAAoqwN//wIHe89jgznqyK4aEbgWZTXX3p15Ud3uNS4A
	 di9mZ9Zlwrss+WS3/XZ4XVFoKm9zOJa8/JmmziHOi9Fgzml18y42uCAd6EusDfvMhm0xW
	 ZjjTDnytAfCC1yFgJmSYFUHzOzkaZJF/D3rOv7E4ReE/HP0/4NdEpbpZicwSY5cXxTI2S
	 iniMkaYhLUiaNTas9HO6sKFeF3KpILr2IutiyvOm7M+4CZayF6SBWIhs1tMxw0oIP0vKr
	 n08vsEBECpMG13zjLY7sRkP+NocEYucR+vmoQ2z6ELNeCLrby6Du2N2baupGECCEu8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119002;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Xi54PCNZJa5IyWG41EmJ46Hym1XE97Ph/llnyZDu774=;
	b=BWKGPSK212JERYK7R6f3LWSM5Aid/WJpS+ukDIoUL+X7Q5RKF3PEt1BKzfwaSOiA+oGT
	 1CLqGLSgz2SA0cqdFYAWhOspUuzlOx4/VMO+l6rytlqG7xpdexJ62t2wGmeEY4OPcchMS
	 crf97L1Zn79HDvxRfiKs0pSgaEjifInOJlx/NB0gfZjsB9ZyiFoADV/ZHcgQU6TEcVAy6
	 HUStKcvY2xucobIH+hDCM8csQU4Dx1bYBPCZB2lDdsqbnBeD6Usc2DLSQYkGm5uTuAmjs
	 ZMM2RAsqAZ42zoJXRSICdMN4q47uewGHQPomCEAeJUyT1SEAiOLL658DRWZLbqO45MA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aYNNuOSN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.192
Received: from mail-oi2-f0.google.com (mail-oi2-f0.google.com [74.125.231.192])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81225606A31B
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 16:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81225606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aYNNuOSN
Received: by mail-oi2-f0.google.com with SMTP id 5614622812f47-533fe730856so32903b6e.1
        for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 09:36:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793119001; cv=none;
        d=google.com; s=arc-20260327;
        b=CSU8v/gz5PtHnI7unYroNzT/KNI03LIiGJrTvuTo9IfKZT8UoVpqUu0rZYf4TjY6uZ
         bukdOjObHlGhsj9rOnggrkpktolou2XIv29oLAUKeXybuDpYCf2TyKKwbyHkqsaNc0X/
         CIANQlGngWK8kUe57fnwAhv/WNHMstPDyP6zo/+Sa/nncagFuFzg6JQI1OIvaXWe0MKi
         XR3TgxnNFtKHowlcoxrG7V7i9e12se14m4sarZbA8nEA66aJZ2KkuhnXP8sHRgJDnnaF
         fuXA2GfSMJcZaNGym7ie0msBUFGSAl0Wr9GRPdKsbeb62dtJP97NVHkkgYdgeYDgVYi7
         nWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Xi54PCNZJa5IyWG41EmJ46Hym1XE97Ph/llnyZDu774=;
        fh=2xzRHu4x6cb9PR3/h3XH9pQfe33b42p+PWaxI4MLpNs=;
        b=W1Rp9lUDqOcoxuUXC74ZKDpBx2WeCvdBlc9nB8qFImv2Bra/4ArY3krxwJg72oMehU
         zBljbJRQL0VLYXTN1vdZsBiLuKVkolw4vagog3N8DETrdMiWBAeVtc2K0aWMbWeyp4Ih
         2202utfwP7wjHhPCPDbCCOGX64gsHEY6uOqX48NGqXfUZvpoIpGy6X7bX/e5Wp2Uzt2B
         NMjKu8bgcSh6+0w/D5Is6AFohpyasojIMbrNn4XE8zHZ4V1L6vPNsujMX5e3c3nryMmI
         D2zIn19XUviXqvyqvGPs6tDhg7o+ipXll2vhK9u1WnxXMFbJ8GxPbYvTk5KPmtJpNttF
         aC1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119001; x=1793723801; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xi54PCNZJa5IyWG41EmJ46Hym1XE97Ph/llnyZDu774=;
        b=aYNNuOSNam8qMoFAgJ+Jczz3/NNuRJ4vDkebynxz/nX9V6RmmDAPjxR6gI4whM2jrD
         cOW3lh1D2tQv0xv94iI80LiTZ0PCmRtUXxxq5ZtnGYVPOTVHp7bbIRKAjPlBxY/3DAAu
         54QfqdFit1qfWa8rVwJHYzyqBb8GZTEviPxJW2qW+5YU7e/K3B2MnH/iG6l/g2EO+eHp
         uOdcZZ3NFJOhrPINp9HRF3ZtYv/Rc3+P2q+gxgRFZDva5MernMj/O4YLsRox/nLVl0Lf
         nSlhQFPIJzu+O+r+BhdpkDPUoObtkGFD1Lg/bJNeuNUfnGUvvqHNJdJdNTGAN94eD019
         K+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119001; x=1793723801;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xi54PCNZJa5IyWG41EmJ46Hym1XE97Ph/llnyZDu774=;
        b=CgOduYFEK+SsvrP65u8bL44zfsFX4pNaY7DY0s1qFUzkC9J73cAeb6L9USdmyxB+5d
         RFuQzQRGtt4k3OVzS4iByozKcKxnxkPEHNqOFActcgZ9PRjdM/Yl18Gi0j8eb4Gcrpyf
         hNmMiroscsU9vIrqvXM1vc+ivU+4SHrgQK52KSWManq2cFmVqjnXetekKJf3c1WgNRR+
         ctK18+dnGMFQe9DN1dXucQLJyKl/cg+69Nfok+iitWNt2Qauv280lQNLBZ29NCILku2+
         FN0RgTUEpVBvUtBP0uRWO7DxqgWcOAbCugEwpjGlNijqqmFY3GabbjgPRkdM7gf/p0p2
         Dprg==
X-Forwarded-Encrypted: i=1; AKwUvBz/yPDLpgWv9CrWbEAYYqtgLMsFQYJj3z96a69ZlWNNHbUYAXzMFgVMUCZxn9RIZmk006svxQngl0C7O7s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKehcXiV0R8+4rinX9IqV23ouUMHnmslw95yCMQuMZ6MbO1Iuo/
	KLgBB50AIu4LWA5hhSc4SWB4I1j/k9Tyefr8qWFN4rfCvQPTvSmawagrOR/a9rMipdDlCgNeS4p
	s4l7aeka4b4pRpbNE8/Ta5zh471TT1OAhhNYjRNDdnA==
X-Gm-Gg: AYBFou1cF+okM6hVUaxsHUQplV1s8VLw+Bd3A1+Fe7yfReiYsaHLU6t9wrmT2g5HHo4
	GdmBShBAMjGuIevwTLCTsIqRsmJR986DIFi0g3kv+EpGmV+mWMJPvJOREwtIlpyZKWomJX46XHn
	GEeIMTNh77In8/SlQaBZPnWJKkLAgO5LLtP6XCHDy+gTUu9XFX2Bd6tyJGRIZhU7rQOeVg3J5Bc
	GzIq79QUFQSNYshPgJa/vI0pg+v1JzsEinVKdNNMnpagat4j+tKv2j5Y7AEerCl5tl/2WLM0vKT
	Uu/T/68thMK8ydvJpVksq/IIcynZdwxLVaqKku9jG4m7/89Y2Q8+ffclXVd7YYI1S9+Mzl883ps
	o980DDemGsWSjt+/e5ti13Z4xGj3VF+oFpnJHc1m5Sh97t4oY4/hsrAKMw559YJeV1V1np/4=
X-Received: by 2002:a05:6808:199a:b0:4d5:291b:b852 with SMTP id
 5614622812f47-55c0038ffa8mr7489693b6e.56.1793119001512; Tue, 27 Oct 2026
 09:36:41 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027054304.35543-1-dennylin0707@gmail.com>
 <2026102711-venture-amicably-24c7@gregkh> <CAGEkeHePGOKXsHg-bqkJH4Dpn=OSxTQx8z5vbjW18uSWHqrpWA@mail.gmail.com>
 <2026102704-exploring-tipping-354d@gregkh>
In-Reply-To: <2026102704-exploring-tipping-354d@gregkh>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Tue, 27 Oct 2026 09:36:30 -0700
X-Gm-Features: AclHuK9LqtqZ5hKmadWWIqpv_URGMX5Z-jKFc00OC_GD2fupaWPqQMV78DPUxyA
Message-ID: <CAGEkeHdk-zxOcN4-gYJS-NOLn5+THtx4b0opSQ4PRUgrRtTkOA@mail.gmail.com>
Subject: Re: [PATCH] tty: discard flip-buffer input for TCSAFLUSH
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> What is going to break with this change?

I missed that a throttled VT paste can hold the buffer lock and
block TCSAFLUSH.

> Why change this at all at this point in time?

I noticed the mismatch with the documented TCSAFLUSH behavior while
reviewing the code and thought it was a small fix.

> What needs this fix?

I don't have an application failure to point to.

> And how was this found and tested?

Found while reviewing set_termios(). The test completes an 8192-byte
master write to a raw PTY, waits for 4095 unread bytes on the slave,
then calls TCSAFLUSH there. It leaves 4097 bytes before the patch and
none afterwards. That PTY test didn't cover this VT interaction.

Thanks,
Hungyu
