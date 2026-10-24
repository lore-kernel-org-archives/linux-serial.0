Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792846549;
	b=se+3iU2zLWv+HprhOQvNXbJ2zIoB7TJahyn1+6ObDyvRH+l4Mr6ypuT9JERepRfaVQe4
	 p/J+5mcATIc9xYgzCeefMaxTAkwZhkXTcpZmlO4ffl2C+uYeqxbaLB0XSMBRmDNI9b1AE
	 Yz8myxWukM9ZtDs6G0jD5n4x/1NZIjEjP/oWCXG+bEgUMAgWWU0Nr/XVV7cuhz7ml8l4A
	 lau86YpongcJ7CAnmZqdONBwcWt2pEwhG9KmPz+bdpfViJAEZeBPSeB8ryazzHx6hhCg8
	 RF55ELh3RhMt6xSYKIAnO328caB/uDwHP9TQKXXAfV67eZUS0wSRHOVdP4/m/BElDvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792846549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:Content-Transfer-Encoding;
	bh=qDN0DhZlpG31Db1a+qgDTn9ndshsKxDFrnBds7GpNtg=;
	b=E/y2n9G7Op1Fjt1ysK6ebFJ8behTtIfMQqfBr0dJ85z5jDVJT4BZUQZ1ZpI7lp4d14Iw
	 mJFAy2thb6DZ93pfcay32r8Td5dQot/LsZuXmCpPiKH/B5Fl47LA0ksY3x6O1h92gOWiy
	 +fZ+xzxIm6+qKCEYU2qhodD75AK+HDVFfywRHaRzE9EKpp9WZ/oPEroHEDewBePhfIDBq
	 4+zedPhBl3zSP5pKEm7PDa1TRt6IA2LXCuJT5V8aDrZ86VWKVWm3RbMUTCbBrzf4wcLst
	 GVTur7wI1rx6zNk32/gzNlKLnQus/MGbHkaX2oAE91lcumVgtPKPqYOPm6dlV/DeFqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FMGUVPj2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A78606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 12:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30A78606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FMGUVPj2
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3550c917fd3so2567958eec.0
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 05:55:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792846548; cv=none;
        d=google.com; s=arc-20260327;
        b=cyExQ25WFs9S7ywdXcGoR6qdd3CQlpRMdyh/gCq1LtA9GUQ38+MwWX/H/UUow6vxHG
         hSMwrkuXKM9skAiH5KsjD64j4qHZZoukQGCk8k6mQ+ScvtDnCwSSVlBOm3GDimA5PfJ7
         s5PrzCHXXl24xFIqF1fXmzuwQGuVwoqpyW8LupSTfuRp1pV0TFwuwHJlOsbtQT2DYa9q
         yaqwHJZKfRT5FOd7zxya45C0BrvabbjSVTq9hWUy1jKaFaAHMYzON7CgKyrmyLrtzwOk
         Ds5MOHFw+FLK/RWqP//fPfqzZataYPJP1p+LDpet8LtXWVhwOeVUtIJfqbn9NjM05S/C
         V3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qDN0DhZlpG31Db1a+qgDTn9ndshsKxDFrnBds7GpNtg=;
        fh=FnZ4GR8kGLIbDoqbKQI5tYkHMYb7lCvK2UEygoFKylw=;
        b=mAG/93uf2mdZAEe4rkr3AEpX+5m52Ij6PNTRrIz3RGq+DcFu9wdqzo1AXZxH9+KIwQ
         Hph4S512A0HA0Sx32SkJSRlkdxWI4zxjirNCSQtJgagAHjtMw/0Iy2RQOf+cB/JeUEDs
         Ar0uREx2qx12/VNWFwn9J6c/vUy2Kbr0EOcBT6prA6qjO0DgHfjtQe4tJt1IrqRy8Ld4
         h3M88dOrs2Jd4n6RoLmm7VHW4eAEK8NP9B7Bm0+jYENv/3xJ50ht5u3HH/goTpAGe+at
         zvv9UW1N9eAgyDewuyrnftCaBfFHIyDDLYmkHQWTQlxcdFFg4GvvPz+Gm1RiiarWZ7VX
         VEmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792846548; x=1793451348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qDN0DhZlpG31Db1a+qgDTn9ndshsKxDFrnBds7GpNtg=;
        b=FMGUVPj2ETH9pORqUREuH1VbouOqxF0Ffuvhmuj9WL9f+8LYi+ZKq1YlilzRPI6MnM
         xcpDwW4JkSvR2Cp7A1BzZZFKvqOv8S6jozlid3XjTKFnrqx3F4GeXut/yT+BAbzmqYKH
         AKZ+1NFB8mzn7RZHnZNcPEq/TWYwLCi3fnz2e6bc3cqRB7aOqxNAl4XLutX+n0F4dxmN
         Dfix1ZUFNTafE/OOIGH5s0ZHXq/g72/8kbaVBNLtPa5h82BaZnwEBVBuvdjLVCYlHpF8
         6FFvtEBeh3nEqZ1EJY3JGQcPEPi1tUgT03UUxOdKNuBSI9gCmDGcLgRav+eSp+WtLGuw
         7xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792846548; x=1793451348;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qDN0DhZlpG31Db1a+qgDTn9ndshsKxDFrnBds7GpNtg=;
        b=NzP8OXY3Thrz7go7j7A4DPqywzVp7HccZxdqBGnFNfKjsbbWN0vRzYPKE3Yh0ex6sg
         ZKXcl0OQZ6rk9oQ9PqrYaURosOe7eD0y67VH2s8uKUmv7VbKedK+/ANfFJVsLRVOafJE
         nhPJE9rnTtOhXHyK3YeetdWcfv8bxu+BpIZJsK1j9bGgpWh3okyLplDXzenXenEFf6de
         NjBzW/Uwl2PuOuesV+NLYfyQjBxAlheIMpRnoHw0UQ5w/XLt5sUVjvraBw5eq6eBNqd0
         +IMYi52gPonliTykzYmnf9m0XhN2VrmR6KPxTJvM/K/oyeqHU02WG7kRHF7ZJT+1n2L2
         22Yg==
