Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EF92F8EAF
	for <linux-serial@vger.kernel.org>; Thu, 25 Jun 2026 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378630; cv=pass; b=RoxNcsddwmGH+W/QT/ga41Shrnm+6hlr+fgJ9nu9nZDxgJBdE5xOdDAtN7skYhnCXBapNoAvnGO/wZxkrMWVJOpqgnnsbHNKARLzgPYB1HpgvzFPqfsSC9gh8OgrSS8hPxiLAEG58Iz2mAj7CrW+qpD1oWtHupwuK9qlYUAWmVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378630; c=relaxed/simple;
	bh=PybBbFFbv2qgp/wGc6XtY0wnuLp8C2DGakY4TdWZcjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DW0qtt7mu64TO691qYNxV4sky8Ihj5DCakUsSeYK+an5K2Y/QHGPyVxS93KOMCNAf3ppyNihKOc9kC0pe7+/kkM0pzEPrxfAw5au3Xpi1io1OW/tO/dWBVCA0NAl111elAdurngGa+K50gIEW9FvZnPu7AjgS77hn7x5vkjqepg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=I+i+w1Kr; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="I+i+w1Kr"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso6078005e9.0
        for <linux-serial@vger.kernel.org>; Thu, 25 Jun 2026 02:10:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782378627; cv=none;
        d=google.com; s=arc-20260327;
        b=bViNS/ewbjA7vA13lu6+n67RGnrRYjkbAQxIxMTyQurW+ZjogcYYZvXG+c7wOqQWiZ
         7bn7w4idtPT4O76c/H4s8axoCzFK8vIXa45o+OEvqmDeBZeFP7+0uvYxIgWcgNLHo0RU
         dj4+Gm0/5LKTvDslrNXiXo15iaN7yKHspUGbotMeIRwdKUDpYAZavYfISrtW78+0DOcW
         zk6seh1dxdiXE9960JqQJSFUYfKCVfYqqVSdv5u7ytkAEPD0MpOQBIcp3u/WVFd+olBk
         /MmrqW4dX59WlC/QxkZUPllNDweq7Ubnca8+JCTnAPGlMhhKmGv1cWX4SSc5CnwOWll2
         Uj9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PybBbFFbv2qgp/wGc6XtY0wnuLp8C2DGakY4TdWZcjY=;
        fh=7bFB97lOaYh74+FVNp9Dw4qJJPpsbKsGsUHAWOeZzK0=;
        b=KJJqAaCFr3qLIE3HZBJyt1n4vqNrGu0yifnQX0yCh+vcxwzIKO/SDIgruG1XxLHtUL
         6thX0DrLDK/jpx0q87x11HTm50f6PcZUF6XvVZ1OL149uMv4yzXnhkEA3mahAHc2ccZi
         DP7A4wKmHNne1SeFpR853YoZsRMgRhde+qgS93EApm09Qch9J/hlcX0yc+pcXSSAe/2I
         G5UCmPkox7lJNImZPtpftqzTII/LlD+FTqUK0k91NpmJshK9nITzBiMBwtZIgErCdxTn
         t8KrgFyoEd4ABtwNB0tEMylJZ561uV0R7DmmzSLsxbfFN2IKmHrYTeAiT3OWbQuvQkBM
         zCbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1782378627; x=1782983427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PybBbFFbv2qgp/wGc6XtY0wnuLp8C2DGakY4TdWZcjY=;
        b=I+i+w1KroVJhttVDKplJ2/thfg47SaAyIUin2mCOCx6aOtnsoevAXlascKdRMNApfs
         4WZtS5XZe2PTZlCR/VJ66XwyD759v8AvdrX9od8Ll1ZOJUAFRnTv5JEM4EHSxsjAVRZA
         zJgWzRr5pU8UbqRzgNIKZZzhLciYtakwfoO7oaUSvdOS/S10H22Ai93IBRXLqPH17f3Z
         qGJC0ZPB9vTszPz5P6Yf+ARii/yvZusFoewj7y60XOvQ6Y1bFno7fV1KH/P+I09Oh75j
         sKiZqTu/Q4aTBjT476ZSM3V1OSLnZmQl8SRz3uLsAbQOLOxtJA2V9X3ugaBcphotjWAV
         Lc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782378627; x=1782983427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PybBbFFbv2qgp/wGc6XtY0wnuLp8C2DGakY4TdWZcjY=;
        b=HH69c+Y4ZBrzMpkDhZCd9Zt8NTqMwYBYtOzlyq6b72JNACbQ6k1eony9imQoz9jBxS
         PmVPOLq/69aTihSit4N9I9e3/MwGV7zSQj6UBn7h751vua0waG1h4B/gp5xQXp1hlghm
         EXZ76paIsSkJFpTpaZFdaQWfvNPylguB3Z1hL3tGzZ7mOOFpYVMQXrnZqfZoeQUQPm2+
         eVdHyM7HTxv/72mmt2kkVdpgaiZ0bwqOWTOtpFJwV/0WJRLUL1nufvHyxzP7h0LLVvid
         gS6BI5Dz8GYMnCej59ZDeezCs7w+kUdqYJSSGIorrln10/4Fbq2SCb/zDZx50lodw8bo
         1lRw==
