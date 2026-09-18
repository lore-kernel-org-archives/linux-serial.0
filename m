Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F643BCD27
	for <linux-serial@vger.kernel.org>; Fri, 18 Sep 2026 07:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789717928; cv=pass; b=TJZVxLx9wN4RAnGQHLMbhoVI+5N4T28SpT1eY6cMYsQiqlKJWeZkGBLwVP4DEUGF7vLbFbjfSAamuYM6IeASTPjNhjOsDAiwANAbRqYGuEr4JCFhHsSWL5XHta/jtWgdidpvmKq7oYEznqeAZw0QvMy02tTEPpszdN2+OVKvCzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789717928; c=relaxed/simple;
	bh=HmU3O9u9jVAkFRCkWEdl+bin1iaF6HrroVvtBQG2j9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3hhIZeQ8Y7yZCYhICbWOEvZ2TU1V0YamzNTRyVqMw7xjYdS5ND00kdtJ/J8j7CW94UnMTmEbrtXZ1MGiRbBpblwlOJO03rwZJHCFeDD/G84IHud2/eL7Cg+g6tExu+++tEexplpe03nuwYCZ8uwy6XWdDdvKll24cYLxMqlISw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/xlBZRl; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/xlBZRl"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530de452c33so4154321cf.1
        for <linux-serial@vger.kernel.org>; Fri, 18 Sep 2026 00:52:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789717925; cv=none;
        d=google.com; s=arc-20260327;
        b=OcdJcpeP9tE+XMJFfeB58bWQop8wi5IcFfzCFRBGoxe7hWFjakZlPUFOq5IQrQo9A9
         yOkE6TDbACx/NyiuOAOfeK1iTC7P0C2qde9nqLNwr2TVvYtYFG90iWop3h6PcYfGQQht
         ofCbkGyY1uGOlJMfm3jkVGONvYBnPOs4nxj4CI7HIgEsZ9BC2Tq+WjOLRPBybhAXNeJR
         c1iVGVvTSqxKRv2iCJ3wHOiJ+W+bGPZuDVUxudwnoaDxH4aKAAOsAr/o9kO72E8me0g4
         Iw41A3b6TAuIyx2sjmT4VLF7rlYoKw71r+VcFOMXnNng2vBKO3r6UHB1hNapfmFCSBdZ
         tBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GENi4md1c446ap3YU+8WbAIKW0z2UxkHlaNTGXc/qAc=;
        fh=rncQ0o2MddxDUWDT9BiksDCpGMBO9AfDJaMU6CoAB5M=;
        b=jjEJk+U/o4z9BFF8NXUVqEAtLOBTKT/8mdUYYG8YKEQ4PMVv+l5Zn89nL3bgQjIPoR
         SYP4cycBDgcXTiOhrJkWlCPWN++DeRcYu5ojAafIlcv5VQpV/cWnKymFKQmWAkdRVtWt
         gkPK8qkEu2f1o1evSQl4/WVBZxao9BqQv7N2X61KKAWEgaw1VHfzMp2I3h8YHuZL99nC
         4lk0Iz8BCjqlphPF8mJqzufFCqwpz8VWn1FGoABuGUJEhcvmUmTIBJga4R1JX72+FxJ/
         jXYg1ySAjGymEFAoo88s4blNfrydaz7LC0XY7sk9QVYchtGVDED32iYdMlw4v52+2T/K
         /7IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789717925; x=1790322725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GENi4md1c446ap3YU+8WbAIKW0z2UxkHlaNTGXc/qAc=;
        b=Q/xlBZRl0d1u4TvTkrjunTffRGdneS3ZGZ9KpeYJHWJ4j5vBeZcAQcajCRBlEKtZ1R
         9qcHZNY5Tj5gTnWw/gxSY2grlwWTayC403wG+ZHKG/+1xWWkQuPRWkXkon96eOxoaw9+
         /oYMDZTPmGa+r0JdjAfetHzpzN0FauE9zA26ewQG/lWJhMe/UklgcqWuQQxN/otC+U5X
         rOMzHO3e4TEQq+/C6ufRmdM/X83CNDZ8IJEtojCF+bJ1eGsugbqQR/iKWNmmazYU59RU
         HPs01ABdOHAM+JFkSrpRcEN7oPgBFJRVdHfjt3e7gfIzRjFWaQNio5RQqDhuVwjyXa2C
         CjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789717925; x=1790322725;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GENi4md1c446ap3YU+8WbAIKW0z2UxkHlaNTGXc/qAc=;
        b=Kuz6FhQ53bj/WgEqDScLQ2wg8uatFLsh6OqO7F5ESt5+sv4EhYQ/uowaTsu9+kzu5O
         pa4UfM+GQK4G5gW7tkrkqQlXAXtiM9TeBxgfhjZtkprFUBkHYihRx0BW3nQyb3Bmw1KQ
         ilccxZTkLBNx5zUdrz3kO4NNErDwe3L5TfuZ1yVDYZXqiaYk1jdNt/WXP/8bMtCLN4I4
         nfuu4UfAObZfQPPh9AsJrQq/OeQ2CU5XtJtS2MmMgKuWJwaGzEa3wM5EhVNqtXIkfUMT
         aMwLMSpnhs2MuuwNXT3L7Omt06hR1zKvWS3azOjW3nkGz/LDjLqFAw17LcN9W+3eHElB
         S/KQ==
