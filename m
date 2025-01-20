Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B288913D297;
	Mon, 20 Jan 2025 03:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737343669; cv=none; b=Vz/dCWNwT7Xscw0v1/OZf1B++6vvTrkxPofEv7WQMw4ffZzwOovTVeXj9yHTED1nPWegG4sIR8fb7AEq4egZ670daj7q0DHmR2s7jVhjvIC13waf7vwAUC4O7ZBfKNsE/+ffYx6f6GEs2uIPXwLAVbFbX5uRxPZsHtTW7YrnGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737343669; c=relaxed/simple;
	bh=QH4aOzm+M3jy2QU88DMAN2bhDn2SN0xgQ4DO6lF6wPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyMoGVD13zLnRW75Zhec26SrrY2XF1yBfmNvGSBrUj0W7TNHBYMyQmTJKUWddRkan5ST+II2NdPxl3AlmZ0MBn3MCX0VNgJkCkz+mROxrjEPl5cHiKOJluTR6Ou7Q07aIOT3QgPQnxHET/pnZJKf46wzIdn4xI9LKwz8Sexifdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZQ5lv+v; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZQ5lv+v"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-215770613dbso50724335ad.2;
        Sun, 19 Jan 2025 19:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737343667; x=1737948467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39LZt66gLjcc6BWmXFdzefZoO4Uv1Ynguyimqonosp0=;
        b=fZQ5lv+v6T05c/xM8c6B66WxcEBfv9LNtt4XutNAWdMUVwmWHH6A7K4E/ToHCsmOXq
         vhcQIq5jfBiuiuTkdByGJ4NIpod2P+pJXkJegbfDyw3/vEDan70E6S1R0CzzPCwKnfo3
         K1ItmUe0K48NFvbuoZ5jHVvRfcovP/FpHTv/wXoGN2x5+k2Q/xGOCoyhRJ7iLVK3iMpO
         BLRn5z4fj5nRtmVpoZmZFFsoWu+3Iv5Ts/jRNZYxZLAqnLYc/c/hWbBj+hoSq/5whP23
         xxTcWUj0oFORHiQV8lSTAX5RVhnbCU5WWWDqjMCsk+x/9+IZOpr/NK97vDUUAY95BFzY
         QrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737343667; x=1737948467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39LZt66gLjcc6BWmXFdzefZoO4Uv1Ynguyimqonosp0=;
        b=n0tOe5bN7GhyzDOZNEZxMdERiWIqGMJaNgYKu2tN9dbwWDUkj1tpC4JTOcWEXSNQjg
         ZIUs7b46ZrNQ7ATbWKiCVRkSftUbFAR5QEuoN2Ous1aeTdHQrlZv+PCtKqUz/FpvioUT
         9zvt3kU8bf2QJyZqyfcBi6pm4U8gpiPxHISsWGiuPQuASFUUccH+O25F0GYMIhUTkpF2
         C3902TAgVa3YlNZnZgytXjLl8y2Bk0olQzRTl75gChz7ohGgejUs2m8A8KeA8UR+QQLc
         Pwd79q/KgESB8WtlKjfa+pTUWza95zkyRnhlN8QDwdroruMhmrbiCc4DXfVntGMHEBLu
         SAzA==
X-Forwarded-Encrypted: i=1; AJvYcCUpyoSJ9BsuyJRABkm5xzF1ahBk7worYlRjggIMyK2/k4+qdeOA8UrgXtYEzYa7cxPXaKBeI/kTrI4J@vger.kernel.org, AJvYcCW1PRQUsVBBxv7KxiqrIKljZPiv+8aarrMOGFoSSD3uWivt+4PLiYfWKhNbNMAJFApJG+DgZEH1JFFtWLvD@vger.kernel.org, AJvYcCWHpg/faxMQbCs8x+uvDG9669XSqKPhudSLEHOa8qFl4g2DlvdjoKZY7Pau86tGa7lD1wE2qW1mG3eq5oEv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmzu51B0HqdtYSH48JDnTg+lD2kzdof+pbms1UXUWx9iPj8yYQ
	X8CsNrOg5N9cis1EePpHR7Xr0w4yFXfspgxunZ6puiFlPEQWUhZlgV+gdZZJj16tV2WE2Ly5/n4
	sShBkUnH/7S6lK1hu7uRQ+svrCBI=
X-Gm-Gg: ASbGncsJPPoNoFrAfoCxlKevkiZZB/Kt7fABvI9Fcw4/OSdr97F4niQdA++dMJrRmqe
	LZVN27f928jIyZAL+tyuqeptyrXnlm6IhrO5nMZwHW5XoVXI6m/0H
