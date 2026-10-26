Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013819;
	b=n6XOQ+KiWWyfCRjW+YMsA7k81mytXjoO9RJhTya5xnEcPtqnDzrJV9ZulHHGNM4XGQbt
	 oKu7tIIx+PJFJZCJZsHUL56+S1cUXYtRhGa03fXiF5VEgEQZJGth17cfqdZ8EsyX25dMM
	 0LWoyO/kiXzgQFGjLcTe1iwX3n0qJ9vHxfstb06UhKDKmoH5Uie7NX7PTnuhBAUk20/yA
	 j1j8I06vPCGj2GOgzLUwDR+oWbOUNE84EJa6pFyYPG2PKS9Yx1PwVn7CP17ketJ3vsvAh
	 9rb2x5yeA+Mc2WQyT5NN0rS693FoATIbdaCzKqypVoVbVVFcIBGX2eZyp1MNuxS1hdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=hi7Sr5AhOZnPq35jxQMZKgyIjGd6gqHdfbAHtpf8ZRc=;
	b=Wcu55JQf1MgJ8ZrvomaLHfcvvbhRxY3SHbGY7kwZE/V1qe79lfu+nJOYEpBaBWXD2mI8
	 cXNh2cMSH2BYzFmdM5Z6T1s95xSjsB9QQ190QiZmodkYrtb0FJFCas3JIlEo5StY1Ql0r
	 IPCDmmCqGWkWeQhf8gSW0cjZP6Rj0ptdV4euVko78wxSTgEkGFmRHvzEMWVgUkybZ3Xdh
	 kY3WJ1qg4BYiPkL1XAZJT+aQnOYC2OfFrnrldjeXduUTI97TiwOhPl3hnuJqwybT3LcbS
	 taH+dzjTv1aPbyltNiErB4w+tv9DRwYmNtyLYRMOu8TdxsrXPZCZQVUojFOpgzancYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ggtyAlK5;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EA0606A330
	for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 11:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58EA0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ggtyAlK5
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so5341185e9.0
        for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 04:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013818; x=1793618618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hi7Sr5AhOZnPq35jxQMZKgyIjGd6gqHdfbAHtpf8ZRc=;
        b=ggtyAlK5d+ZGKZ2b0k2afzMY/YeLK5gUpsHdBkcfs2+quVkigOVOMhTvVD3MfyY+VJ
         RhWb0GBZLYPua1DoXaoxKgGc2mSi31SO0cai/wzdMHK8Sk+AsYOAjQAbAJrFBHgNXPct
         +WSBhk5OEc2o/k2cdeUYmIxwWVx5yRyuZCb/iUXXPTvltGSiXphRVfmRpREcKSBpVOyL
         t9XKQYzKdTjGhCLZVMd/m2wOxMmIcHHe0pPn5GKumaBo3q+rCRc5KFV7C7lSMFMkftcq
         iKNFgnH40VRzdUTnx8O80viDLN0VAhj568VfjBtf52NiBLYkdXyrDfOAtB9vtFKgcfDA
         PJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013818; x=1793618618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hi7Sr5AhOZnPq35jxQMZKgyIjGd6gqHdfbAHtpf8ZRc=;
        b=KmCTueM6eYCm4kE7iCMri6jvaCFvVZflBf2RHKyHXnraUEuQ09g6/ZKnvk4BToJiIJ
         oFBNQITo7uhxOuA+OMPtBTmvdTJgkD9cBAG4CC6mAn6OWjHLb+Da3IeDNmAI4j/An/5u
         t6MoKsFlaG0gY+RfaqVl1mgfoU0K8IWL62E5AZY2f1J+X0iigm2gTdK2Xwvys8TH/6jp
         LEU+6rfk9i/FQz/EdWm/s6lpmW2BF9rXZ6yMVf1vQJek7Y12INYCoCm4rhtj6W2AAudX
         U+awc6d5mVqSLTykYbzumVNuorddVnbbfSRp8xhP0x/wI4SpdteHSC8TvsZvvN79CxBC
         +irQ==
