Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFEC20F987;
	Wed, 22 Jan 2025 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737542388; cv=none; b=jRwyAGkath1TDx31n3fcxfnSTl3L2nmU5Rd8zki9VZ5r2Rs7w4NBN5dQsTSqAs07Q5H4tGcOsUcTpGb9K29zkbEljy/CLzYxp6NfiaTeE1MQ8hOM9aLpkgZwUr/DF+AVMAhaIP4JnbMVbvg0LsZJUR8MIXs9hoMcWg7sc99XWJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737542388; c=relaxed/simple;
	bh=S82Hh/PoUZ4xr3ipl1ugTkMC4wtzF8X0OSDfaqtzaXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JizeXm7/uNlyh0pi9lPjwaaBGbjsgzgO7n0fHnvJxM8NgJ/u741ARJOtGwqiP7xedH9XiJ+8VdVHeNPaUCF+gy2WdYNhpQRE/yYH9InSpQeI6tm6CupdB8thymthcuS13Kz2k31XkCrOSu+8VIwmLg3ebF8xysohShhaNKHizcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FseXreVw; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FseXreVw"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so11505051a91.3;
        Wed, 22 Jan 2025 02:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737542386; x=1738147186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvLYgMwDxY2WEEVF7WFI/etMRdKHJYI8085JwQmePuI=;
        b=FseXreVwpTy/ocBXNbIu9pMBTQiur/y7iYv19NF3jgHKospOdtFt8r8rZgU2MCPONo
         PnZV1eHrT+Hh6T2TXx+qIivbej0CTcctj7gayjzs8qmGkbCz1Wvswc6i7b7BO+49CE2Z
         Zs/0l8o9A2MLU6p4uQ1B3F47cNSfi13T0FeuL+3ZVGR2TYKCnG/LUBIpt4Pv0r3Etr9m
         C0aww5SEwrLuxjRJb6Q+ESaSq0DkPL6zsTF0d+TI7tR16PD/XqMSNJVTumX2Q8B5Df0l
         Yo1DIyiaanF+uLdQPbBTyFSF02sNY98IleGHCHQ2thtMXnnZ2jpgY7JnpUfbl3XJcW3N
         XDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737542386; x=1738147186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvLYgMwDxY2WEEVF7WFI/etMRdKHJYI8085JwQmePuI=;
        b=giEx2nBOSp0YphDbxOuY6n+s4WXzkgmy92jv5Ecpi/DdXr07BKF0SMcmHOYQEBXN2+
         w0xBfCjZWG5ieIAnP0m41KW/GAaqZSMvLeM9UaKPPSHDvGAw6XERPTx/VRF4ne4BtueM
         uNUQNQlO1NqZoUaNP9KdnkA4Dl/6ls4mqJNtPoj83aQjjwgyyPor+7Zffv4VBVEsslMh
         Ob8KbdPe92YgS+FXywjY9O+7ucTO28dnKW+6xop2FgxLDTLd5H2FJEOoZJGiaXhkAlCW
         6PwWAD2HKThzVlkLccCd2ZtteMVD0Tr4O/+mSBmcbrNZeSgkjtX5CZiGmOhFYqRGjZEi
         VVeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9aFPzMBs245kzO42zOAnWl6V1UjQYr8fwIVN56JfNeMUxBhMxa2FAAFq3Mm0uBY9KeKJ14lnC8roX6jOg@vger.kernel.org, AJvYcCUPkkqHHyFOZGc7LESDZm9AjeceEnQpAlCHIuXM3wOCYwrQEWIvXKG/LLpQSS4j36oR8KwupGRDWE8W@vger.kernel.org, AJvYcCXSVZ4LixCf99TUtu6N8xC6CgcEVjNWbhzuF5PRSt5Y9usb245BwnfazeD2m/ZAX8DiZoo9ssYwz1lcp4wb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+yfxi/BXdrmdf37y3wEQAdERL9HrIa17RYZLuEIpnxlgPpTfL
	72n3vwkUP4sqr7aln1doqSQe5igGZRzluoEwgSQu/AEny+1HaqRzacd7KNJ1sbmwG85B9GE61XQ
	om+dGJPPqNHSQGj1N8tuurMSsfYN3k2N+t3o=
X-Gm-Gg: ASbGncu9l+wG636GNDJcNpv7pkYG2WT2o5GolPSa0RH7vn5j2a1D5p2QasAGXC4ohZi
	c2PHLVnRJEG7LPYnP0l1dy+xxrk2hW38KQ3Tq1ERf2brFls0G6q0h
X-Google-Smtp-Source: AGHT+IGcYynYmFuonWhqFvCeF7SY2NReu8OGG99mZBylJLggI0PgO/S8Ebj+AEeIC5CuLFGJxM858QgQZXgo9beF6yM=
X-Received: by 2002:a05:6a00:340c:b0:728:e906:e446 with SMTP id
 d2e1a72fcca58-72dafbda6ddmr33732526b3a.24.1737542385813; Wed, 22 Jan 2025
 02:39:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122072352.3663653-1-Wenhua.Lin@unisoc.com> <482f89f5-3989-4bd6-b11e-2df0833117d7@kernel.org>
In-Reply-To: <482f89f5-3989-4bd6-b11e-2df0833117d7@kernel.org>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Wed, 22 Jan 2025 18:39:34 +0800
X-Gm-Features: AbW1kvZXqjHLfG3LIT6duYoXkTfbS_dWuwVKpjQ-ZZ8cz4S_3nwmxNyhpPR2L8k
Message-ID: <CAB9BWhc5NVARd83C2m9gTMjL1rngCSLUcTZkyK=6z4G3sf86ww@mail.gmail.com>
Subject: Re: [PATCH V4] dt-bindings: serial: Add a new compatible string for UMS9632
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Cixi Geng <cixi.geng@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, Zhaochen Su <Zhaochen.Su@unisoc.com>, 
	Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 3:53=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 22/01/2025 08:23, Wenhua Lin wrote:
> > The UART IP version of the ums9632 SoC project has been upgraded.
> > UART controller registers have added valid bits to support new features=
.
> > In order to distinguish different UART IP versions, we use sc9632-uart
> > to represent upgraded IP and sc9836-uart to represent old IP.
> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> > V3->V4 changes:
> > * Modify the indentation format.
>
> Did you test your patch before sending this time?
>
> Best regards,
> Krzysztof

hi Krzysztof:
   PATCH V4 dt_binding_check test result:

  wenhua.lin@f7fdd53ce35c:~/code/linux_update/linux$ make
DT_CHECKER_FLAGS=3D-m dt_binding_check W=3D1
O=3D/home/wenhua.lin/p/sprdikt/out/dt-out
DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/serial/sprd-uart.yaml
  make[1]: Entering directory '/home/wenhua.lin/p/sprdikt/out/dt-out'
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  CHKDT   /home2/wenhua.lin/code/linux_update/linux/Documentation/devicetre=
e/bindings
  LINT    /home2/wenhua.lin/code/linux_update/linux/Documentation/devicetre=
e/bindings
  DTEX    Documentation/devicetree/bindings/serial/sprd-uart.example.dts
  DTC [C] Documentation/devicetree/bindings/serial/sprd-uart.example.dtb
  make[1]: Leaving directory '/home/wenhua.lin/p/sprdikt/out/dt-out'

Thanks
