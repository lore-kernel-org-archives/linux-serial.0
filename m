Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792617537;
	b=b+OkShMdy5B4a1vyeLkDgPK/awqsiql+cgYXWLLtFMgWCBf7vu4+1pMWWsxjnzHyHAu8
	 SsdT2pDRYzrOO2gSUoX5ao6QJGkTQBNTcHS+OZ0NwZHK0isMYMUTIe7kmfTIu18QPGMhG
	 oAmehA4x8PLA0empJGoNOY5bEXt8YSCeW9k8Gy0w4ol8XhahJ26F687VIMzoL+Wz1Pgdr
	 XWgvxI7UsSLH/2A/f9JHLS6ioXfS5th9XsKinobvQopqI3AIc6wEMK7j88AiGBNWtJhMl
	 N63mQIU1tTVEcQ9RLyoKjuF32szuannf8k/jopuJOTE6rjjwL01giR4WqBvkYTIUDkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792617537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=RsN7rZ2dbjSWgctf/6anE9q3RrhIqoFI9PjpCDIzg9s=;
	b=rvxrKre8vM5k+zQpa4jaSIb+yqNhb3EWU+VfHesusH0gkiiOJ+lIY5OMljmBwoW2u5LZ
	 voWTmpGI469/N/Gq3q1xOEcXBFoKlDnbWl+aygYgfRG9ASGzw3veEHMDkZqvCBfI7Ki0N
	 9fx050r/+JH6MfnFggy11xCAFM2EExnKIFbesqBv42uaVhJ91fGsW7i8aPyZVcu+AOF+M
	 p23LD4D7jaWArnmZSIZZ/S1s2iPAGqNbKOIUjOtT9sosRywg5dJWAcNbyXqGuTp6eoG2q
	 9NgEhfOkaQbZxN8vIPo0Z2H9PMlLmFswGpVYbut/7I3nkLMgNczyjhCi4t2NWH+eJDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ddd8X3OR;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22007606A319
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 21:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22007606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ddd8X3OR
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-823b938464fso891100a34.2
        for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 14:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792617536; x=1793222336; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RsN7rZ2dbjSWgctf/6anE9q3RrhIqoFI9PjpCDIzg9s=;
        b=Ddd8X3ORgJseDZnnHJQFlXS3oVGl5pdotkyE6IqcDl/0bdwyFA04ndcny4IJnn95SC
         tl8q7EKSfeuKvLJNepIVZy7dgrEingoqOT8zkst+qj6BoLiLyrWCUz0YPJiZRu4k0dQ+
         iCYU9QsarMs/SldI1b/zQyo9k1HDCNTKLi3k5mX7EL6YPvcTRKhtFJ1VQ81lC3USC0cg
         +g7flPZCVy3fRySl5WJm+qQdAjdf5Az9srv7tvqr+vxbYRh8QTbYSaOkH/RzmP0sWGmE
         Bh8XNGh2khf0LGEdfQSYGOQ6iDiO1N6iwqClypUHBiPX7wscRSEN/46MJOA2OW5DIvcJ
         RsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792617536; x=1793222336;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RsN7rZ2dbjSWgctf/6anE9q3RrhIqoFI9PjpCDIzg9s=;
        b=la4a3OUSZcfR4sAk/qbnuDvTFLksBzWG94AKZMxlj4Gzxtt1hvTAdMI9RGeI5eHbX5
         2Hxf1PHDFowR/CVL8T/DXhF6+tgXlGjDLuaIuCyFa0UeFkCToN1164pLNvjkiEJNQAo1
         5kptTB3lajJRw7Lb9LtPZ8kdezn0FXmoM1SERRvTXUMInLPOZnZhPQTymUgEojKzwNC9
         nti/Y0GwL9dLdWsnc2kAsdG89HqT9/MVD15SDt6SxUMaT2INv7pifRATVYRAY2ZJVF0Z
         nfqYt6sH8Jv+jS8d4qKZ6H12f3syvqoHzpVIfYU0Ot9I7CahIfkH44+jgQIEYWWHF7oc
         vrxA==
X-Forwarded-Encrypted: i=1; AKwUvBzXhM4b+1V7Ub8rphHPrQMV21sxPsTJKjqr1CDpHMn/JBaxEt6QX+e1ckfGtjMkfaNJFKFf2z/I8wkY1/4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvs7GX8w1nLChzB/QPQ3mHEgvb5V8u7VN38cE/kntX26uAKY1z
	6QFN7sY2ozC0ghnc/viFuQ4+Tk72lMcUa+V/KnunT10iM6ywX24Nokgf
