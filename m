Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794192870;
	b=QFv8bMfD+U41YJZnnJZq5N+8XYHJHonpGpmbQfhdD5weCfMYAIoobCI9drCqHaXpTFyw
	 4k/5gLff+0g6N/o2kSDsyqSL285Pu4s5kRotf6iIv3/9uj1sWnCkHa0FuW2fJZn6trP5q
	 oCmmsMwD4QYk1z0Mt2vUh4nv4KTMb85sED78WgJafavJRcnBFkEDoY9oqIyh6R1+eHJEh
	 H8DcEPgUYh2zU2q7UlbDVGyhxE6QAQNsMRvV+KeyT3Arbr7eNXqxCx2MkGFqKv4wHKDeL
	 slFIoi/iDxwrNpsdlDsVM80abzoPbASRICngTi5yPtcXQD0pJEPTF8hjtblVZge3r4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Qz3NR7MGSXJNdrY+IV5qaIakyyfe+n06O6AowRbO9CQ=;
	b=i2acFTDIYVFxW/su3YiYev1ScRHs5AkBntWM/r2NE+Ko7c59iwaaOvC2J2E/v9YeuAul
	 9G82z2r17uTYHz0L58sTqJMe2Q3Pt8ED/B414Z7JWiMg2o+Xc0/k73lYRrRuDDs7AcKw3
	 eC93vQ2FXzk/Ltq7+o+qKvRuPa9O5+AoXHwr3lpBwG6QT1x6+M+zGm611vMIB7g5k/6oS
	 ptu/10k/0kYrmRioY5cAF25Gl2M+/8HwpanWY1JeOspKMYRd5T8ShUDRLexs6yE5JHNJW
	 eQ7EGlVE5QZ4871BZyYhj5igup2XWypMkB/oCxf2FYG4EVGuGRy23Hjgo29cus/hDkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spacemachines.com;
	spf=pass smtp.mailfrom=spacemachines.com;
	dkim=pass header.d=spacemachines-com.20260707.gappssmtp.com header.i=@spacemachines-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=A+XTWgLg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B81606A321
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 02:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02B81606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spacemachines.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spacemachines.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacemachines-com.20260707.gappssmtp.com header.i=@spacemachines-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=A+XTWgLg
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36dbde64409so726587eec.0
        for <linux-serial@vger.kernel.org>; Sun, 08 Nov 2026 18:54:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794192869; cv=none;
        d=google.com; s=arc-20260327;
        b=gLJ9YcMwHWeQ68ObntcnRXiB0c+OJH5hhnLQhWXNQyxqDpqzMzCMXflkSQcoQUNIva
         AzSPbYBYptZJyaBQErb0LangSe+5Rc6L9aMX614OD0i8geu7Jog97zfjN0EGsGmq571n
         4NO6EbUXjsYS+BniQrJ1kWJeyL9TS3tEloJg/XLeiTDUx+35eC7Q2TSo74cwqTx3gO3F
         ayufXGzt9maXC7g+Vg/2rnOjh2qN7eZFRN+wpo7o1lnHKSw5k54Zum+d00ACBD1eaIQz
         5omoxKsZm1zHHzFrcRAtX/v0GOB6l6pEz8HV3fLB61s3skMHQX44IHuJFxZSkepQukV6
         0jtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qz3NR7MGSXJNdrY+IV5qaIakyyfe+n06O6AowRbO9CQ=;
        fh=qB58Nx0XMn4q7gdM4oF2IJ91t5QIjxfdSanyE56Aon8=;
        b=YdqojiOcbQVavDf5p6vVtoetyokPdipCHP/Tx+lX8zvipmMBj+bXP8YaeHqVbudWR6
         w9sLzLee5tXNDY0sqzuOqWM+qnjFnjLTrdUl7bY8GDDG28Kq9XcMBJCXIXqawk79YPIy
         ANpPGSoDLFNGSvoKdLDGpWjAfTDymtqyUHJz2W/UMnAdPZXwbEicOV72WXjC79ujyvWE
         prx+m8NSS1VvblFMW1jrIAk0ou+nnCwdyLtpO76yhmrP3KwqvFzngdHhJUL/0OsO9/ME
         5i6NlWB3XfVExaj7A2vxyNiSJ1hYY7Cywrmz9+Iouox5/jq5lIpyytJWmMxGkDxo+3l7
         oM9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spacemachines-com.20260707.gappssmtp.com; s=20260707; t=1794192869; x=1794797669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qz3NR7MGSXJNdrY+IV5qaIakyyfe+n06O6AowRbO9CQ=;
        b=A+XTWgLgnrqW+PCT7TIAIIkFzWhX5Buzzt2ApyCVF0MOnlG8Gi+M4EE5q0NaLoq1Ev
         xPip4ML5lUHUiyZ5x2ApGnQrswnqqbtWfN2F+BglB0yjDc9W9JAFdOKJ/zYrzqQ6ttTg
         X8qJUTdRDoFWV/PWbsOfYGw5P8h78PMyfkEHIr9suaJUzbKVw6eNzHnjgP3qtWwAxR2w
         45q+B2oG8EoKqIsvtsVYgUDP1lNJve7W4l4p+hUagMNxjJbaE6XNu6ujr1KEzzK/fyr5
         UG2R31p4ny/82LbEIp9YTBUJgH/cqrS5+HMPMK8IEhvuspgz01J7cId5LwMTWfx3w+1Z
         OHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794192869; x=1794797669;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qz3NR7MGSXJNdrY+IV5qaIakyyfe+n06O6AowRbO9CQ=;
        b=DxvaJLhNwq9yxZrbtamXbSoViPzBAIynUI1WfdS/leQD0TVxIkbaDA7RvZkVnFscY1
         RQalXI5sfLB6m1EogIakjLkujJx4/2jxHdG4L77lbBSNAMdGkqvVPosbNw2FTDenyZI+
         954wDdJx5/UVP9FpXkLuA6/P8AqnoXMM2BoLAMk0BCTRS2BRP24SXyNir6mbXi9Y/aqw
         rqo21TEhpkRO7G8gxPZq8YjpEoRBLzi7Nd1arI4uTtRzcN8B9sKdMNTVXbdJfQOZ7c2l
         n5CTHC+KUPN28uu1NCtD9FUzw+7V+ThhoGfoFCI2y7ljQxTXJEOgv3u64i+alPD+Gw8U
         3Ecw==
