Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE4A3770D;
	Wed, 25 Sep 2024 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275521; cv=none; b=PbJ56Zcm4bGB2zbJXpJfTqAZNoskIWi8nFa+3OgEmKWgoD/yp6F7awnTv1PFYMHVKYP3e0X1FMQTqikyPT89UlioLPabKBF+UGgw2CEe/zzvgYyKElgUDONJhireM8jolnSa3pC3wTvc23B+1eW9RMt7aKmCcdtwx7XlmXfRuMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275521; c=relaxed/simple;
	bh=aCQbL7dF8bvGol6YIVUGOYiuq5XdVTTI8DgtLt/G+VA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cMS1y8Vd6Zj7yV+4Pjceqm6c6Ug2q+5Esk3HRA/5sxk635Vracrqdd8rP6ZlJPurCH6QX4BS7oG/USlLlOtaoOv3mKa3DcMhJYurgrYZBRHMrd4RbJcVSQ2WiIHEzbNk+U8CjPHdulzLwtXtE+ah8r0bG50HhCE5PwfoZcmil8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=EQB6wfO3; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="EQB6wfO3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727275509; x=1727880309; i=markus.elfring@web.de;
	bh=TsWyf1tLlFqi0zeqVIDw1sDXr1M2uMya2IFc+ykY6u0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EQB6wfO39aLBZsoooW3NerOA/NMRJjoasXE1cG9hkRSOenrdovVZgUqRWp5COihW
	 nLDBV9y8NnFG+DLoDhF7rVxq5z9x7pOhx9WJG591dCRLRigMYS4+fggD2dioyZkOv
	 C8f1j3J9CR11ttd22UHazbzZOd3yb2Pqo810WIHETUUraiyzAS8YKeA8U0EMy0jrT
	 nom1VdoKlzKdy6V7X58N6dBKyd2DULWcI+aHPRXvwYJ2TNLiZUGXFr51X4i8n1/06
	 t0WIAeWyq3MF/vRSj6a45jPH/0JNE/yYpkeD27kdpCZ8itS0ii8mayxG64zFtlFxn
	 DeNUIXNGHheFD0HfFg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnG2Q-1sATrN1Axw-00mLmc; Wed, 25
 Sep 2024 16:45:09 +0200
Message-ID: <f1216028-ef38-4f05-996b-bafc71777abd@web.de>
Date: Wed, 25 Sep 2024 16:45:06 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-serial@vger.kernel.org,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Sherry Sun <sherry.sun@nxp.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] tty: serial: fsl_lpuart: Use common code in
 lpuart_global_reset()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9jkkLVsaL/iWBpu6jmFJB7K3jL8mWlukwV+25UaUp/DjIhZY9tM
 ssLmIOq1tjHac8OQOSYr4GeVJUMZU+wiogfyfpHsLHDzwB7CsXfl44eVsd2a/1YHzhR55BR
 ePqBTJJrr67O108kHZSMz4HznwZBecVao6SNtjqrDp89kK43WVUv7/0iJK92+kwqr8TllYV
 PqNA9j4wqryA3tPNaFAiA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wCJw6HKMH2Y=;JgVHGL0SjEFwIqv+JRvsshpN4mi
 23eY5kpjAc3DzSdV2l8PZQUpBDDTJuf8J1lCHh0EMOYYXBAPDU9lOtNCFl00JHHYM4N39bJ+G
 uzOGOjKX5dCVIHAZPiKsKhNXSBzPwXW1Omjwp8MqSfCURJmDOHjbJZE+Y7utCg+tEnbZcQO+c
 UIF2sHqHQUL3Pd2Zc+Y0qXfvvqO1W5P3LFjiohIgwTMvHALbP7FEn3KQdA1g6pFye/dGbf8Sn
 yDNGe+EW1BnoYOuLUwYB5bZn+S6eWTlU06YRs8J99DVST2sEG9dadjvTKIRmYR7sZ8Wr/V813
 rdNnXuLMUnOcK36Mm+b4Juz/iO3fo9ZJB/SsaDqm+FC+3oAbpT9bjWMRiqdxbPSc5SzlBk9W0
 1YNS2ESejoZe07Gl/8poofpKrRAt3a+BwXf0Pe46LACiV4KLXVxvPgJJM0Z6B3in6uO8HUeX3
 85dfY2YPj/F0XM7XSFJ3HgT5t/GkFRy/0/OMdXUIOVM7CdlhvJb9IXs6EvAuVC5tTEBOV4H2W
 uQ73mZan1sIIw5D9635ZI35MdS5ojJM1eWweIqjO7sFyT+vK36u0uOHRfLx9A9YJrv4uDQBZZ
 /PkLB0v2Db/xvGeJATw/Q+N1nFA1geIc2Qeluk0PaHk9BmIv77RwJZFN/7cGu4f+PpOHXfsXB
 O78ySO/xlirSjrilLznECMlA0GC+/TwEPf6UNanISMre7CFf5RYBP2dbjIy4gBKWxAq3Ggs80
 P7m9W/8C2+iLpvodubYntQBUOxrEOsGbWFBXzCD3+EJcvtFxImY+/8Gf/UIVRYZyI5EVLpfWW
 I67B8GdAHxqoDatfPkznIcjA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 25 Sep 2024 16:36:20 +0200

Add a label so that two statements can be better reused at the end of
this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/tty/serial/fsl_lpuart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpua=
rt.c
index 77efa7ee6eda..b63419c1a4ea 100644
=2D-- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2811,8 +2811,7 @@ static int lpuart_global_reset(struct lpuart_port *s=
port)
 					      port)) {
 				dev_warn(sport->port.dev,
 					 "timeout waiting for transmit engine to complete\n");
-				clk_disable_unprepare(sport->ipg_clk);
-				return 0;
+				goto disable_unprepare_clk;
 			}
 		}

@@ -2828,7 +2827,7 @@ static int lpuart_global_reset(struct lpuart_port *s=
port)
 			lpuart32_write(port, ctrl, UARTCTRL);
 		}
 	}
-
+disable_unprepare_clk:
 	clk_disable_unprepare(sport->ipg_clk);
 	return 0;
 }
=2D-
2.46.1