X-Gm-Gg: AYBFou2woOEaZfwjNqRTyf472BXSmN2j03lOEOPPxB53bvZnxPhBmph0ViRHj5Nzs1O
	qqZCX/g5dJ66mgh6OXdsSzbPqf5CXNuFPMOYJc6MiPWnztFgbra/V8BtUVJZT4xzuj/mslE3C+M
	Kq5dLeS/eCv+vVHk75+WiSJl+/buSxHmbAu8TlzlIJRnSi4JwEev1PZRyXqtgPnK6xjsGGfrB3+
	cfHP/q7atkNZPqdNPx/hnkTP4pBihc092X8ue5HnwIK+sYW/N9UmfYRRddOpCaParr3ct8nTPj9
	TetyqwJWRzP3Xxv7HubEwTXs6Usu97VI3b6nDuTVKCxpsxjsZxFhKpvJ3TKJZLLRauMpqT151d+
	ZgEQSbSHWFThfZmKRCZwKXHJpMj9JsACzSce+GTkXxYW/zi5PRp+BiegvubWnu6yxaFU60um1gh
	Z+nXikjQSAyxAT0vLFDzeCMN9fyN9DP6sn6DsLqD0AgbEdPr8ef7fWW4D7AVnU/evxsJ8lNqw/O
	jQPkqab7KRdFzq21bVNlXcs+WUKZ9xNU8njRCKatdlVIJAS0lCg3ZkP3AdMV2Jj8wsBDBuQBcu1
	EIKR8ZAMlkd/Fyd26gMSPqLZYodJXpFelQQD39mD+0KLdbwR6nUStrYxTgJnHE5w4F9sxbPS3RA
	+umsRCIuXOz+el4yY5pf+z2DVSGnlawjx0oVfQApQ9bT3KFpfuCYfGNsSUZM4/ELd7Cn8PrSb1h
	y1qizB
X-Received: by 2002:a05:6830:2985:b0:805:2785:fad5 with SMTP id 46e09a7af769-84d09d0a654mr2293305a34.27.1792617536081;
        Wed, 21 Oct 2026 14:18:56 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbd7d4431sm3527487a34.19.2026.10.21.14.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 14:18:55 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 21 Oct 2026 15:18:48 -0600
Subject: [PATCH] serial: 8250: check DMA channel configuration errors
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
Message-Id: <20261021-submit-serial-8250-dma-config-errors-v1-v1-1-c067587d1ef2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQ6CMBBFr0Jm7cS2BKJexbAo7QBjpJhpJRjC3
 W11MYv38/+bHSIJU4RbtYPQypGXkEGfKnCTDSMh+8xglGm1Mhrju585YZnZJ15Mo9DPFt0SBh6
 RRBaJuGr0Td22tRqUu3rItpfQwNvv0737c1Y9yKWiL43eRsJebHBTiVL6nPNhoC3BcXwBOyFfE
 qoAAAA=
X-Change-ID: 20261021-submit-serial-8250-dma-config-errors-v1-d536630f0c9d
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

serial8250_request_dma() checks channel capabilities but ignores the
result of configuring either channel. Those checks do not establish
that the provider accepted the requested slave configuration. If it
rejects the configuration, startup still selects DMA and later attempts
transfers on a channel that was not configured successfully.

Return the configuration error after releasing the channels acquired so
far. Both the common and OMAP startup paths already fall back to PIO when
requesting DMA fails. Check configuration before allocating the receive
buffer or mapping the transmit buffer, using the existing unwind paths.

Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_dma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 1da605cc8601..d6cda9a121c2 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -262,7 +262,9 @@ int serial8250_request_dma(struct uart_8250_port *p)
 		goto release_rx;
 	}
 
-	dmaengine_slave_config(dma->rxchan, &dma->rxconf);
+	ret = dmaengine_slave_config(dma->rxchan, &dma->rxconf);
+	if (ret)
+		goto release_rx;
 
 	/* Get a channel for TX */
 	dma->txchan = dma_request_slave_channel_compat(mask,
@@ -282,7 +284,9 @@ int serial8250_request_dma(struct uart_8250_port *p)
 		goto err;
 	}
 
-	dmaengine_slave_config(dma->txchan, &dma->txconf);
+	ret = dmaengine_slave_config(dma->txchan, &dma->txconf);
+	if (ret)
+		goto err;
 
 	rx_dev = dmaengine_get_dma_device(dma->rxchan);
 	tx_dev = dmaengine_get_dma_device(dma->txchan);

---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261021-submit-serial-8250-dma-config-errors-v1-d536630f0c9d

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