X-Forwarded-Encrypted: i=1; AHgh+Rrig5acp/0B2h5LGUvqR8NQTJ94qmzTSudvQgrcV77duBsTy4teAWdjD/+TsbWYtp02oYaAAPyVSnVPeVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOBiJfDBD1BTKDOJF+te8USZFh1oZWWietZYDXZ2k9PdqScmiN
	9ZEwb87jbfb4ZngtXv+ahmfnaj7A1/hapD5wE35/gN9GQM9OXyc75INoIl33xxtFo+5FXmng9dU
	16ol80peUDW83+2/SBsUnrwFgkcd4W8d6BUxxcQ9ETg==
X-Gm-Gg: AfdE7cnSVg2Ngt4kD3PAI8oRfZ9EcMcdQwsgok8EsZ0qBcc3sJluuNm8eP/tAUgxIO1
	Aghbv2QQP5e0TU+LjZsxCIHN8xUwZr1qphBoO6BweX1TmHDFXtxqt4Ig+TvxpbdhpdvXcAv4dLJ
	XEvxRiiWJ4aB+mpdmGqDgA6bt8TjaFFFvxFLr782NjSCc2p38aRErYvkNZe9KXyRLQhtPLHo4SO
	9vx+0mada5t9m2ocHt11ratgESBTUuPEqaXlDn0x9LpYx5d76iRF0gfyErse6HqY6pVbjOEEtM+
	nUAR/BAkXhMNE4LAFHRt2WD5mmbbHWdr4ZhZtGBXfEULBwj6CmhNHlyHyA==
X-Received: by 2002:a05:6000:24c6:b0:463:b7f2:cc7a with SMTP id
 ffacd0b85a97d-46da9508504mr2493751f8f.17.1782378626958; Thu, 25 Jun 2026
 02:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782224059.git.gregoire.layet@9elements.com>
 <73b2bd81ce70814612e6d3cb689c3296de742aaf.1782224059.git.gregoire.layet@9elements.com>
 <20260624-original-vigorous-mayfly-dfceac@quoll> <CAFi2wKbKr8FMcJeGWA5e1UZUTh2=LwYNkLEj6exd2as7=AcvVQ@mail.gmail.com>
 <b9ca9e36-a851-4a98-a739-ca99dd534d6d@kernel.org>
In-Reply-To: <b9ca9e36-a851-4a98-a739-ca99dd534d6d@kernel.org>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Thu, 25 Jun 2026 11:10:14 +0200
X-Gm-Features: AVVi8CdVW0AmRhEG0L6wUoqXHMzj3ec0waXKRN6u-RXjXnalVyhv5A88QhYFWcQ
Message-ID: <CAFi2wKY-73nXEKxp3vfB0RBsB+VB_stNk6NKk8gCopaoav6Tww@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] dt-bindings: serial: 8250: aspeed: add
 aspeed,vuart-over-pci bool prop
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> > It's a Virtual UART. Internally, it's two FIFOs accessible via
> > 8250-compatible register sets on both ends.
>
> I do not know what is Virtual UART...

Yes the name of ASPEED is a bit weird, it means that it is not a real
UART. It is two 8250-compatible register sets, and the data path is
handled by two hardware FIFOs (one per direction).

> > There is 4 Virtuals UARTs on the LPC bus of the AST2600 and 2 of them
> > are bridged over the PCI bus.
> > So, from the host, you can access the 8250 register set on the PCI bus.
>
> You mean these appear (or are) as PCI devices?

Yes but not as a UART devices.
The two VUART are accessible under the same PCIe BMC device, at the
VUART addresses configured on the BMC. They are accessible on the BAR1
of the PCIe BMC device.
There is a 2 bit left shift between the addresses of the registers on
the BMC LPC bus and the addresses accessible over the PCI device.
0x3F8 on the BMC is accessible at BAR1 0xFE0 over the PCI device.

The PCIe BMC Device is one PCI device where you can access several
peripherals. It's not one PCI device per VUART.

For example, you can also enable the KCS channel 4 and it will be also
accessible via the BAR1 of the PCI BMC device. KCS is a protocol used
for IPMI.

Only these two peripherals can be accessed over the PCI BMC device and
they need to be enabled.
The host cannot access everything on the LPC bus of the BMC.

Best regards,
Gr=C3=A9goire
