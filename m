Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794262068;
	b=IgRfIvV+5w2mJePemzkE9EUhWI50KjOdcZaUHwxqRVj45/rD1KDtU9nDkWuPkYMXR0NH
	 lAYFVwU96s7nhk8TVGAWkYcR70sQTbBN8JcwmvXM1bcySdqO/UwSK2lsFNp8F9k3okb+j
	 aACP6GxGnUSLp3/Ev5oxqj7dIbn1MRJdcInO6W6ubVqpEi4WKRdqBqysHux0fc2cN2eWm
	 A1ILimLwsySFEWW79tnyFDCh+Ne8L2k0P0U4Top98XAVIWMZl8ZRz89Bwygzw3uCVzv/q
	 OSbKleDFSjRbpdw2FM+4FIdB7D9TVElaP+vfJSaa/FcizXcnxchssAeoCHEkZtHblqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QcUpnpKg20NxvBr0a5ywGW50/2qOjmULZA7gI4yvXH0=;
	b=1RRCkBLd6DGzuE48xy3TBg8avrwLC4HxItXR3TY00oey92Mn4LRs+GVQpfuJUZL3alxt
	 lW65S8U1OMbreIN3mdrZvxw4jB6VRmxQ4fmI84nm2GRqLvSv8Y3/7EWbWHnwtaIwJWwir
	 Xn1FQKsyIMA/ghLJXWKrjNfW7GjvttDDBDbmhisICPrZmvHLrxFSX0OvgJ4BiQwQXEg12
	 mtY/FY7rT7NG1Z2qhAw/LPlko6FKhfEgYUnKnVRZ8KoUNVEW8E2NCPAvkkXkJMNLI+Uwt
	 vbSrat3+GPMDtkz1RvPowHwncOVUm9OlAIi2vUwRSg4RTo/WVz5zyrAXrYGNU3kHcJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spacemachines.com;
	spf=pass smtp.mailfrom=spacemachines.com;
	dkim=pass header.d=spacemachines-com.20260707.gappssmtp.com header.i=@spacemachines-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BaWCv17P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51908606A33B
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 22:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51908606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spacemachines.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spacemachines.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=spacemachines-com.20260707.gappssmtp.com header.i=@spacemachines-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BaWCv17P
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3704d30b84fso1754249eec.1
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 14:07:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794262066; cv=none;
        d=google.com; s=arc-20260327;
        b=ciI1SsNSC0t0C7w0ya8h4B0nmKkQl/IntmFUCVIOZkEplbJcxhPlvI8RDLAQ7YQn+A
         GxYXuX5nA3rMtOv1ABsy9OnoMc5eve0AqptBU4v2JDCdlPNWC+H32kANy7R+Uzeu9SUa
         Pk2eo/3drw9yFM00GR+cWz/V0RGfzhUY8EyuKHs3vlhRlHP/Jwnj4qAq1ZBdOC7VBqho
         O8rDH6O0+VcHm+Gcz10EmVneS7mnCrTkGgRXjOx1mrnmwroJUbacAz4JAvabCv67afus
         1emerMRhq4xp7aRFPp9xzD59d5hgFM0DeSBSg6yDi3b31Uesr7zT6kAoqjbc9GmdFu5O
         98nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QcUpnpKg20NxvBr0a5ywGW50/2qOjmULZA7gI4yvXH0=;
        fh=47wycIx7z/hlr6Q0qELv6VzxJwR7O59vDCjex2Ue4fI=;
        b=ABPbEA7WKtVa/rX2LYJ3/+kohLGuC1WFBjyQD7duGGKYj59iWeR7ljxG9TREtgSUho
         iq0pKA4n9tAVEBlySOhjbinKFQYAdhv3PNsDLN6XSeuV7IQiuWA/XL9inunCzAUhZcm6
         lx5sLMBNTMI4kJu5UaRE/TnJZuJVvP/cXlPbpjmAdbGqepUkA+zqbrwiTtEeKIQagoqN
         0kbU0azDUUqbAsTgU3k4Q4w00hw4Le5YcBzHW3u1KibWR/Vk/5eYzjJUKBMDVNn21MHx
         t9VPp63n1Z3sijL5+JjUXggYYb8MSlvl5Xp55alr8UxmyXKgremveh81lhITX9XhIGLP
         PlFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spacemachines-com.20260707.gappssmtp.com; s=20260707; t=1794262066; x=1794866866; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QcUpnpKg20NxvBr0a5ywGW50/2qOjmULZA7gI4yvXH0=;
        b=BaWCv17PHSiTRyTlxQPASAWMJeZnaXjziuwGrHaCRLqUplR+O3Kjd9torHVzPfp+UI
         F27fPXDPMT0ZfDiQCfyyHaVBZnhJTOL+f5UKoRfCgLiketMQBubOzUgCYheQLm0DiEIZ
         0ooQfMaKuOnrI2kf0B/s6oebZTPCSw6EbpBrXQl3JUIQW1NBiVAvQoOOXtaJiAx0c3gi
         i3f7TFDaLQpscHuXusjrHwiDy1UVtthdK+fyJtyE+IcaCdO/oDUvwe0C6pNMWU0vXnay
         UUppCSBDgt1ALp3dSdpGiyRG2mf8fti5QitibXUlFb04c7/nD3OVDTMjyorP8BWCfO2u
         ot0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794262066; x=1794866866;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QcUpnpKg20NxvBr0a5ywGW50/2qOjmULZA7gI4yvXH0=;
        b=ZU3r9oxFMkWJ4TyfJOFa4nnRtL2E9ssOUU1rRDUWMgHzqoGRwZ5Jvm+bRpzjE5gZJH
         WSuo8xS6HO59OMtf7F8SOxP7rhEfc9Ml1lNMVOE/zTvJSwPSW+ZvQc9W63DW1YA2FFSe
         kOXkZhae3HZIPMPDHr+4uTm0oSupcDW4F4c7uGQMZXpGc0nU1YqqURjXMQ2wqE875p1B
         LrFCbabqGzwTnLrmsoMt2RpPeTHY9/26GDC36emN9Jipg0NuJ1DdGYHZeK3Lq/HHw+6T
         cSruqcAISkoSSVQKEd61pto9rpnG6rzba6ijv86MZn8zMIBE69BfRB9RFit4rhMH1PiP
         Catw==