X-Gm-Message-State: AFq9FYJhOrvgy2US+IEZ3/Qtg55HnAPV4X/lRW9SIGv06zRYTJ/5tEsf
	UBpDOzSdN5NqDmjJUGkwtcekeyeypimZas33Iap1zk45l3+HsF9RdDy3+EfRWRM5sVcjTfQ1n/u
	XtiD+nmyfFypWBUq7zIsNv5myxr6nhsTRBg==
X-Gm-Gg: AYBFou2b6w+cyU9RjezgXCHnypboGQIx4vduujXo9gE7hl7B9fzJNvYTAw9CdqOflSe
	CYYbYZFQhZaQCWjwFklT7DQDHQ6seEoYTX+OEf0Mb5+sCtT6dTErs9zTryGstvkNREqScxPjK0E
	EDUfR6F8pQQUsv0451gEs4vV1oaNvqzQXkqzGcafK1qHa27mahO/UDG5X1hfFqo4cactNR2N8Z4
	YGCon1B5NJrkboB+A/BupJU3DjtUM75XkLO0UJseXMwtgRC7OM5l2GyE7xR5IX/KfM372am6M8R
	8PK+PoVg8Yn2Yj18+EotUw8I2wlGafVBIcshuBO3V306nHIrmH8rbSi+/WDrW+uMijzauIS37l3
	5pRBZQ2al1EHqaHrrL4TZi5fVK7PHhuyIGGq5LE7PdZF2ysMrT2cY9X2X/xNHSEfaVA==
X-Received: by 2002:a05:7300:8812:b0:35d:e49e:74ec with SMTP id
 5a478bee46e88-369e84e88a0mr3831920eec.41.1792846548250; Sat, 24 Oct 2026
 05:55:48 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAO6a-9_b5qEu7WqZ_Db0fwKRo29zhsYV+UbQFPvHJa+O=HES-Q@mail.gmail.com>
In-Reply-To: <CAO6a-9_b5qEu7WqZ_Db0fwKRo29zhsYV+UbQFPvHJa+O=HES-Q@mail.gmail.com>
From: Vivek yadav <linux.ninja23@gmail.com>
Date: Sat, 24 Oct 2026 18:25:36 +0530
X-Gm-Features: AclHuK-8zD_o0_eJd9eBwAAfd0VJ1S_c-vwVkRG99e3nUL125uREUY1PVqYGNmk
Message-ID: <CAO6a-996waMafG=p1-GN25P1zsECAgW=OMV-UBnp3060bo2iRA@mail.gmail.com>
Subject: Re: Questions on UART FIFO Depth, Watermark, and RFR Values
To: linux-serial@vger.kernel.org, linux-newbie@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For wider audience

On Sat, Oct 24, 2026 at 3:21=E2=80=AFPM Vivek yadav <linux.ninja23@gmail.co=
m> wrote:
>
> Hi,
>
> **File:** `drivers/tty/serial/qcom_geni_serial.c`
>
> The functions `qcom_geni_serial_port_setup(...)` and
> `qcom_geni_serial_earlycon_setup(...)` both call `geni_se_init(...)`,
> but with different parameter values.
>
> I noticed that the RX watermark is set to 2 (`UART_RX_WM`) in the
> former case and 8 (`DEF_FIFO_DEPTH_WORDS / 2`) in the latter.
>
> I have two questions:
>
> 1. **FIFO depth assumption:** Why do we assume a default FIFO depth of
> 16 words? Since the FIFO depth may vary across hardware
> implementations, shouldn't we detect it at runtime or obtain the value
> from the device tree?
> 2. **Watermark and RFR values:** What is the rationale behind choosing
> these specific watermark and Ready-to-Receive (RFR) values? How do
> these values affect UART operation and performance?
>
> Thanks,
> Vivek Yadav
