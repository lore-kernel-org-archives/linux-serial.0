Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248931C07C4
	for <linux-serial@vger.kernel.org>; Mon,  8 Sep 2025 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353407; cv=none; b=EIXJEkqrRyeLE7cjnrW+4BfRuR6LQwSn+I5bTQ3JqwL13qI+3qghUMDid4CEYyQTY+JfB3UnTV3DKHIEwQbbUMspD+v1MiCosPBCjf34lLl5syEOJDjvH8XYut1mvHEKZ+SMJfeGSOhOIcGzPru6Lpnz/MUK1PPwemSVVUjb8No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353407; c=relaxed/simple;
	bh=uNe7xwF+09czpp1zvAQmHWliffYX9vJgmJ7NMWFNsBk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=N4XL4999R/MCJL4UZXhoQTSknPm5Uqvgzw9C8WhC1TJSsnE+RxRQrmaIHJmzgAMTfaaJgdAVurPgt3x7D0x0QZscyEU6SZwoYNejKDWVKGXr49vLMo6jnQtoo7BTF8Kd4tAHliRVIT7mF4aFfm5mspm7grJ/PXqGvZYvdV1Ckvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jbC2l8nS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbC2l8nS"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45debcea3aeso3916255e9.3
        for <linux-serial@vger.kernel.org>; Mon, 08 Sep 2025 10:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757353403; x=1757958203; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9xqB3OJYnbhkKTLmD064zHurp1hR8d4tN/toD2idgE=;
        b=jbC2l8nSDYoJj8OtuOa04UBLNTDC5YLxQwRAmjM3q6OVLjMzS5eaOTdKa8QiqruWoj
         /VV6gFuzsYKCf0JdNoH/Z1mDjY3vodHPQb6xD78oVxkH0dnPd0vk2/ChCvR7erGmdUSw
         CelL8gzo+jj5NTh1+L1T6A9iNY0DGev6XKZBqXjlcEeXq1zfB3Vcn24iu9zphALwjXoF
         lG3eQCKHbc6A/yC4Ol1C0uG1aToL4O0pTQfYS/8senpDOncOKSpoQcqRBIH0MA1Rvp4u
         ysMHHZkqmHeYjm6qYiPh1pMkK57XmXmH/ES0VxrChYo5bUe4etxd4HwIbDk2IH4YmK2W
         FIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757353403; x=1757958203;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i9xqB3OJYnbhkKTLmD064zHurp1hR8d4tN/toD2idgE=;
        b=jLAF8E0gkcGvbPXHlKFeYwlqnuOr7eNsbVD+PT7ZtSa5augFxfYtRq5r65QVaBkJiw
         inmTIh9pNsizaUikf8P6Fmr+XPj+XBJDFDuDI5i+5Q4zDgxhAWnKfOORvTPPrZLlT4Uw
         5SdoCOdElo3+g1ZXKmWcQpk4rDyTVPdFey/aQiN/bn3J4tff7+v6xne8RdgS0PLPRLQF
         7szlWUqDgjI5xKmx/fnfan/E2qpRJ/3q8nsWAl6d6WiOArDLy35g7NDY/0KFxZuy28E1
         Uxjr7CWho1lpFkSnHk1kWfmXlak05wMdWajjZc8JlLmFN51kIzXH+mTj7sm1MEU1k6wN
         K7TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcZsi2WXNxbI+eatziQqmnwgnotJrR94aQPwCL3vknTLJmOMOJXPU6RTDYEv/ffnpN+2o8v5cX0V9qQ/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4eG6oy2EOk73cCEeXtBiebAfy2M8fBLSyofZ5yT9MGhqohBC1
	4iVJonN8ZiuMHtMvk8tq20Q+lzoEfnFxTrzz/FmEUtZ4KVoK0Ut6NWUOPvYXAz+uaBM=
X-Gm-Gg: ASbGncsBJlzWwWX+4InJl51IBXbMrFlmWp5II41+3VgQTGneT8deOMvGtm+Q0zQeEAf
	odeieftTjPUVIQLgWvTJtFd/iCa+pFtWndQiBoKt852RdFDvNp+DuC8tDMcji3OgECMvuPeqOT7
	+K6+BtmeXFBY0voxrnmf0xr8ilWjy3Mir20MlK5Trm1kljtBu4MyJImMjkPVTeUcRHIFxvG1r38
	YMsI11WUg3HS9dNSoAapfgM9rR4Z7mmQPJs/mP9hlWlGsVtaQTgw5Vr94nBhGYTcLw24JXrux6U
	sgZ4vwnlZiVzRJcqqZL3hbxpW1i+6ld0bllzq2eKnLct/LSHEQAPHm1N34K4mtf/eDmpO1PbgsV
	5hWvPHNO2v0b53NezeDVxMDnBnFYwv6ecpSKyiw==
