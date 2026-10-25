Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792965987;
	b=LENnVo0lxggw0Ib9nsofzrA1jq6km3TmFAiGFQvDe9JG4O2W3tmiSfh8Xm6KgeJqIDAo
	 qNvUDb/aeFhvKWS3JZJvZth2mC4P5bGAw5AI7LJgNNw2JtnwPhoL0Fu26ItQ6kOibS7C/
	 15EMEHxeN3tmac+RdWytizLY+lorCNetsK9LfCDGM1Ohxvc/9ucJdaR9cwdrK8+1G5nqd
	 CVgTViaNmzSdMYq7XgW7qu+eko0+IAWeWtEApSKRYtF6Nu8HQGRi4VkdaX8bt2MAjUiPd
	 PMj6DF5zNV792YcnlJ7S3Hq/KW+6x5jHGYrxpJVyUiCoDufGmqHj5I9ZipuN+qLGVIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965987;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=InTBVuYJDkDbarDfbmFiK7vMvKZsADS4capA79VR7aw=;
	b=OUf3zgB2E7QpRMwEj4YaF2s4Ia1d2SaNDF2QTuafjOS+ZVnwTlKgRcUshWLiDgOVcg2+
	 5GVrzD4rHlpOpjcQOmi6wgb91+AYFLlK2RcfdsTTjrQd7QDSA6Avp4/i7lGdnAVF5sjtm
	 6244Hvym4XqpwSTOstialuw/tJS788TH3xEl2lpFNMmhVBsHE2MDu23vnqTIWsPL0fgDu
	 dK/OFrGTTPy3ne8XjE/N5JIM3x+mnvywz4hTBOHh/6LdJECQXr96ltoCBh05daALqJ9eF
	 Sw0/PVp+kak8U6lpACFA6JolqGqRhto4ZkIWlVPKejeq7AY/pYuCtkHjn5qCeXBXHBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=HHpzSW98;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="EUKfcOl/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.51
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2CD606A31A;
	Sun, 25 Oct 2026 22:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB2CD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=HHpzSW98;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=EUKfcOl/
ARC-Seal: i=1; a=rsa-sha256; t=1792965975; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ml4+SpjoPhGa+IJYKpsmlZ1yGnQT1EQ4VJR5jA27XQ6LrJc8kT8Bnbk/ut1U5adrK5
    jOr6l82a4/7CQFpz+H9TkGZJihwidNPAioAIXar8o522MvdMiTkOdduI4+PghDC1cefn
    4dk/7wGIrLz/xlqVMtLOwCV6opMjdoIuMhG9TiB6PN76L21eo18cfRwVOpmieGiHE6oz
    UxtyPWG6a7rmH2v7hRPxC/jZSKBp77CaH03SpzShosRoNXidL1kPRGluRPbe2rJAFXCm
    7LWhsZeszhxiHrHmCzgOVg5+RkpQBFGNTIywZFL1ou8G+KZjBPR9d3MKvS/Kt/p1694a
    t/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792965975;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=InTBVuYJDkDbarDfbmFiK7vMvKZsADS4capA79VR7aw=;
    b=ZG+hEOZtsIGuF+RxL9ILUUaKTbUYnYnDjCkeF9HRJFxKzjsn8cYVlgq1AZ6cUyhRwa
    TZ0CwTGoY6kz4tO8CXR1XrJadN5kVQGN4Ov8jDPGzZSUf2TiT4lap27Lh6wQFKZaWRpw
    068l6cfM2Mt2l6BQIkPWbF8FODu7nqgEFX05AlNx0k4dFosxfTeh1ssT6QJGHZgzxyF7
    6KtLpz7QnSXJ1ZXbBltaRxCiiHZRlN9PRpy3kPdPXOvv54USdDPJ/cvYSY/ZCWXa8je0
    MyZmB+gOOT7WtAfYXo3bEKHiT9vHvv14RYthd1E4+vKw6Nu4J7vB4abJiSSMFlnQvQBK
    u3hg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792965975;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=InTBVuYJDkDbarDfbmFiK7vMvKZsADS4capA79VR7aw=;
    b=HHpzSW98/IZY1p5xvu/1iCg7Kqa8b8AH9nSJgAT14E/ZphDcyaAcpUa+C94XI4CZOO
    xchCYe9EWFiGZJoBAQ0kegDX8PLWPnEQh7R5M/kxhJ+jB32pHt4wO7YrFlXW8qpIesAn
    UEKWdXHbZHDNd+vMK9wiZCrWm6zJy1MyFzlaHXabV4UlRDbp7UfE1xT0gqmhco5ArSow
    TCM4cebOdRDEzAI6FAsbMu75Cw5IgxplYq4wMDY0phEjouTjM0dZve9QyFbQAvCcKiLv
    9WtCYSf5+PIu5wyb337ZH6xbbHgDJlZ7f1PFO26RuP1I1m1XljH+gAx/m6aqiBGEaGl2
    m9hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792965975;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=InTBVuYJDkDbarDfbmFiK7vMvKZsADS4capA79VR7aw=;
    b=EUKfcOl/+UwfGj2YSIIwk5IRigAqzKvym5bL+5HEBPFo6FwwbXo5hkXOBuJAy96163
    BcsY4N+Fr9zlAUB8IiCg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrS2poNy8iNoc+LWkugLIF0fnfvFgpgbBBt2w=="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a229PM6Fzgm
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Sun, 25 Oct 2026 23:06:15 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.10\))
Subject: Re: [PATCH v2 0/2] serial: 8250_ingenic: Set UMR and UACR, add the
 X1600
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20261024220712.23250-1-olivier@mgcrea.io>
Date: Sun, 25 Oct 2026 23:05:44 +0100
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A1F59D84-765D-4363-A7A0-47E9312DCCB2@goldelico.com>
References: <20261024220712.23250-1-olivier@mgcrea.io>
To: Olivier Louvignes <olivier@mgcrea.io>
X-Mailer: Apple Mail (2.3826.700.81.1.10)