X-Forwarded-Encrypted: i=1; AKwUvBwja5H0BJFxjiuPyaHO3GNo7HT7+m4oxmYkSxIaFmSekb0RfZOtHGA86g3VMpjDxSMXfXsXNSPfqomKaXQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2qUjFEf1bYMoDMS1v7ZezjKsymCnJbufUag4/4bzvb1tNbd+f
	TT+2jGOhrRg+Ogyk27J0u6Cj1VWCjEstpwP7OOxun2Uci8y5LEAeSs385+/NEQ==
X-Gm-Gg: AYBFou3jDaH4vT0LIbHra6WAt7GayJDkMfBJgkaK4QIz6d3M4JUU1ToLyp1ys0fvDlT
	MDtEQee5mRbEUgraTi0wCXQV6qHcbwUDYhrLIhtDkQqTjuRoZ9PvnNNwF+iE7eTvwB1GaYOmvhX
	xJF3Z0xFOt9oqR54h3b37iTyCbgrh+Hwx9KelNHnL8R5XCrc+9ciKb2qFT/z2f8Suj0+pgBrnTV
	zYFtQ6T6FGwzA4FiD+utMQ2IE1VFzllt6uT3O274Ea4XSrfIPzOCTHHxHO022AW6iKFMG0u42x/
	Uf/8bP5fGHmAJty3ognVot/jeFmkhuqtYD48gB4IE86C477NBdCJYEXNaGDiLYb2uf3GhtzCQni
	C5yhbQyLf+oBejlb9ROj7iEOxgPbqQuxHtuMJm+fseNtD54uPJVxmbmzTqrkqPWL4AKJE5dSaWj
	8RJuxaoGp7n5c8VzyDFKcASLMzoOgmXDKcTlMcO4vFTu5VzNJLZPw8dN3lk8BJfSQbfD4D/Jq94
	8hT4yvHw0XRPnTza0p44I0+lm9/X4JSpmkS6sPAkvx8zOdwb4A7IzNfebpV4VLxBePBarVl7xGT
	+sXDFRoDMMYCHQ8juYw=
X-Received: by 2002:a05:600c:80ca:b0:4a2:5ef:1400 with SMTP id 5b1f17b1804b1-4a35ac9a7a3mr79652025e9.12.1793013817664;
        Mon, 26 Oct 2026 04:23:37 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:482f:657c:9770:475e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfb8esm15959263f8f.54.2026.10.26.04.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:23:37 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Date: Mon, 26 Oct 2026 11:23:33 +0000
Subject: [PATCH v3 1/4] serial: sh-sci: Drop TE disable at end of
 transmission on SCI
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-g2ul_sci-v3-1-b3097163edd5@bp.renesas.com>
References: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
In-Reply-To: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, x86@kernel.org, 
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793013815; l=1401;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=Ii4p8OHUuRr+409dJC7XNZ8wHyl0UhxZWbqcu7AjCfM=;
 b=QPOwAoyUkoWS9Bqp2w2X70DfqejfizPDZXdsQkJEafZxIQD29eClU0HtB39i56Y/RJtVqGMco
 7idJP3hdNJxB+CdRDa70bI2O2JYk8pvtPqPW2OopCkZ4Ge+olw0piyX
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

Commit f06c2a9000eb ("tty: serial: sh-sci: Fix end of transmission on
SCI") made sci_transmit_chars() clear SCSCR.TE and return early on
PORT_SCI once the transmit FIFO is empty.

The hardware manual does not describe disabling the transmitter to end
a transmission, so this special case has no basis in the documented
programming sequence. Remove it and let SCI follow the same path as the
other port types. A plain revert no longer applies because the driver
now uses a kfifo, so the code is removed by hand.

Fixes: f06c2a9000eb ("tty: serial: sh-sci: Fix end of transmission on SCI")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index bd58bbfa65aa..9eb297dbc901 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1036,13 +1036,6 @@ static void sci_transmit_chars(struct uart_port *port)
 			c = port->x_char;
 			port->x_char = 0;
 		} else if (stopped || !kfifo_get(&tport->xmit_fifo, &c)) {
-			if (s->type == PORT_SCI &&
-			    kfifo_is_empty(&tport->xmit_fifo)) {
-				ctrl = sci_serial_in(port, SCSCR);
-				ctrl &= ~SCSCR_TE;
-				sci_serial_out(port, SCSCR, ctrl);
-				return;
-			}
 			break;
 		}
 

-- 
2.43.0