X-Forwarded-Encrypted: i=1; AKwUvByXRXdq4B2bXRk9Tdt7pAGR5Nap/tqdcrRGiyRPfXa0psHPcJ2XdynFDOX26i3QapFjJr9qd+2DoH4ik+g=@vger.kernel.org
X-Gm-Message-State: AFuF++m/IFyks7yOdteuRz0CUuZpqTeZLb8HsWHwQ061PIZo5kxx49Kp
	y11CbfQZ+BUInZ3VEMjfbWvkBHuxaw75wrCiyJJUvff83YghGr05AhIZKZ+yV418rSHjJKRh1PF
	K30g0NKPz4NeEVmKDCI1MTtTyocTyJmc=
X-Gm-Gg: AYBFou2OOzexPuKJmROMmq7nZ5AxWFisdYfPrLiWzWP4AGbDetiCOJwgCx6R4IictTh
	nKD7ZbcXEO2Ejp4GFl1IH6wE4/6zEsNY1ZHOvrK78V8dHzDWBTSvaSSV2PKuFpZVIH68DhOz0wr
	mKxtr3cWImP/Q2d0qFKP0/HpgJRLT7Bpgk4efoG1jvucho4/AaEDS1jXhufoFcuEVPtFs7bhCbh
	/i1d8D+WrGv2AYTQ/7KzSWe/mUFe/2MljA4YfurB700Akq2fLYzEfxFFMhAGfT4mdSNWl+i7sFO
	3NIR8E8ZFQO1sKgs3DeVAQrrmLRgyxmkP/lzZFxoBF0A5rwkkI+TT8HdMetFUmpuMEaJATKMH2h
	EWQZj728emnK+0Q==
X-Received: by 2002:a05:622a:54b:b0:530:e6b9:f5d9 with SMTP id
 d75a77b69052e-5329e2887c3mr28806961cf.20.1789717924743; Fri, 18 Sep 2026
 00:52:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917155834.2161361-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917155834.2161361-1-vulab@iscas.ac.cn>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 18 Sep 2026 11:51:56 +0400
X-Gm-Features: AcwNN1WPnMYUOHlV-frab_8tJfPEncIhhSiRLeqBqP4mXUOCMzFeKOSH0f4nq-I
Message-ID: <CABjd4Yy-9A0xWCDfZemHOTZDrDdtdO05nUjmN=w=sLwYjzZn8Q@mail.gmail.com>
Subject: Re: [PATCH] serial: vt8500: Fix clock reference leak in vt8500_serial_probe()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux@prisktech.co.nz, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 7:58=E2=80=AFPM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> of_clk_get() returns a clock with a reference that has to be released
> with clk_put(). If clk_prepare_enable() fails the function returns
> without doing so, leaking the reference.
>
> Add the missing clk_put() on that error path.
>
> Fixes: 12faa35ae5cb ("serial: vt8500: UART uses gated clock rather than 2=
4Mhz reference")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/tty/serial/vt8500_serial.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt85=
00_serial.c
> index 78a1c1eea11b..fc6fdc751b16 100644
> --- a/drivers/tty/serial/vt8500_serial.c
> +++ b/drivers/tty/serial/vt8500_serial.c
> @@ -656,6 +656,7 @@ static int vt8500_serial_probe(struct platform_device=
 *pdev)
>         ret =3D clk_prepare_enable(vt8500_port->clk);
>         if (ret) {
>                 dev_err(&pdev->dev, "failed to enable clock\n");
> +               clk_put(vt8500_port->clk);

The probe function currently mixes devm-managed and manual resource
allocations, with the clk standing out in particular. Instead of
adding a manual clk_put, could you please switch the clk calls to
devm_clk_get_enabled and drop redundant boilerplate?

Best regards,
Alexey
