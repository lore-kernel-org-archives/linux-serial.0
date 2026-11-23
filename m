Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.83.234.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453511;
	b=2+VZWiexSvDG3Cw3+TreGVvrGIDWEgrw+zBTAtAkH9sIA9z9eVeNKVYuN2a0o417SdIB
	 6gDeYKO5M9dSGxrt9H80lGuIWB3X80MVWNnNRPAGoUI3TDnCv/6UTuLkTYRjDUUcQp9so
	 GdGyP9uk51S4EKSgW3hl5whvT6iRRtjV8pTMsm8xcILLr9qtX4iX/gGs0iYJEEJXqgpST
	 TzDYqo5meNBxiM02wEKqdR9gW24vUH9bbQzYRFmRf4+fbOh8ivSfVdQer3KJAEvrFh2pW
	 P03OIVGUlLD2s4Xc3qXvnu0AKng0TFjsKxopnMmmUgZqpT4V5VbnMTTg+WcRMYS6dUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453511;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	bh=5e1D/AwNT7uXRLVdrS93vUr0IEl29U9F3/IiUvXkxPI=;
	b=pUaExRG0mPhCyUjUDwmJfHg227NXqETDC+2QXbLKnax+3pQpFNUCfYhUSqaZRw07knMb
	 BSLhUkeRqR5D3gG6EsXyoksu2RcpuG0pkT2zHf9t2sJ3RR5ZbO90y9Uulpx3zWR8vMIPB
	 MEc0qokwz6dAbIn+0MOEoR8CN0Evalw4StSbXi62V07qv5mLyM8Was6r02vWXTr0O0D/r
	 pNSeDLvj53JEXl9Np7CrQ7b40WRmm9/6h0+uoSKB9MfbIfRq13tA6OrSG7KYf7D9eLnKz
	 95ronQmAxiZJcOA4j/Sth6t6SH222pVOavVAqIVCnndBUdAr3rVYNG6NerkAXX+mvcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sput.nl;
	spf=pass smtp.mailfrom=sput.nl;
	dkim=pass header.d=sput.nl header.i=@sput.nl header.a=rsa-sha256 header.s=dkm header.b=TU5eKWXL;
	arc=none smtp.remote-ip=45.83.234.41
Received: from kill-spam.sput.nl (ns4.sput.nl [45.83.234.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D5C606A31E
	for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 17:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2D5C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sput.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sput.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sput.nl header.i=@sput.nl header.a=rsa-sha256 header.s=dkm header.b=TU5eKWXL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sput.nl;
	s=dkm; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:
	Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5e1D/AwNT7uXRLVdrS93vUr0IEl29U9F3/IiUvXkxPI=; b=TU5eKWXLYlodJBt0YD4luKTEqi
	tBXyOAUjnqZFFj9jBAIx8IFolnYJi0UQT1kh813SRECP3/6jBMwPJ/i/rui+d2QT/AenjqXCCdeSR
	daatnN3uLp3AKbCHCd6E/lOAnSuEZZ7AOm793GWLpao7xPdZlqZHtaElfA17zEYa2PXlm2MhN0auE
	6klbHg3A0H5ljHeR4NOnQc4SjmxWgXICbzLM+KFlcspREo/twob+40O3DVSP3EOidvgCC7wbysXeb
	SKPOTrGDcxy8r9wVABCG8YiZTqy/k0HbsR0vOQIl+Uo7SIBJv93A9NYcF877kVtc9XOyh9V63n3bA
	ev59CClw==;
Received: from rob (helo=localhost)
	by kill-spam.sput.nl with local-esmtp (Exim 4.96)
	(envelope-from <rob@sput.nl>)
	id 1xVXTT-0000oH-20
	for linux-serial@vger.kernel.org;
	Mon, 23 Nov 2026 18:05:03 +0100
Date: Mon, 23 Nov 2026 18:05:03 +0100 (CET)
From: Rob van der Putten <rob@sput.nl>
To: linux-serial@vger.kernel.org
Subject: CVE-2026-97481 ISR Fix breaks NTPD raw DCF
Message-ID: <8ca52644-6857-9792-9651-22c1f473eb62@sput.nl>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Hi there


It concerns the following recent change to 
/usr/src/linux/drivers/tty/serial/8250/8250_port.c ;

/*
* Recover from no-data-ready and FIFO error condition to avoid getting
* stuck in the ISR.
*/
   if (!(status & UART_LSR_DR) && (status & UART_LSR_FIFOE))
     serial8250_clear_and_reinit_fifos(up);

This particular fix breaks my NTPD raw DCF reception.

Question: Does this fix still work if it ignores parity errors?
Example below:

--- 8250_port.c.orig	2026-10-15 14:15:52.000000000 +0200
+++ 8250_port.c	2026-11-11 09:00:35.850614579 +0100
@@ -1937,7 +1937,8 @@
  	 * Recover from no-data-ready and FIFO error condition to avoid getting
  	 * stuck in the ISR.
  	 */
-	if (!(status & UART_LSR_DR) && (status & UART_LSR_FIFOE))
+	if (!(status & UART_LSR_DR) && (status & UART_LSR_FIFOE) && \
+	    !(status & UART_LSR_PE))
  		serial8250_clear_and_reinit_fifos(up);

  	/*

The above modification did fix my problems.

The DCF receiver produces pulses of either 100 ms or 200 ms long. At 50 baud 
(20 ms per bit) this is either five or ten bits.
Depending on the parity setting (eight bits plus odd or even parity), this 
produces parity errors on 100 ms or 200 ms pulses.
Users of serial data are free to use data with parity errors if they want to; 
Input parity checking is not enabled by NTPD's rawdcf driver.

Alternatives to ignoring parity errors are:

Modifying the Linux TTY driver to support 45 baud (22 ms per bit).
And
Modifying the NTPD rawdcf driver to use 45 baud.
And
Modifying the NTPD rawdcf driver not to use parity.

OR:

Build and apply a circuit which reduces the pulse length to 180 ms (or slightly less).
And
Modifying the NTPD rawdcf driver not to use parity.


Regards,
Rob