X-Forwarded-Encrypted: i=1; AL+hErG/JY0j0BOJJeG7cVJDXu++NHhITSkd1TV9GEr7o8eCj5/oQJZAUn9xDuiSUJ63DuIQ9hmrUZKIHLJbIyE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oe4bEP4noUvkQnxibxOmEsLpqg0B0skael8r+yaGmEuSF1euu
	Xqo1Cha2OiDjCk1Fa3Q66ZcYbXp3Mk+xIu7xzKjO3FaVEhcQsInzjY1cEwUX4hyVoOoPYf0r8I7
	rZLQCAGV7eRSTjtvOc7Qa6uwPEkmMZE8pBOLoyArr2g==
X-Gm-Gg: AYBFou1rxMw3I+p2lZ5dvsnn0zTLuW0l0eOWdXpyvCcNR5OtW9i+/6UpHRUXGRkBtoi
	4eRYWj6Zs9ZUG/ufw+HfvhLyt1+FBVHnvEladswhd1AMfjXanQ3jcHNmVKZXVwDI6+KebKFeuli
	E2437262KqbAObOraTIj0b18dcdgGOqpvbeMp2OAzUf767iCf4nTikd9RF0pKwaJOvQeUj5aIBe
	G5HOXx68jcSiWWj1pYw5rOJ+9aqhmZKcVoFwWKVn6NkA1NWF0t85hyP9D7QJKG8shKui8x8Uozu
	j2UDOOZG3aPaWRz+9T6g0ywh16thLN35gm7rCuvhiw/OH29jkBw//7TFT9CnNSbXZ3eHl5Nu+pV
	CDIjps9L2wvZAB8zsuD5HAm9MQlO3XI4Hohtb3VJqG1tk/wAOtM1/uW4Yanw=
X-Received: by 2002:a05:693c:834e:b0:35d:2633:ff79 with SMTP id
 5a478bee46e88-37520510ae6mr909969eec.40.1794262066318; Mon, 09 Nov 2026
 14:07:46 -0800 (PST)
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
 <20261103-core16550-rs485-v1-1-6d15ebe1e5b9@spacemachines.com>
 <20261104-zen-aloha-35da49a7e72c@spud> <CADMKYUAc3QPCdpH8JL9VHk4d0iETsUL2ao2i4OhoHYoZGoAnnQ@mail.gmail.com>
 <20261109-sheath-companion-d7063fcbdbfa@spud>
In-Reply-To: <20261109-sheath-companion-d7063fcbdbfa@spud>
From: Kohei Otsuka <kohei@spacemachines.com>
Date: Tue, 10 Nov 2026 09:07:35 +1100
X-Gm-Features: AclHuK9l1GWI0bIlcJDD2h4RqXtEuzFkTr5VEGPfn7sQUhXhTFIqGkVSKW4Z4lQ
Message-ID: <CADMKYUBqti5CNTyR=ADwTUpKTbZLCgmDf4D3cNFrwaShsQO1fA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: 8250: add Microchip Core16550
To: Conor Dooley <conor@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, conor.dooley@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 6:35=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Nov 09, 2026 at 01:54:17PM +1100, Kohei Otsuka wrote:
> > On Thu, Nov 5, 2026 at 3:20=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> > >
> > > On Tue, Nov 03, 2026 at 11:11:31AM +1100, Kohei Otsuka wrote:
> > > > Core16550 is a 16550-compatible UART soft IP core for Microchip FPG=
As,
> > > > including the fabric of PolarFire SoC. Its registers follow the 165=
50A,
> > > > so ns16550a stays the fallback, but
> > >
> > > > it raises no interrupt on TEMT,
> > > > which the driver has to know about to support RS-485 on it.
> > >
> > > Doesn't this exclude using the fallback to ns16550a, since it require=
s
> > > specific interrupt handling?
> > >
> > Everything a plain ns16550a driver does works on
> > Core16550 including transmit, receive, FIFOs, modem control and the bau=
d rate
> > divisor. The only thing that needs the specific compatible string is
> > software RS-485
> > (em485), which waits for a TEMT interrupt the core doesn=E2=80=99t rais=
e.
> > Without the patch, RS-485 direction control is missing, but the UART
> > otherwise works. If you=E2=80=99d rather
> > not have the fallback, I can match the compatible in 8250_of directly.
>
> In my opinion, this is enough to invalidate the ns16550a fallback.


Thanks, v3 drops the fallback and matches the compatible in 8250_of.

--=20


Kohei Otsuka
Satellite Flight Software Team Lead

  koheio@spacemachines.com   spacemachines.com

 UTS Tech Lab, 36-38 Lord Street, Botany NSW 2019