X-Forwarded-Encrypted: i=1; AL+hErFZf71m/Sayu+xY8xNJUc2949W1BpoD2uETE+Nxxrun4FAkj6RDXFnF2yhYAVJdAhRqZd/DDhCZpcCdIsQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9g6SVrRJppR1YOZ0VXRB0or2slGZzj/Qj2kXk3OHYrjdR+iLJM
	Z2GR94dy798uc1B1pqEch4Qz1SpGvOs8Q2Mz8/alu/3J+XX87XxNjnSFi/PjOrHcvOQPkqk4Mnw
	fpu4+m/AQzZ4O1w8zimVnWCSx/W8+hr1dVkE6SNdqZw==
X-Gm-Gg: AYBFou3a/p/HgjzyRhSRVYNbLt1cvLegbLKozb+v9EOa6G0jIhXgrrPvGw2LXWZuzDp
	Pz/sdpjNfWfpHZ1FC9T4u9Z51cE4EyUsEQ29XhAFUDEXDvaZLS3bF1sZvMSC2eyYAWTQgmvu1TK
	gT48mCkxD6NVXU0im50TyHIy+V/Q6gDWjdn1yGr3PqQ16dQc8pVogGfl/vjE7Uz2tRBX5b6Sq+k
	REakNPtURmUJhHfZJMvfW779MHcxFCJPRnZeUh2hI+XcM08vuBh134bxyR/0V5/WVKBEOanqyMi
	jPuLGxdwNMygCmb59yaEb29y22HvcP7rrtq69oRxhsbftuge6SZ1bfaGp9DYJVDTR5P9yTMgGCc
	zA0ca8JcJd7EI+A0jih24+FxGvznFvZdi2bKSgw==