Hi,

> Am 25.10.2026 um 00:07 schrieb Olivier Louvignes <olivier@mgcrea.io>:
> 
> Ingenic UARTs carry a bit clock count (UMR) and a per-bit adjustment
> (UACR) that the driver never sets, so a UART runs with whatever was left
> there. On the X1600 of a HiBy R1 neither the vendor's 8 nor the reset
> value 0 gives the 16 clocks a bit the 8250 divisor assumes, and the
> Bluetooth chip on UART0 fails to set up. Patch 2 sets 16 and 0 at probe.

I am still not convinced that this is a x1600 kernel issue or something
that should be solved in kernel code.

On our LX16 board all 4 UARTs come up with UMR value 0x10.

> 
> Changes since v1:
> - Set UMR and UACR on every Ingenic UART rather than in an X1600 entry,
>  as Nikolaus asked: the JZ4725, JZ4740, JZ4755, JZ4760, X1000, X1830,
>  X2000 and X1600 programming manuals all have them at 0x24 and 0x28.

That was not what I have suggested. I asked to a mechanism that allows to
tailor this if the boot loader fails to provide the correct value.

> - Write 16 rather than the reset value: with UMR at 0 the R1's Bluetooth
>  chip fails just as it does with 8.

Ok, it would not harm our boards, but there we get the right value anyways.

> - The binding keeps the X1600 compatible with the X1000's as fallback;
>  the driver needs no entry of its own.
> - Rebased on tty-next.
> 
> I could only test the X1600. On the other SoCs this writes the value the
> divisor already assumes.

On our LX16 I find in U-Boot the default value 0x00 for UART0, 1 and 3 
and 0x10 for UART2 (which is the serial console activated by U-Boot):

lx16# 
lx16# md.l 10030024 1
10030024: 00000000                               ....
lx16# md.l 10031024 1
10031024: 00000000                               ....
lx16# md.l 10032024 1
10032024: 00000010                               ....
lx16# md.l 10033024 1
10033024: 00000000                               ....
lx16# 

But after booting into Linux (without your patch):

root@letux-lx16v0-3:~# devmem2 0x10030024
/dev/mem opened.
Memory mapped at address 0x77e61000.
Value at address 0x0x10030024 (0x77e61024): 0x10
root@letux-lx16v0-3:~# devmem2 0x10031024
/dev/mem opened.
Memory mapped at address 0x77e05000.
Value at address 0x0x10031024 (0x77e05024): 0x10
root@letux-lx16v0-3:~# devmem2 0x10032024
/dev/mem opened.
Memory mapped at address 0x77eb0000.
Value at address 0x0x10032024 (0x77eb0024): 0x10
root@letux-lx16v0-3:~# devmem2 0x10033024
/dev/mem opened.
Memory mapped at address 0x77ea1000.
Value at address 0x0x10033024 (0x77ea1024): 0x10
root@letux-lx16v0-3:~# 

So something is already setting the UMR register properly on our x1600
without your patch.

I am not at all a specialist for the 8250/16650 but I got the impression that
what we call UMR in x1600 language could be the UART_XR_EFR register
in 8250 language.

There is a function called default_setup() in 8250_exar.c which says that
some UARTs have an extra divisor register.

This all sounds like some standard code might already be responsible to set
the UMR registers to 0x10 for UARTs initialized on the x1600?

But that needs deeper analysis than I have done for now.

BR,
Nikolaus

