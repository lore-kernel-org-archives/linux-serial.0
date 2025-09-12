Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29302877D9
	for <linux-serial@vger.kernel.org>; Fri, 12 Sep 2025 06:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757657225; cv=none; b=dQnpuqN+JmroEPcZjpPrO76a/BsSj+f7aN5tu1buqrX29rs6LqYx4btVYmUJhxHWVyrTp0vPgKwX2oTo68ktOUOeGr47RS+QHp/wGAaEvPnF76H+knGJUROx7Od1I/RI7zuHBw74MYp0ow1akm3kaVBpkdrJuWj3IXo7mZ+y/5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757657225; c=relaxed/simple;
	bh=xhNUv4r15tNXSlEeRfAfsJoZ1YS+9y9Hm87zeZ8pVCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+lNrKmROVJ93oAuPuizj9dnhrchsMF0UPqGh+9rD86jrL/fNVySpcNqkWYD5ZVYk5oZ7X2KpPplTwkhWgtAeEL+MrseF3L4tQAfAGD7U2sZRkn009dOQXnyce2ttqn8g3Wgzn3K4McSLy0+W3/EoTitVj3Qlfgn0LQ/qB4U4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9BuF4HD; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9BuF4HD"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b07c38680b3so68850266b.1
        for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 23:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757657220; x=1758262020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOVssAlVzuybD/LJbI3Y9xOJ1MXiBDYcVtpUt3l7gBI=;
        b=a9BuF4HDwTEpkoIjFNsvhzg0TwrGqAFD7uHRDwY1Jb/G8o6eKu+v8SWrTTvNwFgW7b
         R9evenz/cn1H/O2xwjavr/4swv6ah+na6Ki58Wjf2/Txd2JcBdx3skqcMkRG9NwaQgNU
         4zSQnLvpcxzZpaGHjZ7NJD7ctjLn8p1HbI5kZKCJq5vPdU89onyP9gpXhoOOEwGLVJlg
         F9rTDIjtKzRgJ6P4R5W4wShJWvRu3WWhX/dCmNMxr3JjakT3VnkdcwMmzo0sbpgYx93C
         DK14xReJ1n8OXXQCErJD5piN2HWbwcAoXyp/df+eM6EkpKHUv5hRzb/kf86fvYTweImX
         LGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757657220; x=1758262020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOVssAlVzuybD/LJbI3Y9xOJ1MXiBDYcVtpUt3l7gBI=;
        b=WZLOHsKdbY9H6TfRxdefqN2pac2SnDYCwEZemKOUBFiX2gvQ3jZD1PZ03bAWWdDeDt
         hnosac9bSx+1so2AMpbIwswrnx7cRtsMto5oLTU7vHanFhZAg3uH1hNfEpehPJbaYA+k
         KD3UjN9EnbVLRUYuOlQTrFBm8cQlbXLd5uJYyCkuVT6PYDIolMMXaV8GrCN+NEMVU9GO
         d4g9QUCLfgRCxyH9w8E6c0L+L6XMfozhgV44V2jdnxJV7GKQ6YiMc4z19pcczTOVmHrl
         C77ECDzUslksq9Sw4dXh0rUD+rZieB453KIyg8l8Hizi8UAzlJD1nug2dsb2kkYXGRo1
         YEYw==
X-Forwarded-Encrypted: i=1; AJvYcCVWUn3IhRfZU4LRSh5micX9gpT4hAPvi9Mj6fvXBfEW7vVJ3Iij2DKoNqlOXWiJMfdD0eDXnqVrElAZCRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD9Y1+KnJjr4sdKGhvj4uTKhx6WDRedH/OHfBVgvExsZ8SsyyW
	Ur2K5BpnECADiorZVfdF0Z3wpF353RQEXgJF5BXNUcwd+q7buZ0Pk7hhOJ7rDjXNTxvl1CWcuQo
	57LBV9Pr8r186vwltbVmop1t2DXFBX+c=
X-Gm-Gg: ASbGncugxBuFM7hT5Ticl02cAhZfQP694UBnNjYlK5WTeef0hb34Z14pMuE0exlcff5
	GQi2svHyLkznpr0nYqEP3naRCMV/uIwKqi6QUI3GaZINxOhz1mLzt9/Ipm8e49eZx9iZeZIv7cr
	qyTioXM0OYnOnWfu0NYZaXX+CCDRAXhR0PJPtmPoKVq0cMp9Vx0Mb5whRAIKHVsKbKK/sKCHw2j
	/PVg0S7BexO5pQA3Q==
X-Google-Smtp-Source: AGHT+IGbUmIoLVqRxKuVQ8ZiqtWYSSth8aq/nfPm70faiRBEOfXVPN4NALZRbJpq4jayZtv4bcHIGewkEuMmT769r/8=
X-Received: by 2002:a17:907:3f07:b0:b04:7ad5:b567 with SMTP id
 a640c23a62f3a-b07c35be704mr164366766b.16.1757657219928; Thu, 11 Sep 2025
 23:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757318368.git.zhoubinbin@loongson.cn> <8575ff2d46b701950b1b0da3d3c181db331f79db.1757318368.git.zhoubinbin@loongson.cn>
 <20250910-knowing-labradoodle-of-protection-d37884@kuoka>
In-Reply-To: <20250910-knowing-labradoodle-of-protection-d37884@kuoka>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Fri, 12 Sep 2025 14:06:47 +0800
X-Gm-Features: AS18NWCgzeCmKpxIiPEQ4y-Le_Edm7fm5KZRjhTlMd28XiZokJFtKz-8hZ5wN2U
Message-ID: <CAMpQs4+9DwkELn3xyi+PqOGNabGC2vvYiujjTa0Q1wH6mSacRg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: serial: Add Loongson UART controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Haowei Zheng <zhenghaowei@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof:

Thanks for your reply.

On Wed, Sep 10, 2025 at 4:28=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Sep 09, 2025 at 08:11:18PM +0800, Binbin Zhou wrote:
> > Add Loongson UART controller binding with DT schema format using
> > json-schema.
>
> Why? Your DTS claims this is 8250 / ns16550a.
>
> This is just incomplete commit msg. You must explain the bigger picture
> here, not repeat what the patch does. We see what the patch does from
> the patch.

According to the chip manual[1], the Loongson UART controller's
registers and functions are compatible with the NS16550A.

Would adding Loongson UART compatible to the 8250.yaml file be a
better choice, as shown below:

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml
b/Documentation/devicetree/bindings/serial/8250.yaml
index e46bee8d25bf..abd41e996e68 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -99,6 +99,8 @@ properties:
               - nxp,lpc1850-uart
               - opencores,uart16550-rtlsvn105
               - ti,da830-uart
+              - loongson,ls2k0500-uart
+              - loongson,ls2k1500-uart
           - const: ns16550a
       - items:
           - enum:
@@ -143,6 +145,18 @@ properties:
               - nvidia,tegra194-uart
               - nvidia,tegra234-uart
           - const: nvidia,tegra20-uart
+      - items:
+          - enum:
+              - loongson,ls2k1000-uart
+          - const: loongson,ls2k0500-uart
+          - const: ns16550a
+      - items:
+          - enum:
+              - loongson,ls3a5000-uart
+              - loongson,ls3a6000-uart
+              - loongson,ls2k2000-uart
+          - const: loongson,ls2k1500-uart
+          - const: ns16550a

   reg:
     maxItems: 1

[1]: https://loongson.github.io/LoongArch-Documentation/Loongson-3A5000-use=
rmanual-EN.pdf
>
> Best regards,
> Krzysztof
>

--
Thanks.
Binbin
