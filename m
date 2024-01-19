Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A404654FA8
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680616; cv=none; b=TF+0r0PX2Zyuq5y0qWmb+qHv/RWsAaXS05Lx6RDu6V1zzXvFfBeC04ylUB2F1cClNuJ4gIp8tQYZ1+A6bVUUKNhBD0U3MdWlhmYCFCdLHn78NCIbVHEfPgBF91sJoM+kbaK2G/EpRsxJ0DFvncyvdcQJZnrmHjKN5fUN/3aiaNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680616; c=relaxed/simple;
	bh=UIfSZZLrOU6yAjs83tQxP628/v7NNSkU0fQmLwQ5Rgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMpw1ocJrXdoMlnsKMhcbYzG3otIxPKnfuJbDkj1lRIFSUpESdVZ8WEwivszfBSeYVitr56Eredew1RQ9OLTaO9n/WuhAUBA4aiOC3/l9JFiT4AM/N5VAGCwI6UB1liZj5DAR7Mm1g79pWeRahyD5Kej8UsWqfIIRGVruQoPFfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O0oOBPl1; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O0oOBPl1"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ce0efd60ddso684724a12.0
        for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 08:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705680614; x=1706285414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQCgIpzx27vwofqc1JrDE3mPbm28nF45xDQ2x4EHqYg=;
        b=O0oOBPl1HnzDOBptxY3mHrILPDDqYYsBbHHthZ4fLPO25Hq+aIGGU3QD289YggeXRU
         Qh76VBPuqeEnuq6GMQel73FQcOwcaedTz7PMpd7CU9da+CBF+TU9rXGfOanodGmCidOX
         xjx/FoiJLFWVjn/FeCNyiG5H7i8/8up5L+AA3uRExaCEAmIdF8h+URKlFhMfJ2vB6Dhw
         k00ObGAJaX+D0ph/ljST6hZ9LgP+07+lWGHmi9iveLxlypIzm07uaWbVncvquipFsLMQ
         yvvSDn+IbHjHGIOa4CluxTUolyf8GWaMRmINFBeYE54K2ic5tmq+gvrsW+CUKD7XBqGw
         5QQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705680614; x=1706285414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQCgIpzx27vwofqc1JrDE3mPbm28nF45xDQ2x4EHqYg=;
        b=DS1HC3Qbpj0e5D3669p95ZYU+JQv9/IfMDAapMppZHI+ulGmw56AgnHUTZRZIrPsj5
         YxvaLQNDvJJq61JFLq97uxlaGi/0Zg91jBG7ruvvlc4WTeO95G5SyIiphi20IfSsycpn
         q76GtoNF214+zmi2QG+agK0ahgbWgdNUpqsgPsZYI53bdJPsD/RpIsijZr9A2df5g9sy
         k4vhmSTY2Nt2ONmtZhb24u1t1EJezirfCylFK7/FD/Dk5sQB8wknKGcVWyIqoHOyEHJD
         zOHXmwbJ5gSNajA9TNSiEc6+Ce/p0+fsk8+1DjldckVgvS0iztKFGyNBoJFPzuPG/8D1
         US5Q==
X-Gm-Message-State: AOJu0Yz6QvrdLVonAqE/IWO1k3GPVJAGB0WBdol0cPtF6OC3y5X6mjxp
	ncuX3uPmKzrGIms9PJdjLbsAdEOMcQ6EDMAZwZ5qKxvcvNv3wjajlbGhCVv/kie768gackp43BX
	ZHbE0nYjcMu6BSj2cYtQWOBjmTctHcLj4xxFtlhJA6fmBVeZ8
X-Google-Smtp-Source: AGHT+IEiy4VyavSARFTn3SaPOtL6MlCYRRMqM1J8DTeMjjwa3YfuzfgYhlEBz8SnyqE7ELSpye3aSowtoQGWAJ59kBM=
X-Received: by 2002:a17:90b:124f:b0:290:467b:b7d6 with SMTP id
 gx15-20020a17090b124f00b00290467bb7d6mr1054946pjb.84.1705680613997; Fri, 19
 Jan 2024 08:10:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119104526.1221243-1-tudor.ambarus@linaro.org> <20240119104526.1221243-3-tudor.ambarus@linaro.org>
In-Reply-To: <20240119104526.1221243-3-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 19 Jan 2024 10:10:02 -0600
Message-ID: <CAPLW+4=GvEZXXzzRj789JmCzLLnQ6cNDLhbF7i6nwiW9x6EGHg@mail.gmail.com>
Subject: Re: [PATCH v2 02/19] dt-bindings: serial: samsung: do not allow
 reg-io-width for gs101
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	andre.draszik@linaro.org, kernel-team@android.com, peter.griffin@linaro.org, 
	willmcvicker@google.com, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 4:45=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> All gs101 serial ports are restricted to 32-bit register accesses.
> This requirement will be inferred from the compatible. Do not allow
> the reg-io-width property for the google,gs101-uart compatible.
>
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b=
/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> index 133259ed3a34..0f0131026911 100644
> --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> @@ -143,6 +143,8 @@ allOf:
>      then:
>        required:
>          - samsung,uart-fifosize
> +      properties:
> +        reg-io-width: false
>
>  unevaluatedProperties: false
>
> --
> 2.43.0.429.g432eaa2c6b-goog
>