X-Google-Smtp-Source: AGHT+IE091C8zwFMRw0Jlkq9rgizmdT1JXnkZiZtb71fLUbeqCOaZbrCKUF+l7CPSQcBUn2jxocBYA==
X-Received: by 2002:a05:600c:468a:b0:45d:d19c:32fc with SMTP id 5b1f17b1804b1-45dddeb7e1cmr82645915e9.10.1757353403512;
        Mon, 08 Sep 2025 10:43:23 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:1299:47dd:d3d7:b7cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45ddb779eb6sm136589595e9.8.2025.09.08.10.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 10:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 18:43:22 +0100
Message-Id: <DCNLSFVPCKMV.K1UE3J3K6JQD@linaro.org>
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>, "Bryan
 O'Donoghue" <bryan.odonoghue@linaro.org>, "Praveen Talari"
 <quic_ptalari@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Cc: <psodagud@quicinc.com>, <djaggi@quicinc.com>,
 <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
 <quic_arandive@quicinc.com>, <quic_mnaresh@quicinc.com>,
 <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v1] serial: qcom-geni: Fix pinctrl deadlock on runtime
 resume
From: "Alexey Klimov" <alexey.klimov@linaro.org>
X-Mailer: aerc 0.20.0
References: <20250908164532.2365969-1-praveen.talari@oss.qualcomm.com>
In-Reply-To: <20250908164532.2365969-1-praveen.talari@oss.qualcomm.com>

On Mon Sep 8, 2025 at 5:45 PM BST, Praveen Talari wrote:
> A deadlock is observed in the qcom_geni_serial driver during runtime
> resume. This occurs when the pinctrl subsystem reconfigures device pins
> via msm_pinmux_set_mux() while the serial device's interrupt is an
> active wakeup source. msm_pinmux_set_mux() calls disable_irq() or
> __synchronize_irq(), conflicting with the active wakeup state and
> causing the IRQ thread to enter an uninterruptible (D-state) sleep,
> leading to system instability.
>
> The critical call trace leading to the deadlock is:
>
>     Call trace:
>     __switch_to+0xe0/0x120
>     __schedule+0x39c/0x978
>     schedule+0x5c/0xf8
>     __synchronize_irq+0x88/0xb4
>     disable_irq+0x3c/0x4c
>     msm_pinmux_set_mux+0x508/0x644
>     pinmux_enable_setting+0x190/0x2dc
>     pinctrl_commit_state+0x13c/0x208
>     pinctrl_pm_select_default_state+0x4c/0xa4
>     geni_se_resources_on+0xe8/0x154
>     qcom_geni_serial_runtime_resume+0x4c/0x88
>     pm_generic_runtime_resume+0x2c/0x44
>     __genpd_runtime_resume+0x30/0x80
>     genpd_runtime_resume+0x114/0x29c
>     __rpm_callback+0x48/0x1d8
>     rpm_callback+0x6c/0x78
>     rpm_resume+0x530/0x750
>     __pm_runtime_resume+0x50/0x94
>     handle_threaded_wake_irq+0x30/0x94
>     irq_thread_fn+0x2c/xa8
>     irq_thread+0x160/x248
>     kthread+0x110/x114
>     ret_from_fork+0x10/x20
>
> To resolve this, explicitly manage the wakeup IRQ state within the
> runtime suspend/resume callbacks. In the runtime resume callback, call
> disable_irq_wake() before enabling resources. This preemptively
> removes the "wakeup" capability from the IRQ, allowing subsequent
> interrupt management calls to proceed without conflict. An error path
> re-enables the wakeup IRQ if resource enablement fails.
>
> Conversely, in runtime suspend, call enable_irq_wake() after resources
> are disabled. This ensures the interrupt is configured as a wakeup
> source only once the device has fully entered its low-power state. An
> error path handles disabling the wakeup IRQ if the suspend operation
> fails.
>
> Fixes: 1afa70632c39 ("serial: qcom-geni: Enable PM runtime for serial dri=
ver")
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

You forgot:

Reported-by: Alexey Klimov <alexey.klimov@linaro.org>

Also, not sure where this change will go, via Greg or Jiri, but ideally
this should be picked for current -rc cycle since regression is
introduced during latest merge window.

I also would like to test it on qrb2210 rb1 where this regression is
reproduciable.

Thanks,
Alexey

[..]