X-Received: by 2002:a05:7301:4601:b0:369:f9da:a70f with SMTP id
 5a478bee46e88-372579ada0cmr5004293eec.17.1794192868908; Sun, 08 Nov 2026
 18:54:28 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-core16550-rs485-v1-0-6d15ebe1e5b9@spacemachines.com>
 <20261103-core16550-rs485-v1-1-6d15ebe1e5b9@spacemachines.com> <20261104-zen-aloha-35da49a7e72c@spud>
In-Reply-To: <20261104-zen-aloha-35da49a7e72c@spud>
From: Kohei Otsuka <kohei@spacemachines.com>
Date: Mon, 9 Nov 2026 13:54:17 +1100
X-Gm-Features: AclHuK-Q4F2OkjltIrYE04Gknko9UUPJ0_lJdkzGPXUFMua3_w-rpVx6FPuUaIQ
Message-ID: <CADMKYUAc3QPCdpH8JL9VHk4d0iETsUL2ao2i4OhoHYoZGoAnnQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: 8250: add Microchip Core16550
To: Conor Dooley <conor@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, conor.dooley@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 3:20=E2=80=AFAM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Tue, Nov 03, 2026 at 11:11:31AM +1100, Kohei Otsuka wrote:
> > Core16550 is a 16550-compatible UART soft IP core for Microchip FPGAs,
> > including the fabric of PolarFire SoC. Its registers follow the 16550A,
> > so ns16550a stays the fallback, but
>
> > it raises no interrupt on TEMT,
> > which the driver has to know about to support RS-485 on it.
>
> Doesn't this exclude using the fallback to ns16550a, since it requires
> specific interrupt handling?
>
Everything a plain ns16550a driver does works on
Core16550 including transmit, receive, FIFOs, modem control and the baud ra=
te
divisor. The only thing that needs the specific compatible string is
software RS-485
(em485), which waits for a TEMT interrupt the core doesn=E2=80=99t raise.
Without the patch, RS-485 direction control is missing, but the UART
otherwise works. If you=E2=80=99d rather
not have the fallback, I can match the compatible in 8250_of directly.


> >
> > Add microchip,core16550 with ns16550a as the fallback.
> >
> > Link: https://github.com/linux4microchip/meta-mchp/issues/5
> > Signed-off-by: Kohei Otsuka <kohei@spacemachines.com>
> > ---
> >  Documentation/devicetree/bindings/serial/8250.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Docum=
entation/devicetree/bindings/serial/8250.yaml
> > index 50d5c977afa3..33a5929bdaa6 100644
> > --- a/Documentation/devicetree/bindings/serial/8250.yaml
> > +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> > @@ -137,6 +137,7 @@ properties:
> >                - ti,da830-uart
> >                - loongson,ls2k0500-uart
> >                - loongson,ls2k1500-uart
> > +              - microchip,core16550
>
> This needs a -rtl-vX suffix on the end, as is used for other fabric
> cores - see microchip,corei2c.yaml for an example.
>

v2 will use microchip,core16550-rtl-v3, thanks.

> pw-bot: changes-requested
>
> Thanks,
> Conor.
>
> >            - const: ns16550a
> >        - items:
> >            - enum:
> >
> > --
> > 2.53.0
> >



--=20


Kohei Otsuka
Satellite Flight Software Team Lead

  koheio@spacemachines.com   spacemachines.com

 UTS Tech Lab, 36-38 Lord Street, Botany NSW 2019