X-Google-Smtp-Source: AGHT+IGZJJTz3rBi8IQSmJd8tnXJujsweYbKmKFIsAfOnBJvWd8pe/bRBVVQhAqD5CVy7QBf8x7Ct4aW6/6Nr0JgTVg=
X-Received: by 2002:a05:6a00:ad8a:b0:725:322a:9438 with SMTP id
 d2e1a72fcca58-72daf9bcf2amr15953112b3a.1.1737343666880; Sun, 19 Jan 2025
 19:27:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120032212.3579184-1-Wenhua.Lin@unisoc.com>
In-Reply-To: <20250120032212.3579184-1-Wenhua.Lin@unisoc.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Mon, 20 Jan 2025 11:27:35 +0800
X-Gm-Features: AbW1kvZVcxBtrN_BrkoFb9rYrAea1msIsNao1_pgmwpVIlPTiRhWLJ8T2kVIW-M
Message-ID: <CAB9BWhc9rf9Egn=4qnquPN2vasXpT20ATXD-=LZr3mkjLWoO6A@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: serial: Add a new compatible string for UMS9632
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Cixi Geng <cixi.geng@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, Zhaochen Su <Zhaochen.Su@unisoc.com>, 
	Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 11:23=E2=80=AFAM Wenhua Lin <Wenhua.Lin@unisoc.com>=
 wrote:
>
> The sc9632-uart is incompatible
> with sc9836-uart, Add sc9632-uart dedicated compatible
> for representing uart of the new project UMS9632 SoC.
>
> Change in V2:
> -Change commit message in PATCH 2/2.
> -Modify the compatible string of enum in PATCH 2/2.
>
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>  Documentation/devicetree/bindings/serial/sprd-uart.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.yaml b/Do=
cumentation/devicetree/bindings/serial/sprd-uart.yaml
> index a2a5056eba04..83582aa6c750 100644
> --- a/Documentation/devicetree/bindings/serial/sprd-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
> @@ -17,13 +17,17 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> -              - sprd,sc9632-uart
>                - sprd,sc9860-uart
>                - sprd,sc9863a-uart
>                - sprd,ums512-uart
>                - sprd,ums9620-uart
>            - const: sprd,sc9836-uart
>        - const: sprd,sc9836-uart
> +      - items:
> +          - enum:
> +              - sprd,ums9632-uart
> +          - const: sprd,sc9632-uart
> +      - const: sprd,sc9632-uart
>
>    reg:
>      maxItems: 1
> --
> 2.34.1
>

Hi Krzysztof:
PATCH V2 dt_binding_check test result:
cixi.geng1@tj10039pcu:~/p/sprdikt/kernel$ make DT_CHECKER_FLAGS=3D-m
dt_binding_check W=3D1 O=3D$OUT/dt-out
DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/serial/sprd-uart.yaml
make[1]: Entering directory '/home/cixi.geng1/p/sprdikt/out/dt-out'
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
/home/cixi.geng1/p/sprdikt/kernel/Documentation/devicetree/bindings/iio/adc=
/adi,ad7606.yaml:
io-backends: missing type definition
/home/cixi.geng1/p/sprdikt/kernel/Documentation/devicetree/bindings/sound/r=
enesas,rsnd.yaml:
post-init-providers: missing type definition
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/dtc/dtc.o
  HOSTCC  scripts/dtc/flattree.o
  HOSTCC  scripts/dtc/fstree.o
  HOSTCC  scripts/dtc/data.o
  HOSTCC  scripts/dtc/livetree.o
  HOSTCC  scripts/dtc/treesource.o
  HOSTCC  scripts/dtc/srcpos.o
  HOSTCC  scripts/dtc/checks.o
  HOSTCC  scripts/dtc/util.o
  LEX     scripts/dtc/dtc-lexer.lex.c
  YACC    scripts/dtc/dtc-parser.tab.[ch]
  HOSTCC  scripts/dtc/dtc-lexer.lex.o
  HOSTCC  scripts/dtc/dtc-parser.tab.o
  HOSTLD  scripts/dtc/dtc
  CHKDT   /home/cixi.geng1/p/sprdikt/kernel/Documentation/devicetree/bindin=
gs
  LINT    /home/cixi.geng1/p/sprdikt/kernel/Documentation/devicetree/bindin=
gs
  DTEX    Documentation/devicetree/bindings/serial/sprd-uart.example.dts
  DTC [C] Documentation/devicetree/bindings/serial/sprd-uart.example.dtb
make[1]: Leaving directory '/home/cixi.geng1/p/sprdikt/out/dt-out'

Thanks
